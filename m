Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADE5B1F453
	for <e@80x24.org>; Sun, 30 Sep 2018 00:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbeI3H0j (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Sep 2018 03:26:39 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:37799 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeI3H0j (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 03:26:39 -0400
Received: by mail-wr1-f41.google.com with SMTP id u12-v6so10036406wrr.4
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 17:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XcrAlFjxC22PGiZV3qNY4+GRKA+WnHxT5ZrXgT/0c/s=;
        b=U8T7rTPjl/Z3MqQ9mjgJQvMV/4jAJhNdPRQ06esZ9uUYD65HOVtpxSM+3pXBoKEYtO
         ycEmkRWtJR1RH9xQTIKxgtfMAtSjJkdjWAhUsk6A84A5G8lPDyD6F+KUG/uDMApbJxr+
         kUg3nOB/sQjxkqzE183gixjIpVvxJGHadyUtfBwiRMkdK1MPHBm1zrenmWcc8HYl/M1o
         gGZ82JiJoMuDSuE033LXZIPEuQBTDNNQIY0rXHSSSSBfcTC8nLjDtm0ZnWfqHwmaZ4X1
         NFDaEWY7gvf+U3YqdTQ7n+KD0p7EHmRobJ2SHKcsLPPnJcNnbNoqvDGnZ9uSqXx5I+L3
         nI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XcrAlFjxC22PGiZV3qNY4+GRKA+WnHxT5ZrXgT/0c/s=;
        b=k6rrIMAT18DsTrN7mtknJigc3haaREPUgUNZhlDzVIqwl6FusXWKqT6A50T+E03uKz
         YIRMRrHUBSd9gTv6IsWa75EnAXUsQpMLitq/7yjXDO0KUX93WGIDz4/mYTwz4t3bkuzG
         FGQlJWc3TDC8WDGzI1YDt025MCkwfAazZzzBZ1Ba2z25K64CzjzT5AZdSh0a7o5ErGfs
         gyOKowJbzA/ane2X/J3NiUduuoxjDSu0Z1vb9+OFTY7jbqMpXlcfdghk+yvLga9ck0Nv
         GYXgyd+G0bsVWmP38aB/Hgz8BFtd2K9wJSttIdLyUlfaxFQCHeD5Aqw552T4B504q8Vg
         7Flg==
X-Gm-Message-State: ABuFfojNEPVQEE6XWGqEX2+fNOjxEz98UXKkRG2ELqG1gRR5LBrxf8T9
        nf6KGB5t8xzhUtGt8TCyYi4=
X-Google-Smtp-Source: ACcGV63nZUoTVvfxuL/2hzQBFoVFXOfznhaCNd2CQ52RzMxLpJZ8ZnuW88crcC81/BZjb0BTJh5apA==
X-Received: by 2002:a5d:6a46:: with SMTP id t6-v6mr3158006wrw.192.1538268959957;
        Sat, 29 Sep 2018 17:55:59 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f6-v6sm6662076wrr.68.2018.09.29.17.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 17:55:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Xenos <sxenos@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Git Evolve
References: <CAPL8ZivFmHqS2y+WmNR6faRMnuahiqwPVYsV99NiJ1QLHOs9fQ@mail.gmail.com>
Date:   Sat, 29 Sep 2018 17:55:56 -0700
In-Reply-To: <CAPL8ZivFmHqS2y+WmNR6faRMnuahiqwPVYsV99NiJ1QLHOs9fQ@mail.gmail.com>
        (Stefan Xenos's message of "Sat, 29 Sep 2018 16:00:04 -0700")
Message-ID: <xmqqbm8f952b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Xenos <sxenos@google.com> writes:

> What is the evolve command?
> ...
> - Systems like gerrit would no longer need to rely on "change-id" tags
> in commit comments to associate commits with the change that they
> edit, since git itself would have that information.
> ...
> Is anyone else interested in this? Please email me directly or on this
> list. Let's chat: I want to make sure that whatever we come up with is
> at least as good as any similar technology that has come before.

As you listed in the related technologies section, I think the
underlying machinery that supports "rebase -i", especially with the
recent addition of redoing the existing merges (i.e. "rebase -i
-r"), may be enough to rewrite the histories that were built on top
of a commit that has been obsoleted by amending.

I would imagine that the main design effort you would need to make
is to figure out a good way to

 (1) keep track of which commits are obsoleted by which other ones
     [*1*], and

 (2) to figure out what histories are still to be rebuilt in what
     order on top of what commit efficiently.

Once these are done, you should be able to write out the sequence of
instructions to feed the same sequencer machinery used by the
"rebase -i" command.

[Side note]

*1* It is very desirable to keep track of the evolution of a change
    without polluting the commit object with things like Change-Id:
    and other cruft, either in the body or in the header.  If we
    lose the Change-Id: footer without adding any new cruft in the
    commit object header, that would be a great success.  It would
    be a failure if we end up touching the object header.




