Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 271C21FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 21:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbdFPVlK (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 17:41:10 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36794 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbdFPVlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 17:41:09 -0400
Received: by mail-pg0-f41.google.com with SMTP id u62so6114948pgb.3
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 14:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Q6xrOo29tGUWjYs+rwPEQGCyR0FVkktzZhpUwJDmfRk=;
        b=f8rdvyQljHC4ILUvILf5OEhp5j3kS5aTvMmH7rFXzpzI4UXrhiLlDhMmufjm6MieNI
         dlqlX96Yzf0sWYeSvZejCCdU8ho5zOnQT82q56yseRDndXHLVzEi0Vpy5zdCF0D7prXW
         Z1U9Ib1ZCovJ4o3aKcGuk5xyEENKDskucy6rCv8ivoWRyOJZq+jZ09w65s0RDmX1PRJW
         psXUD/RxZRjnZHz3jT2y3FMEo5rDEmX7M2vumGpTPaGJ46VEy1/cjENlmYaKhN+EYqFI
         0wYrqQz02GfAS++UKRWqJ91X+JOX4LILdGRyM6v9GPFIo0VQP4MkVDqM2FkFH4SJl/LE
         eFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Q6xrOo29tGUWjYs+rwPEQGCyR0FVkktzZhpUwJDmfRk=;
        b=RoZE0s0iixDxo2uEuiJxDLDI4U3F6hgNSCDDeaTMgZoNSO4P7XqNdLUed6BG2tdZuo
         vjL5VHEeFQsyMoRa0kEmyCfFhV3cY2TebyVQ6aY27Fz2Yxc/XyGfI1yQelyHhYvilOgM
         eFndj4e3R5xcOaGI32e6oqy+hQrQ5KZSn8u37IkLBn3NpD0zcQEnE0YPkai8fzFalePL
         ct4EO+xm4X7Ah2nIUIBI2z8W+4SVuP1b/I4bTan0jFrimCLrOOkd6NfQH02DzSxY/Vog
         oJfacPjJrujd2otry0sH6zBkTt+Na+kd2rRCnJ6Er8R64vXGgnHolRYAQgbyHw7tLTlg
         aLMw==
X-Gm-Message-State: AKS2vOxEfzJscdPq+KczMcZJcvfOo7eZV4yxz62pBH5APKZKyAsz5+Qs
        wGJOQ+GoP9M29Q==
X-Received: by 10.98.11.80 with SMTP id t77mr13242700pfi.104.1497649268549;
        Fri, 16 Jun 2017 14:41:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3047:3460:ee36:a98a])
        by smtp.gmail.com with ESMTPSA id y13sm316961pgs.30.2017.06.16.14.41.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 14:41:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Cc:     git@vger.kernel.org
Subject: Re: [suggestion] Include commit-ish in git status output
References: <CACcTrKfPKdPCVONMcGRbisK_WOt70yLdjavZnLTMMVocrwzk1w@mail.gmail.com>
Date:   Fri, 16 Jun 2017 14:41:07 -0700
In-Reply-To: <CACcTrKfPKdPCVONMcGRbisK_WOt70yLdjavZnLTMMVocrwzk1w@mail.gmail.com>
        (Mahmoud Al-Qudsi's message of "Thu, 15 Jun 2017 18:43:46 -0500")
Message-ID: <xmqqefujwqz0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mahmoud Al-Qudsi <mqudsi@neosmart.net> writes:

> I hope it is not considered too forward of me for my first post to this list
> to be a suggestion on a change to git’s behavior (though not in any
> functional manner); but a persistent frustration for me and everyone I’ve
> worked with (so, yes, 100% based off of anecdata) has been that the output
> of `git status` does not include the commit or commit-ish, and one must
> resort to a `git rev-parse HEAD` call.

HEAD is, unless you are about to create a root commit, always a
commit and not other kind of commit-ish, so there is no need to say
"or commit-ish" here.

If this were a proposal to add human-readable information about the
current commit (e.g. the title of the commit), perhaps next to "On
branch my-topic" line, e.g.

    $ git status
    On branch my-topic
    HEAD is at "*.[ch] refactoring: make use of the FREE_AND_NULL() macro"
    Changes to be committed:
       ...

I can understand why sometimes such a piece of information may be
useful to users.  But I am puzzled by your `git rev-parse HEAD`.

Suppose you get frustrated due to lack of HEAD information in the
output from 'git status':

    $ git status
    On branch my-topic
    Changes to be committed:
	...
    $ git rev-parse HEAD

and that was the reason why you resorted to "git rev-parse HEAD"
immediately after asking "git status" about the current state.

That command may say

    $ git rev-parse HEAD
    88ce3ef636b1385e861ec0e9e2155248b999b032

or it may say

    $ git rev-parse HEAD
    e140f7afddcdce2bae062ea1578eac38c744e3a5

What would you do differently, after seeing this random-looking
40-character string, based on what it is?  Do you know recent commit
object names by heart and can tell, immediately when you see 88ce3...,
"ah, that was me fixing foo", as opposed to e140f7a... that is a
different change you can immediately identify?
