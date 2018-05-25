Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1ACC1F51C
	for <e@80x24.org>; Fri, 25 May 2018 08:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964963AbeEYIrL (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 04:47:11 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35642 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964826AbeEYIrK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 04:47:10 -0400
Received: by mail-wr0-f195.google.com with SMTP id i14-v6so7811932wre.2
        for <git@vger.kernel.org>; Fri, 25 May 2018 01:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=mpMG8dzSwV9FnfNQg4kPG22yR4X8fOUVVHpocKDYrXY=;
        b=aojirr5HuZZYuFSwQJYCHjHIEnvD7tGnRQ2YmMkud5Z2ackLgNIHxgVwuPVzafBT+m
         TMSmknZo68Tsv3SPbNP2lg8kaNf8D5sLM3iEOFNhdFN2KNmWm0xj3TZDkyIIFDyd7Frg
         TvI93I+DudSH15iFnVnrBD1+agrjOMFY1hB1rSMqAvzk0ryuu1fe/P59okZd8EQcnVOO
         cg3WcP2PgHHno/YAAQCBUbvA68ut4aP3BVlf3Z73xQaTj2wN1jqQH1As5T7GbXnlw6zq
         sEf3BNTOxGKHRmNOmZk88s0UHPunG0WgRiEz1EfY323SSdf1Kj/9ghJo8sJ+hX8QINnp
         vgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=mpMG8dzSwV9FnfNQg4kPG22yR4X8fOUVVHpocKDYrXY=;
        b=sYnVaJsCntSCSxCXW1w1W68JIeb5mpzddhZoBwWLE3JHF5dRsZommtMy8E4Egt0Y2k
         Lc4FE5pSdwFD8+p3hhv9GiS67xNAF3g58BwWzR9SdsQlN69Y1RTQzM89ngFhOQFS1KOS
         XuiEge9lqHJ9sZJPAMTD7Ls9/LNsRQ1NvSq0iX+G+JSClZ5NWE7M/MaMYtent7L4Bin5
         K1oOJpdcsElbCiT405TUAJWtNHraz1H71pPUW72WHSnvBITUNbGZKDmJEOChtWh+8SPm
         NNNkULOkKhrEoBPfZkVxLG5oEi5Zw5WQqjcEn97zwolUOCIltAY4S2WkLBvqn/f0NxRX
         vGLw==
X-Gm-Message-State: ALKqPwdEAVgm/NiMQE5Xs0OON3PI/pQonl8TgS171q7NROrfCPalJkkI
        HQo/PLYT4CZa3NWJeY2DgfM=
X-Google-Smtp-Source: AB8JxZpQdc/pZGS8lx27sGTvqntwMP2latmZJtjrHxjNIJtm4TqU9LzPc5hAA31F7tOyHY/L195+WQ==
X-Received: by 2002:adf:abab:: with SMTP id s40-v6mr1420534wrc.259.1527238029002;
        Fri, 25 May 2018 01:47:09 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y45-v6sm22475549wrd.97.2018.05.25.01.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 May 2018 01:47:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "man git-tag" inconsistent about whether you can tag non-commit objects
References: <alpine.LFD.2.21.1805241040400.14773@localhost.localdomain>
        <xmqqpo1kpl9i.fsf@gitster-ct.c.googlers.com>
        <87muwo6uwq.fsf@evledraar.gmail.com>
Date:   Fri, 25 May 2018 17:47:07 +0900
In-Reply-To: <87muwo6uwq.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 25 May 2018 09:45:09 +0200")
Message-ID: <xmqqh8mwnmus.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> As that sentence talks about a lightweight tag (i.e. a reference in
>> refs/tags/ hierarchy that directly points at an object of any kind),
>> another possibility would be to say
>>
>> 	Otherwise a tag reference that directly points at the given
>> 	object (i.e. lightweight tag) is created.
>
> Related, this recent patch of mine:
> https://public-inbox.org/git/20180429202100.32353-6-avarab@gmail.com/#t
>
> I.e. might be worth talking about this briefly in the git-tag manpage as
> well, i.e. that you can create a lightweight "tag" to a commit, but then
> depending on where you push it it becomes either a branch or a tag,
> which may not be intuitive to users...

I am not sure if I agree.  People won't get confused, unless they
think too much and pedantically.

If you make refs/tags/$name point at a commit, it becomes a
lightweight tag, if you make refs/heads/$name point at a commit,
it becomes a local branch, if you make refs/remotes/$remote/$name
point at a commit, it behaves as a remote-tracking branch for the
named $remote.  Anywhere else, it is just a random ref that happens
to point at a commit.

And notice that I never said "push" in the above.  The verb I used
is "make" and that is deliberate.  It does not make any difference
if you make such a ref point at a commit by pushing into a
repository, fetching from elsewhere, or running "git branch", "git
tag", "git update-ref" locally.

