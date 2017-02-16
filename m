Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE50D1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 19:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933083AbdBPTtW (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 14:49:22 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36049 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932344AbdBPTtV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 14:49:21 -0500
Received: by mail-pf0-f196.google.com with SMTP id 19so2265927pfo.3
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 11:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QKanUHBgeIo2AjNjaPSKl+JF4Y0ZAO5jRsbd60J4wgM=;
        b=PvQEBdDgxzKQTY/6XH7SNXY3Vmk0zdWuptse409eo0ZbSKC5Ur9GnCf9jIknbaY56m
         4NdkGEj0Av8+1qc1TbcDi75K2l93toJqIALBDYGPfpQSAlfFZBsfhMAE8qB6/dbkOYpl
         tZkDwr736yA5gWTigYx1W9Mq/EgfZ4uR7eIIfdMGe4nkI4OIFqt0y+ta/x7KXqiybGlz
         LiVVuJZHKaYZlaNkACQcR6QKbFj2hfY9RyX2PRuQvN7exYFey5v1dXHLZC078TV9wC5V
         cGu1OAq1BLlqXjGeDInVGi5bI6CxF5WC0ctk3wzP+cztjw8tYvd84B8lOW+R3DyuNQST
         FtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QKanUHBgeIo2AjNjaPSKl+JF4Y0ZAO5jRsbd60J4wgM=;
        b=N+ZsN8PHQfjjNuUS63AppeLTocbjE9uj/QF0RL5a3Y7tWnfvxChIYJE0HHwuhPMw3q
         nJy//QiOJX7/T12C72viLQfanG1GhfioLY6wba6VN3FrFB31vsaBQo7tMZ3Au5QD6CoO
         L/b2J9UUBS14EtkrlbXhSNxMnZuaZxAaV5XRm5HUIiGgRipXQj8yScRbxTJRuD8pB+Qm
         O3EjMlB6gBgU+Ibbg5gZg+FLDZVNMdagbH1SsOax01RAQtvWtuvKxOYuLv6z1OtU9Pex
         r21cc2JticzeFcSXboJzrWeivtfqgLRv9o9x4KwAiSDQzOe5ohWwcWQN9he0WBWzppPv
         7VEA==
X-Gm-Message-State: AMke39n6ZXrhB610hmoUF+BvIjBLe4BPQV66YuoUufrmTPh+ABSxRhsHrcS+JtDP5oxByQ==
X-Received: by 10.84.218.129 with SMTP id r1mr5530983pli.6.1487274561233;
        Thu, 16 Feb 2017 11:49:21 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:9476:4c5c:6ee4:ba3])
        by smtp.gmail.com with ESMTPSA id c11sm15151410pfe.68.2017.02.16.11.49.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 11:49:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3] reset: add an example of how to split a commit into two
References: <20170216002212.31088-1-jacob.e.keller@intel.com>
        <xmqq4lzux7sc.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 16 Feb 2017 11:49:19 -0800
In-Reply-To: <xmqq4lzux7sc.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 16 Feb 2017 11:19:47 -0800")
Message-ID: <xmqqpoihx6f4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> The interdiff between v2 and v3 is not really worth showing since I
>> basically re-wrote the entire section a bit.
>
> Could this be made into an incremental, now that v2 has been in
> 'next' for about 10 days, please?

Nah, I think it is easier to read "log -p" if I just revert v2 out
of existence from 'next', and queue this (with a minor typofixes) as
a different topic to be merged later to 'master'.

So no need to resend and certainly no need to make it incremental.

>> +Split a commit apart into a sequence of commits::
>> ++
>> +Suppose that you have create lots of logically separate changes and commit them
>
> s/create/&d/; s/commit/&ed/

I'd do this myself while queuing.

Thanks.

>
>> +together. Then, later you decide that it might be better to have each logical
>> +chunk associated with its own commit. ...
