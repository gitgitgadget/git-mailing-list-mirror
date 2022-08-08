Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973C1C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 13:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242800AbiHHNNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 09:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243206AbiHHNNF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 09:13:05 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03DD2EF
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 06:13:03 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 186-20020a1c02c3000000b003a34ac64bdfso5139450wmc.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=Gr42mM1Ban94NMYX12/wIjocw6Ls7TeGq8uyl4Gh6v0=;
        b=Qq0gnP8x7TrKvWyGfajDWgEhycACShrVLDAS8kGKpJcCg+fVhLVcGEiWw74EulVCBK
         vYmhLeEZXuVB3JXaTxl08UUZwssR2XsBpgtITTFiXJWmh8r1Gipkm1PWi1D54rU6SbQ5
         UDFmBDtOxQBUVwm6tTU1dgP6Tat9MOErIu/2CrUlb24gwWfKQSPmaP7EAZlSbvOl2QRo
         znwRctrXXMJL+rtF/cyxsXVFp4jP/E4ENBMLjdKShKg8D8rq2niMZQgU6f0LmNQSY7bp
         6ZMPTnTTGM+NXHF0lM9s9CxoUaeOYkFKR+HrkbhH8OyQf2liF9cnLsu1B8ewx90HAomA
         nA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Gr42mM1Ban94NMYX12/wIjocw6Ls7TeGq8uyl4Gh6v0=;
        b=Un7nS6gJOMoS4lmULgt7YXuSNNo600b435hBTalpTnpOfOvsUC1s78zmqSyAknOF3+
         l3Q2cgyoaYHK3S/tTAuRmZod8byNZ433JqCwt3mFJZPcwN2hagxmWun+WaQhkvKMejWf
         Z4HnyTQzPa8d5a8VpuG6m0LsIGOGGgIiVpsUIIj4p9axvZt66lnmmpgrHL5t1c8+LEAB
         IGodzv69026Vb9A+7vQJZhXbO5yaDamK0XBbS8mrqgRscpZTpG4SGJKhdA2wK60PDgn9
         AWyeX5i7DzQxLP4onZ8TUHomwTWLt0oDsKCozspk1a0ncuzs7iwyYc/Ea/0LgdPiJsLQ
         3oHQ==
X-Gm-Message-State: ACgBeo3IiOz19CdJaKl1pBRoRZaSHCAK9BznnIasE5RAAzetLDCsLkHk
        69zClCeA+QKCVOQPhuiGPd4wwxYPC10=
X-Google-Smtp-Source: AA6agR5o83M6mSF9jEEABGeFBvmdPLr2w9Wc3Lcq8jwUslKijJW92aP/nv+8lSEDGWUL9J40E7q2RQ==
X-Received: by 2002:a7b:c003:0:b0:39c:5642:e415 with SMTP id c3-20020a7bc003000000b0039c5642e415mr17029521wmb.111.1659964382205;
        Mon, 08 Aug 2022 06:13:02 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id t25-20020a1c7719000000b003a2cf1ba9e2sm5372172wmi.6.2022.08.08.06.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 06:13:01 -0700 (PDT)
Message-ID: <47bfbdb5-c907-6a35-6662-72a446869227@gmail.com>
Date:   Mon, 8 Aug 2022 14:12:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: --batch or some --paths-file for very long lists of paths
Content-Language: en-GB-large
To:     Yaroslav Halchenko <yoh@onerussian.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <YuxPNFtTBmkZkiCW@lena.dartmouth.edu>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <YuxPNFtTBmkZkiCW@lena.dartmouth.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Yaroslav

On 04/08/2022 23:59, Yaroslav Halchenko wrote:
> Dear Git Gurus,
> 
> In DataLad (https://datalad.org) we are doing "our own" analysis of what
> specific files (not entire directories) should git and git-annex operate
> on.  Obviously, in large repositories (and we have with >100k files)
> that might require invoking  git add  or  git diff  etc with a long list
> of paths specified in the command line.  For that we often split
> invocation into multiple and even resort to   git commit --amend  to
> combine multiple commits then into a single one.
> 
> But I wondered if may be there is already some trick to make such
> commands as   status, diff, add, commit   to operate on arbitrarily long
> list of paths passed to that git command somehow.

A number of porcelain commands have a --pathspec-from-file option that 
takes a file with a list of pathspecs or reads them from stdin. When 
combined with --pathspec-file-nul this handles paths containing newline 
correctly or you can quote them without this option. You can pass 
--literal-pathspecs if you have a list of paths rather than pathspecs.

At the plumbing level you can use "update-index" to add/delete/update 
paths in the index which will read paths from stdin and "checkout-index" 
will also read paths from stdin.

The diff family do not have any support for --pathspec-from-file at the 
moment but I'd be happy to see someone implement it (I think it would be 
fairly straight forward).

> Note that gitglossary (at least in 2.35.1 git on debian) says that
> 
> 	Pathspecs are used on the command line of "git ls-files", "git
>      ls-tree", "git add", "git grep", "git diff", "git checkout", and many other
>      commands ...
> 
> but
> 
> 	$> git ls-tree -h | head -n1
> 	usage: git ls-tree [<options>] <tree-ish> [<path>...]
> 
> so it is <path> not the <pathspec> like (why in stderr this time?)
> 
> 	$> git commit -h 2>&1 | head -n1
> 	usage: git commit [<options>] [--] <pathspec>...
> 
> So if in both cases it is pathspec, may be pathspec could support some
> other magical keyword like :(filelist)/tmp/mylonglistofpaths ?

I like that path magic idea, but as we already have --pathspec-from-file 
I think we'd be better improving support for that.

Best Wishes

Phillip

> Thanks in advance for your time and thoughts,
