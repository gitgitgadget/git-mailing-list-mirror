Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709A2C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 13:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiGUN6e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 09:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiGUN6d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 09:58:33 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EDA1D332
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 06:58:29 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g12so1844345pfb.3
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 06:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Y0aaOHPKesPOOFECu0uFjHkZda4cxsSeBi2lpzVTPmM=;
        b=W4LCGUSb220QphU/EypJIkYYzyCyapITByZqq93PlnX+sFScnIMynRl/CMKQqelFDx
         3EiLeaphx4W0osHUly+lA7u2j3EO4IuSBJMjHUA2lW8GzdWEGc5rcNsnwMnp1h1sJMZr
         MdkW6JZz2EBwhjqvDIl8hljw3u/0eOtEnFPTL6MPWqVMcFV9oxTUGrNYLx0Jll8ZA9wm
         Je8MZcgkK/rf127W/xVFCi21gWZ8472yunv4z9YRH9NUWAyoBmMC+G+JYLDqDhUI1xO7
         /GJR6Jm+pkNh0X17wioEFfpqywl9NvrCRv5FS9RrWXAPdcg9KjwHl3T0Yp+XQ269CrrG
         gppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y0aaOHPKesPOOFECu0uFjHkZda4cxsSeBi2lpzVTPmM=;
        b=I36tZ7rLbCONIJxNlnfD+QTDUUWs4sDs0ESy5i+2CUy0XQrt/GwHRHBRSZTOoAPZE6
         nPt8q37Gsru4Ku0Z/9GiBFOa9H8oFJx4xzET1CvYw2+65E8mb1NAw51DeqIppFUERgwi
         0xXfW4ObrVE1N9BKjmqQydUQvLPZShq6vGj0UQBhuqA0S2A8lGqOQPycrawRzuJ6/c7z
         Y7siTFqi09XrIvJetWMZfFR2ispNOtPc68N8/3Qkn58/Bo+UJRjs7Tl65ay4ssU1KQGS
         WzIhyLvFWcfoysfArfIjuctfCShFxBM4rUijuw54iQTMtZ4FWcI9faEijTB7Jxe8uadP
         TNZA==
X-Gm-Message-State: AJIora8HghQmxvMbdmBfKz8tMTEh7CKJBXhA+/naCCf/gTD/4Uhsu9r9
        aAZBaZpVUUoHoS62PAYxTCI=
X-Google-Smtp-Source: AGRyM1s0ePV/48ujtEBrBoweNW6wye7KbC84fuFGq3EmoCFSFNQWSDhXqomNjh8HFwQC24tpbtM41w==
X-Received: by 2002:a05:6a00:1410:b0:528:5a5a:d846 with SMTP id l16-20020a056a00141000b005285a5ad846mr44999671pfu.9.1658411908540;
        Thu, 21 Jul 2022 06:58:28 -0700 (PDT)
Received: from [127.0.0.1] ([45.138.210.17])
        by smtp.gmail.com with ESMTPSA id q27-20020a635c1b000000b0041a390f276esm1536631pgb.40.2022.07.21.06.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 06:58:28 -0700 (PDT)
Message-ID: <0af9c29a-2071-6aa3-28ce-9b9127789644@gmail.com>
Date:   Thu, 21 Jul 2022 21:58:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/7] mv: add documentation for check_dir_in_index()
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     vdye@github.com, gitster@pobox.com, git@vger.kernel.org
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220719132809.409247-3-shaoxuan.yuan02@gmail.com>
 <228ad533-477c-f16e-220d-61e52d9aee26@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <228ad533-477c-f16e-220d-61e52d9aee26@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/20/2022 1:43 AM, Derrick Stolee wrote:
 >> + *
 >> + * Note: *always* check the directory is not on-disk before this 
function
 >> + * (i.e. using lstat());
 >> + * otherwise it may return a false positive for a partially sparsified
 >> + * directory.
 >
 > I'm not sure what you mean by a "false positive" in this case.
 > The directory exists in the index, which is what the method is
 > defined as checking. This does not say anything about the
 > worktree.
 >
 > Perhaps that's the real problem? Someone might interpret this
 > as meaning the directory does not exist in the worktree? That
 > would mean that this doc update needs to be changed significantly
 > to say "Note that this does not imply anything about the state
 > of the worktree" or something.

This method assumes that the directory being checking does not exist
in the working tree, but the method itself does not check this. And
if the user does not make sure the directory is absent from the
worktree, this method may return a success for a partially sparsified
directory, which is not intended.

 > But I think I'd rather just see this patch be dropped, unless I
 > am missing something important.

I found Victoria's paraphrase [1] makes my point much clearer.

--
Thanks,
Shaoxuan

