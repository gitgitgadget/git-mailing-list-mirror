Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74D21201A7
	for <e@80x24.org>; Fri, 12 May 2017 21:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758706AbdELVLI (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 17:11:08 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36644 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758146AbdELVLI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 17:11:08 -0400
Received: by mail-pf0-f196.google.com with SMTP id n23so7125568pfb.3
        for <git@vger.kernel.org>; Fri, 12 May 2017 14:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kxMLKPGPaCzEt/DJBmGkYTDU39YCPMUot6kYGUxZThE=;
        b=eq8YBLglU5Odibh419dLfTL9wBqEm7CNqVQ2VQ1iwSEFbb0StWHRDH0MBmJ74wbn9+
         bDlfrMhn6cPO4G2LMv8mDqXMBjmhL9/s3100QgRA5QBaf2FmMnkCO0VxPIqA93V8VMUQ
         1BMoynmhAcstGYbH8XMKkgFT8f/aQVVrpVxC18EX0SdnSA92AgN/H1Q99qSJLbWkxyvo
         UOiXYxgQOMNsHJUEmQMDcC4UyhylmBKYGk0CzzySpb6HnWdsBiHM6mcd0I2YtRj2Izl8
         lN5YaiicCfV0n2Yi6LkCLJyaLbWhv6kJkbhaelESuJUTxLXTbA4gkVXg8BJHX2QF4o4Q
         aynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kxMLKPGPaCzEt/DJBmGkYTDU39YCPMUot6kYGUxZThE=;
        b=LU9ubkA79pHXGdaRc5tDOFwtOv7ybqdVjGn7e5pqWHiqCLW2LIOvrX+K11JSZnKERH
         4gv4BEsit8/fHmkUKaJEqFwkCrJGkdxAyUVfbFf0Nmfjx9TbEBprHBuLK73tDn0b9/Of
         Y64yoTb1l/g0leen6QkvnO5LJtd5df+pqwLZ7AT0hL1uSOhClUxd2f2EnwtRaBR1uTt8
         UbTq5G8hfg1CNce2bfRBzAEqnyYuDDZqMzycIaLfdW7kdMapXygM0oTgsYPrUiz9Hih5
         Y5Kw0i+T/EV0FNRwoxRXazvzWnQY4NVSnfZQdcurYyZ2O8KkLTfrAgUNDogoYYFbOI14
         PV8A==
X-Gm-Message-State: AODbwcD4Jlsbsi5fgD6M0OFIG24dCYZoRgEEGb7mdviXVPcDVoPNRkUh
        CLAgQLyNc32Q0cvLhlc=
X-Received: by 10.99.127.73 with SMTP id p9mr5844587pgn.169.1494623467455;
        Fri, 12 May 2017 14:11:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:954c:c08b:c855:8b7f])
        by smtp.gmail.com with ESMTPSA id s18sm7622118pfi.16.2017.05.12.14.11.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 May 2017 14:11:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/11] Start retiring .git/remotes/ and .git/branches/ for good
References: <cover.1494509599.git.johannes.schindelin@gmx.de>
        <xmqqk25m98rd.fsf@gitster.mtv.corp.google.com>
        <xmqqfuga5lp2.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1705121617420.146734@virtualbox>
Date:   Sat, 13 May 2017 06:11:05 +0900
In-Reply-To: <alpine.DEB.2.21.1.1705121617420.146734@virtualbox> (Johannes
        Schindelin's message of "Fri, 12 May 2017 16:19:55 +0200 (CEST)")
Message-ID: <xmqq7f1l6as6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 12 May 2017, Junio C Hamano wrote:
>>  ...
>> FWIW, I do not think there is any reason for people to be using
>> .git/remotes/, but for .git/branches/, I do not think I can offer a
>> more efficient and easier to use alternative based on .git/config to
>> do these things:
>> 
>>  $ grep <substring> .git/branches/* ;# what did I call that remote?
>>  $ cat .git/branches/$name ;# where do I get that from?
>>  $ echo "$URL#$branch" >.git/branches/$name ;# I just learned a new src
>>  $ rm .git/branch/$name ;# I no longer need it
>> 
>> without having to learn things experienced CLI/UNIX person already
>> knows.
>
> I do not understand what you want to tell me with that example. It is
> confusing me utterly.

They show how it helps a user, whose primary use of Git is to fetch
from many places, to keep the the old "branches" machinery.  It is
not "hard" to migrate in the sense that there is a way to (1) find
the short-name you gave to a remote from a part of URL etc., (2)
find the exact attributes of the repository a short-name refers to,
(3) update an existing or add a new short-name and (4) remove an
existing one.  The remotes.*.{url,fetch} configuration are expressive
enough to represent these operations.  It however is more work and I
couldn't think of alternatives.

>
>> We simply cannot beat the above with anything like 
>> 
>>     $ git config remote.$name.fetch refs/heads/$branch
>> 
>> even though the config based remote definition may be infinitely
>> more powerful.
>
> Then maybe we need to teach, say, `git remote` to be that powerful?

Ah, after all, you weren't confused utterly.  

Not necessarily "that powerful", but yes, if we had something that
is quick and easy to use as a replacement, I do agree we can plan
.git/{branches,remotes}'s removal.  The point of "branches" thing to
existing users, I think, is not its expressive power (it is much
much simpler and can do only one thing) but its simplicity.

Thanks.
