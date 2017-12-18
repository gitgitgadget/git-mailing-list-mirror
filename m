Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C8931F424
	for <e@80x24.org>; Mon, 18 Dec 2017 18:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759142AbdLRSbS (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 13:31:18 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:42829 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760018AbdLRSbL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 13:31:11 -0500
Received: by mail-qt0-f174.google.com with SMTP id g9so21199703qth.9
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 10:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5XmcQ4/oCkZCPamtg5sYZqblK+0Ono4r1f0afbRAedQ=;
        b=cnRzEwC2FNjOLMX99MqKZVyKmAuPpLtcEY5YirWzQGNuIKSFK8O3glq1k50cWfFODG
         22UehwSwKpBFJs+kGst9K/J/R9YwqKFE4Smn5XhYDPltKdwYWqSHd5aCzDasGKcweLCe
         VztsyunWCu3gANYfwBVPY9sjycLRMT+0fvLoTFDYBpbC2UkWKuZOUXv6siu7OGqXEmZB
         N6ox82/KYPZ/etcbAV3Cqoa8gAuIUp6THAzUY58Pqk0ceNTeI0fA7U/cyNqpJF6ZTtjK
         5IkeiK9cYXg0MQSAeifW4401uH74ffIWlvh44M65YHIeTuW8v7KWggwwEwrZoI9L8Rvm
         P4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=5XmcQ4/oCkZCPamtg5sYZqblK+0Ono4r1f0afbRAedQ=;
        b=n9tGLqnMxbWLuytVmuYA1wrk1NyQIM2aQq2Bl2OTxO50eM4OfGvptC7/7qJmWrvXlv
         sHklHsP9+pMhl10F/ki2gifv8iUpuKyHsLcrav/6rNajM548EG6hie+y2SEhg1OQPiA+
         lTjY0AjkhBO+9Ft4e8jXpMh5+OhF2zPE003j9pKn8nMHaUmXT3xA/44P5AnLZ+7zf9e0
         5I915QLd4OFiDqB4O71eZWQc0ATobtSSJgoYyYXtjw4NEJauoQzXtRbTAo+BAFjryp/H
         Yj9XTWX6cFjqgtzR20HMdtHpanITXoJoO35D1lEOOqSBpCLlxqeWkIGK+79oZ2qoTu4v
         XR9A==
X-Gm-Message-State: AKGB3mIPvq8uY1yugZCauSQgu9iwgGw96qsvNR3zbp03vttPSUvv0C7X
        aHMTT3HJxV8A8o0CNM+CDBA0mk/A1L/Gu6nWqIc=
X-Google-Smtp-Source: ACJfBouo3tXjaCqP05xwNLSNc1QNBcI3LfZ+g/uI93JexKBZGgfsnxYS8zhHnVOweIFj0rq0lcdG9YFv9jNczXKdHMg=
X-Received: by 10.200.6.76 with SMTP id e12mr866374qth.217.1513621871053; Mon,
 18 Dec 2017 10:31:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Mon, 18 Dec 2017 10:31:10 -0800 (PST)
In-Reply-To: <CAJ4+5mHMD+yW1ZDD6KJSnMtyygLUGiHzNPgPDZUi7+KUvOczkg@mail.gmail.com>
References: <CAJ4+5mHMD+yW1ZDD6KJSnMtyygLUGiHzNPgPDZUi7+KUvOczkg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 18 Dec 2017 13:31:10 -0500
X-Google-Sender-Auth: v_yMT7AX8tXQ94P4dfSuew72ogA
Message-ID: <CAPig+cTmRiSfY9+DsvEB7X_cL4AiAmq0FUb-CoDyc3HNDJLtow@mail.gmail.com>
Subject: Re: commit-msg hook possible bad behavior with -F <file>
To:     Seth Raymond <seth.c.raymond@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 18, 2017 at 11:43 AM, Seth Raymond <seth.c.raymond@gmail.com> wrote:
> If a commit is invoked with -F <file>, indicating that the commit
> message should be read from an existing file, the the
> prepare-commit-msg and commit-msg hooks do not operate on <file>. The
> first argument to the hook is always <git_repo>/COMMIT_EDITMSG, rather
> than <file>.
>
> Am I wrong in this line of thinking?

The content of <file> gets copied into COMMIT_EDITMSG, so the hook
does see the supplied message, as expected. Given that the hook is
allowed to edit the message, it makes sense that it works on
COMMIT_EDITMSG rather than on <file> directly.
