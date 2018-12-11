Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EBDF20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 20:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbeLKUPB (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 15:15:01 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:41968 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKUPB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 15:15:01 -0500
Received: by mail-pl1-f201.google.com with SMTP id y2so11306109plr.8
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 12:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z0U322U9YpGndd762FYNTd64SzpcXOMzR1/Zn5qt/lk=;
        b=jsutXHHtNRqcVpmv8XvCtzE1xnhJEyaCiLoJCym15H8PcHDw1ymBEt3rghViJ+U1Nt
         b8nEebSjetKJQfchfLCqkUt9tIPjk0w/CAbZN6V6X9EQMviZ7QmZB6Uq/KKSzkzGUQZZ
         JpHe80Jy8Kxg6xQ5KPlLdOFzCrL8K8/nT3GEUezud9S6dS4ZHHQV53WZwzJlnoTNSHYi
         DTVhvs9cPzRgPFtWVe8TlYRt2yYhJqr3Aj+OrBTbLV/1grSfDaEYO5CpANrRBXO6G0bX
         eGpYRaxD1eNgYh/ZKwZF8ouJAjbnidPO98ZoKHV50QpZK6FH+pt75sbCZndh+4exE04t
         yIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z0U322U9YpGndd762FYNTd64SzpcXOMzR1/Zn5qt/lk=;
        b=YuJQvMf+zo7P7ep7Zt46sadZy+zAgkk0v7s3DHmo+RD3EszN6yV+DrSKMRzVd/lsLB
         OuZxXlFXOunUysx/21S8Ub7zZ93pBudu2RhIWKxgQPB052bc7STx2SgEN6yDAQxmEgk0
         t4mhtLfL3CZ+ENWB2GWPxNksk844T/j1GAJhlH4cSJtaAMs0Li+yjiGFJ76bE1SfRHQ7
         CIc0OkJL8ktOLXtmrX6uwWOinAr+AjLlkaD/uPghxmfLzZPvIE7xnMG1yhNnR+/0wNcA
         1QgbKl/MqbJIalAwXBd5J5qUW9oZoPwOeJOeLD7UTtS5ID6k/Edsj4DYMuk3aOAcTJ7Q
         Gycw==
X-Gm-Message-State: AA+aEWZ9naoI+utXFGIHEuZ7u24H3aiAPlT/aQ0iBvB0b2ONl+SxjLQK
        0oDQjZgdy5D4o5Uan8miIfhpaDcWmgos9r5kaue/
X-Google-Smtp-Source: AFSGD/VldVC7ZgzhBcYITNNk4GhT5IZpHxRiRIYj473J419+itdCEsf5CtnAVZJpi4R87g0YGoAwF6aS7ts4RQzP98+r
X-Received: by 2002:a62:15cd:: with SMTP id 196mr8829164pfv.137.1544559300293;
 Tue, 11 Dec 2018 12:15:00 -0800 (PST)
Date:   Tue, 11 Dec 2018 12:14:56 -0800
In-Reply-To: <xmqqin048te8.fsf@gitster-ct.c.googlers.com>
Message-Id: <20181211201456.122625-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqin048te8.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH] commit: abort before commit-msg if empty message
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > When a user runs "git commit" without specifying a message, an editor
> > appears with advice:
> >
> >     Please enter the commit message for your changes. Lines starting
> >     with '#' will be ignored, and an empty message aborts the commit.
> >
> > However, if the user supplies an empty message and has a commit-msg hook
> > which updates the message to be non-empty, the commit proceeds to occur,
> > despite what the advice states.
> 
> When "--no-edit" is given, and when commit-msg fills that blank, the
> command should go ahead and record the commit, I think.
>
> An automation where commit-msg is used to produce whatever
> appropriate message for the automation is entirely a reasonable
> thing to arrange.  Of course, you can move the logic to produce an
> appropriate message for the automation from commit-msg to the script
> that drives the "git commit" and use the output of that logic as the
> value for the "-m" option to achieve the same, so in that sense,
> there is an escape hatch even if you suddenly start to forbid such a
> working set-up, but it nevertheless is unnecessary busywork for those
> with such a set-up to adjust to this change.

Thanks for bringing up this workflow. Note that this patch only changes
behavior when the editor is brought up and, thus, the advice is shown -
see the check for use_editor in prepare_to_commit(). So there should be
no change if --no-edit is given, but I acknowledge that there will be a
negative change if the user brings up the editor and just immediately
quits it (which can happen in a workflow where commit-msg always
produces an appropriate message, but the user can provide additional
information if desired).

> I actually think in this partcular case, the commit-msg hook that
> adds Change-ID to an empty message is BUGGY.  If the hook looked at
> the message contents and refrains from making an otherwise empty
> message to non-empty, there is no need for any change here.
> 
> In any case, you'll have plenty of time to make your case after the
> rc freeze.  I am not so sympathetic to a patch that makes us bend
> backwards to support such a buggy hook to e honest.

That's reasonable. In any case, we'll also look at fixing the Gerrit
hook - at the very least, so that it can work with versions of Git that
do not have this patch of mine (or something similar).
