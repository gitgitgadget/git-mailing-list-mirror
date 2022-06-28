Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D618C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 13:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346311AbiF1NXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 09:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346294AbiF1NWz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 09:22:55 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06713139D
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:20:26 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id p13so8158649ilq.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uIMvaGbJNPw48DyWBwQvGVIjNl4h06TfM2g1MzgzvMU=;
        b=gFNOaBjXp+dQlBQxQO/ehawbBHy0hdXD/BjoluGTSLjvLZ9/mtNOL8FMZ2cNseM4gA
         VyO6snqmSqaXDX6uye6mhow7KCzncHn5HhFiKXqgjkGpB3tO8Xe9OqhYoOFmG1wJVDqx
         jqaDHUfPY7NzF27UDQc3cwOEvyvMovyzR+V3CB+GCLEA54CAal2hnpg1o64GLu/4vsv+
         KPeF/uKOcFqOp7u6SMBcpd6sretNLqG4ybm1bt35vMfruPP8tUDcjrtdyH5vlfafWna5
         xxk/OusyzBiuGy+rrI+VpQg4KiiwlfLx2rbtXX3yRLfps3BVhotCpJIsjYKaJjpskGLB
         bqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uIMvaGbJNPw48DyWBwQvGVIjNl4h06TfM2g1MzgzvMU=;
        b=M5VoUf4egBvAps/AWxgrpTYCNzuQ/5h0uHlMroHHwToF1UX5SJPpDKGh1gzThhNL9q
         8naBXspCcHisH6YevKg+JPVzaAldDksFsLxdgydlSqEGj9EOYwnPt+diDE4bXFpFFP2t
         jKpn1CTo4rP9UiyXLfGppLUDxwFT8MtQgX3nP2Zi/UIH0RqwTEWnt4AxYwnLANKu9lCU
         a2AZWAqIYjkgmTYeWvYgXYu3FIRyitWZGODmtytQVXeWTLc6HjqhGp1n26kKH25KKUOi
         y/jpNMK8bP8QQD5ZUOtsAuOXNoep2VOXZHqtHV7zHKP9psjVkS9kXaDgi/Og2xSJSyNa
         F8dA==
X-Gm-Message-State: AJIora9doYg66h0UISmQMhwIf6MglSQRt7yvuLpmG0jSGwd10KJq0gxL
        d3MHpx8qVNShZB2iXvZsquEN
X-Google-Smtp-Source: AGRyM1s2HNb890pmVJyTShD1Phrkv3xFymKv8uINHREx4GfAd/8rInuXVLxaZQ/CSpqMMcJ4GqEkgg==
X-Received: by 2002:a05:6e02:1214:b0:2da:705c:5f03 with SMTP id a20-20020a056e02121400b002da705c5f03mr10344560ilq.318.1656422426003;
        Tue, 28 Jun 2022 06:20:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9537:28a2:3225:9796? ([2600:1700:e72:80a0:9537:28a2:3225:9796])
        by smtp.gmail.com with ESMTPSA id x13-20020a92dc4d000000b002d94b276fc8sm5851218ilq.6.2022.06.28.06.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 06:20:25 -0700 (PDT)
Message-ID: <a01c1ff7-74a7-b32f-1a1e-a8f2e840ae31@github.com>
Date:   Tue, 28 Jun 2022 09:20:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Rendering back-ticks in plaintext docs (was Re: [PATCH]
 git-rebase.txt: use back-ticks consistently)
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        Johannes.Schindelin@gmx.de
References: <pull.1270.git.1656364861242.gitgitgadget@gmail.com>
 <220628.86k091f5fy.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220628.86k091f5fy.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/2022 6:22 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Jun 27 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
> 
> This looks 99% good, but...

>>      3. Focus on the edits that most-recently edited these lines. Doing some
>>         scripting, I was able to construct this date-sorted list of previous
>>         edits (by diffing the git blame output before and after this
>>         change). The most-recent changes before this are:
> 
> I think this is fine, but I want to recommend doc-diff in your toolkit,
> e.g.:

Thanks for the recommendation!
	
> 	$ Documentation/doc-diff HEAD~ HEAD -- -U0|cat
> 	diff --git a/e4a4b31577c7419497ac30cebe30d755b97752c5/home/avar/share/man/man1/git-rebase.1 b/e37244faa0a730bb930dac4e10d8eed4af682a5d/home/avar/share/man/man1/git-rebase.1
> 	index 91ccda823b2..41dfbee38a4 100644
> 	--- a/e4a4b31577c7419497ac30cebe30d755b97752c5/home/avar/share/man/man1/git-rebase.1
> 	+++ b/e37244faa0a730bb930dac4e10d8eed4af682a5d/home/avar/share/man/man1/git-rebase.1
> 	@@ -489,2 +489,2 @@ OPTIONS
> 	-           Append "exec <cmd>" after each line creating a commit in the final
> 	-           history. <cmd> will be interpreted as one or more shell commands.
> 	+           Append exec <cmd> after each line creating a commit in the final
> 	+           history.  <cmd> will be interpreted as one or more shell commands.
> 	@@ -502 +502 @@ OPTIONS
> 	-           If --autosquash is used, "exec" lines will not be appended for the
> 	+           If --autosquash is used, exec lines will not be appended for the
> 	@@ -880 +880 @@ NOTES
> 	-       When the git-rebase command is run, it will first execute a
> 	+       When the git rebase command is run, it will first execute a
> 
> I see Phillip spotted some of this already, but the "exec" change here
> looks unwanted, i.e. let's use double quotes there.

This is definitely an issue where I was looking at the HTML formatted
output, which respects back-ticks. Thanks for pointing out that the
text docs just ignore back-ticks. This seems problematic, in my opinion.

Is it possible to update our doc formatting to convert back-ticks into
something like single quotes? That would help these plain-text documents
point out these places where exact strings are very important.

I also have no idea where to look to make such a change, and it would be
very wide-ranging. I just think that the plaintext docs are currently a
lossy medium and we should work to improve that.

Thanks,
-Stolee
