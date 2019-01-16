Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA0351F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 04:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731766AbfAPEIY (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 23:08:24 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:52821 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbfAPEIY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 23:08:24 -0500
Received: by mail-wm1-f47.google.com with SMTP id m1so514944wml.2
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 20:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xUBP3V8c0wE6Zk1hg/0w89kBcQSKSpb+MS/2iYr4cag=;
        b=crbE3ofyUDfSVMk+CBJBnmiQjCzJcC3bKcnZr6XPQwkU4s4LsHZgQ/vumyAR7rlekT
         h6aCJD3I4rekqT1o2xs0h0bdmk1z8piB3hkDp8pD3b8uklve78/FCex/0HonsOPlLgPe
         N6zuOvTW3q2A7GkP4YNQ9R+3q/mPxXUMug0R/BiCepb1QL++cBjzowd0HyXdrWJFN1rn
         iop+N1w/tf6Hl3IuWyKW1bnGlwGR2/WmvTir85my7UiWNPX9J+p7WCltV8D1K+/+UHSi
         h7ux+K6l+MTMlYAZuefN04dkAeBhjuBoae/uiw0AJkQeU4+BL9kW/e4fp94KqO0/CewA
         OnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xUBP3V8c0wE6Zk1hg/0w89kBcQSKSpb+MS/2iYr4cag=;
        b=CKe8i5+i0eo3ybZHsKxWmtP9gQHMEqExLn9KCe4hN/lUoxC6tVHbwC2K9Ocs94KOsj
         hcUOtxgBtt+2KrbunDwUnLCC/VQja0Ips/1lOSxBhVrTLE4Dpod74K6L2I5D2AF+qteC
         6c5ja+n/ySKnfe6Z1k5/f5aZH3yCK1eeHDjaRVE/TsoUSKIDy6aCKGTqp5AgeGg3L4n/
         xHT7Mc0iVyPyrjQnBxFbsTe0DJwvXCFH0S4r/ooh4S7GfayNV9VVNI+Jen9a1/jxZapA
         Q4Wj1Ge4z/w8UG2PEMo2ngFEBOZJUWGXzk8JZ8HzeMj0qf0NGOMLZxmDt8f0sJFlTjsf
         VnyQ==
X-Gm-Message-State: AJcUukcnXn6fC4pvs/qUYEBf70vpmQuO3gx+soFE84UKrpfj6fZhhfSd
        PB1bggYpUM+QlIgI0cbrj6E=
X-Google-Smtp-Source: ALg8bN7ZIoirwAf0pGYvrjtEHoT6iTdmZtJFdiOkvpFXFI822BuhLhiWnmmPcxQcjdm69BD+DfHTIQ==
X-Received: by 2002:a1c:e242:: with SMTP id z63mr5566482wmg.2.1547611702047;
        Tue, 15 Jan 2019 20:08:22 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t12sm80859612wrr.65.2019.01.15.20.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 20:08:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2019, #02; Tue, 15)
References: <xmqq4la9r1sl.fsf@gitster-ct.c.googlers.com>
        <CACsJy8B5ARpXfOzuud-4BBxsT4ziNkgPBYUqNy231cGVhVNu7Q@mail.gmail.com>
Date:   Tue, 15 Jan 2019 20:08:20 -0800
In-Reply-To: <CACsJy8B5ARpXfOzuud-4BBxsT4ziNkgPBYUqNy231cGVhVNu7Q@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 16 Jan 2019 07:35:12 +0700")
Message-ID: <xmqq7ef5p7m3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Jan 16, 2019 at 5:31 AM Junio C Hamano <gitster@pobox.com> wrote:
>> [Discarded]
>>
>> * nd/backup-log (2018-12-10) 24 commits
>
> Discarding this series is not at all a problem. But should I be
> worried about the silence on this one? Perhaps nobody is interested in
> the idea and it's better to drop it?

I personally took the silence on the list as people not interested
enough to help pursuing it.  I do not speak for others, obviously.
