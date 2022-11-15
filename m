Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE14C4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 09:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237247AbiKOJhv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 04:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237825AbiKOJhp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 04:37:45 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D3922B13
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 01:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668505051; bh=/5J0+p4kVAHJfS85MFvaS2vkIRurl1CLG4WWu8e6Nn4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=M0MZN/VL1ey2k6fT3eDQMwYN53yXNms77Qrqoetz7ALAXY9eKttndjEeaDEIOTLk4
         Y3Maz0om4EabKzkp40rPTWoh3afu12iDFlOZrwRWYXjSuJVvsOPHeSlhNwDcv5U3Mz
         v5+qO4N8Hm/uIwqzNMiVIJ45iekbldoGvnTFWgQyPV/7I3L+8o1RZ2jzdl1PvpCNWt
         j4i5LBDE8bFFRpCogiPuMO3gwJYhZONKlOsZWeeLfDfjI2C1a7zQo9OVuFbSYgXdY0
         2xN5GjadZZTqb/+tC8pf89sTfX4jGqEm7pSg9tsYhoFXlwquxHIpKm2bSFQdYkkstK
         eYWCpw2PiUhAA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.20.115.3] ([213.196.213.188]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9Mta-1p0SNS45fI-015Iv8; Tue, 15
 Nov 2022 10:37:31 +0100
Date:   Tue, 15 Nov 2022 10:37:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Ronan Pigott <ronan@rjp.ie>
Subject: Re: [PATCH] builtin/gc.c: fix -Wdeclaration-after-statement
In-Reply-To: <patch-1.1-54d405f15f1-20221115T080212Z-avarab@gmail.com>
Message-ID: <3p6n2r7s-q136-n7q9-8o27-740q4qr5os84@tzk.qr>
References: <patch-1.1-54d405f15f1-20221115T080212Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1599185146-1668505051=:183"
X-Provags-ID: V03:K1:BBAb4l39xHqQ8sS3VY+DLjcR/IQ9sEgEXRkXFipGwrN+JufFN2U
 XOOE+bLZPKc+UZJVsPV7OQsNL6iGTRtjJ4zt9Tt8Jejt/5zDPeIpJ2oZRKvvNndCPGmn2pq
 6HJ/nkPUaQEH+cv8NznCmlWnxRZiEPdeZ6REBd0zueCfHM4f3BesASFHizMniY7wrbuflGY
 MHWalJwwTyUEqKMT93DYg==
UI-OutboundReport: notjunk:1;M01:P0:DWTf/t8FIEs=;v/TjD0N/cvqGR5cF3tkO3XNBiAU
 KOtt0XHK1+3e3DYs4kEJuaMnyb+7cMXKuCXAfH8uWidDadZWN42RdDFPwyoXsirO/fXVg0jXX
 O/KS3ohTsrSLw1CyW9nX0+ohHaK87HgZodJ3KO+PijmaaKP9tIo76pw/QuzOR/46zmN0RZdHT
 P24dLUICGwhxA+I++ZcC4fWVGu4pU03ZeWBnwqMdn200ZK5gr84dXkdJ2/hjmJLRudLwQLXAu
 Sz6IhUGXMhuGQVbaFoKu8jy2WF26QX50XYUKzfc3pwAF1k24sQ6JB9Tdk6rqEuqLJMjbag2vR
 C+bTUSZFO/+BYk8xBMwX8EK1BP9QfHyZ1A8dCYD4Lw59YRfe0z7SwuzYTauwyKZYFlbK+gj6f
 rqYV4q0zdoSozD6m5CTgwN6ixZXzvBNkNUPsLUA//NY3h+AOFYi5/P+mw34AOQNUQOrYJSmLN
 y3wSEoVxKFxhICZp+6QkMGDfAkyXU9IP65ICi5kH/QWoNU0+wRVXgnbqsJbSrVBRZTehA8lzY
 v3x3xLWHBFiorqd0eJSNOK+On410+BjKZyUd6+YPgiLidGa4zzc0vCU76d4EWdmC0AThk1L+V
 9LRm1KeG1B+r9OcSXyF2cyjKv3PvEXO//yODowHdCmrReIJTlF77H4N58pjNsRzqEDH7NdiG5
 xOW4bbl+kFE5bKi8sKPr1t0sgBL5K07i20WtsYYfWP1bWwmZ28nsBsryEuKO95sUbrUA3hzv0
 WKhUleaX7pqcGfrzKXjMy+PsNN0Wxk5dxB3wZPiednf7YiWVy8IK7RQg8E52fDz9yUUd0DrFK
 ac52m6pHf/2SvpS5m/TZ5Ii4daTiaKlejGgiDDD5OqvobeEjQDAHaZSvrdtLNEOdwGM1wx9TS
 cIOxCqNTLzTGfCeupDLo/4CqR6MLQBfoaOzCS14uz95d1BDTyYWFRGH1rzC80IBjNs6HZ6qdQ
 oHSQyQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1599185146-1668505051=:183
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Tue, 15 Nov 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> In 1f80129d61b (maintenance: add option to register in a specific
> config, 2022-11-09) code was added which triggers a
> "-Wdeclaration-after-statement" warning, which is on by default with
> DEVELOPER=3D1.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>
> This landed in the latest "next" push-out, causing e.g this CI
> failure:
> https://github.com/git/git/actions/runs/3467538041/jobs/5792504315

I looked at the same thing all morning, and found that
https://lore.kernel.org/git/20221111231910.26769-1-ronan@rjp.ie/
_probably_ was designed to fix the same issue (and I think you agree that
that patch should be used instead of yours because it is more complete in
fixing left-over issues).

However, try as I might, I did not find out yet why it does not apply
cleanly over here (I got side-tracked into range-diff'ing patches
downloaded from the archive, which is quite the challenge and not even fun
because `range-diff` requires commits, not emails, so I side-tracked
myself into teaching `range-diff` to accept mbox arguments).

Maybe you can adjust that patch so it applies cleanly?

Ciao,
Dscho

>
>  builtin/gc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 56b107e7f0b..22a990db0be 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1543,6 +1543,7 @@ static int maintenance_unregister(int argc, const =
char **argv, const char *prefi
>  	int found =3D 0;
>  	struct string_list_item *item;
>  	const struct string_list *list;
> +	struct config_set cs;
>
>  	argc =3D parse_options(argc, argv, prefix, options,
>  			     builtin_maintenance_unregister_usage, 0);
> @@ -1550,7 +1551,6 @@ static int maintenance_unregister(int argc, const =
char **argv, const char *prefi
>  		usage_with_options(builtin_maintenance_unregister_usage,
>  				   options);
>
> -	struct config_set cs;
>  	if (config_file) {
>  		git_configset_init(&cs);
>  		git_configset_add_file(&cs, config_file);
> --
> 2.38.0.1473.g172bcc0511c
>
>
>

--8323328-1599185146-1668505051=:183--
