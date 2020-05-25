Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E04C433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 14:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69BEB2071A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 14:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ub1NvOa9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403950AbgEYOp4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 10:45:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:50297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391020AbgEYOp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 10:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590417954;
        bh=zYMiUFoD7f9qP1/tkPQwCKTvyLgbEE1p+kUjhTuLi7s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ub1NvOa9nqnGBRZJ1pKLXFv9ERhXtqjvWOtft3PDahwwO6HNiyf5AT9n1HITMvZ4I
         VdlSEGkwMSX6m0D47RZiFZ4f+oO6YQVIHUqNilTJiD9fCe7DFbTBv/bqrBvu2P5vvb
         g4OWWXVUCW9cvZj1o57wVhRZpC9zdlMm0BONzvjk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.215.52]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZTqg-1jZKcx3m7S-00WTx3; Mon, 25
 May 2020 16:45:53 +0200
Date:   Mon, 25 May 2020 02:29:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] hook: add --porcelain to list command
In-Reply-To: <nycvar.QRO.7.76.6.2005250053080.56@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2005250228080.56@tvgsbejvaqbjf.bet>
References: <20200521185414.43760-1-emilyshaffer@google.com> <20200521185414.43760-5-emilyshaffer@google.com> <nycvar.QRO.7.76.6.2005250053080.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MKMsJsj2ZJHSXgubv0yw0edCHuHbX4LfFKpHRKjHOYEM6TT3XEr
 BZrfDe4pC+rUw7F9aaST5L15ZdeC4mYtp+D+FTpYRTmvG6O8OkzLfQ44jyNe1HOHIzIO/0Q
 BKGMkbVF/PPyL/4wSg6FF6jd1l99GOjEhLHMjZnYlTp0ccf7Fljr370jd/HtTp9RYEAqqgP
 n6PA6pK5SJMvWB1hG9sgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oGLlBkeEm+E=:ck7ED5djtp/m7UUhrFVRrE
 hZA1v2bB5svGI32LsA7Z5eABg7R06sIxPX2+eSTvbLj31z5iRJbWfU5hrlAiIaD9L2qkjeAM2
 3XP3uyfeLLbeQ3sh+RJDwc38JPa3+qv1bph+Rlt6VQMYFbKYJKfgR0wA87/fBe59ZD/Gz3yNi
 QurRv5/YLMiqiPlFynBfMnaNeZK56+n7Z8xTqD9PP3qoh5UwD93m7jB57TZ9pAU52hBIPMGeR
 JF47jqpoXGD5uGkbNcRTCLpHMmjl3UTo3UGm/orQ6eCn6kCHNqzUCIhYZvJ+uhfgt4EZwdr2Z
 UMRviplyBnRVdhP3XOjkn7T1s8y8poKVGEAKlwNXIYmtmHr71yiCI5N0lBq7glbzVj13ETwTh
 OtZVE3LUpFGAIZ1ebP3I3BAvf12mxBuF7I+3aCWzjH7EEAmgsYMeCN0pZYZJQgTMDVaRFQCE9
 cmlUKa9ZRCHYGYJSqQR8A/pjZI/Uy6vA2D8j8QHaz+29LsRkwnOvzlg39LGc5B0NMxBdvbrLQ
 kIeLBpbk4PDaUALyEWn8Ofu7giAI/8fGce9rQT0kcA7u9Dn70ztRMCfCQbaR8+l5RiZdu8M6i
 v0U1qUUVT3FgmrrA8xG1iKFLL5TXJ9hpVb5rpC4gPX7p9BEgaba4lx2hufqixyjSkX1CwreEy
 WsUDiusY/x7RvsgJeeKdknJyyQIldi7SaXPTn2KLqRrsihWB/NRNWlWWodEDRbH8IzUi2rftW
 CiLwqVY87WDh2rtUwQRHDEEsZNrTbSuOyWgcAcTVBc4KwZ5MSmMTmGzGXHcoIRHPJFJuPY2m9
 9OHd/YndpQlElwKmkblnDhuyd33J9YsiMo5BwOy4F/0PCeYBOZDrD09CX3IUsBxTiBLYof7zi
 R6CtNQPP2PYVwJHrQaSV7tAY7cG8+5ychRoi9/oiMgJ6SUDa0OjcMxnsgHBDDNaBmy/BNSQXX
 T0sdsn9bPJM5Cp5H05MelM4wVJWd9WP/ntWhqIZTcb0aXYAD3q5kSxFkKSn04INhNkNED9wkl
 eRTObQTur0vEig5olp9bcLoUq+IcMmqpjGd5UR6FUcuXW1b+VjrFfQIKNxRDrdKtY2Obt08bG
 UadOSAExogq+jfg4OVlMpChjSbnpsrzP4etLPjJW4696L+mU880MhDt1CoGkD2R1tgVSeJ+SP
 4xbeaz6xLTSS8c6NMB1PcYU2G3Dp6yF7kHBugDM0uOHkqtJtTgY7z/9nDhfFIJerDSEKjTp8H
 TcZyxzsXZYks8zeVU
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Mon, 25 May 2020, Johannes Schindelin wrote:

> Hi Emily,
>
> On Thu, 21 May 2020, Emily Shaffer wrote:
>
> > diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hook=
s.sh
> > index 4e46d7dd4e..3296d8af45 100755
> > --- a/t/t1360-config-based-hooks.sh
> > +++ b/t/t1360-config-based-hooks.sh
> > @@ -55,4 +55,15 @@ test_expect_success 'git hook list reorders on dupl=
icate commands' '
> >  	test_cmp expected actual
> >  '
> >
> > +test_expect_success 'git hook list --porcelain prints just the comman=
d' '
> > +	cat >expected <<-\EOF &&
> > +	/path/ghi
> > +	/path/abc
> > +	/path/def
> > +	EOF
> > +
> > +	git hook list --porcelain pre-commit >actual &&
> > +	test_cmp expected actual
> > +'
>
> As you surely found out from the GitHub workflow running in your fork,
> this does not work on Windows. I need this (and strongly suggest you
> squash that into your patch):
>
> -- snipsnap --
> From 97e3dfa6155785363c881ce2dcaf4f5ddead83ed Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Mon, 25 May 2020 15:04:24 +0200
> Subject: [PATCH] fixup??? hook: add --porcelain to list command
>
> This is required to let the test pass on Windows, where Git reports
> Windows-style absolute paths and has no idea about the pseudo Unix
> absolute paths that the Bash knows about.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t1360-config-based-hooks.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.=
sh
> index c862655fd4d9..fce7335e97b9 100755
> --- a/t/t1360-config-based-hooks.sh
> +++ b/t/t1360-config-based-hooks.sh
> @@ -65,10 +65,10 @@ test_expect_success 'git hook list reorders on dupli=
cate commands' '
>  '
>
>  test_expect_success 'git hook list --porcelain prints just the command'=
 '
> -	cat >expected <<-EOF &&
> -	$ROOT/path/ghi
> -	$ROOT/path/abc
> -	$ROOT/path/def
> +	cat >expected <<-\EOF &&
> +	/path/ghi
> +	/path/abc
> +	/path/def

Due to an oversight on my part, this is actually the _reverse_ diff, and
the corresponding part in my mail answering your PATCH 3/4 should be
skipped from that fixup. Sorry for that.

Ciao,
Dscho

>  	EOF
>
>  	git hook list --porcelain pre-commit >actual &&
> --
> 2.27.0.rc1.windows.1
>
>
