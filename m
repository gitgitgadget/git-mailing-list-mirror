Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CB381F576
	for <e@80x24.org>; Wed,  7 Feb 2018 11:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753630AbeBGLvW (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 06:51:22 -0500
Received: from mail-oi0-f41.google.com ([209.85.218.41]:41125 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753496AbeBGLvW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 06:51:22 -0500
Received: by mail-oi0-f41.google.com with SMTP id m83so438301oik.8
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 03:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CLSAAj4k8jXo8gvwjdxKCsPJUNuQZus3XxRCTole2aA=;
        b=hoBJ5CkSycFYgyzas/7Q/ExK8xV7bxg47o29WJlknK6M0EJ1PSgl6DcTWpvJKzhJE6
         oZhg7uP0Aw1bPGRkYKNGGiJ0PMndXY4QoCQ2EnG8TRQ0EUgMUyxVkPpAA37j1ijkXKkQ
         QyvNWN78IzG8irepalHXz2J8O/ZOaIkfYmyq+Dn7t3ZHp8VBkoxYN+4any5LNZ+zVWu8
         jaG8BYUQs3Il+jZgcYI+SEuj3ZuAgaqOAnxg5adzMgtTVnO6Ovv5T7MQpzfIxSjgFEcG
         TXrsSh3jUzhHS3pq/HrMhpD+EKnfw6inXdKBHPFEcl06nglviScVxasL7PZw4hFpmpuQ
         xibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CLSAAj4k8jXo8gvwjdxKCsPJUNuQZus3XxRCTole2aA=;
        b=gq1QbAXvDcyLfEjqO2RmXjgAa7P8l7Ffs4IpSQ97uLPy1oJIWoq4OrRqplR+SzH4J0
         x2A1agb8y7AbZlqkhNOG0raWh2iBvP6UxCJX+mFZIxmdXD5yQ19VPEJEOzIHlEuZPJDd
         bpr8gi/xRj2Zv8TOfdoqPZ0nu0RmKCEhUQNFKc6q50qfWOwhiiPn6B8ZdBBanRGmBLbh
         v+/rvDfBU0FFfDbLJFPMTbU5ioDFd8WxKjvD29viuHOhHCXLFJtfZ8tQ6ZMYnTdL8+nH
         rO6rZ+v7SEnUuQN1MN7UUwz9rZ7QYaXobH40xJpnF+plhFkT88/pMT3UkYl0DZpheHXo
         8p6Q==
X-Gm-Message-State: APf1xPDmraDyZNNyNoEffcZMgWixoN14h71bq6Sf08Ztlf69FJ6IBtbD
        syWIHKCs0Rt6d3HsaXAaQG3y1Il1DxYrwryLTCo=
X-Google-Smtp-Source: AH8x225gQ68UDpk2oE3kvryxnmZLIYPn+jxUoA+0TVDsEALFEh4XF3LYw+K4Y7trkFIvkigyX77I8SHmFyM9ULGLszg=
X-Received: by 10.202.171.207 with SMTP id u198mr3802895oie.253.1518004281679;
 Wed, 07 Feb 2018 03:51:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Wed, 7 Feb 2018 03:50:51 -0800 (PST)
In-Reply-To: <alpine.LFD.2.21.1802070637190.7359@android-a172fe96dd584b41>
References: <alpine.LFD.2.21.1802070547040.5530@android-a172fe96dd584b41>
 <CACsJy8Dt_TjfRk05oNW8DXrdn6s_QV8NQZKnnrgGkj3WTN_=3A@mail.gmail.com> <alpine.LFD.2.21.1802070637190.7359@android-a172fe96dd584b41>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Feb 2018 18:50:51 +0700
Message-ID: <CACsJy8CWkjoFvDmB_EEvrJR=4snFqnVGUKvo_vR33asOXB3CWw@mail.gmail.com>
Subject: Re: is http://git-scm.com an *official* git-affiliated site?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 7, 2018 at 6:41 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> On Wed, 7 Feb 2018, Duy Nguyen wrote:
>
>> On Wed, Feb 7, 2018 at 5:54 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>> >
>> >   i ask WRT whether it should be up to date. i'm currently writing a
>> > number of git-related wiki pages, and i want to link to whatever are
>> > the canonical man pages for various git commands,
>>
>> I think this one is updated often by Junio (Git maintainer)
>>
>> https://www.kernel.org/pub/software/scm/git/docs/
>
>   whoops, just noticed that there is still no entry for "git subtree"
> there; is there something about that git command that makes it so hard
> to track down? :-)

git-subtree is not an official command, so it's not there.
-- 
Duy
