Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D459C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 18:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE27610A1
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 18:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhFGS66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 14:58:58 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:36377 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhFGS65 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 14:58:57 -0400
Received: by mail-pg1-f180.google.com with SMTP id 27so14561082pgy.3
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 11:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fKWLwhkNOul4VTIJTPNDh0MVEAbbU5lV9U6v/QnjjEk=;
        b=f23kjyhWK290dK29ZCn8J6VyQubAi2PkAHAK49jaC7f2YJfbNy0931uLM4sRQeK+RB
         uqhQzfZp34PBvmGQN9YdjNJX/OnAyRTgHV9I9Ood0LyGSpQuC3Gz7t0SnsckmNeDXKdw
         WMlv8LnY30ztuBJR+2yFQc9UgD2prT7F1bJv1KF9SMo5GqZt/Pw88tC3ZTm25WB4krvx
         fuowvXyHt1d1tKoaYsRv1HTjlYqlAlyn/jSEqUHZNJZ4HPzm2aQbkGOOxJTbPKF1JZ6t
         paqXNo/CgZYKqM2wb7coAl5kc+FqKs21mPnOANn8kN9oQghCrNgrYAK1OlT4D1xu2agb
         e2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fKWLwhkNOul4VTIJTPNDh0MVEAbbU5lV9U6v/QnjjEk=;
        b=B/+ohpm7LaiWfZ3bGm8XF32aPi/V2d9I3y/YCg52PM13zhnct7fqe72oY3JkNyT26e
         vhsruyTrPMD15buJ9SGrl3l8W3TxM5mFUDhPwKCKrF8UYSbNL0bXH3043IuPEB4TA0PR
         d4NdP8g6RskKI3DMl+qwp9G4KXf5Z8afNIQhp3cL2v/9YaHFJVARAO0ne1AsAVPFbjS/
         IjzBAgjj8+1gg4ubO9GDdbYjMz+OZjAnQfLcSKPJPCV2FriBchqXGTd8//LUxo+uL+gq
         L1gujaxX455i/7mZkbEhd6EZG1sxMeIZygCuRY74Nv2NnAJj2o7ur7BtL3TJidk0YhjP
         wssw==
X-Gm-Message-State: AOAM5314dw3L64/sF68FieLbVvYSC3mm4Ktnx94253WxhwbISc4Sun3X
        INMfHJB/03/tSBClZnR26woCZ3R1xCI=
X-Google-Smtp-Source: ABdhPJzKpq3wvSRFEFMIHI9JtI6y0IlmJADfWOhCFEtV+0ah7LPDjExsEDMw2Dt+t3z+stpRZwITqw==
X-Received: by 2002:a63:d47:: with SMTP id 7mr4816957pgn.339.1623092149095;
        Mon, 07 Jun 2021 11:55:49 -0700 (PDT)
Received: from [192.168.208.38] ([183.82.191.33])
        by smtp.gmail.com with ESMTPSA id b16sm13303430pju.35.2021.06.07.11.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 11:55:48 -0700 (PDT)
Subject: Re: [GSoC] My Git Dev Blog - Week 3
To:     Atharva Raykar <raykar.ath@gmail.com>
References: <FC56DF49-CEC5-4C9F-BDE4-B0119558E4B2@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git <git@vger.kernel.org>
Message-ID: <4a4a3d6f-7d06-ccdb-7d5a-4057c7549927@gmail.com>
Date:   Tue, 8 Jun 2021 00:25:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <FC56DF49-CEC5-4C9F-BDE4-B0119558E4B2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva,

On 06/06/21 5:56 pm, Atharva Raykar wrote:
> Hi,
> 
> Here is my latest instalment in my weekly Git blog:
> http://atharvaraykar.me/gitnotes/week3
> 

Nice post!

> My not-so-well-read guess: Some users want certain submodules
> active in one worktree, but not the other. For that, there
> presumably exists a per-worktree configuration, and the current
> implementation just assumes a configuration that applies to the
> full repo. Changing this is definitely a patch for some other time.

I get to the same presumption. You could try exploring worktrees more to
confirm as you point out. You could also try Cc-ing people who you think
would have an idea of this. 'git blame' could you here.

 > A painful merge

You don't mention which branches you were trying to merge but
from the context I sort of figured out it was the
'submodule-add-in-c-add-config-v2' and
'submodule-add-in-c-add-clone-v3' branches in your repository: 
https://github.com/tfidfwastaken/git/

You mention trying 'recursive' strategy. Given this isn't a
fast-forward merge, I would've expected it to be one that would've
been triggered by default. Was that not the case for you?

Also, which version of Git did you use to do the merge ?

I tried reproducing the merge and it's indeed interesting that
even '-Xpatience' didn't do the trick.

> I still wonder how non-Emacs users deal with situations like these.

Git lets you invoke external merge tools which could help you resolve
merge conflicts in a easy way. See mergetool doc [1] to get an idea
about it. `git mergetool --tool-help` would give you a list of supported
tools. In your case, I happened to notice that P4Merge[2] does a good
job of properly resolving the conflict by itself.

[1]: https://www.git-scm.com/docs/git-mergetool
[2]: 
https://www.perforce.com/products/helix-core-apps/merge-diff-tool-p4merge

Speaking of resolving conflicts, there's also rerere [3] which should
save you from having to resolve the same conflict again and again.

[3]: https://www.git-scm.com/book/en/v2/Git-Tools-Rerere

> So I’m glad there’s the reflog.

Now that you've learned about and used reflog, I thought I'll let you
know about `git fsck --lost-found` [4] in case it might come in handy
someday ;-)

[4]: 
https://git-scm.com/docs/git-fsck#Documentation/git-fsck.txt---lost-found

> 
> Have a great weekend, and stay safe!
> 

Thanks. Hope you stay safe too!

-- 
Sivaraam
