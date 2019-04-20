Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0910920248
	for <e@80x24.org>; Sat, 20 Apr 2019 01:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbfDTBBZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 21:01:25 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:38448 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfDTBBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 21:01:25 -0400
Received: by mail-qk1-f172.google.com with SMTP id g1so3715903qki.5
        for <git@vger.kernel.org>; Fri, 19 Apr 2019 18:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BwhgZ8egDsUH8zcK8qPtEwdRNf2sPThBekKUvHz/e1o=;
        b=jFeHgAc8fdVR5BYBQsJi9VJeLp0OohCja8jMvXdEglb0B8nUMVngo5vQSUqgP7uFgO
         ZvAmqitoyTX+TOPr1tKpE9PjzZKLcgEuWBMWquY3frevhpqvhzavONE1Vuhlr1Fpewv3
         lhJSF9+UVvRct2BDqXupI7gtUUbRyFbvp0dYSX1+Pbi5zAjNRhM4LMXne7WJJBKvW8TA
         8323RSVuIdZ3uEMXobiS3WKsxPyBEWRh0MWcR+zreURc+Yy5g2a7j2E4NfAcq61cOf8r
         y5tvxTVNefDydJwBU3kjH6m7SCSBrejmp9TTcAUk6IcbiCX8xbEGmqKgbFamJHk1QeoB
         slgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BwhgZ8egDsUH8zcK8qPtEwdRNf2sPThBekKUvHz/e1o=;
        b=Z4BP7DPVrf8qOW3oWtktTIZQ5MLoE6tSctOQEpomPnTkuOXYm0MKTsQdio2st99fFn
         wUC+lEX4j2dR+q3qXS9dde88D6c9IsL+7nM8Lcl4fq8ZWwvIEAVw0h3+ObkbLxYhBUaH
         tInOwxr3MhJUMj85Kr0ME9OO19ogfNQNXgzg3woPtcYnziC+8may06LL6w05qE15sRbz
         m/J/VotRSUKPvg7wSyTpYWpOBBNrjVI/YWqIZUUh8FuqcIGFQ0spHkAWGcfCl4cP0MJd
         UDzEA/1AAeKajXs57N2q3NOpolXbi04zd1ayAWXVlU3PrioaCB2WxCErN/8LE2rV4KYk
         6q6g==
X-Gm-Message-State: APjAAAUDdVU11A80UggcMybruAbBalMy/XFL5EaMHvMS+30C7k55PSxl
        ZuJyvqXIE78ydTGBfv9/yRePrPee0YDpwu4yHBMxAe7M
X-Google-Smtp-Source: APXvYqzq7xHUDPabiKr51INpG0jvYiHFhU2HJ/Us4+VKS2fc1G7+Q4TJtsd3EaQ2okt65Qm6+ynvuX7eXK+/BiPi2Gc=
X-Received: by 2002:ae9:e012:: with SMTP id m18mr5662810qkk.267.1555722084221;
 Fri, 19 Apr 2019 18:01:24 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Jerdonek <chris.jerdonek@gmail.com>
Date:   Fri, 19 Apr 2019 18:01:12 -0700
Message-ID: <CAOTb1wc=qBmD4k4DH1bMckrYzc3ZzB=bBYDk7QUQWxKdtsXCHQ@mail.gmail.com>
Subject: doc bug: update-ref --create-reflog also works with --stdin
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is to report a bug in the docs, or at least suggest an improvement.

The update-ref documentation says that --create-reflog can only be
passed when providing a new ref to create and doesn't say it can also
be used with --stdin:

'git update-ref' [-m <reason>] [--no-deref] (-d <ref> [<oldvalue>] |
[--create-reflog] <ref> <newvalue> [<oldvalue>] | --stdin [-z])

from: https://github.com/git/git/blob/ffac537e6cbbf934b08745a378932722df287a53/Documentation/git-update-ref.txt#L11

My testing shows that it also works with --stdin, so it seems like it
would help to document this.

Thanks,
--Chris
