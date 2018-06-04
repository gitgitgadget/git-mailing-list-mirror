Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 228F71F403
	for <e@80x24.org>; Mon,  4 Jun 2018 02:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeFDCPZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 22:15:25 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:33680 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751373AbeFDCPY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 22:15:24 -0400
Received: by mail-wr0-f170.google.com with SMTP id k16-v6so14266831wro.0
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 19:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/mP5O/v5fIMwzvhOIAWthQw2LjvKic2eNo2w6ot6mGg=;
        b=PfIxSTanjxXmpOvhoWWYMcvBjxPijmVlKRnt9rSCD2nYqCNrmeic0heMAijjDjSkmM
         AUUaAbIlIku3rbkC/8J0QejBmcbubFi0UvpKuTf0+4KP+8Tcn4H0VVBJFlDSFsBFzqzO
         fe3hjkgZqCtGOt3XaoEv5mJ1wafIEHQ7KKmtogB2FOE6EZcd25quKUP/weSr0tLqBS6a
         0n8/d7+WKaSvge9cqWOw/r34pz0fdiqzV0xzqzbsEeuWD0ZPUDfvvqPkNkl+aLEEBNmi
         Swxoc1AXAoXjtLB4Y18YDBhbgj140lnzcH3gUaqgWtdTz/6qn6iqLN/gC5AIz40heUyN
         ptAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/mP5O/v5fIMwzvhOIAWthQw2LjvKic2eNo2w6ot6mGg=;
        b=JUQmuwdY8bJxRSgDbz4F1x/IfMJxdUVY2GQKQvD+1cfr0b8atxn3Md6a6aUhBmTKr1
         Gcd+3dUAhbtJ/5IU+Ayt6btjRY3G48Pe3c0EWyKnZPz4HxlcnCDrsOgZIocbrjfheMDJ
         enfyZz0rHMeTQdZDEEiUlUhBADL8KTN7AU2Ury8cBjdvWg/f2B/AP7Mxgi8ouQDC+9IR
         16V5itBI09+21FCYiiF9SKDCgVDJG2bEYAHraCl2X8jfGXj4HCaG4o26IAc5Bh9eILTl
         xjphkiyZrc1tt9uVukVoK5GEw/wQeRp/sRPdB61zkV0Hm/mrtx9EiMdBFSZpzxemJeGZ
         JJZw==
X-Gm-Message-State: ALKqPwdoqqWwAOTnlkBSmW1oHj4FVxWGHwMu2lT3Tx0AXo3m5dtBr7vs
        /8b+1j1TbRLDy8T0dhqiYZA=
X-Google-Smtp-Source: ADUXVKKqt8ciloyCkn3MZmWSifZUYumjA5d7ezT/hx83PXDHmFUVIny2AIunZTPN4GyjAVCAEDTrIg==
X-Received: by 2002:adf:9525:: with SMTP id 34-v6mr10602189wrs.99.1528078523043;
        Sun, 03 Jun 2018 19:15:23 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m64-v6sm10753984wmb.12.2018.06.03.19.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Jun 2018 19:15:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ye Xiaolong <xiaolong.ye@intel.com>
Cc:     Eduardo Habkost <ehabkost@redhat.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: Re: format-patch: no 'prerequisite-patch-id' info when specifying commit range
References: <20180529184651.GB14525@localhost.localdomain>
        <20180603060702.GA1306@yexl-desktop>
Date:   Mon, 04 Jun 2018 11:15:21 +0900
In-Reply-To: <20180603060702.GA1306@yexl-desktop> (Ye Xiaolong's message of
        "Sun, 3 Jun 2018 14:07:02 +0800")
Message-ID: <xmqqh8mj70w6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ye Xiaolong <xiaolong.ye@intel.com> writes:

> I narrowed down the problem to revision walk, if users specify the commit range
> via "Z..C" pattern, the first prepare_revision_walk function called in
> cmd_format_patch would mark all parents (ancestors) of Z to be uninteresting,
> thus the next revision walk in prepare_bases wouldn't be able to reach
> prerequisite patches, one quick solution I can think of is to clear
> UNINTERESTING flag in reset_revision_walk, like below:
>
> void reset_revision_walk(void)
> {
> 	clear_object_flags(SEEN | ADDED | SHOWN| UNINTERESTING);
> }

When you are done with objects that are UNINTERESTING in your
application (i.e. only when "format-patch" is told to compute list
of prereq patches by doing an extra revision walk), your application
can call clear_object_flags() on the flags you are done with, I
would think.

But the current callers of reset_revision_walk() do not expect any
flags other than the ones that are used to keep track of the
traversal state, so it is likely you will break them if you suddenly
started to clear flags randomly.
