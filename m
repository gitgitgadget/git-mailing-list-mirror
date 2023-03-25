Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EA5C6FD1F
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 18:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjCYSJm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 14:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjCYSJl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 14:09:41 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE72C40CB
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 11:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1679767776; i=l.s.r@web.de;
        bh=Qzry+yRbZ9sths6M5rx7wQZ1h7xynGseRQPo3pPjVoQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=OtATa+WF69Ym25D5ZDuyK/ZWfU78FYHBPcu/cgaip9SNIt1BHi6NCoKA14zoOpHog
         AtL7kt85+QMBxNQhFEMkGv6o5guUMl2HLCT5iTBc9G/tJMhQXOTzO28mpurv0xqYOt
         csXAQUQyOc+9zOXOsHG/+wxDHU2cLTv+wRT5Pz7TIP+9OErzp/LBS9Sn52/lkYriDX
         dM9r3bcH3c/5jy3j8kJaEEPpNztk5Xk5wbwr39Q1N+S7qS41/mNShpj8KCfd9V1iC7
         iRbq4zbQBF0yQgGP/vw/BD3F/7ke8WOg7TKz9ynwdsGmzLTp3C9R8rmh11xz/+yxu9
         eYJ966joxbvcA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.31.43]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MAtsZ-1pmPqz09vt-00BGm3; Sat, 25
 Mar 2023 19:09:36 +0100
Message-ID: <eba23dc4-c036-fd1b-a1f0-028e8fff602b@web.de>
Date:   Sat, 25 Mar 2023 19:09:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: git bug: Perl compatible regular expressions do not work as
 expected
Content-Language: en-US
To:     Mario Grgic <mario_grgic@hotmail.com>,
        demerphq <demerphq@gmail.com>
Cc:     git@vger.kernel.org
References: <MW4PR20MB5517583CBEEF34B1E87CCF1290859@MW4PR20MB5517.namprd20.prod.outlook.com>
 <CANgJU+Vn8ZLGcAYbuDeNkv6T5YdX6t20BqGQDPB0VL_TzoGSWg@mail.gmail.com>
 <MW4PR20MB5517888E63C13099E284B97590859@MW4PR20MB5517.namprd20.prod.outlook.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <MW4PR20MB5517888E63C13099E284B97590859@MW4PR20MB5517.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JMbDqMIrngCMR/nkMBhHhDUC/BkHF5/uyD3ibjB9plBrKMAcGMQ
 rYch26fs/fUcge6PZ9EL+koFjAhTT5qqACyGVsFfSgcHqH5MnNNFHsZJYOc9HI9de4Vuimd
 QroY2xBI3IIDLN0kCCa4ekHhc5E25zh09Yjn2aIxzhUghhhyoLtug5e7A3gKNcjvJnHZvsh
 gmbmdeuiEw9dQ7FCLHIYw==
UI-OutboundReport: notjunk:1;M01:P0:76R7JJNSQgA=;IdWGu6QeQM8uHMOqezLT36LLMkL
 Dnnd+tjmnWM3CvOaz9cX0JevLvY7gziGd+DCzPjv1Rg/fU/UzZfCgNJV6/TZmRaTpl6IJ6ojU
 pa9KJrlvH91jLv1S8HYgdaY/ucGFnRAvGlEy3XOyRJHo+HViX2FZ/uZBMG3emZcVidG4jJONZ
 QPkJ2pfZutoKQRkOS+ZMNelIgj6XuFyjvKHYjSLsTm5bKBqfMewH9ScFQzC4L2XsCAiUERmJr
 I2U7KFujBEG4xVRtRpDIV5XrxaImwvWWzDRsZ8XrElEtBCs7lP2HWrqIbKHmgB1arhFvohHI+
 +13wCBvn6log1cdmxrQXsvykpMm9/srd80hTPwvlujPgKpHeQ8UzDYehYljcvAoqbpNBnmqO8
 mCbRq+HxVpiX2MRgBP90p7N3FBLfqC+fqaSb/PmZxBPDQ2om1t1DATQ/Zo5J9dI7FSL6fQA1S
 i+numeG/U1glKjvUnHH1VbUHglJr0uMC6l6BmvqsjJrUcXU3AZMj2isHsaQyAc+O2EKYhb4bY
 ikyjOfQ8cyTA2fexeyz4roR6qCFHIbIJWnopPpwL2BjcTErFqCUXYmRLIc7hrZkvT58iuUnpq
 /3xG02c65uqiG7X1pbOO7BGlungj/UhAYqsDxVNm58d7jrsp3woA3JmfjX8Ag8NFoJmP+gyqT
 ANyHDBMhlnAZEL67FCGHA1/1PKbSGu+luxOPbtnjiiOMB/sV7K5911ZB6JssTgJJ5eYf5aRrQ
 gjMX/IkOFiiFQie/5bpWCDpttjn9X6j2dnP3+w6RzcxQvYSLBEQu3JQ8Vc3Lw8SiemN2SEK7I
 TrZkEJ29dXP+/F+wgDC6dbKkiESu/nC46Wg9NYCJr/76YsOGQuI6RpzBZrqHKIiv2hxB59A84
 Tz9ruWUmjKKV3kWKEkK5NSynmvFBn2j09laQG6akEwWISlaztwpOHwtkPNLWgT0L6235tJAOO
 yWJGaQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.03.23 um 14:09 schrieb Mario Grgic:
> The lowercase -p is to print the output in patch format. You can rewrite=
 the command line as
>
>  git log --all --patch --perl-regexp -G '\bmain\b=E2=80=99
>
> I still get no output in any git version after 2.38.4

-G doesn't support Perl regular expressions.  --perl-regexp only affects
=2D-grep, --grep-reflog, --author, and --committer.  Neither POSIX basic
nor extended regular expressions support \b as word boundary.  GNU regex
and our compat/regex/ do, as extensions.  macOS regex supports it if the
flag REG_ENHANCED is given to regcomp(3).

So perhaps this is rather a feature request to support Perl regular
expressions for -G (and probably -S as well).  Or to enable REG_ENHANCED
for them, at least, like 54463d32ef (use enhanced basic regular
expressions on macOS, 2023-01-08) did to get alternations for git grep
on macOS.

Ren=C3=A9

