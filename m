Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22F5C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 14:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348029AbiCYOcr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 10:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345604AbiCYOcq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 10:32:46 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0EDC3378
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 07:31:12 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-dd9d3e7901so8278162fac.8
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 07:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oaF3g12BwySWEwVv7E8y/mr2GnkL4wJTk20S1kPVs8k=;
        b=BjE8f0GIs+RI1wJxrhopdl7+LNhv+BA17HeBO3cQkNwYCXOYTUE11I4ZnHYbYePDgk
         HzfnqfRZa7tx4VdmyMHZdQUvjribBBD+mxEXr1taXBjY9roc+sWSU2hsJiKzS6o0qbFp
         JihEahc1bgK2cuCDhMNHlgtsDjN9M1BT1wSBEeSzSrCy2LgY4qdRQwHrbi4tK4UIsINc
         WMwkW9xRU4mhLcSUuWNciZIwSWMFs7tnkVOAnMwhQNSDzhmroG/DFCWVPwqcXuPwY+bl
         OZqVMKwK5+eIfZMKfaAXFSHexTvuwI6+cPuW3gEgrXeW4igRn8r6z3WqRgtP9KZK+xqQ
         eVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oaF3g12BwySWEwVv7E8y/mr2GnkL4wJTk20S1kPVs8k=;
        b=3BuwWAOBlMR7B0HbVbdhcz1N1bYAoTJM5RveLY6wmKICVroB0yE9OnozdcXheVr5TQ
         LzfOsewcsocKXY5C++vqwm+wVNYbvGPkimCrKsJ/tEHlOoz9GK6QUtmduY65F8uph6qB
         wMAwTP7wFZztnbYdCHctrXGUslJY3x8Pn5xNZq3MFNcerlUSK0ZnX9b1AtS/stHBEUjV
         3fW+rnjJ9u4wT4jmQoIZKYH95ZDazrNmYdOIM6oAeNxn+rXAasNptqmK25R2M/6wH9qJ
         nc7urEKxIIscvJh8DCrMXzZXDY5MyGk4Ri2rHKXDOaFZ79u9zUqnVjE5WKHThsZS0Sh6
         DewA==
X-Gm-Message-State: AOAM531+SS18oZ9jIyFbTA6NS1JQFxHgL8e1gLMCYVpuLyMmXxLGF7xr
        dzoX/NMmjS0EUmJPK3DyT7Pj
X-Google-Smtp-Source: ABdhPJwTstt9n7tyK2YsnVLg7FJvikzcukuRzdl5jEz4N3IcHLzwe6Gk1eCcuOByScTShFkUpOXLEQ==
X-Received: by 2002:a05:6870:589b:b0:da:b3f:2b68 with SMTP id be27-20020a056870589b00b000da0b3f2b68mr9123328oab.263.1648218671690;
        Fri, 25 Mar 2022 07:31:11 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id p14-20020a9d744e000000b005b235f5cf92sm2661322otk.65.2022.03.25.07.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 07:31:11 -0700 (PDT)
Message-ID: <30d20d10-da33-ae41-7887-d73279e14e92@github.com>
Date:   Fri, 25 Mar 2022 10:31:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mv: refresh stat info for moved entry
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     reichemn@icloud.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
References: <pull.1187.git.1648173419533.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1187.git.1648173419533.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/24/2022 9:56 PM, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> Add 'refresh_cache_entry()' after moving the index entry in
> 'rename_index_entry_at()'. Internally, 'git mv' uses
> 'rename_index_entry_at()' to move the source index entry to the destination,
> overwriting the old entry if '-f' is specified. However, it does not refresh
> the stat information on destination index entry, making its 'CE_UPTODATE'
> flag out-of-date until the index is refreshed (e.g., by 'git status').
> 
> Some commands, such as 'git reset', assume the 'CE_UPTODATE' information
> they read from the index is accurate, and use that information to determine
> whether the operation can be done successfully or not. In order to ensure
> the index is correct for commands such as these, explicitly refresh the
> destination index entry in 'git mv' before exiting.

Good find. Thanks for the fix!

> Reported-by: Maximilian Reichel <reichemn@icloud.com>

Thanks for the report, Maximilian!

> @@ -148,6 +148,7 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
>  	untracked_cache_remove_from_index(istate, old_entry->name);
>  	remove_index_entry_at(istate, nr);
>  	add_index_entry(istate, new_entry, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
> +	refresh_cache_entry(istate, new_entry, CE_MATCH_REFRESH);

It certainly seems reasonable to add this line. I was unfamiliar
with this method, and it is used only twice: when creating a new
cache entry in make_cache_entry() and in merge-recursive.c's
add_cache_info(). So, it is currently acting in the case of a
newly-inserted cache entry in its existing cases, and here in
'git mv' that's essentially what we are doing (deleting the old
and adding a new would be more appropriate than just moving the
old one).

I took a brief detour thinking about performance, but this is
run only once per command-line argument, so any new overhead
is minimal.
  
> +test_expect_success 'mv -f refreshes updated index entry' '
> +	echo test >bar &&
> +	git add bar &&
> +	git commit -m test &&
> +
> +	echo foo >foo &&
> +	git add foo &&
> +	git mv -f foo bar &&
> +	git reset --merge HEAD

Is there any post-condition on the index that we want to check here?

That is, is there anything that we could notice via 'git status' or
similar that would break before this patch (assuming we put a
test_might_fail in front of the 'git reset --merge HEAD' line)?

Thanks,
-Stolee
