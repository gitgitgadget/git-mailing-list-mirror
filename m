Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D95CD4F57
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 11:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbjIVLJr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 07:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjIVLJp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 07:09:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AABCAC
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 04:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695380968; x=1695985768; i=johannes.schindelin@gmx.de;
 bh=naww9tZvyzJZTusOSRFL0Oil4MUUXzMap0n+46EPOw8=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=XZegNbA/UZzlalPhg71mXGe1Gui6m75w+yJ0/XGm3S/AczRAsnnnkhiHXBcGJH5Xchet9fgVq/r
 EL9aZiXS7YyRuAmHnExmZSJClfENUyP+zREle89V50QNaNkW1XaFvrB89lnNqW+LveWpt2Ct8clOG
 xBbTGdxsNhI+po/HtOvxB/5yCdzBqDL21nALeJ20koYocm1hQKneo86y8ZKDnwt8qdNKIjRoIBaiU
 nkdn7VK7r8sQLekIv/A63BWk6VJy1UXjGyTgnZ29/qshhVPaySmn3IzRncMyS6g/rs/j2sN2whjt1
 E+ndqydo4SfFAIuqMJF0iy3E4LwopFzRdISA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.206]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWRRT-1rCPI33QHD-00XqUB; Fri, 22
 Sep 2023 13:09:28 +0200
Date:   Fri, 22 Sep 2023 13:09:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Taylor Blau <me@ttaylorr.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] .github/workflows: add coverity action
In-Reply-To: <b23951c569660e1891a7fb3ad2c2ea1952897bd7.1695332105.git.me@ttaylorr.com>
Message-ID: <d29b5fd3-3b44-89ca-62b4-cf93b23031fd@gmx.de>
References: <4590e1381feb8962cadf2b40b22086531d662ef8.1692675172.git.me@ttaylorr.com> <b23951c569660e1891a7fb3ad2c2ea1952897bd7.1695332105.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HiXCfTpYL9ZgvIaddwBIT0xZsu8Z3DhaExNsYU15grMAPSPB26K
 zzcFJL/F4Bv26luJj+fvMrAU+ZfTOeKGTh4pCw8f1Ncvz7ETa5H9OG+AiLGBmFh8PD18RTw
 I2ApsnG4x2OY1iqO1yfXBQWyiSDG1dgJv2m4TOAF0kswO/5rcN8xlvHDF0REFUILpt6z0QI
 7DylPmwb/fb1mrhGHpsBQ==
UI-OutboundReport: notjunk:1;M01:P0:SvQrDp4P5S8=;bccTIoeRcDAMad1puz1/fyDE9P9
 LAcLGDSUYw6bcUAmtr36QgF7GIfVd/Eq5lftHmcnexT8NeAWjUhv/retgkXuxDYUOTZV9X5e2
 UHEpMWx2tpC5ne5H/75e7kr7MSpzpk0sjBeOpq36JJgGva49qmaUapPXtsfgjtvVVy56oEje8
 Tj3YKaETdrJ3NxaLYenXV1LTP5npddF+DcoYFBV0Ktp9Nf3wSNub6bSJ9Yjrma5rXx9wxJNHe
 4I+5gmvpCV1+9I9rXAIiFjQ7aBVmlyAWrwhXq1LvfoojEDk+uHc02ew6CYKn3Ld26/KYwJJ4Y
 QvVCvc/nhadaJ88d0t/WPdZtYpi6apJ6xUo+8Lf6q71sB+2MkBMfDNzpz/D3ofixKFxD8uTtA
 kxV7UdOZY8VLlPSQAzg0fpoyg/AdsznCAWenva6RrZnnbsqGbj8iXje7x1EAKvUmNOTy+mpEs
 WT5qj9yODNiEXcRqFpKx13MoKrT4F4rxruRTiipny9eptovzcMsywEa/nEgifG406klGByw7m
 Z9YIHTwqdp8PXvWgWjHnLaZ1jV8Vcvb4vouop8xeRawrZnD4R9aldvL7ugw6kva/z/8SYeKcu
 r5GFJkH6EQnrITxrTD9eQcTut6GYiuUDmvWKmhPaVCtC7ltgvbonbUUy5rTB7L+S0iXrGJKy2
 LouTQskCrrbqlDgaufZksyRmH+EZ0nQavZo02t9FZWbvEyeMGVd/EH8lace+Dn1/nowO+6xKJ
 zGncLtTDwY+/O8fuEBF6dhpygPCPrV3inHddMZlgeBQM/6E/X0+rWZIVUrncIMEFkckuJcYRD
 wyew+M/6AQZDhuTviSji6yZUdyl1c994igZV/QlVYUzaBQNtArprtzt1fyQGUOeYceGcz+CZs
 iTXBpcpCtbLfuwUdlhXxoPB8V1uZr6fHKXKM12+w9L9kwbpdDwM/JnLp6n750JgG/Zmd4aTSr
 BDQOKA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

thank you for continuing your work on this. The timing is a bit
unfortunate, though: As I had not heard back from you in this thread, I
had started work yesterday morning on converting Git for Windows'
corresponding Azure Pipeline to a GitHub workflow as a consequence. I had
to leave some polishing for this morning because the validation that the
workflow actually runs correctly and is versatile enough to address both
the needs of the Git project as well as of the Git for Windows project
took longer than anticipated and revealed a couple of problems on which I
will elaborate below.

On Thu, 21 Sep 2023, Taylor Blau wrote:

> [...] using the vapier/coverity-scan Action comes with some additional
> niceties, such as caching the (rather large) Coverity tool download
> between runs.

While it is true that that Action caches the Coverity Tool, this GitHub
Action comes with a few non-niceties, too, one of them being that it
actually fails to do its job. Looking at
https://github.com/vapier/coverity-scan-action/blob/main/action.yml it can
be very easily verified that `cov-configure` is not called. But as
https://github.com/git-for-windows/git/actions/runs/6267593979/job/17020975444#step:9:12
demonstrates, this command now _needs_ to be called:

	Error:  Could not find file coverity_config.xml in directory D:/a/_temp/cov-analysis/config

	The cov-build.exe command needs a configuration file, generated by
	cov-configure, to know how to capture analysis inputs based on
	compiler invocations and/or scanning the filesystem.
	Examples of running cov-configure:

	cov-configure --cs          Microsoft C# compiler (csc)
	cov-configure --gcc         GNU C/C++ compiler (gcc/g++)
	cov-configure --java        Oracle Java compiler (javac)
	cov-configure --javascript  *.js JavaScript source code
	cov-configure --msvc        Microsoft C/C++ compiler (cl)

	See cov-configure documentation for more information.

I had encountered this issue already in April last year and had addressed
it in https://github.com/git-for-windows/build-extra/commit/cec961d2536c,
so it came as an unwelcome surprise to me that this GitHub Action leaves
this problem unaddressed.

Another issue I ran into: That Action defaults to using the URL-encoded
name of the repository (in our case, `git%2Fgit`) as Coverity project
name. That project does not exist, though, and the GitHub Action therefore
silently assumes an empty MD5 and attempts to extract a tar file that is
actually a text file instead, with the contents "Not found".

Further, when I tried to specify `win64` as this GitHub Action's
`platform` input variable (whose existence suggests that platforms other
than `linux64` are allowed), it totally fell over, trying to untar a
`.zip` file.

For this and for various other reasons detailed in the cover letter of
https://lore.kernel.org/git/pull.1588.git.1695379323.gitgitgadget@gmail.com,
it would appear that unfortunately that GitHub Action won't be helpful
here.

Ciao,
Johannes
