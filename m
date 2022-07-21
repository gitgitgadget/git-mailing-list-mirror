Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D82C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 14:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiGUOUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 10:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiGUOUc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 10:20:32 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AB820BF6
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 07:20:31 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b9so1875789pfp.10
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 07:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ykxYLhGNO3O4OthxJbXCF8HGMwAgKlllQughP7j5UUc=;
        b=ZVQXO1zxROcVvmQO+PS6qyxWCNYZBnojwlXnoFFOyMnP1F+0tQS+6fhJWt1FlSHv9m
         mc0y6LzW5Fh7I/+SACn5kxmdl5vQzANhJvPhm94xkV1wPzQebB5wl1Pes4Pt3nHFS3RR
         h4R0F4zlNeBdpwZn+yNjU0RPQdBjcpxJnSCUZFCQRcZFWA2O/HPStPBnH4yoqcSi8bgP
         sWAhxL3crBJmyjweZeSfvGCjBHP6AbIUOpdeF7CxHpQXUndCnWL5bIrr8UknPvoCJzK2
         htibqYoqLvB2bEhnKYo/sIhR5ibFifI0MiTDp08j+FlyUDX/XKiOdVIsNdQHLNERMlp8
         vr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ykxYLhGNO3O4OthxJbXCF8HGMwAgKlllQughP7j5UUc=;
        b=bV/YW5fyUXuscDw8+LF28vQwXoK74e+KYGRawvvbAIUkd5RnVDUsJZLdScF57zalcz
         G/S49fdw+sBgE7aoBn62l/rJg8kr5HiptYOyUnHPvL7BgeoyXRrGDcSamcJg+DXY+qb2
         XtL/SAL8FZfwi6cbyXt65L8oS2gMrI5VQNzJETasSGJH4ZbBdpVwKbmo0wWgOXWgMecf
         UHsC32xhlHgS6g0XVfdYuh1DDgP4hYKsli/VT0/clJKO0ap2qSQ81pTkFNHwMkVzdj8R
         RNwweh5YB1dzoHRebSpmKrgMtNdovYtjUBuEbFfieMg1WBT88pvAKraJ1Y3Pj7eXH8ZC
         reiw==
X-Gm-Message-State: AJIora87bDXCmoNJLACJ6674qgkU3Y/U6ZgvMf7RXUKDWYBH4XXT+apM
        b81+bHwujb9QHNclQNeUGD7crXSg6xo=
X-Google-Smtp-Source: AGRyM1sOgH5nmtKNQSXWOQE/eqWm4xvJinHt4hHkjAZdvC5CLY/R3j2t0xby8JB3qNpuRO8/T57GNg==
X-Received: by 2002:a63:f143:0:b0:41a:5c8a:915c with SMTP id o3-20020a63f143000000b0041a5c8a915cmr8983938pgk.369.1658413230986;
        Thu, 21 Jul 2022 07:20:30 -0700 (PDT)
Received: from [127.0.0.1] ([45.138.210.17])
        by smtp.gmail.com with ESMTPSA id s188-20020a625ec5000000b0050dc7628148sm1802258pfb.34.2022.07.21.07.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 07:20:30 -0700 (PDT)
Message-ID: <191bcdca-c7fd-665c-78ce-ef4c5843d13d@gmail.com>
Date:   Thu, 21 Jul 2022 22:20:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/7] mv: add documentation for check_dir_in_index()
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>
Cc:     derrickstolee@github.com, gitster@pobox.com, git@vger.kernel.org
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220719132809.409247-3-shaoxuan.yuan02@gmail.com>
 <6188fab7-df5e-b3fb-92a2-47039254ac45@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <6188fab7-df5e-b3fb-92a2-47039254ac45@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/20/2022 2:01 AM, Victoria Dye wrote:
 > Shaoxuan Yuan wrote:
 >> Using check_dir_in_index without checking if the directory is on-disk
 >> could get a false positive for partially sparsified directory.
 >>
 >> Add a note in the documentation to warn potential user.
 >>
 >> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
 >> ---
 >>  builtin/mv.c | 5 +++++
 >>  1 file changed, 5 insertions(+)
 >>
 >> diff --git a/builtin/mv.c b/builtin/mv.c
 >> index 4729bb1a1a..c8b9069db8 100644
 >> --- a/builtin/mv.c
 >> +++ b/builtin/mv.c
 >> @@ -132,6 +132,11 @@ static int index_range_of_same_dir(const char 
*src, int length,
 >>   * Return 0 if such directory exist (i.e. with any of its contained 
files not
 >>   * marked with CE_SKIP_WORKTREE, the directory would be present in 
working tree).
 >>   * Return 1 otherwise.
 >> + *
 >> + * Note: *always* check the directory is not on-disk before this 
function
 >> + * (i.e. using lstat());
 >> + * otherwise it may return a false positive for a partially sparsified
 >> + * directory.
 >
 > To me, a comment like this indicates that either the function is not 
doing
 > what it should be doing, or its name doesn't properly describe the
 > function's behavior.
 >
 > Per the function description:
 >
 >     Check if an out-of-cone directory should be in the index. Imagine
 >     this case that all the files under a directory are marked with
 >     'CE_SKIP_WORKTREE' bit and thus the directory is sparsified.
 >
 > But neither the name of the function ('check_dir_in_index') nor the
 > function's behavior (hence the comment you're adding here) match that
 > description.
 >
 > Since this function is intended to verify that a directory 1) exists 
in the
 > index, and 2) is *entirely* sparse, I have two suggestions:
 >
 > * Change the description to specify that the non-existence of the 
directory
 >   on disk is an *assumption*, not an opportunity for a "false positive."
 >   It's a subtle distinction, but it clarifies that the function should be
 >   used only when the caller already knows the directory is empty. For
 >   example:
 >
 >     /*
 >      * Given the path of a directory that does not exist on-disk, 
check whether the
 >      * directory contains any entries in the index with the 
SKIP_WORKTREE flag
 >      * enabled.
 >      *
 >      * Return 1 if such index entries exist.
 >      * Return 0 otherwise.
 >      */
 >
 > * 'check_dir_in_index' doesn't reflect the "is not on disk" 
prerequisite, so
 >   the function name can be updated to clarify that (e.g.,
 >   'empty_dir_has_sparse_contents')
 >

I really breathed a sigh of relief after seeing these two points :-)
They word things out much better than the original ones.

--
Thanks,
Shaoxuan

