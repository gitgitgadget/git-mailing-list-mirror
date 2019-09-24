Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 492741F463
	for <e@80x24.org>; Tue, 24 Sep 2019 03:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405585AbfIXDqX (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 23:46:23 -0400
Received: from mout.web.de ([212.227.17.11]:44197 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389841AbfIXDqX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 23:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569296773;
        bh=clV4pw8UG9cj+hIRh2tq1J+FbUzKBT4WcYqSpH3BsWY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=o8CxYBHIhg0g2qirwjZNzNJJny+qDy4cG2YUSL/rHo5uFAYDZYpq/sSEgOmym/kxE
         By5bezZa+q5U6lwb8G1aPrhMNOxcruemiXTOrKUOtGPRHKrnfBbKXyk1BWQUzwdR2a
         Rr9BfFUvlVio+Cp+/I6MLNI4ZVt50TXU8gA0BY44=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MNLNt-1iEWWj3QFd-006sUP; Tue, 24
 Sep 2019 05:46:12 +0200
Date:   Tue, 24 Sep 2019 05:46:11 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH v2 1/2] t0028: fix test for UTF-16-LE-BOM
Message-ID: <20190924034611.6bsy627udlzgxuv2@tb-raspi4>
References: <pull.347.git.gitgitgadget@gmail.com>
 <pull.347.v2.git.gitgitgadget@gmail.com>
 <d717a60932223443e95c000f4d17210b07d7b1a9.1569233057.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d717a60932223443e95c000f4d17210b07d7b1a9.1569233057.git.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:7H5TcAKpjKu+52Jj+TBkwtmQzHjmjM5HMTcZGPQkVQGGu3RiDgP
 WUOchlSoQ/A9+yKKD+h3GUMAEOGXTF0ICvpYmbulu2JQAQbOQ5eLC4E4WQ1FbpKB2N6Byd7
 6mFUWTbJl5WSPEJsLOO5itYj/UPtDPGsHOkR0CviI7Wti4sTK3/LZZzuNFRqUA2sZ/zSujz
 pgfHyK5lm0uesZPrWx0bg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PHuONcA/ZRs=:DOc6KLL04ZO333V4UEgkWT
 A5kR1agm2GvR8I2P496I6AO1to3+ZN91X4k4p6ZBcE2wzjFSpSXy5IOS53FoPYtKcXrXz0AQB
 sJkEG89n1Aj+pw826tUCkpWBDTtM9TrCXzyh0FROFidASTdyOsbiNS1d74OhQ5yzP5U4goxVN
 jQo4DijGMVE1mEZQBBXAmOYmLgwte9o9dLQoh/vATiEg7fQR4yCPTsfK2j7ssc5d0icM4+4nu
 rAMsn26rjFUMne0nvJVNR2146WE12islT0FEnClJdI75z62zWKo54Z6pXEs1uFhZpumpVewLH
 /nXFYHc9pi5jhaXi+libsaIbrDNXBWlYe6GLQEYmD5OYhJkb4ON1JkMxmNfM59dFWYYN9ZeMv
 bpvWDAwehiGzwPCqo125OwNtjAIAtALRCpVkXE6CWq/u38ffcGLYyszWNscatEYZIIdaC2TYt
 4HsEA5UF0ReJ1fjoNdZ6SoHLCCWmHOX2YfgDorDG1VFPP8wRN2UURLRmp54Q31eYDlEFR9d+8
 Dy2Y/zTm2MKTMR8G+AURUugF1YlCCdYpavA4Jq0BsMAy3ZP6iV+wWgHo8h9uIToEiP7S+j0zs
 8MqpK/bCYWShymW71zp9bqYh/oBmhxsFFpPM1vEIG9Emy8mtM+5ewNI9aQ+kxJGu+xV3AoEZ6
 Rwnvv2lsRhdgnmWluC4/GBLST2y7Qu/0ZYjNxunrk+Clstw0Do5sffuw+f3n24cWSed5orkL0
 02qNc29mLBcFxzQGOwEqKxR3riE37WB3pDTDAYy8eSd2u2/xsIaMVCD+o+212M3R4PYsQapJs
 Yx/J00XLSZOmqVTBiFkfYTwI/77U1p8zzIZC2gtorAol0sJvekr6R24lNfww33yI32DlbzSJ7
 wUvW/OCJ599dX2tLeuOdD/EH2crqvveinc9gAupMe45iLchbjCX5YE0SlDnh68bvtcqTU8Hlx
 MMSEnRaYR3Uz7TZOlEjuYTTKsPICELBlrUkxmZ30OATR9V/72GuszQxTE8xOtNOshm4h2yBcO
 SMy4+cxm7VSkoApMKKyD6b5FShuPQY0p6w4eb+sv9j2d2Cvnlcl15UsNjMW0hS1xC3eXF+3iE
 uu4XTp9WRCcNuVIvLIZORga+vCynE8XdDUBVmteAGQD/vB3/PUKHOxhdjaYHlpPlRp4Bntlf2
 c74/FGexUaxYPEIYAF7b6kVzHAvLLOjYRfJ2K9Kxdcmh+wpeHmV57v4pInadgQ0i4LTVj8j+u
 xo+rRjEGfBtmlXYXiVxU60KlhVxEP0Lmwqri+Bw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 23, 2019 at 03:04:19AM -0700, Alexandr Miloslavskiy via GitGit=
Gadget wrote:
> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
>
> According to its name, the test is designed for UTF-16-LE-BOM.
> However, possibly due to copy&paste oversight, it was using UTF-32 file.
>
> While the test succeeds (probably interprets extra \x00\x00 as embedded

We can probably drop the "probably" ?

> zero), I myself had an unrelated problem which caused the test to fail.

Out of curiosity:
What made the test fail, and does it pass noe ?

> When analyzing the failure I was quite puzzled by the fact that the
> test is obviously bugged. And it seems that I'm not alone:
> https://public-inbox.org/git/CAH8yC8kSakS807d4jc_BtcUJOrcVT4No37AXSz=3Dj=
ePxhw-o9Dg@mail.gmail.com/T/#u
>
> This fix changes the test to follow its original intention.

Thanks for debugging and cleaning up my mess.
The patch is correct, and I have one or two small improvements in the
wording.

How about the following:

According to its name, the test is designed for UTF-16-LE-BOM.
However, possibly due to copy&paste oversight, it was using UTF-32.

While the test succeeds (extra \000\000 are interpreted as NUL),
I myself had an unrelated problem which caused the test to fail.
When analyzing the failure I was quite puzzled by the fact that the
test is obviously bugged. And it seems that I'm not alone:
https://public-inbox.org/git/CAH8yC8kSakS807d4jc_BtcUJOrcVT4No37AXSz=3DjeP=
xhw-o9Dg@mail.gmail.com/T/#u

Fix the test to follow its original intention.

>
> Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
> ---
>  t/t0028-working-tree-encoding.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-enc=
oding.sh
> index 1090e650ed..5493cf3ca9 100755
> --- a/t/t0028-working-tree-encoding.sh
> +++ b/t/t0028-working-tree-encoding.sh
> @@ -40,7 +40,7 @@ test_expect_success 'setup test files' '
>  	printf "$text" | write_utf16 >test.utf16.raw &&
>  	printf "$text" | write_utf32 >test.utf32.raw &&
>  	printf "\377\376"                         >test.utf16lebom.raw &&
> -	printf "$text" | iconv -f UTF-8 -t UTF-32LE >>test.utf16lebom.raw &&
> +	printf "$text" | iconv -f UTF-8 -t UTF-16LE >>test.utf16lebom.raw &&
>
>  	# Line ending tests
>  	printf "one\ntwo\nthree\n" >lf.utf8.raw &&
> --
> gitgitgadget
>
>
