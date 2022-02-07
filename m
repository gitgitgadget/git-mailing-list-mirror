Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3455CC4332F
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 14:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390829AbiBGO2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 09:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350013AbiBGOL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 09:11:27 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76AEC0401C0
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 06:11:26 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r29so7079890wrr.13
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 06:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FV/gIBeZ1lQn+GRE0UGk7TASQy9CPLk9iQQTCCFrK+Y=;
        b=ik0q308FS3RPHOBPY1OMPV/nsW51F9kaiJkl70wdhs8r7HAsIImA2QpioF4wTKGB3k
         8OPGwlsZAV9516Fe4DmGp1aeQkOIZaiz1UXbAFyL3tsQb/vAtRfYUsh48fV6JqI9smRU
         iS3lPkiBCxJ8UjO6beHRC3gQ/GPBXHIU9GPhAMe9uyxcJzgYNEvu4ui+9/1s3ceTclOj
         AWbDSwKBkLJ9UeZsy19EPwaa8cj+BU8IrjlUS9kUM8ZFee86J5lXm5QcWcLo2jIyMgxb
         n0RTTwcxX5iG9NyQnwnSOB93n0hYNcpp6z0qKhMT3IrvEq9r12IphmyGJkbQoQCg+l3N
         eRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FV/gIBeZ1lQn+GRE0UGk7TASQy9CPLk9iQQTCCFrK+Y=;
        b=u/LPhVrxahoRssCGPKMXCl7c33K+WYYnrBsjq6R7q+tnRUJ4aOKzaxw2waasCY0LPn
         gFP+yXrgGJ9o35hXPgf8GxAwm4FMkbXJb91mcLg9UT55jZa6AyS95c5zOxJEEt/o2d1u
         392JlPAW3jOXiu5uPKP1D/3Kim+9cwSIZBsfeDY4dpfNM9+93dnWEbN+KD+Mj8uG/Xui
         +exeqBChfgDPeaicVr8dwU1gUjPMjcZSrAjqAYBiNA2zAS5hNP2m+N/m/ZBL384Ig7Ir
         T/cLfrmy5ZUgEHxvW3uXpkJqFMuK+OXv1uOF0eLz+Az/ffeofwMnCsIuWy7LG1lDuW5V
         cbWA==
X-Gm-Message-State: AOAM532Yfo8OS61aaekFE/c3vi1Twpa0btfF+nOrRFH+c4jtF7zZ6Bco
        sivjFeWOp0tp1KhyqjeGbvg=
X-Google-Smtp-Source: ABdhPJykZQI/JEsM8pqZS2sg5t+iCGNtxkVeeR8yg+nHMvIxDuOKtuK2LOZgkLucCOLi+y358+7p7g==
X-Received: by 2002:adf:a2da:: with SMTP id t26mr4342147wra.290.1644243085464;
        Mon, 07 Feb 2022 06:11:25 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id bh19sm11607129wmb.1.2022.02.07.06.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 06:11:25 -0800 (PST)
Message-ID: <fcba4c20-c29c-c114-c1ca-ac61b9725827@gmail.com>
Date:   Mon, 7 Feb 2022 14:11:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Opinions on merging questions (Was: What's cooking in git.git
 (Feb 2022, #01; Thu, 3))
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <xmqqr18jnr2t.fsf@gitster.g>
 <20220204081336.3194538-1-newren@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220204081336.3194538-1-newren@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/02/2022 08:13, Elijah Newren wrote:
> Hi,
> 
> I thought I'd respond to some of your questions with my opinion and
> pointers, in case it's helpful...
> 
>> * pw/fix-some-issues-in-reset-head (2022-01-26) 14 commits
>>   - rebase -m: don't fork git checkout
>>   - rebase --apply: set ORIG_HEAD correctly
>>   - rebase --apply: fix reflog
>>   - reset_head(): take struct rebase_head_opts
>>   - rebase: cleanup reset_head() calls
>>   - create_autostash(): remove unneeded parameter
>>   - reset_head(): make default_reflog_action optional
>>   - reset_head(): factor out ref updates
>>   - reset_head(): remove action parameter
>>   - rebase --apply: don't run post-checkout hook if there is an error
>>   - rebase: do not remove untracked files on checkout
>>   - rebase: pass correct arguments to post-checkout hook
>>   - t5403: refactor rebase post-checkout hook tests
>>   - rebase: factor out checkout for up to date branch
>>
>>   Use an internal call to reset_head() helper function instead of
>>   spawning "git checkout" in "rebase", and update code paths that are
>>   involved in the change.
>>
>>   Will merge to 'next'?
>>   May want to rename the topic branch to "pw/use-in-process-checkout-in-rebase"
>>   or something before doing so.
>>   source: <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
> 
> This series seems good to me and I think it's ready, but the topic
> branch rename sounds good.

Thanks for looking at the latest version. I think it is ready for next. 
Ævar suggested using a designated initialize in the conversion of 
reset_head() to take a struct but I think that makes it harder to review 
the conversion c.f. <7b56e91b-a7c9-b7cb-356c-e9615b9459fa@gmail.com>. He 
seemed to be happy with the rest of the series.

Best Wishes

Phillip

