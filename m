Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C618C43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 14:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiGOO2P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 10:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGOO2O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 10:28:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9430A5D0C9
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 07:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657895278;
        bh=nRA43C+pOfp7qBSLzxQQRrx8N//aOcU92xtue0RHZsI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KjC/9XBwtL1+amdwvmAfzAkNZTBk8RueYj/YVTLt4v3ek7BgCszSqcrtVkvCczN4f
         nBjPE0Q3fq2kqmyBPKN7uKuDFY7/cZU9HDhawGDTfDvX+Qg+U8tpa5EY8h1DnOpXaA
         YN7iXZWreWyCGUJIvW6vwBYYW1AfIzOtlD0PA2W4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.21.23.67] ([89.1.215.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQMuX-1npzvb17wn-00MKqR; Fri, 15
 Jul 2022 16:27:58 +0200
Date:   Fri, 15 Jul 2022 16:27:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC][PATCH] mingw: avoid mktemp() in mkstemp() implementation
In-Reply-To: <7265e37f-fd29-3579-b840-19a1df52a59f@web.de>
Message-ID: <s2ooq33p-sn76-o2q9-8471-4411rp1ppq7s@tzk.qr>
References: <7265e37f-fd29-3579-b840-19a1df52a59f@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-646679950-1657895279=:184"
X-Provags-ID: V03:K1:mJVpd/ijin6alOYmiO4VX+925SfnFZrYG45lZw6631a9xD1xQS8
 yLUxOVKjMoo49JbWh2gGNsTJTt9qG6WGM41rSBfwzkqnaivHNGZe7OUOpchUnq+QTM7fh1L
 TeiCyiA5EKOmsuxQei6dnfnUMClrenMr4z9aH7nM3MzAdCOpm22hKWvHam13yVKac8VyhyZ
 UAi6fe2ugbwHl1uxVY0cw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HMY65Ceo2mg=:+9y2XnAK727LqUK69zW10n
 a9wK7qKZF5O2mK4u59YAzKPPh9Z68wNsgXlYrXsJiSjsgwRG7dcnEKp3k72Bph9ZyldMxFp2b
 y5/A0M2RY+S10OgCJfpXMpbTMFKPQTwxFFnLV+6Qy14rWU9RUBMANNN4SEqcaQ4Lunzpzopx/
 Y4U/EhR4Cdry6yShBOJrbMts1A8+nRondqFF0561+XevaKW9IPYTE8ficDI96bCGyOHCzLlW9
 8UhLYjTIKp1Gq/Z/vNOhnwaNeXOaZl1rtVvuSy8zQUkj6OhdqMeB2MpOsau9Dz9cnWqLMOIpf
 41fNTRaEpbEBBrJaANrUpEI0ejRMt3dgpF1JB+FpneWeKFUunTpkisErKxnOhoYEvVxfR2aUU
 1opbvvMKczTMfCwXrlQiZDooZYb0hiNnUaTmHczydw4bs7panbNfTcE7janGdd1m11yObxJiY
 Kd2W2XBGNgIUK7IGiKVwVwboWEB6zxwYaby8Cg3I9FkjME/PjHQG46wqkYp6qf/FDMiCn41bp
 RE6E6ZnS4KJpMENBf5E3EctdrVGXpQVH8agAW5mUdI/LquRu2UNWuhqoPV9wrghpaKtJ+nt/0
 Rrn6Lbz7HxEtJX1aUmg6PfhMbKQ1bfBYpMN/zTCLeO0rIEIj3GwsUI3A5qj7RWOUz9qOoLNKy
 +o/KQNwojpGsIgWN+gwpdwDlHfwSJIsRanKh1J6TzvmgKZBc7H+qgwil5gFRgNiZpFKWXe7ED
 e1t7mVs1GKOJ77Dg7ZfFQ9gYIDQaO7olnRSqHBoWIc1YoMrifw83uJXr3UUrYvtq2/moATvxb
 C0a1zxljNjLJAWtd5JMnA/smzWV9WcA46JzXi7FJclb6UR/By6umscreDGhodDjUPM5XvpvND
 WSXwKENDd+xnmbBBmit3R1Ew38K4aH9u44rU6ysOVfZP0PJ6r5HJGnVWNdZt9vKpEsqc1qfeD
 i61uUhsK3xXC0utAeylel5cZsSy3gI5AtIYGphuyLIbSftOr85/nER+o0o5+4TD20cViUczau
 WetpLmrwS8kgITHPIrY+3mn5VNjgzfRnmtYkixgiQ+cQvnyiZMVEXhiCgV2gK0GALRzKl8lWO
 cZPN7ZSeYPKTKqUp2jGqglcmV5eYPvH6ZP4XdLgWODe66NObyyBGiVp/Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-646679950-1657895279=:184
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Fri, 15 Jul 2022, Ren=C3=A9 Scharfe wrote:

> The implementation of mkstemp() for MinGW uses mktemp() and open()
> without the flag O_EXCL, which is racy.  It's not a security problem
> for now because all of its callers only create files within the
> repository (incl. worktrees).  Replace it with a call to our more
> secure internal function, git_mkstemp_mode(), to prevent possible
> future issues.

Excellent analysis! And thank you for noticing and fixing it!

I agree with what you wrote, there is one instance where not only files
inside the `.git` directory are created but also files in the worktree:
`ll-merge.c` has some code to write out files in the worktree before
calling an external merge driver.

I believe that your assessment is correct, and that this cannot
realistically be exploited (the only attack vector I came up with involved
a shared repository, a symbolic link to overwrite/corrupt some files only
writable by the attack's target, and some rather narrow TOCTOU window
between that `mktemp()` and the `open()` call).

> diff --git a/compat/mingw.c b/compat/mingw.c
> index 2607de93af..b5502997e2 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1059,10 +1059,7 @@ char *mingw_mktemp(char *template)
>
>  int mkstemp(char *template)
>  {
> -	char *filename =3D mktemp(template);
> -	if (!filename)
> -		return -1;
> -	return open(filename, O_RDWR | O_CREAT, 0600);
> +	return git_mkstemp_mode(template, 0600);

It is also much simpler to reason about the post image of this patch than
about the pre image.

ACK!

Thank you so much!
Dscho

>  }
>
>  int gettimeofday(struct timeval *tv, void *tz)
> --
> 2.37.0
>

--8323328-646679950-1657895279=:184--
