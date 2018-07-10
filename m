Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B58D1F85B
	for <e@80x24.org>; Tue, 10 Jul 2018 22:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732344AbeGJWhX (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 18:37:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35407 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732251AbeGJWhX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 18:37:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id a3-v6so6950959wrt.2
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 15:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sZ0K6FC1y7dXou6fkDYArXzH8pfUEd0mXMS/i7TkYJI=;
        b=Z3siw7HgBhm6vWic18fN6bu1ZqpUxvsmRG8fwKUEZKvFJ3BjC021fwo90kRVzcHVuj
         IWsC1SGhEjoqLC4z7S0nFcucfeoTttLHT/HgGuGzYET0yjYmk9+4aNPnITEV0XXefsdA
         RyYWXv7lIeFkp8Hzbican0GshU/IG3OUqeFEcIqSS529W4FcJKvOQfyJ1qzwAhS7k8Gk
         Mz/5ym9QJGBNDNiKTI+Vl/ycXfkNHcvo9JTpe7XMSTgxzrdmWmq8LQCTKPNjR/LkomHQ
         +BMTT+MJksiXfs7xFkgQOaeVq+6xwRAuxAJ2Pj+aBjjOIL7txmrwBVxo/CA9czI5Edmk
         ivKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sZ0K6FC1y7dXou6fkDYArXzH8pfUEd0mXMS/i7TkYJI=;
        b=raCSeZN9zfdj+Cnx0sxzuFA2jL/MPcQnh1eUowj/hD+67KrVTHfAbHbNq5cTXk07xT
         IN00r7vAj+TkWghvhoSbRyQ6I2e3Gt9AEm90oX+X3VrcCDlH1bN+ZI41cPnscU9bwPsw
         BtSFRzZ8pO8xxLQWgI1jngOwykV1Ftr8nEs7wuCAbmonzD1oxW4Kfn0bqOYRhLIW957S
         6spp3JcahuJHYVk+NYHpiXeiXztdljHLPhLkpGf9LQuHqxQKhLx47jGGxnQROCgp1/70
         vq4ef4UJcZRcL4deo1XsLr116sRxSqRIh8hY1U43M9DvA+rZCpGs6cZnaSOhKX2QLFsY
         snSg==
X-Gm-Message-State: AOUpUlHBLFGLT7NHUPxfF32ko+BrO5k1E8Xo1IMSzn+nS1rY4WtI8Sxn
        IsJRTyLk50K5RIrQBCJZFsU=
X-Google-Smtp-Source: AAOMgpd6i0EGdeI7p8MXYxRow8EpIxTXuJlr2zxo1/gbS5ZNijdetVO0UJgJukri0szlSeyZmNfPLA==
X-Received: by 2002:adf:a789:: with SMTP id j9-v6mr7777611wrc.277.1531262169722;
        Tue, 10 Jul 2018 15:36:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k14-v6sm15604095wrg.38.2018.07.10.15.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 15:36:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v3 11/13] rebase--interactive: remove unused modes and functions
References: <20180702105717.26386-1-alban.gruin@gmail.com>
        <20180710121557.6698-1-alban.gruin@gmail.com>
        <20180710121557.6698-12-alban.gruin@gmail.com>
Date:   Tue, 10 Jul 2018 15:36:08 -0700
In-Reply-To: <20180710121557.6698-12-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 10 Jul 2018 14:15:55 +0200")
Message-ID: <xmqqzhyy4t2f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> This removes the modes `--skip-unnecessary-picks`, `--append-todo-help`,
> `--checkout-onto`, `--shorten-ids` and `--expand-ids` from
> rebase--helper.c, the functions of git-rebase--interactive.sh that were
> rendered useless by the rewrite of complete_action(), and
> append_todo_help_to_file() from rebase-interactive.c.

Good.  So far up to this step, I thnk the organization of the series
looks good, even if the execution in each individual step we have
seen previously may still need to be improved.

