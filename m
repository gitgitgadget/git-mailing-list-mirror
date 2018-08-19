Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A09421F954
	for <e@80x24.org>; Sun, 19 Aug 2018 01:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbeHSEhc (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 00:37:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45936 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725741AbeHSEhc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 00:37:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id f1-v6so5146497pgq.12
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 18:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QetmngArlo8jcqAa3cp4cJpe8ACwiEvOmqOo+ZH6Vao=;
        b=laYoARwxlSghqhjUjg1++wstCOKEtYig6H+APKAiKER/MDL1HkU9vCGYobH2pt8XBL
         EXfvDfRKFVVNYLDe8BH2T7h0901WOkJIf7Jh3KQIvoPnn97F49tNmcuRXZJlKNB82NmB
         mDkV/O/ES8N6UQjCiyoD6hvwFQcDMy5KFG4+soYLZh7UBwcEPoHZwjmP7mnf4kSkuLYb
         6vEGVM9/9mwX/7lVg7GWdzC6BmMCwYnqyKhuE8TR6kCvNdCVe8WAaqEIOdVAKneCOgwP
         XEL4J5fgkO8+Th2DnYuPmJUkvXbvY7C0/Hb4oe14QtSnXjQiJArgZLkB38B+2prVVRvH
         bPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QetmngArlo8jcqAa3cp4cJpe8ACwiEvOmqOo+ZH6Vao=;
        b=OFrK3OS0z37lZFEFR/dcvizA7q1d/VbXonIvMAOD9EPeBdQdL1zVgTHkhCLAOIG/hf
         1IXpQx1TvYCtrNE9yq1qRsw5K4bXWauuc8uhC0AyT+CjmP05OFTgqzUDFQ5Tb+spJpKX
         ivj/BvNOTWIi2jp1JJxi8laXWwlssd0bh0CW5qrU9AFF/KcjWTANet6YDCJaQ64EnZh7
         4sWS/lNrrVLCQEmy7n/LuAgHyfY816R7fF+b3VeeV+T39Wk6AsNiJdWthGEDVIT6C4wu
         MOWtUy7BLYQ+HlgbzgYYrOOF+SYJnC2shuTEmvx6mS/n1LW9jFdhdaLdN/atq0jC7NNK
         /dpw==
X-Gm-Message-State: AOUpUlG/xnmGhmFNhXpWVFUkVYQVobSTpn9qZoPs2+ksLYoTEf/bfsoQ
        mrKne8AOs4BVdA8+hFZwed0=
X-Google-Smtp-Source: AA+uWPzgGnuuGfQFOJnjIPrIsk5XNPdlI3LAHoOlpNP7arfryAwXTCKUFrQj0dfFYIMsJHE1AByGqg==
X-Received: by 2002:a63:d309:: with SMTP id b9-v6mr38214148pgg.163.1534642070790;
        Sat, 18 Aug 2018 18:27:50 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id o10-v6sm15475882pfk.76.2018.08.18.18.27.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 18:27:50 -0700 (PDT)
Date:   Sat, 18 Aug 2018 18:27:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael =?utf-8?B?TXVyw6k=?= <batolettre@gmail.com>,
        git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
Subject: Re: git-bug: Distributed bug tracker embedded in git
Message-ID: <20180819012748.GA175033@aiede.svl.corp.google.com>
References: <CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com>
 <xmqq6007abmu.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq6007abmu.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(cc-ing Scott)
Hi Junio,

Junio C Hamano wrote:
> Michael Muré <batolettre@gmail.com> writes:

>> I released today git-bug, a distributed bug tracker that embeds in
>> git. It use git's internal storage to store bugs information in a way
>> that can be merged without conflict. You can push/pull to the normal
>> git remote you are already using to interact with other people. Normal
>> code and bugs are completely separated and no files are added in the
>> regular branches.
>
> This reminds me of a demo Scott Chacon showed us ages ago, the name
> of which escapes me.  I guess great minds think alike, or something?

I believe you're thinking of TicGit[1].

Some other related work is listed at [2].  Most of these projects have
gone quiet:

- ditz[3]
- git-issues[4]
- cil[5]
- Bugs Everywhere[6]
- milli by Steve Kemp, which I haven't found a copy of
- simple defects[7]
- kipling[8]

http://www.cs.unb.ca/~bremner/blog/posts/git-issue-trackers/ gives a
nice overview, though it's rather old.

This area seems to have gone mostly quiet since 2014, so it's nice to
see new work.

Thanks,
Jonathan

[1] https://github.com/jeffWelling/ticgit
[2] https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools#Bug.2Fissue_trackers.2C_etc.
[3] https://github.com/jashmenn/ditz
[4] https://github.com/duplys/git-issues
[5] https://github.com/chilts/cil
[6] http://bugseverywhere.org/
[7] https://syncwith.us/sd/, https://gitorious.org/prophet/sd
[8] https://gitorious.org/kipling/mainline
