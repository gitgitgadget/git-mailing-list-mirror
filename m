Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BC581F4C1
	for <e@80x24.org>; Tue, 22 Oct 2019 19:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbfJVTS4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 15:18:56 -0400
Received: from mout.gmx.net ([212.227.15.15]:42631 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730186AbfJVTS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 15:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571771929;
        bh=Q8Dfdz7XAO1sRb87hpPbu30wGeOzHIQ6V5KR436WrvE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QuiEAsYbfrgilG7IZv0j2ofXKspLoiYu7a82059NPzIf5CvK/g5R3FR0wV2umMv6C
         rTk5ET8iPUIXBBUQWxN5EYslDyuwG/2mZuSdvTv4rRhtB7IS87+OwpAh3CG3z+VXBb
         57flJYPqtvqUw1lWxr8hxpfhFViSA6XTnmfIb2a0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNcA-1hnvyb2JPs-00ZRVX; Tue, 22
 Oct 2019 21:18:49 +0200
Date:   Tue, 22 Oct 2019 21:18:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Wong <e@80x24.org>
cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [RFC/WIP] range-diff: show old/new blob OIDs in comments
In-Reply-To: <20191017121045.GA15364@dcvr>
Message-ID: <nycvar.QRO.7.76.6.1910222111430.46@tvgsbejvaqbjf.bet>
References: <20191017121045.GA15364@dcvr>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:t6itgSt1lX/CUgJtjav+uXnCRQuSupCDs3uMepBSlMZ7sJxr91C
 iOZFnoCrqpSM73Vaejhuy4Dwk5VEcCclwDoWkgVwkGfFyK8REuNsmKeOunrTG3ud30bPhPw
 4MouZKyo+lGl5pj0jRHwGNm1x0ellyGkMnEirU/8ZT07O+5Q2dUerES7MnZQe2RTmPlCYwD
 YfQLo8uFVcqJPrzeP4N8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gDn/V3tJ53I=:ar7qBdEJscuXw1Uy+oRzbS
 wsguUNDIzdpjNzMiWU6gpA2qMTvWWD271gKJEFGWII/TdfEuy34oH/puVT6uxpVa5LSqmrPDi
 XBrKYrwB9iI2QKnJwrFdm2/LIpPNyxF1KA3CoJIEql5X4sacQtSPpqfJyppz2ME9LlYN8qT7N
 XoRFV8DfjBAhEdcZUsL6QX8PdpDvNEJwcnEdDJ/8HSCyknbJsHeEuq3sF6aZAiGzjBH7N5hHF
 aQRzU2OLTX6zTd3P69wWQTipwQd38ShD4Xn2vMSHkL7Vnnn7TpQHi4OR/jT9pnqlVfCT8pvEw
 gaZIcB4hAcJTOeVQPs/npOVhkXCBdpV3nF8me2F7vdTeK+FLAJTWXhsfTWzVQ+1WbDXgzmnvt
 0VDD8Zsr2kjHefuP6nQpP76v60Nex76NfxZrsyPCSeaWvXRz/RQs8ppM8mJuMJlFS1qboCLUF
 y7GU21sh97G77Zhdq4w9CHCp6ftwMCcit+WdUym8jWdPQm3a+PV2A/nUr0AsO7Bz0Xyjz9yKj
 110gFBdtevL/L8+gBQVmpwZp6GgVoKUwGlhuvQ8Zp6nfCX0Yommhu/IFeeCrJHbKQ/lBvlggb
 sG6pyLsKT9a9SW6zM4uD4QrbKr/1+gSWz/0AFwHeg8uj1EZWrETGJvm625fl7hTpKtYL3lbYl
 GfrWuoH/MwxCBfp+rByWKNo3Phi6j/aNTfziFijHarjxqBu0lamqN2XFx71diB/ZA3yKlJDXl
 UMzmTBGF7eUhz4Ww5KTQifZegIL60xgtSt9qBT7bbXuXCLjRmvVZMN3PoY6Xx5r9rKVS1/6O5
 3PGeGnSuZOuho4PsdWYwT9rSkTWf+aP7uwH07Hsg8RPM1lY+5uvKU93ibmAgP7xaDj6DZqyqY
 BdBmY/zDhyM69hXeGrEC+MCQCuCsd3jriCfsSGlxXFVpJwOyJbStYe3OnxDB7PP74pF1mjZsx
 iDnijTqLyEuOcF0hMsKyesIf0OAJz7R6e8M726yq5cuZtfjqfpEUCuHIJ/apWHS62uU1+JWA1
 AXVdkVgQbo1XDIPypIAInvlqY8Puc24p9r3UVbPo1H+0Ue12Sro23nydhqdgOzISrnrJVdG7v
 ZhtnYWvIwI0iLveAA24veNSSrXUonn1IYCquzDkcjaJ27RJa9LsOEpvSjRTniUo8ILhW7DshI
 3m2O8p+M0lYLafEjf6/JXPLaWJWdx94X9Vgb1J03U3rYV+xe3P8raCQ9fChEtz5cDcNRiBtce
 9TSw1jJ7+Mz6CQ5Vq2wlnlQtWHopXp+doO6NNoMmm/wEqne45Occ7X/OEvHI=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,


On Thu, 17 Oct 2019, Eric Wong wrote:

> (WIP, mostly stream-of-concious notes + reasoning)
>
> When using "git format-patch --range-diff", the pre and
> post-image blob OIDs are in each email, while the exact
> commit OIDs are rarely shared via emails (only the tip
> commit from "git request-pull").
>
> These blob OIDs make it easy to search for or lookup the
> full emails which create them, or the blob itself once
> it's fetched via git.
>
> public-inbox indexes and allows querying specifically for blob
> OIDs via dfpre:/dfpost: since June 2017.  As of Jan 2019,
> public-inbox also supports recreating blobs out of patch emails
> (querying internally with dfpre:/dfpost: and doing "git apply")
>
> Searching on these blob OIDs also makes it easier to find
> previous versions of the patch sets using any mail search
> engine.
>
> Future changes to public-inbox may allow generating custom
> diffs out of any blobs it can find or recreate.
>
> Most of this is pretty public-inbox-specific and would've
> made some future changes to public-inbox much easier....
> (if we had this from the start of range-diff).
>
> Unfortunately, it won't help with cases where range-diffs
> are already published, but range-diff isn't too old.

I guess your patch won't hurt.

As to recreating blobs from mails: Wow. That's quite a length you're
going, and I think it is a shame that you have to. If only every
contribution came accompanied with a pullable branch in a public
repository.

Instead, we will have to rely on your centralized, non-distributed
service...

Ciao,
Dscho

>
> I'm also still learning my way around git's C internals, but
> using patch.{old,new}_oid_prefix seems alright...
>
> FIXME: tests, t3206 needs updating
>
> Not-signed-off-by: Eric Wong <e@80x24.org>
> ---
>  range-diff.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/range-diff.c b/range-diff.c
> index 7fed5a3b4b..85d2f1f58f 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -118,13 +118,24 @@ static int read_patches(const char *range, struct =
string_list *list)
>  				die(_("could not parse git header '%.*s'"), (int)len, line);
>  			strbuf_addstr(&buf, " ## ");
>  			if (patch.is_new > 0)
> -				strbuf_addf(&buf, "%s (new)", patch.new_name);
> +				strbuf_addf(&buf, "%s (new %s)",
> +						patch.new_name,
> +						patch.new_oid_prefix);
>  			else if (patch.is_delete > 0)
> -				strbuf_addf(&buf, "%s (deleted)", patch.old_name);
> +				strbuf_addf(&buf, "%s (deleted %s)",
> +						patch.old_name,
> +						patch.old_oid_prefix);
>  			else if (patch.is_rename)
> -				strbuf_addf(&buf, "%s =3D> %s", patch.old_name, patch.new_name);
> +				strbuf_addf(&buf, "%s =3D> %s (%s..%s)",
> +						patch.old_name,
> +						patch.new_name,
> +						patch.old_oid_prefix,
> +						patch.new_oid_prefix);
>  			else
> -				strbuf_addstr(&buf, patch.new_name);
> +				strbuf_addf(&buf, "%s (%s..%s)",
> +						patch.new_name,
> +						patch.old_oid_prefix,
> +						patch.new_oid_prefix);
>
>  			free(current_filename);
>  			if (patch.is_delete > 0)
>
>
