Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E46651F453
	for <e@80x24.org>; Thu, 21 Feb 2019 20:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfBUUre (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 15:47:34 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37444 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfBUUre (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 15:47:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id x10so10470587wmg.2
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 12:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gKbYb8ZXc2mRN87ooENYjorcvZqzxYVhLaQsz5Ve7Bk=;
        b=ec2duWPGYajE5tRbx4axjxaIHOSJeB0uRc+GYP8D1TrQgV3DTXIjfrVlyxJ9iPuHyY
         4IpggJvxTF/8sdQJUKPiFv1Tk2oBWmprNNCKu77qb/E4uKldAbRfvpKOFgGqRxLx22RE
         623pkaSKm6w0+m5lhLKDz6gIfKnZKtPf9iPvXtxuG86KM5Q3ukz4TpoXKEXJBXZkUAp+
         wIlFyTwxpZPq6Ff0+4uZ329Pt0sRhsXbZbbD5b8GDMLBLy79Die0+KF+x8pjHraKBu6k
         qVIf18Le+mu+Be11zS7C+C6KtEcDrJ4yt37eCY3oNg/bT5FPK5VOclg7zSe6h6tFF94+
         tVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gKbYb8ZXc2mRN87ooENYjorcvZqzxYVhLaQsz5Ve7Bk=;
        b=nYiPcnJBIltjZDhMbq5+pKt/vNwHHDgm2utKvlpdcNdMKSj/76bHw5dFeYygyx9hO6
         naUsK8Pu7Xf/qJHStxn/vSfOz8uA4/dVYhX0j/YGCPJsdLes4r14oXJueT5TJyJi4RKr
         OKL2fRpew9GB1XF/Gmb+bs+m3ZDmY6mBHj83/EAtZtydvGlwe57vukcBkmpvnzUUVGNY
         KHrWqjrv6Cg230u3RpjDyZFJD6LfJrsNWPs+tAMbl69WEy4wdwT/d9FpKqYc2I7cw2xW
         0iapuDFAaNXqPTlgKY8MF88jh+SjRrRj+9iynNOe+BCo9S8SWB2NntLOsi0PUiLKIPvf
         kQig==
X-Gm-Message-State: AHQUAubSo2rY9rLSW7PameVOL0PR/hh4v2qBIPSrn3ePr5v3bfHz+05Y
        uXo9ZyWQdz8nfFwz7KE42/4NS+jY
X-Google-Smtp-Source: AHgI3IbTHrc3dpViJZLgw7zO8RIza4JqyTrnqPzOsa9XjZ+/GawkhvefWa0fjZshQRDlessrYbR77g==
X-Received: by 2002:a1c:ca01:: with SMTP id a1mr234955wmg.124.1550782052125;
        Thu, 21 Feb 2019 12:47:32 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f68sm17273666wmg.5.2019.02.21.12.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 12:47:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ismael Luceno <ismael@iodev.co.uk>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH v2] git-gui: Handle Ctrl + BS/Del in the commit msg
References: <20190216031051.8859-1-ismael@iodev.co.uk>
        <xmqqbm36w7hl.fsf@gitster-ct.c.googlers.com>
        <20190221093059.GA6594@kiki>
Date:   Thu, 21 Feb 2019 12:47:31 -0800
In-Reply-To: <20190221093059.GA6594@kiki> (Ismael Luceno's message of "Thu, 21
        Feb 2019 10:31:00 +0100")
Message-ID: <xmqqa7iouavw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ismael Luceno <ismael@iodev.co.uk> writes:

>> ....  I am not sure if going
>> back by one character from where the current insertion cursor is and
>> further go back to the wordstart would give the beginning of the
>> word to the left of the cursor, though.
>
> ...
> Current implementation doesn't behave correctly when there's multiple
> spaces:

In short, I wondered if it is correct, and you say it is not correct.

I would be surprised if git-gui were the only program that
implemented an editor-like feature using tcl/tk, and none of the
other editor implementations using tcl/tk had such an industry
standard "delete previous word".  Perhaps you can see if there
is already a correct implementation of the feature this patch can
borrow from?

>> A larger issue is that we haven't heard from Pat, who has been
>> helping git-gui.sh maintenance, for quite a while, so we'd need to
>> find a volunteer to act as a replacement maintainer.  If you are
>> willing to, that would be great ;-)
>
> Sure.
