Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57CCA1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 19:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389114AbfBNT4q (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 14:56:46 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:51572 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbfBNT4p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 14:56:45 -0500
Received: by mail-wm1-f47.google.com with SMTP id b11so7665831wmj.1
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 11:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KXoanlQMXEH1ZZ8k6I22roRiDQDH9cczl9eE1e1kLLs=;
        b=nLMpkHl+EyyJhTsgmkhWD8nGvkpq+EJnFqP6mOWSYm+MJLyOKZlRzsW059GzBB3c4V
         0KNF2feaBKh3SkGqqZfp+n3p4DmWnT8ZxJCSZcCmwkAerwLrllHeEAqxT+Wi9+A1Uhl4
         riSmePPIPfCQGlNYfZ9yp58gizU9h4nkXe9/d8pLvr7TEsziztWyP2F+By2S03TYHu7n
         fC3te0qt/+7zSFYdMKnv8Mje1EJweO1A/de/xDNpkbugpudeBMCQidSNowuZChHnjlB3
         J4n9DCKhSwmZMMhRZKAlxLXdBB4618laHqMXuFP9v7bivsV9VlihSC78PP6eJeGb927y
         DfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KXoanlQMXEH1ZZ8k6I22roRiDQDH9cczl9eE1e1kLLs=;
        b=jxYKyP410gPC+e+9b/m1WZaUcRVGrXDqI1r1R2pO7XLNop6XSLa8lx1tRA4X1wrlwK
         k6g6KmqKynUwBn/JdRpPPKNMcNloXa8vbdNGEezKDOCAutx99QbiiWeHkL3ri0OUO5LG
         5sMKtQ5658xUDazv3vyutilBbmqnPlAADGCixIG+GBianbUr+5t16LNl/6fliM8n2j9j
         32GnOMRSb8iG1Kev83ayLz2mlDURLnFGTYvdGo2HP+irhpF4rSlFHgb0lsI6EU7830cQ
         HpGZNrh/MY38NXMAEuuJU72iagj/JnDNywrPm6wGgtybt3Izw6wG9T+mTIgu7/Du6Vmp
         0NAw==
X-Gm-Message-State: AHQUAuYjGTdmmakYRK86BK0I1A5QLNoPybUcTpwl9N2s74ok0mZvjlvH
        RNOEaa2Ec8WXWStRcU3OXJM=
X-Google-Smtp-Source: AHgI3IZcaaAkM8alUJpZG1T2zJTf7+3xne2Ht5yFYpCndA1wQzjrcZ6OJv9xspORIRE1D9MBjwKRvA==
X-Received: by 2002:a1c:e18a:: with SMTP id y132mr4272190wmg.48.1550174203774;
        Thu, 14 Feb 2019 11:56:43 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x21sm1352156wmc.19.2019.02.14.11.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 11:56:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>, <szeder.dev@gmail.com>,
        "'Max Kirillov'" <max@max630.net>
Subject: Re: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results)
References: <001501d4c476$a94651d0$fbd2f570$@nexbridge.com>
Date:   Thu, 14 Feb 2019 11:56:42 -0800
In-Reply-To: <001501d4c476$a94651d0$fbd2f570$@nexbridge.com> (Randall
        S. Becker's message of "Thu, 14 Feb 2019 10:04:56 -0500")
Message-ID: <xmqqk1i287ph.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> On February 13, 2019 22:33, Junio C Hamano wrote:
>> A release candidate Git v2.21.0-rc1 is now available for testing at the usual
>> places.  It is comprised of 464 non-merge commits since v2.20.0, contributed
>> by 60 people, 14 of which are new faces.
>
> We are currently running through a full regression of v2.21.0-rc1
> on NonStop. It will take about 30 hours, but preliminary results,
> relative to breakages found in rc0 are:
>
> t1308 is fixed.

Nice.

> t1404 is still broken (explainable) - scraping strerror output
> mismatches reported error on NonStop for EEXIST

IIRC, the consensus was to loosen by not matching for the error
message?  Let me take a look later today.

> t5318 is fixed.
> t5403 is fixed.

Good.

> t5562 still hangs (blocking) - this breaks our CI pipeline since
> the test hangs and we have no explanation of whether the hang is
> in git or the tests.

