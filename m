Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE2341F453
	for <e@80x24.org>; Wed,  7 Nov 2018 22:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeKHHlw (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 02:41:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37254 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbeKHHlv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 02:41:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id p2-v6so17062080wmc.2
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 14:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=L87tEH24m6cMCP9FxQQ23/+iLmH9hOUfwGXg2wS7jJo=;
        b=ufuDzFgS/C4ZsPY6C/R4bdfStjVcPGD2Z50O+WfYoBnXLfMU008JblG9n/DOgKMYHa
         0Nj2VlfOENvDK7BignldZevsOpTA7BK8nnBphI2+ENVPkg4fN3qf2rt5Buwd5dVrpvCD
         GoHBrPPo9PxYZxVvzSRg4lYZuTywheNzcffL6t7Byb7uDAoPYx2Fz+JXLy9IMJiKl5RA
         oQaqT88NE4nfY0AOLxRG2AtJk2EmkdtmXwL3hOurbzz40NDTdYrF8+1rotrFsHL7+zu5
         2Whux0YnpsNvJUOGrS3nbDNGNRNFtk97EolNQEMMhFsbJDFZL03QMcc19rvnSvQdzWGV
         oyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=L87tEH24m6cMCP9FxQQ23/+iLmH9hOUfwGXg2wS7jJo=;
        b=kiSVI+fqH78G5wDaZz3iAjdgMeZzFzu9zuLbzXSo1LLelxRI7qg8qd1sfnjrPo3V5h
         OY30G+OLGXLkI/rVXWItIhfllOCiwnSJ13OXPKnOKlrv6LwOO9U6uYW4m2cVzVrBPk9Y
         E6Wc3ZwnCZl8ych/6OCkH4T5a9jAq9mPSA9PFtLmEfyqNJx8zP6L5BdUEhCCF70Uiby+
         eqGs0iNbTelI3UcrtRktyLs7VhKZZ1/V35g9QDB/2hFP2jB3Y39ih6L25GMEoz6U5XYP
         hLVHamF92N+jQUqFou4wbXYhlPsf1RfwyOLmu2X+ccajwEl+91TlX/aceDRIbrIebCzw
         aOnw==
X-Gm-Message-State: AGRZ1gJ/08DjKj/VzhXDLZ1Rxk0/aocWZJTf5xyPVZQ/pohBx+9xa/Ci
        L65NfHPFNOo7g6G2k8c2zDM=
X-Google-Smtp-Source: AJdET5eCVt4BdfV4kpAZhtflDtraeO2ppuuxEnC1dixKNAQOZ7IrByaqtc0ivIe61iB2EAYpvjDIOA==
X-Received: by 2002:a1c:5706:: with SMTP id l6-v6mr1688258wmb.51.1541628568157;
        Wed, 07 Nov 2018 14:09:28 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e8-v6sm1770505wrw.75.2018.11.07.14.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 14:09:27 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Nov 2018, #03; Wed, 7)
References: <xmqqy3a5b4x2.fsf@gitster-ct.c.googlers.com>
        <20181107130950.GA30222@szeder.dev>
        <CACsJy8CuYgX9yFisJerf9C_6-hyyZD8DjzTsQ7v-uKpbm5LvQQ@mail.gmail.com>
Date:   Thu, 08 Nov 2018 07:09:26 +0900
In-Reply-To: <CACsJy8CuYgX9yFisJerf9C_6-hyyZD8DjzTsQ7v-uKpbm5LvQQ@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 7 Nov 2018 16:09:36 +0100")
Message-ID: <xmqqpnvgbkvd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Nov 7, 2018 at 2:09 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
>>
>> On Wed, Nov 07, 2018 at 06:41:45PM +0900, Junio C Hamano wrote:
>> > * nd/i18n (2018-11-06) 16 commits
>> >  - fsck: mark strings for translation
>> >  - fsck: reduce word legos to help i18n
>> > ...
>> >  More _("i18n") markings.
>>
>> When this patch is merged into 'pu' all four tests added to
>> 't1450-fsck.sh' in b29759d89a (fsck: check HEAD and reflog from other
>> worktrees, 2018-10-21) as part of 'nd/per-worktree-ref-iteration'
>> below fail when run with GETTEXT_POISON=y.  The test suite passes in
>> both of these topics on their own, even with GETTEXT_POISON, it's
>> their merge that is somehow problematic.
>
> Not surprising. The i18n series makes fsck output localized strings
> and without updating grep to test_i18ngrep, new tests will fail. If
> 'pu' was passing before, I'm ok with just ejecting this series for
> now. Then I wait for the other to land, rebase, fixup and resubmit.

Let me first see if I can come up with a merge-fix that can be
carried around during the time this topic cooks, before talking
about dropping and reattempting the series.

For a change like this, a time-window in which the codebase is
quiescent enough may never come, and because the changes go all over
the place, mostly but not entirely repetitive, it costs a lot, not
just to write but also to review them.
