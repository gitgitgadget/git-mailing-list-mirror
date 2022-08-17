Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11016C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 17:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238426AbiHQRoC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 13:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240393AbiHQRoA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 13:44:00 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D0225583
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 10:43:58 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id n21so10918037qkk.3
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 10:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=sOh+xxbvuAlRtSYx76ZDJycR3gDadEwNUp7qGCpIyRc=;
        b=c0HtjMtSKXWiNvNL3QqQKCIAmbI01JXnd8xyTsVy8DvDACR+3pde2+F8ymr8e84MDt
         b16ebUkaOPO79noW1ok/IhkSJE86kLJGYsPhaV5pD4bV5N5MAsEfHSCam2btIZA4fLxx
         QXxEFumWatB3ZHsQjnb8D67zka0f2WQRXRSGuJw9Vp/gzClWQLb6MZxd7it/Ve3lLaPg
         t+f8o770W++Kz75JGI/sJR/1zbcA1wWXoiLXdpmYkOmA1DCdRx72k1ucH5cYWmEVk8pP
         wnTHu3BbwD6uDy1PErGLdPF31Z6GOsU15EDik1sl7YCYKx/mJsOR0qWbLx2xDPhmBC2f
         Gnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=sOh+xxbvuAlRtSYx76ZDJycR3gDadEwNUp7qGCpIyRc=;
        b=qbWDbR+P2SvXc+LGGUoBI6wNsSm/ivw8uMusGVfGrRz+t9DHct5onFOAtq0cjYr9hY
         NpluFBLEpNiOEY5QOK9nmdZvubWVXUjbWk0cozgZMQQR7oH+qRZgJOK+WFqu9NRIrW7/
         8rOaLU99cfPTS/8KM6H0uOOf95BFl/wfBZJ/uc1BS11eeCmOlT+87heolClQyYjGUmlQ
         CMfEkUou8jGaXQfT4Ag7IS+3ZFsyugoew0ppVuiRGLzgrpmJBHEvnV25v2nP9hSxgPBL
         AJfz2+kX+IC7bCJqGV9CtIctJOs/SIIoiJ52A4UFhveic/5GLO6np9s6sZI7iCk/2tqJ
         xmPg==
X-Gm-Message-State: ACgBeo22t5Kp4k6irJh0GfSR6jX07j5TIa6SDCWq6qLWgRnF+cs965FK
        8iY9RiC0LDv19AzXqE3TQwTH
X-Google-Smtp-Source: AA6agR6shK9Lpg/xEPr1lXYZQ995MHMuPIxgTwuFariHXp4MjF4XF7Mli2H2PDr8fB7pjP0qyP1qRQ==
X-Received: by 2002:a37:444b:0:b0:6b1:48dd:e56e with SMTP id r72-20020a37444b000000b006b148dde56emr19356559qka.501.1660758237782;
        Wed, 17 Aug 2022 10:43:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f8cc:7049:fd75:5ebd? ([2600:1700:e72:80a0:f8cc:7049:fd75:5ebd])
        by smtp.gmail.com with ESMTPSA id fz9-20020a05622a5a8900b003447ee0a6bfsm1898791qtb.17.2022.08.17.10.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 10:43:57 -0700 (PDT)
Message-ID: <e719d1e1-1849-07bc-ea08-2729985e5048@github.com>
Date:   Wed, 17 Aug 2022 13:43:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 1/2] builtin/grep.c: add --sparse option
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>, Junio C Hamano <gitster@pobox.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220817075633.217934-2-shaoxuan.yuan02@gmail.com>
 <80f24382-1188-d450-d1e2-42f68c08e60b@github.com>
 <xmqqh72ayeru.fsf@gitster.g>
 <bc923a75-7d60-1199-40cd-9d5067d6511c@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <bc923a75-7d60-1199-40cd-9d5067d6511c@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/17/2022 1:34 PM, Victoria Dye wrote:
> Junio C Hamano wrote:
>> Yup.  Is that "--sparse" or "--unsparse"?  We are busting the sparse
>> boundary and looking for everything, and calling the option to do so
>> "--sparse" somehow feels counter-intuitive, at least to me.
> 
> It is a bit unintuitive, but '--sparse' is already used to mean "operate on
> SKIP_WORKTREE entries (i.e., pretend the repo isn't a sparse-checkout)" in
> both 'add' (0299a69694 (add: implement the --sparse option, 2021-09-24)) and
> 'rm' (f9786f9b85 (rm: add --sparse option, 2021-09-24)). The
> 'checkout-index' option '--ignore-skip-worktree-bits' indicates similar
> behavior (and is, IMO, similarly confusing with its use of "ignore").
> 
> I'm not sure '--unsparse' would fit as an alternative, though, since 'git
> grep' isn't really "unsparsifying" the repo (to me, that would imply
> updating the index to remove the 'SKIP_WORKTREE' flag). Rather, it's looking
> at files that are sparse when, by default, it does not. 
> 
> I still like the consistency of '--sparse' with existing similar options in
> other commands but, if we want to try something clearer here, maybe
> something like '--search-sparse' is more descriptive?

My interpretation of '--sparse' is "include skip-worktree paths"
thinking of those paths being "sparse paths".

A too-long version could be '--ignore-sparse-checkout', but I can
understand the confusion where '--sparse' is interpreted as
'--respect-sparse-checkout'.

The existing pattern here means that it isn't Shaoxuan's responsibility
to pick a better name, but if we are interested in changing the name,
then we have some work to replace the previous '--sparse' options with
that name. I could do that replacement, assuming we land on a better name
and are willing to have that change of behavior.

Thanks,
-Stolee
