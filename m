Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2B7F20248
	for <e@80x24.org>; Mon, 15 Apr 2019 12:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfDOMxn (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 08:53:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:36271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbfDOMxn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 08:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555332815;
        bh=6mBmqwdbyHLFY43fJQknqRcuLv62V9E05xg52RsTeZ0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iD5x//Jni7twx182HxFjf5HQHa/wLMf2L/ldb0fR2sooTmo/cxWhCJSvf9Ec5f/KS
         GUc9ygccKpchvmg8OcNxODzcd32Zi9VvJchLFBbhuTzNMVm34fygaLDt4NM8I6H68s
         zoKLRDsu7v85gEceIBI7sgeHrZSd6xAU3mhHEr70=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MADqP-1h9eOk0iAD-00BJwp; Mon, 15
 Apr 2019 14:53:35 +0200
Date:   Mon, 15 Apr 2019 14:53:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/4] range-diff: don't remove funcname from inner
 diff
In-Reply-To: <20190414210933.20875-3-t.gummerer@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904151448530.44@tvgsbejvaqbjf.bet>
References: <20190411220532.GG32487@hank.intra.tgummerer.com> <20190414210933.20875-1-t.gummerer@gmail.com> <20190414210933.20875-3-t.gummerer@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Dlq1SO9yjXSGUJPXQoPDKknHW0HNpuihWJkSYt42P1xnnc/8dFB
 Hjw52ZvEuxUxqyeTehiDg61le3rjI8QuBcgbvAkpml6CmiZksGH+imvefbpHU7uFxOhY7zj
 C+NRNK8wOjr4DqzMPejtoUBkM4V3emxORuv/IcSsbcGAPcxt1FVrPiyJwH5Gl04RLHpwgE0
 ZFxN0L5CuGRKTq35yJCyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KcAoeazGTwc=:rP1fUxQXlgzdA0HPWqXYOM
 w+UjMwkCD/avwEiIK+uMgIVP5AH68/47UC003pDBTeDXeEeHsB54idgS3cqLd58cg84RTuQj1
 hjQCr6645C/sjHDCKuYtnPfP4qR2vzyf6jQ08fp2OeozktJCNRxP2+mX1wTpb6AovBmbe13zZ
 VeqYsk0j3Ota7SQ1dFq77MBmuHxKDvLrdf+elOrPrV1trd5CtgxtNrHSBpqXo5nt0g0xuYGnF
 LOASAeSidAupt9/raRtqIx2jCC+IFCLBFaT90aqbKsPRK84qF3xErqbp6HC/9aYrmqN1+eZ09
 SmG9AzF14e7QD17dl3zDpq3vb3JfKe0pDXHjON7hU0sumgQhXU9V/+8uxSa9VEfr2umX2AUsr
 6Evj+r5JwHBYaxiQ2mG65zeONi651dguA6DuaE2WDhjbsVgCT7jIc3lbCKXnKtEEUnn8NOyPp
 cNtvLq8cTSLlsMMakaoWVPxP9ABlh3Rnj0unBfsPXxyvTcuhXusjr/ek0GtoJrrdnsEzYOw5Q
 HgDZ1y9G3bQ4WFuI3p2VZx8a2XdiWMMw3VRro/pbSrbMQZnUszrVpijUWA/6k79BN+uRBcLfm
 ZVJWTKcjIQ/wISTeORNnyhzubvLTp7TORP5IOkD0XWZyjKsFj6ZNZMtbX4/CM+0ow13DuFiny
 6DCvWk+JXA8lTPG67rTPWqrnga1aMSkQePdDIa3kLrXy571wJwCAHiQN0sB0wImPiLP5drzpg
 x/C5LamR63bJDE7OPsVo+9jX3B0Qj5yKPPFlxLhq5p5xqa1WXKNOIASumslhFYA/DJEiRu63n
 HSedWJSXTVjhtanDGp2Tn5Je5Wp4CKH250XzEk2JctX55VGltJntXQn9RxDu6BIU7wcRY/zJg
 L7kX0FySR+8VSImpUfRE2rR2O40EJLYzE1sWwrSR1Agu6ws4rfQIku1evQrGZPQUHVM4VipyK
 HG2JNtXLjRQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,


On Sun, 14 Apr 2019, Thomas Gummerer wrote:

> When postprocessing the inner diff in range-diff, we currently replace
> the whole hunk header line with just "@@".  This matches how 'git
> tbdiff' used to handle hunk headers as well.
>
> Most likely this is being done because line numbers in the hunk header
> are not relevant without other changes.  They can for example easily
> change if a range is rebased, and lines are added/removed before a
> change that we actually care about in our ranges.
>
> However it can still be useful to have the function name that 'git
> diff' extracts as additional context for the change.
>
> Note that it is not guaranteed that the hunk header actually shows up
> in the range-diff, and this change only aims to improve the case where
> a hunk header would already be included in the final output.

Makes sense.

> diff --git a/range-diff.c b/range-diff.c
> index 9242b8975f..f365141ade 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -102,9 +102,12 @@ static int read_patches(const char *range, struct s=
tring_list *list)
>  				strbuf_addch(&buf, '\n');
>  			}
>  			continue;
> -		} else if (starts_with(line.buf, "@@ "))
> -			strbuf_addstr(&buf, "@@");
> -		else if (!line.buf[0] || starts_with(line.buf, "index "))
> +		} else if (starts_with(line.buf, "@@ ")) {
> +			char *skip_lineno =3D strstr(line.buf + 3, "@@");

Rather than using the magic constant "3", it would probably make sense to
declare `skip_lineno` outside of the `if` construct, and use
`skip_prefix(line.buf, "@@ ", &skip_lineno)` instead of
`starts_with(...)`.

We *will*, however, want to have a safeguard against `strstr()` not
finding anything. Maybe re-use the `p` variable that we already have, and
do this instead:

		} else if (skip_prefix(line.buf, "@@ ", &p) &&
			   (p =3D strstr(p, "@@"))) {

> +			strbuf_remove(&line, 0, skip_lineno - line.buf);
> +			strbuf_addch(&buf, ' ');

Shorter:

			strbuf_splice(&line, 0, p - line.buf, " ", 1);

(assuming that you accept my suggestion to use `p` instead of
`skip_lineno`...)

Thanks,
Dscho

> +			strbuf_addbuf(&buf, &line);
> +		} else if (!line.buf[0] || starts_with(line.buf, "index "))
>  			/*
>  			 * A completely blank (not ' \n', which is context)
>  			 * line is not valid in a diff.  We skip it
> --
> 2.21.0.593.g511ec345e1
>
>
