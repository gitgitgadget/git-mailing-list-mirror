Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14F821F428
	for <e@80x24.org>; Mon, 30 Apr 2018 00:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754566AbeD3ADf (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 20:03:35 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:37199 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754409AbeD3ADf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 20:03:35 -0400
Received: by mail-wr0-f171.google.com with SMTP id c14-v6so6494344wrd.4
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 17:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sQsiG/GKGAkGxB5g9LaayznsYmfU+15/fKSWrXnW3Fs=;
        b=KTH9No+us8Jy6wb4yzeUc+ClLL1s1VyNF4gD7YkuCHg5B6JDgrL6ky1HpJRCrM9YrL
         FEz/VJLWDAf/k/8k5tXBWkPCBXDeGvo8iDl2KF0F9VdiFGoSNbXsLTKSiw+k4DynK/TE
         aBAjOAtHrYFZYQ6iOKXxe+W+9yN9xYQgDT3acEbcc9RJGY+P0nHrTdIPt95fxld8wb09
         3C5Oz271pXx2i+gB5wOq2gVHyekc5PYkm+NDPQFyfQoBUmUK3ainpIWWbE8j29SCkKBV
         B93pI+GOHpu62tlbjHwhukAc6TYvUA9hoID9JGKpSSYgRlMFVJOfEqnygW5+4/40zUrw
         J2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sQsiG/GKGAkGxB5g9LaayznsYmfU+15/fKSWrXnW3Fs=;
        b=V3e9MIBZKzHJLLpV+7Dl6mJNGNlCp3W2wHaXnaQk+ZJlaJRGdNdJ5kMZoqiGT8wlJ1
         SGLHTFyRHjt47+Nm2V8jW/Z+LHVK/VGnG9RPrnzq38NdiJaj7NWk/PekBYMfqY/9/o7G
         +TkPSWizGzw5Zg6Jmao0Be0dfGTcU4DLHds15x2yx4aKoKi30vq9R2S/3sBySsfqgjki
         mSkcYf4/WEBBIrRxn02ZQvsPDRzTkGhW6fyErKikjISQK7LKEIUrHlo3/ZO70Q6Bi8Ht
         U3IXoX3bg4OPLm+mTFVo8OgoqA04v4JDKr1Ym0Qm71c1GQ6WdTL7+4VGOE3NnJAzQEtK
         vQSA==
X-Gm-Message-State: ALQs6tAJn8Gjbc4vRxE4zQRpdWDPwounutbVTNbV4HMwXuumGttNNbHc
        CLivI5Zqm06HmVZ0WpVyjd0usAQf
X-Google-Smtp-Source: AB8JxZrZEwgOd0hK0Qie2CzEI0Cd155iWd9ZmeAr8zyXkTJQU2/n05vm95VIKYkPqCUxEYX1UDpGiw==
X-Received: by 2002:adf:a294:: with SMTP id s20-v6mr6927677wra.114.1525046613769;
        Sun, 29 Apr 2018 17:03:33 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b10-v6sm14883151wrn.42.2018.04.29.17.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Apr 2018 17:03:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2018, #03; Wed, 25)
References: <xmqqmuxr4r6n.fsf@gitster-ct.c.googlers.com>
        <CAPig+cShfaKR_L+ypKwKZV_Hv8kwY37dGhJ8_WTSMZFqWX+EkA@mail.gmail.com>
Date:   Mon, 30 Apr 2018 09:03:32 +0900
In-Reply-To: <CAPig+cShfaKR_L+ypKwKZV_Hv8kwY37dGhJ8_WTSMZFqWX+EkA@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 27 Apr 2018 03:39:10 -0400")
Message-ID: <xmqqlgd5zhkb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Apr 25, 2018 at 4:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * tg/worktree-add-existing-branch (2018-04-25) 4 commits
>>  - worktree: teach "add" to check out existing branches
>>  - worktree: factor out dwim_branch function
>>  - worktree: improve message when creating a new worktree
>>  - worktree: remove extra members from struct add_opts
>>
>>  "git worktree add" learned to check out an existing branch.
>>
>>  Is this ready for 'next'?
>
> I just gave v9 (which you have queued) a final full review and found
> it satisfactory (and gave my Reviewed-by:), so yes, it seems ready for
> 'next'.

Thanks, both.
