Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FFB6202CA
	for <e@80x24.org>; Sun,  5 Mar 2017 03:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752534AbdCEDg7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 22:36:59 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33865 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbdCEDg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 22:36:59 -0500
Received: by mail-qk0-f180.google.com with SMTP id g129so46327087qkd.1
        for <git@vger.kernel.org>; Sat, 04 Mar 2017 19:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+PTxezdvHIYLLsVRdtUhVwipW6Fq+80fEMxOKpsUhGE=;
        b=o/IpTL8vs/YTSuyNJUnR6UvWvb2x+ZdIhizN3xJA+5K6s1A9N+GEF6TnqLihOHBVxX
         PQurrbCeheaaxFk9Se1FU26AobNHQDcZdwaGin9+q4hl9TZf+OOoq/7yvdSK1yHQ27Zq
         4wZPtsxXFmvhhcEVtyTuBgTUgHKe/HjBmW5BopUkyxx+tC9zOmj+SO0ehPcyeU4O1C66
         nW7JYZdD7bOTlIixHjq7A3WDhpcjKo4s5wTEWCheOkr2ILTBNz3cPeFpTj10j1ipoh04
         uoGPS2ivo3AhSvL/v1qvJ6QRPfszxkWaaQ7XZH5wpntU2se3Y1Bn/DxJqHel0f0ja5Uf
         qVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=+PTxezdvHIYLLsVRdtUhVwipW6Fq+80fEMxOKpsUhGE=;
        b=OjOD8rw3xdQekSqBd7Wm8qVKYUxPqg313nVI7to8RG+bxTjofTpjowi3w64c/CD2wE
         eKNs8Iu6dXJTH1grSMNRRcCDYk0000NYwGDPK8/KSCARkR6fohrSIZ2+xp1spT25gBoL
         xzKZRZ92i8NgcVnrWwQOGwH/bo952SIqCzNJSyMyhkE0q3B4S2Mw4b9rn+GW0s21EC0o
         e0H3vCZ13GrzuNVf11FtjmjRHm381km3GpyZ70YQmVRSAFt3uuAlAcFx+WuC+sg6yMJ5
         i0Tdldnr62ENLvBqq3tIPMeG5BR5uMBcuVhjO66QT9XY4twjJ4LIHv0Mwk/It9LZYgmb
         RHfQ==
X-Gm-Message-State: AMke39kZMDzh3sYnhhzew5rRCgIjDQUI8rn/rjTIA1xWP7mJBe/h4uQK6l+RCtNUn6PxdWn2bLZFOxvk738Flw==
X-Received: by 10.200.35.36 with SMTP id a33mr9822411qta.216.1488685017695;
 Sat, 04 Mar 2017 19:36:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.178.20 with HTTP; Sat, 4 Mar 2017 19:36:37 -0800 (PST)
In-Reply-To: <20170304073952.drfgy7jacnlm6tum@sigill.intra.peff.net>
References: <cover.1488506615.git.johannes.schindelin@gmx.de>
 <cover.1488562287.git.johannes.schindelin@gmx.de> <20170304073952.drfgy7jacnlm6tum@sigill.intra.peff.net>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Sat, 4 Mar 2017 19:36:37 -0800
X-Google-Sender-Auth: cL6uCB2qUhigzKkFksofHF8hsGo
Message-ID: <CAPc5daXZ+VUKYtNV4OT+CBsqL3qOGiKQsttFJdby6OrNzMOxbg@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Fix the early config
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 3, 2017 at 11:39 PM, Jeff King <peff@peff.net> wrote:
>>  +     * When we are not about to create a repository ourselves (init or
>>  +     * clone) and when no .git/ directory was set up yet (in which case
>>  +     * git_config_with_options() would already have picked up the
>>  +     * repository config), we ask discover_git_directory() to figure out
>>  +     * whether there is any repository config we should use (but unlike
>>  +     * setup_git_directory_gently(), no global state is changed, most
>>  +     * notably, the current working directory is still the same after
>>  +     * the call).
>>        */
>>  -    if (!startup_info->creating_repository && !have_git_dir() &&
>>  -        discover_git_directory(&buf)) {
>>  +    if (!have_git_dir() && discover_git_directory(&buf)) {
>
> I think this "when we are not about to..." part of the comment is no
> longer true, given the second part of the hunk.

Good point.

> The parts that actually confused me were the parameters (mostly whether
> gitdir was a directory to start looking in, or an output parameter). So
> maybe:
>
>   /*
>    * Find GIT_DIR of the repository that contains the current working
>    * directory, without changing the working directory or other global
>    * state. The result is appended to gitdir. The return value is NULL
>    * if no repository was found, or gitdir->buf otherwise.
>    */

This, too.

> This looks good to me aside from those few comment nits. I'm still not
> sure I understand how ceil_offset works in setup_git_directory_gently_1(),
> but I don't think your patch actually changed it. I can live with my
> confusion.

I'll wait to see if Dscho wants to clarify the code and comments further.

Thanks.
