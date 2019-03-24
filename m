Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CD5F20248
	for <e@80x24.org>; Sun, 24 Mar 2019 13:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfCXNPf (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 09:15:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34603 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCXNPf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 09:15:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so7152577wrq.1
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 06:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SDMbvQEUOrfUW5Y4+EW1XcH2uVnsXqIObnnKHlhGQ8A=;
        b=ehswytX/46TFHAZsmQeXHYIH282CPLaPqCsQVRvOgMU/8ebnB9kfNnohOa29GN6qT/
         AH13bo7YTGk2kcMXnjKk+whWh8Udjmg8RfpcR3mdw8m4JxsTQND8bSWs4asmJTmjimig
         BVgdgr0lzZ8VEt/k4RiQXktGJEqQlGh7LLfdHg0r5siLYE2YO0fwD0O+tpALRhFqGLRP
         vAtoocoCqxb39fh6ze94uFI/A1jWT9gklsJx46ly/17teqI6g94OwsltJdkBIDh4/HKB
         0ldQA+b5sKGdGCnushq+ZIKQPRDHjMInfp6m7MNwELeSWgNudsMcXQcGF87y6/9vAGTi
         nq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SDMbvQEUOrfUW5Y4+EW1XcH2uVnsXqIObnnKHlhGQ8A=;
        b=WyHqZS1GqEEKm7h57FURsa0RTZinB/nbKk3jJE84ECxZdxg+mPp+J4gqrKVHn/j2D3
         ZOZU+TYjY8j0fYsNCE87UhpCe+XiQ0cj9Xb39IV5XAmIp5ztYnLO+M+9vTHdVaupXHBl
         4d1QoqSt0XHuvC4NTBFZ0YToVLDpdnOscX/H/qD79cdk1yDkd9ZOiA0E62O8BF5BH1vb
         WrdrDlpqMJdd/Kpzzqa6QERX68auJHJgVsWpD01Ft8uG/cTDu7C3ZRUyHiTej/vytIEw
         aFWxZKkUd+i4qteLd+9wgib1JumW7I4ji6yxV4L6sl6zkw1/tVMwftwrBI5VxD8q6Fvo
         TYKA==
X-Gm-Message-State: APjAAAXuFjHANpVEEPu+dDk3QoqKnpSZcdqiKudn8mqv+LvIIoR34dPl
        qt09OW9nWt1nhvxlevWdGYg=
X-Google-Smtp-Source: APXvYqyhMHwz34+cMfN/+mvuJPZpraBS2ETN2iG2ga7czvHQfa9sQ1it729mTt5nF39nrSWM89IAaw==
X-Received: by 2002:adf:ebc3:: with SMTP id v3mr12397140wrn.35.1553433332954;
        Sun, 24 Mar 2019 06:15:32 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id f1sm1148779wrt.87.2019.03.24.06.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 06:15:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] rebase: learn --keep-base
References: <cover.1553354374.git.liu.denton@gmail.com>
Date:   Sun, 24 Mar 2019 22:15:31 +0900
In-Reply-To: <cover.1553354374.git.liu.denton@gmail.com> (Denton Liu's message
        of "Sat, 23 Mar 2019 08:25:22 -0700")
Message-ID: <xmqqy354o1l8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> This series teaches rebase the --keep-base option.
>
> 'git rebase --keep-base <upstream>' is equivalent to
> 'git rebase --onto <upstream>... <upstream>' or
> 'git rebase --onto $(git merge-base <upstream> HEAD) <upstream>' .
>
> This seems to be a common case that people (including myself!) run
> into; I was able to find these StackOverflow posts about this use
> case:

Since this is 0/3 I won't complain too loudly, but read the above
again while pretending that you didn't know what your initial
motivating example was.  The last three lines does not explain
anything useful to such a reader, and the reader needs to decipher
the two sample commands to guess what you wanted to achieve.

Before "teaches rebase the --keep-base option", you must tell what
you wanted to do with that new feature to attract readers---convince
them your new contribution is worth their time to read over.

If I understand correctly, what "--onto $(git merge-base @{u} HEAD) @{u}"
lets you express is:

	no matter how much progress the upstream has made while I
	was away from the keyboard, I want to rebase the current
	topic on top of the same commit from the upstream, on which
	I based the current iteration of the topic.

I suspect that such a rebase will become no-op without "-i".  Am I
mistaken?  I am not sure if "--keep-base" is useful without "-i".

But of course, it would be useful with "-i", i.e. when you want to
further polish the topic.  You need to give <upstream> to the command
to let it know where their work stops and your work begins,
i.e. letting the command figure out what commits to replay.  But in
such a workflow, you do not want <upstream> to affect on top of what
commit the replayed history is built.  And "keep base" would be a
very direct way to achieve that.



