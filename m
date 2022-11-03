Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9473C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 09:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiKCJ33 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 05:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiKCJ26 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 05:28:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168A4DFAD
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 02:28:10 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o4so1710896wrq.6
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 02:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vBxOX6EXy6YWX7xaBIRMjfPoVl77fi2HZeYsEwSqK6s=;
        b=NuOh+2bQi3uWG1CddxPsq3ZW2HejdzH8uIVTnA8cJWc2jVOb0+LXHddCs1FceNgOeX
         INSSLvPRgB1c/mR082SjtJQ7jz55QxYNSbXyNXmpJPdesMiHsvHnOCgRou8KAuv3dxtI
         bjtiojCamFCkJPMloH5bnegYS2ulir01Mha4F2Vn6htY0iusgJ6Tp6tto7wd6Xdbz1E8
         tHvqqD2hPNC6tynIMVxhL6hjPKanehHT6GrYlciW35w8be2uej8mr09d6U3lg0rn8D2P
         soviSsXPszAYJoQ5qHdPxM93zNW5QtrvpOombVAclNngsPNuLGC5ddbhYfauByl4ghB3
         /8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBxOX6EXy6YWX7xaBIRMjfPoVl77fi2HZeYsEwSqK6s=;
        b=vtI6LoQKB7wkF3KJMrENc8VCHwgyEkv2YcahxDLUOt2SOXqJIvMcVK5FNcbW395bUb
         jLfKAe+wwVzvOsh6oPJX63D9IFco+qrsFiK7KcuGnZbeZRDSFeJ37cUGcTAky9xjt49D
         hkdAL+0jZrD9hsmTPoVA+U9FrXSTwflQY2BfqoyI98ASSBzR3ccx/XiErwfn7qyBLudR
         04TWV+c5KeCl8ghJB4tATg5/D6gCkZmQpbLcqIznQqiop6++R2Ebv+WImImwMeK4tdeX
         gW7sbARIJ8vTJSTF46i02A0mP9jBw04VlCxbiy6AZwABqStsnYJhdrGCoUHYDpUkYgMM
         X+5A==
X-Gm-Message-State: ACrzQf2IA4R3mEBDQO808Mv4U7YJvhN8t97jfEAPZ/kGqN6lskEg6g7S
        O+X9Eclqnz1iMUMuf5FBdiQ=
X-Google-Smtp-Source: AMsMyM6sI+NBP55EeAKDRpQ4VhEOfos+O7UJS7RsnE6TGdasLh5XXL9iAfe9XGNI3mkE0Vq0rvFGKg==
X-Received: by 2002:a5d:5386:0:b0:236:bec0:d935 with SMTP id d6-20020a5d5386000000b00236bec0d935mr13837033wrv.547.1667467688517;
        Thu, 03 Nov 2022 02:28:08 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id i15-20020adfa50f000000b002366c3eefccsm289087wrb.109.2022.11.03.02.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 02:28:08 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <6efed789-7ea8-5135-aafb-59da1312b80d@dunelm.org.uk>
Date:   Thu, 3 Nov 2022 09:28:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 6/9] strbuf: reintroduce strbuf_parent_directory()
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
 <2200a70d279adcc6460dcb7bef7b0e681d19a414.1667264854.git.gitgitgadget@gmail.com>
In-Reply-To: <2200a70d279adcc6460dcb7bef7b0e681d19a414.1667264854.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 01/11/2022 01:07, Derrick Stolee via GitGitGadget wrote:
> +size_t strbuf_parent_directory(struct strbuf *buf)
> +{
> +	size_t len = buf->len;
> +	size_t offset = offset_1st_component(buf->buf);
> +	char *path_sep = find_last_dir_sep(buf->buf + offset);
> +	strbuf_setlen(buf, path_sep ? path_sep - buf->buf : offset);
> +	return len - buf->len;
> +}
> diff --git a/strbuf.h b/strbuf.h
> index 76965a17d44..8a964a08c31 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -664,6 +664,13 @@ int launch_sequence_editor(const char *path, struct strbuf *buffer,
>   int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
>   			      const char *const *env);
>   
> +/*
> + * Remove the deepest subdirectory in the provided path string. If path
> + * contains a trailing separator, then the path is considered a directory
> + * and nothing is modified.
> + */

I found the name and description a bit confusing, if I've understood 
correctly it isn't really removing the deepest subdirectory but removes 
the file name if there is one from the path. As such perhaps 
strbuf_strip_filename() might make it clearer that it is a no-op if the 
path ends with a slash. It returns the number of characters removed but 
that is undocumented.

Best Wishes

Phillip

> +size_t strbuf_parent_directory(struct strbuf *buf);
> +
>   void strbuf_add_lines(struct strbuf *sb,
>   		      const char *prefix,
>   		      const char *buf,
