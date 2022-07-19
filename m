Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4010C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240054AbiGSSLl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240056AbiGSSLX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:11:23 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873A15D0CC
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:10:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n4-20020a17090a73c400b001f1e87432c2so3796025pjk.3
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=J8Z+lIHImfgmJb/gZSkNnfH6PgFl9I8OqGGL5g4rWa8=;
        b=A91WkaWp9fur8LaWhUY2GB/V4YtXIp+5u/kgLr/V4fu4GiA7kBPqUrHJ1KUsO5DtDQ
         qdYSUxqfV3bBQNM/ZvJKIQ0FQsv/OSuJ6w+AQLE2hZuDngxdMDGJA3aKh+Ldi4C5pDMp
         wB4wmklVPrXCLdh4J4IJ6A69dUd/WxA94TTc9LtdULcZQxV+iWZz8V3WBZuahvmmVx3y
         2P7xIkt0Gl6k8/bc8TbioeTyn4d7dk5hjTcAVfADCx9hu5P9mvJ3gvUzf4NMca3fjiax
         5V5V3VF1rmn1ZKNp/7IkrDZEOqh5oRD3sAKx9tcBM4Zi1mebWtCo3+fHs4EEcyNUF1Yl
         fTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=J8Z+lIHImfgmJb/gZSkNnfH6PgFl9I8OqGGL5g4rWa8=;
        b=obF9WyT4HIu0sjkfl/17TYdtqG09F5Dz7JfYLMBAEX+HbCuyw1RI9+mTu5e+V7vOUO
         OJY0ESgqlXEelt/yoeA/jYt6Bwdn6XF9Ej7GL8Ap7pGyO1+bxonXzA1hWE369+zyeQpX
         zQ8dAvX6LPcWJ2b0nqVn34vaIA8iU7BFrZ7YQINbh7k0kuwB3+lfDHSyu/lJYecckKJW
         0oRxvjlAoaiuxFA0lnuhGijOsVigICKsCZnmVjLSXqldomv5pgT1Kb3H/meQRY1EfQjr
         9A/N90rgNSw9BtrjBvKoXdSISGCyQnqHT9IHD8np2uLWrh2S5PbA2MWA/QKiq3AqpF6H
         zc/g==
X-Gm-Message-State: AJIora9LT+sW9XEnDqqtVs7QbY1/PS9M9GCtU37JdZq0HRxZwbf4RCja
        ZuTv190KINJJRNc+Nl1blieY
X-Google-Smtp-Source: AGRyM1vbPa7zyQV+j4RCKHSrZw/JYDafGn9htQhGMc6P6TD1rOtj7Ckq/z3mKgAXdELXSSbFugoH5w==
X-Received: by 2002:a17:902:ea42:b0:16c:ca53:816c with SMTP id r2-20020a170902ea4200b0016cca53816cmr23198604plg.94.1658254257996;
        Tue, 19 Jul 2022 11:10:57 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id m11-20020a170902d18b00b0016d1bee1519sm195321plb.102.2022.07.19.11.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 11:10:57 -0700 (PDT)
Message-ID: <d5889658-77f5-25ff-7469-3f00a41857da@github.com>
Date:   Tue, 19 Jul 2022 11:10:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v1 2/7] mv: add documentation for check_dir_in_index()
Content-Language: en-US
From:   Victoria Dye <vdye@github.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220719132809.409247-3-shaoxuan.yuan02@gmail.com>
 <6188fab7-df5e-b3fb-92a2-47039254ac45@github.com>
In-Reply-To: <6188fab7-df5e-b3fb-92a2-47039254ac45@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye wrote:
> Shaoxuan Yuan wrote:
>> Using check_dir_in_index without checking if the directory is on-disk
>> could get a false positive for partially sparsified directory.
>>
>> Add a note in the documentation to warn potential user.
>>
>> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
>> ---
>>  builtin/mv.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/builtin/mv.c b/builtin/mv.c
>> index 4729bb1a1a..c8b9069db8 100644
>> --- a/builtin/mv.c
>> +++ b/builtin/mv.c
>> @@ -132,6 +132,11 @@ static int index_range_of_same_dir(const char *src, int length,
>>   * Return 0 if such directory exist (i.e. with any of its contained files not
>>   * marked with CE_SKIP_WORKTREE, the directory would be present in working tree).
>>   * Return 1 otherwise.
>> + *
>> + * Note: *always* check the directory is not on-disk before this function
>> + * (i.e. using lstat());
>> + * otherwise it may return a false positive for a partially sparsified
>> + * directory.
> 
> To me, a comment like this indicates that either the function is not doing
> what it should be doing, or its name doesn't properly describe the
> function's behavior.
> 
> Per the function description:
> 
> 	Check if an out-of-cone directory should be in the index. Imagine
> 	this case that all the files under a directory are marked with
> 	'CE_SKIP_WORKTREE' bit and thus the directory is sparsified.
> 
> But neither the name of the function ('check_dir_in_index') nor the
> function's behavior (hence the comment you're adding here) match that
> description.
> 
> Since this function is intended to verify that a directory 1) exists in the
> index, and 2) is *entirely* sparse, I have two suggestions:
> 
> * Change the description to specify that the non-existence of the directory
>   on disk is an *assumption*, not an opportunity for a "false positive."
>   It's a subtle distinction, but it clarifies that the function should be
>   used only when the caller already knows the directory is empty. For
>   example:
> 
> 	/*
> 	 * Given the path of a directory that does not exist on-disk, check whether the
> 	 * directory contains any entries in the index with the SKIP_WORKTREE flag 
> 	 * enabled.
> 	 *
> 	 * Return 1 if such index entries exist.
> 	 * Return 0 otherwise.
> 	 */

Whoops, I mixed up the return values (I assumed this returned a boolean
based on the 'check' in the function name). In that case...
> 
> * 'check_dir_in_index' doesn't reflect the "is not on disk" prerequisite, so
>   the function name can be updated to clarify that (e.g.,
>   'empty_dir_has_sparse_contents')

...there are two options. Either you can use a more "boolean-y" name (like
the one I suggest above) and flip the return values (where "1" means "the
empty dir has sparse contents"), or change the name to something that
explicitly *doesn't* imply boolean. I'm personally in favor of the former
(I'm really struggling to come up with a descriptive, non-boolean name for
this function), but I'm fine with either if you can come up with a good
function name.

> 
>>   */
>>  static int check_dir_in_index(const char *name)
>>  {
> 

