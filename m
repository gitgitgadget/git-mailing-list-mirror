Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E659F1F461
	for <e@80x24.org>; Thu, 29 Aug 2019 14:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfH2Ocd (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 10:32:33 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:52423 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfH2Occ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 10:32:32 -0400
Received: by mail-wm1-f44.google.com with SMTP id t17so3977731wmi.2
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=continuousdelta.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=9XAOwiwmL2j2dXBKdJ29sPdry2nm9I0NVgeYeOCQI3U=;
        b=d+gughDMgwk6GZ6tSTcSs+gbCSF4E7SnmpKearPVOX25TBWlcDG/SVr9gula3RtB4l
         pPVSaLLXh5QX68nEbEWKS+YJIxKYqhLVxm7lFv4gN/FurOpPxWSZsB6IEUkjLCO+ESPH
         c/4Pz8PsvXbb4WmPdS1sYRVCy6ozuOe9K129YAps97+dJ4tXOl3CwzQoKeynQx+F4rCO
         SVWNL7jnpUzMk9es/+Qtxp/0TuoajaGE1NqU43jXkpvulfsc3Ot5h8YZNLa99ACV+/QI
         hvPFE5Nh//HpEeT6pDSz4effsayGrN/yEZTw6J9YDh7bWkKCmo1qeOy8L7MIdKnTwqHE
         eyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9XAOwiwmL2j2dXBKdJ29sPdry2nm9I0NVgeYeOCQI3U=;
        b=BRHVYvuqHgK3+QUptWKYLyL5tFCd9KVN0gfbHmr7ts9v4dC5/P+Tuac2xephXgCvFq
         FIlBX34Oi/0fvlr+19zFIVZ1QIMS2LjRD1dGfZU//FFNmAl3RRnj1Z+wPG6pxQ5NzKx5
         4zbnbZTq1OO+QmDAGZ8v9uEdgZ7zLOYyZl3U6E8h1H2YoEabB3Z/wo6vbodnKxqCapGx
         GL/5kQxQsen7zlZqh5sV0a0Ryw9HQ50NniTxljNXxjrGtwc1EPElz+4U3/oi/7yBhCgn
         rCxnXIKsxCxCT/S1X6Q4c9zSJ5oC2J4jnEgKgg3xiX1n88qRyX/sUS5BzT+BjAXMJyYY
         Xf0A==
X-Gm-Message-State: APjAAAWg+e7A273iZI8skmKjRC/X2OtJkkwKUUKtEzJR/uHW/QIj55+/
        fbsi8lO38D5+HCnH9Xh9br0iSZuB1hUTsUvtmE+v6WZ7NiCg3w==
X-Google-Smtp-Source: APXvYqwm3jqFnI7XtIS4lXXmvRlXrY9hzjKbS0V2xfgMtyhY1iL/cwuBWuE0ot93I59XTDaVUDm3BUg3YBk49azq0lE=
X-Received: by 2002:a1c:be05:: with SMTP id o5mr11065773wmf.61.1567089146835;
 Thu, 29 Aug 2019 07:32:26 -0700 (PDT)
MIME-Version: 1.0
From:   Matthew McClure <matt@continuousdelta.com>
Date:   Thu, 29 Aug 2019 10:32:16 -0400
Message-ID: <CAEV-cEryZZarfz5SQsRphBXeYMPJW7tdSfY8NYnzb_-ra-pGHw@mail.gmail.com>
Subject: How to track history of personal changes in a repository?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm looking for a way to track history of personal changes in a repository. I'd
like to protect against accidentally pushing the changes to a remote branch. I
imagine this working a little like `git ignore`, and a little like a separate
branch. It might be like a personal sub-branch that is ignored by `git
push`. Or it might be like a history of the work tree that runs parallel to the
reflog and to the history of any given branch.

Does something like this exist in Git or a complementary tool?

I found `git update-index --skip-worktree`. I imagine it might be relevant in
some kind of workflow where I can maintain a personal-worktree branch.

Does any of you have a personal workflow that addresses similar concerns?

Thanks.

-- 
Matthew McClure
Continuous Delta
https://www.continuousdelta.com/
