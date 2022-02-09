Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8DDC433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 17:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238173AbiBIR0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 12:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238155AbiBIR0P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 12:26:15 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2428C05CB87
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 09:26:17 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id m10so3217862oie.2
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 09:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NjbK9e6LySVCqK/pSUOj/EYLIwdLaW6O0/ZMG4O6b8c=;
        b=Le1cy3rFxTZy5SAvr08dpDm0JqHzIGLKyuL5ywkOXufMZUG/713UOohGckpkiF58yM
         KMm9+ZHd3dGLgs8gmbPEN/Bk0IH4WREXe4PWY2RC4PT1Sawq/sUc/EG0kwWIMG/MnVT7
         zd2xCK0zi8fnGAeErNh7c22I6xpq2w6DnEjyeKee9GuaE+YxooRvp0tHrarQdyO2bY/T
         jOiSvR5MzecD9Azc+2Z5KXLC5SFXP0Mlo/kT681kd6nsgqdIP+PiNtAOYSLJ3QHVf3lT
         InQpKWTgkZ/0+uVwQ6r8hehurebxA0TbaqKQQans6RNzBxwMX89N7RLLsCn46tMEb3P4
         2S0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NjbK9e6LySVCqK/pSUOj/EYLIwdLaW6O0/ZMG4O6b8c=;
        b=68mzeNOeHoA2itgEXoNI5vPj6YP2PfBnAHh7KwYIO3B42HKol/4q2akvTxlmDutDrZ
         cxymlmIxlgiJAmqQ6rbDEuIveGUH7hRUxaXD8cvGu+hWPffRIfJvVpjHEWyhZYuDARzx
         4Qu6Sa0y4NKd7ruVgp/E3gfShmITG6cgpnbyUfmk+ACr1X9uhHy1Y9MpUGzjfUvLrQ65
         KsfqODLE8nvVj5CQL2DRgihgVBLRd3lnLm9W1f8tBcD/Z2erZ/bbmhjz7uqjajLBQv0v
         UKrKWttQ+TIinUtb7LtM1z40kEorsbAwsmyWyo5THa6Xn4Ou5DSVfOACujh1yfW8518l
         txng==
X-Gm-Message-State: AOAM531ArX7bquwD5vBjMojQNZLyf8hryO3IPClLiveNKeN+CiL7uSI+
        mVt91/F8b1ojOAQTvESnNdE=
X-Google-Smtp-Source: ABdhPJzE74hHiw3zAVx85JTAXSX4aTrJNI653zt3iGT+kvukeQiiKJFRdSzMJbKgH0qZeltaT2sX5w==
X-Received: by 2002:a54:4503:: with SMTP id l3mr1440998oil.161.1644427577126;
        Wed, 09 Feb 2022 09:26:17 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:2177:fee8:1597:ac9f? ([2600:1700:e72:80a0:2177:fee8:1597:ac9f])
        by smtp.gmail.com with ESMTPSA id j9sm7075431otp.23.2022.02.09.09.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 09:26:16 -0800 (PST)
Message-ID: <a51e39f4-a1a1-de41-d643-6f7c277bfc1a@gmail.com>
Date:   Wed, 9 Feb 2022 12:26:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v6 1/6] Documentation: add extensions.worktreeConfig
 details
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sunshine@sunshineco.com,
        allred.sean@gmail.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <jn.avila@free.fr>,
        derrickstolee@github.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
 <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
 <0260ff6cac0c76c6d66187d77defef1edd4c6fb5.1644269583.git.gitgitgadget@gmail.com>
 <xmqqo83hatm1.fsf@gitster.g> <11bf1541-c46a-fcf5-f8d4-0d144b942d59@gmail.com>
 <xmqqmtj09cuz.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqmtj09cuz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/9/2022 12:19 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>> +[[def_work_tree]]worktree::
>>> +	A repository can have zero (i.e. bare repository) or one or
>>> +	more worktrees attached to it. One "worktree" consists of a
>>> +	"working tree" and repository metadata, most of which are
>>> +	shared among other worktrees of a single repository, and
>>> +	some of which are maintained separately per worktree
>>> +	(e.g. the index, HEAD, per-worktree refs and per-worktree
>>> +	configuration file)
>>
>> I like this addition, except that I don't understand the "per-worktree
>> refs" (other than HEAD). Are there other thins used by features such
>> as merge and rebase that would appear as worktree-specific? Of course,
>> some state for these operations is stored per-worktree, I just didn't
>> know if any were actually "refs".
> 
> "per-worktree ref" is an entry in the glossary.
> 
>     [[def_per_worktree_ref]]per-worktree ref::
>             Refs that are per-<<def_working_tree,worktree>>, rather than
>             global.  This is presently only <<def_HEAD,HEAD>> and any refs
>             that start with `refs/bisect/`, but might later include other
>             unusual refs.
> 
> And those other things are also listed as "pseudoref".
> 
>     [[def_pseudoref]]pseudoref::
>             Pseudorefs are a class of files under `$GIT_DIR` which behave
>             like refs for the purposes of rev-parse, but which are treated
>             specially by git...
> 
> I think the motivation of special casing refs/bisect/ is to allow
> use of a separate worktree for bisecting without affecting other
> development or another bisection.  The HEAD is singled out in the
> description, but MERGE_HEAD and others (pseudoref) that are declared
> here to be files under '$GIT_DIR', when we migrate fully to other
> backend that may not want to have files under '$GIT_DIR' to
> represent them, ought to become per-worktree, for the same reason as
> HEAD should be per-worktree, i.e. it allows worktrees to be
> independent from each other and have their checkout at different
> commits, growing history of different branches in parallel.

Thanks for this additional context! It means that I need to look
around more carefully, not that your patch needs any changes.

-Stolee
