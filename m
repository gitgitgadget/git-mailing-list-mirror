Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B02711FC47
	for <e@80x24.org>; Sun,  5 Feb 2017 23:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbdBEXZy (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 18:25:54 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33743 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbdBEXZx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 18:25:53 -0500
Received: by mail-pg0-f68.google.com with SMTP id 194so7387853pgd.0
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 15:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LFQ5acpP/G4EJDBfyFXmYSKPdyn8Wyoyveuq106rTWc=;
        b=BsWX2LD1ZoQYf7eX4uSstdo18gclJEaf4OjO/nYLdA8zl0BubUDCndqboJnpYXX05Z
         MllQvqL/7SOtatNQY7Tw5uLoSXz4iYpH8V4jDTCfUUT5ijBT8UFuE+69Wymc1rxCWZcT
         wRCSDUjrNWOKaHDEr43q6u96FzQEXhKVP+zfE6bNqgsCExM3Sp7uxSiA1ZDSgWgRZle0
         OJMMYE1kA6Ll/5vtXXkkTSueEH6GNcI1KynWnu5YFdyKxrj0hjQgUrimEOaf8cCKFyLf
         aUcOuXg+TXx406BSNcFz2XuUNyWg6wE5X7+XnTT/syYJHTvNXHxqgXuStOUPCgATY9OP
         iblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LFQ5acpP/G4EJDBfyFXmYSKPdyn8Wyoyveuq106rTWc=;
        b=l0v+ffA4/zJ4nTOF/7hOTmAmcRk84Q7zfWeOqxlolV33tUFaPcMujKC2QSRyCkfXk1
         gQBTSasYZ5UG6m5uNnv2NYRjviTouW4hS6CUHopCP8v1NqkCcG+c4/DO7PJK7ELaJGZh
         BQEMXmXO7NLjojMU4uyc0anbzDHys3vus6Gk+OSEJYGdYWf7V9AGG6mlIjTwEJt1X2jv
         0/8tHWLxVnJmaNGamRH7vo65NUzrMJsKexERz0wiJdtruUDRl6UKYrP7R0HFm8HVe6F4
         3E9Uxcu/Rh3mP6X3iuDjvdDx8GWub4Swigb4iCk4JNlVGlGb6XXkD3vnE0SOjQJ3EYuP
         yl1A==
X-Gm-Message-State: AIkVDXICRUnf/AJKw7Casdmkm8cMsJR3aVcvCsa/tUwa8ojAFUOvnnO53PD/CaYO3eGzlg==
X-Received: by 10.84.233.136 with SMTP id l8mr13313313plk.169.1486337153149;
        Sun, 05 Feb 2017 15:25:53 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:ac74:31b6:1bdf:d117])
        by smtp.gmail.com with ESMTPSA id a2sm83388468pfc.72.2017.02.05.15.25.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 05 Feb 2017 15:25:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     cornelius.weig@tngtech.com
Cc:     git@vger.kernel.org, bitte.keine.werbung.einwerfen@googlemail.com,
        karthik.188@gmail.com, peff@peff.net
Subject: Re: [PATCH] tag: generate useful reflog message
References: <20170205214254.24560-1-cornelius.weig@tngtech.com>
Date:   Sun, 05 Feb 2017 15:25:51 -0800
In-Reply-To: <20170205214254.24560-1-cornelius.weig@tngtech.com> (cornelius
        weig's message of "Sun, 5 Feb 2017 22:42:54 +0100")
Message-ID: <xmqqo9yg43uo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cornelius.weig@tngtech.com writes:

> Now, a reflog message is generated when creating a tag. The message
> follows the pattern "commit: <subject>" where the subject is taken from
> the commit the tag points to. For example:
> "6e3a7b3 refs/tags/tag_with_reflog@{0}: commit: Git 2.12-rc0"

Because the reflog records the actions, shouldn't it be saying that
you "tagged"?  The reflog for HEAD says things like "reset: moving
to...", "am: $subject", and the reflog for a branch says things like
"branch: created from master", "am: $subject", "rebase -i (finish)".

For a tag, I would imagine something like "tag: tagged 4e59582ff7
("Seventh batch for 2.12", 2017-01-23)" would be more appropriate.

> Notes:
>     While playing around with tag reflogs I also found a bug that was present
>     before this patch. It manifests itself when the sha1-ref in the reflog does not
>     point to a commit object but something else.

The underlying machinery for "log" and "rev-list" is about showing a
stream of commits, and most of the reflog entries point at commits.

On the other hand, the "walking reflogs to and show the sequence of
the tip of refs", and there is no reason to expect the tip of refs
will always be commits, but an ancient design mistake bolted the
latter on top of the former (perhaps because in practice the tip of
refs are almost always commits); "reflog" aka "log -g" and "rev-list
--walk-reflogs" share the same issue coming from that misdesign,
which needs to be corrected to solve this issue.

The exact same design mistake also makes "git reflog" to accept
options like "--topo-order", even though many of the options that
make sense for the "commit DAG walking" (which is what "log" and
"rev-list" are about) do not make any sense when walking a reflog.
And the command would give nonsense output when given such an
option, because a reflog is a single strand of pearl of objects (not
necessarily commits) and the order in which these objects appear in
the reflog does not have anything to do with the underlying commit
DAG topology.  Fixing the ancient misdesign would fix this issue,
too.

I think the fix would involve first ripping out the "reflog walking"
code that was bolted on and stop allowing it to inject the entries
taken from the reflog into the "walk the commit DAG" machinery.
Then "reflog walking" code needs to be taught to have its own "now
we got a single object to show, show it (using the helper functions
to show a single object that is already used by 'git show')" code,
instead of piggy-backing on the output codepath used by "log" and
"rev-list".

