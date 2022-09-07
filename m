Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DA2C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 23:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiIGXBj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 19:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiIGXBf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 19:01:35 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE82BC116
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 16:01:34 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id h8-20020aa796c8000000b0053e7a226751so1514701pfq.10
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 16:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date;
        bh=wwLdvM49jxn4Vlg0JQE3fahB6fUficR+lV4X0URY8fc=;
        b=So1+MiVFDWnl/vCNYQ/YPNnjuweGbyLiM5J7p2nAvlK/h2WEHHfix+QU+wzZ1CVQv8
         /u2OVYYK9jQ8rXyHDlWQM4HQe4VR0V49D3527i8GtPnjXwKAdb3WcaylOg5HdejGogxV
         cshNW7svEPADSg8TZ/+EFfsF3U8HhNNC4KidV9b64TPzVdnnlKl0DU3eE9oAUun1pqkA
         UvT5Aqa7lvCii6LGaCdBBPRe39rpSoqicnYDXMNxxvpV51zRCvy2YBwhmW65s5iUkWlr
         X+huihwmGoOnNiAt2erhrRJ8NiYOzIaSJuT/B643+7VqI4vtPL3wLvV45yuk+enzh9Mh
         59gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wwLdvM49jxn4Vlg0JQE3fahB6fUficR+lV4X0URY8fc=;
        b=6qt52q9xpJvCGGizVKhd7N2RZ+I/lhf4Ln9jFjBb5cVKs4NaBswUSdIe1Hh2qZ7kSw
         7wbMV/E6vZTLkipCvtFZlaidLdWglvnen4KhSsl7Rr+L3AE3SWfX8w2m/pwSPon2a1sb
         HByL2jzKUclS4FmHi7ekxPn39Igph8wwV+0oOQcvDRCXi8lGs28KKMqwrDSQLouVnMK2
         lpB5nSw9VuHTgSJC+Nl/Tg7lhSj+DIGBNP57FC2pCoghkEntK81a/9UqWOh85grjgPR7
         bMU7UMjvMy2XedjWKLkp0ebjkegpbmg+TMsV4fMcZETeYf6RF2JMYPJS7XhLloHk+AVf
         6kow==
X-Gm-Message-State: ACgBeo2u3A1Yh5wIJTOpR1x7G1YL2mch0UcdwgZj2/7H/yc/WPOX2Zyf
        fsmEys0BmWIYB7ywkMzLxZm3dY3yYXOYEQ==
X-Google-Smtp-Source: AA6agR6gzP3kt7/K3Q7Ck7AkDnd52iG9/Y1MqST4LX9p935DYdsLUJh+naPmsHV+zGm/yvE+c+TaUKbQ7ag9qw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:fc13:0:b0:42b:890d:5954 with SMTP id
 j19-20020a63fc13000000b0042b890d5954mr5354845pgi.200.1662591693752; Wed, 07
 Sep 2022 16:01:33 -0700 (PDT)
Date:   Wed, 07 Sep 2022 16:01:25 -0700
In-Reply-To: <xmqqilm1yp3m.fsf@gitster.g>
Mime-Version: 1.0
References: <xmqqilm1yp3m.fsf@gitster.g>
Message-ID: <kl6ly1uu94ca.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: What's cooking in git.git (Sep 2022, #01; Mon, 5)
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * gc/submodule-propagate-branches (2022-08-29) 6 commits
>  - clone, submodule update: check out branches
>  - submodule--helper: refactor up-to-date criterion
>  - submodule: return target of submodule symref
>  - t5617: drop references to remote-tracking branches
>  - repo-settings: add submodule_propagate_branches
>  - clone: teach --detach option
>
>  "git clone --recurse-submodules" and "git submodule update" learns
>  to honor the "propagete branches" option.
>
>  Needs review.
>  source: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>

I suggest renaming the branch - the config "submodule.propagateBranches"
will be used by many more commands in the future, several of which will
probably be authored by me :)

Maybe gc/submodule-update-with-branches? Or
gc/recursive-clone-with-branches.
