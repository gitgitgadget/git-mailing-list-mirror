Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECF2D1F461
	for <e@80x24.org>; Fri,  5 Jul 2019 19:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfGETI4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 15:08:56 -0400
Received: from mout.gmx.net ([212.227.15.15]:41211 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfGETIz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 15:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562353729;
        bh=9KtIJR8BLfZ6u/0cKS9ME6U0Zv9AUag1Zvoh401KuNk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ksRuAWMAs05onioi1Zq1WyXtQLrjhHr8zkhUlbxeN3W97RVmNiJMRxGzhhVzFtFH9
         xDjoEDtC4flSwxNrMG7Tslzazrr7605cl4Gp5MAihfdMBvCnFE1KxOtjmAeuegsLiU
         VFffwEgVBbz2IZVzrLMUbB+LA5BbIkBjX4LkTMdU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Meh8S-1huZNg3U40-00OF92; Fri, 05
 Jul 2019 21:08:48 +0200
Date:   Fri, 5 Jul 2019 21:09:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 10/14] range-diff: don't remove funcname from inner
 diff
In-Reply-To: <20190705170630.27500-11-t.gummerer@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907052106430.44@tvgsbejvaqbjf.bet>
References: <20190414210933.20875-1-t.gummerer@gmail.com/> <20190705170630.27500-1-t.gummerer@gmail.com> <20190705170630.27500-11-t.gummerer@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MouA4YA9ZFRoL4mN5XW7cROny9Bx0IqS9/zhxOeDdo5QZNLnM6U
 VS0Ml6exHIlad2q4m7O4deZGN4X1Oc7sF6p/zGT9TH0+v4Orbev/qYgegEMkshBnLtPT2UR
 rb35CPEJXi0Pwo2+U9h6rJTkttZUsDA68Ixs9KRYt1cRmCIHiTgaurYomIsH2DK2ity55iy
 EoY20+VHggSl5EWV5IQsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k6ZY7G80AsI=:XGshsy6r1hG9PSzIEUqhuD
 6x/sZMOrMeJ1QUXUYhCxHvR2Vlf9OpQM206cv/eJQ+S9CmsHGc3wI9zIT8xI07CT9R6r0JC+F
 hjZVWNg08uRzHnxyzs0dOkyIUsMFIXwGC0nQPQH030tnhHWK3iD+JorwWrJexoO/GaggH9wZe
 /5ZgQigN932ADAqWXMU+hcKzsngSThAxVfioyODHb6HOX3iNN7FTS+C1YaAViKlX1EDRM1bPf
 WyYUnS6cwfQVbQjkPU1206J+pMAarglJu9IP2Xabh3/G6vy5EhUNXOfKRp4bmIp78GPKKnGsx
 mtZEC6eJhjzgD9lyvPGRLc71xgOpm3fluB+MMXhLH0RvjYQxNMDiThZk1xIg36rEOd5znmNa0
 yp1HHM0p156F7RxLnXOFzuSxudYwhCQG1C/+50XQrfoYozY6p9lWydTJKhuhMol0GanCDfbOq
 uuNVD6YboMvVb5TCST/3XV4dkwsDg21GYf1J2PAaMP3fpVZ4XnkcZyU8MMsFTZpvnjWoe9jBJ
 4myVykrjmjGwbIApnj7Q5vzKmxEnSzMXBDeHmcjy7aH213XYx4Xzr7CL/ENEEwNGPR13YWmjN
 sTbeQfsma+8sMC119OUpZGDaf1+oJjCFk7A49c4DCA9toP9DLjG13bwBBzbYmj66rRW4m0DrU
 EIMoSo9vcFOQ5nQzUitYHQd9repA+b4a261a+mfnswG1tFLRzFI1LCW5/5lbCx68SQkm/gLS7
 qeD0kNzdYq7YX86rckX41tG9z/l7flHl28eX21rBkzNGSGj5/8qzP27+c4YxjVBb7w+DxI0PX
 JW95bk+PcYDZna5mKvlkwo+kE0M6oMIBGGWtqwyFF5MUWazbcxRusQUDfNcCKJux7MUmFvMuU
 N2op4XruxfC3pwUQ7f5Y5nIC2wXgKibZZqmbW8oRb7zpkp3fh5ct0mdXryZTl4yk55ijCvGiO
 5oCwiz0f7pYYKx2E95zk8HHnBmtv/vzegJ4Jq/9thuz9pNA0r+72I183KVmttFLkUy+95Xbxc
 6S0K5CLvo7gErC5INNi92G++e4FZv7IrgblwyTiHfs4WQPW4PBHTlzITNe3JPBX35qWVF9/Yc
 hxfiNGAruOeztJd0eypY6Rr1PjLpwMzWlcy
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Fri, 5 Jul 2019, Thomas Gummerer wrote:

> When postprocessing the inner diff in range-diff, we currently replace
> the whole hunk header line with just "@@".  This matches how 'git
> tbdiff' used to handle hunk headers as well.

Right, that's why I did it this way: `tbdiff` did it.

> Most likely this is being done because line numbers in the hunk header
> are not relevant without other changes.

Yep, and even worse, it also leads to uninteresting differences.

> They can for example easily change if a range is rebased, and lines are
> added/removed before a change that we actually care about in our ranges.

Exactly.

> However it can still be useful to have the function name that 'git
> diff' extracts as additional context for the change.
>
> Note that it is not guaranteed that the hunk header actually shows up
> in the range-diff, and this change only aims to improve the case where
> a hunk header would already be included in the final output.

Very important paragraph here, thank you!

> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  range-diff.c          | 8 +++++---
>  t/t3206-range-diff.sh | 6 +++---
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/range-diff.c b/range-diff.c
> index 916afa44c0..484b1ec5a9 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -113,9 +113,11 @@ static int read_patches(const char *range, struct s=
tring_list *list)
>  				strbuf_addch(&buf, '\n');
>  			}
>  			continue;
> -		} else if (starts_with(line, "@@ "))
> -			strbuf_addstr(&buf, "@@");
> -		else if (!line[0] || starts_with(line, "index "))
> +		} else if (skip_prefix(line, "@@ ", &p)) {
> +			if (!(p =3D strstr(p, "@@")))
> +				die(_("invalid hunk header in inner diff"));

That's a bit more strict than the preimage. How about

			p =3D strstr(p, "@@");
			strbuf_addstr(&buf, p ? p : "@@");

instead?

The rest of the patch looks fine to me,
Dscho

> +			strbuf_addstr(&buf, p);
> +		} else if (!line[0] || starts_with(line, "index "))
>  			/*
>  			 * A completely blank (not ' \n', which is context)
>  			 * line is not valid in a diff.  We skip it
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index 048feaf6dd..aebd4e3693 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -110,7 +110,7 @@ test_expect_success 'changed commit' '
>  	      14
>  	4:  a63e992 ! 4:  d966c5c s/12/B/
>  	    @@ -8,7 +8,7 @@
> -	     @@
> +	     @@ A
>  	      9
>  	      10
>  	    - B
> @@ -169,7 +169,7 @@ test_expect_success 'changed commit with sm config' =
'
>  	      14
>  	4:  a63e992 ! 4:  d966c5c s/12/B/
>  	    @@ -8,7 +8,7 @@
> -	     @@
> +	     @@ A
>  	      9
>  	      10
>  	    - B
> @@ -231,7 +231,7 @@ test_expect_success 'dual-coloring' '
>  	:      14<RESET>
>  	:<RED>4:  d966c5c <RESET><YELLOW>!<RESET><GREEN> 4:  8add5f1<RESET><YE=
LLOW> s/12/B/<RESET>
>  	:    <REVERSE><CYAN>@@ -8,7 +8,7 @@<RESET>
> -	:    <CYAN> @@<RESET>
> +	:    <CYAN> @@ A<RESET>
>  	:      9<RESET>
>  	:      10<RESET>
>  	:    <REVERSE><RED>-<RESET><FAINT> BB<RESET>
> --
> 2.22.0.510.g264f2c817a
>
>
