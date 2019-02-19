Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B6FE1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 19:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfBSTlZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 14:41:25 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:33566 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfBSTlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 14:41:25 -0500
Received: by mail-wr1-f48.google.com with SMTP id i12so23381187wrw.0
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 11:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OFNzY4o1UmaiHREP7em6/o2EhLjrnlxmbpL5HanZG2A=;
        b=oqD/Jn3NCx4vp0Nw1FtEbbaprOm8ZvXwWB+5YJ5nHr4192IT+XT7htoCqZhYa0Z00p
         rSVCMTDHABtERlKMVXXJe7VqW1kQ3PsC0r9Awy+3TGRn6AnPsshmuOYF22EoHuyiXUvO
         zlcIH2sLy7IYnyJfT7dW0dhmJfqVnSavIjybxfuJ377FT61/J4H/x09fa0L1182KWTFy
         tm8yHuh07MzlrKS8P5i3EiCwRo53jlkc1gXjoBUz9O8GyuKd4OJ8VULpxlGfW/tkVIiN
         JuWs/lJkyhW0vCIOzCCwkOP0h3CynE+2pj8kn2Ee8wv8P2GgnfGKhuWQuS5AykRVLci/
         u6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OFNzY4o1UmaiHREP7em6/o2EhLjrnlxmbpL5HanZG2A=;
        b=ctllNntSsvdoeqcprj/zJq01ory5lqtYFkUFTG2E9CijVecRblTC9kjATCCQT18hJE
         zjzmZmD85lBbF6TcusKMDnQEecpJb308+a8OAWcT6p6l0SlBG3XTH7/A8nHFJ5XA5N0m
         vYW45tOCoZM/iX3jdw+Oq2Wn6/UKqaEc6m+P5FIgGk3a+wcvs0TikJ/TSuy1AFO3Rd7r
         pok0/AMkbgtD8FGL9dwjQP2bsrP5QpekcbhN94R9f6V5jdAWVfme81vh0QFK7hRYhZcM
         Dw14i/JW7oDIQehffU3J9NlwwKbscGFLLntHfOZxKogVicnO6x5GSF1PHvWJeSsmAVVl
         gwvw==
X-Gm-Message-State: AHQUAuYJCBOj5gqXKfwkFfC8P4u0i0mM8jPyrMbYzqEUGfw04iWtcGjv
        Twra1sV8lez2yMiat5UP1+s=
X-Google-Smtp-Source: AHgI3IY20ucBoWvV9inICpozP2wGHplvrxf2DUeopd/YNypr8mTnFxhLSVh/sNKAhVuh5hPYh2A+7A==
X-Received: by 2002:adf:8251:: with SMTP id 75mr23156559wrb.112.1550605283122;
        Tue, 19 Feb 2019 11:41:23 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h9sm13430766wrv.11.2019.02.19.11.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 11:41:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: why no mention of "hooks.allownonascii" in any man page?
References: <alpine.LFD.2.21.1902190544470.23739@localhost.localdomain>
        <87mums58f2.fsf@evledraar.gmail.com>
        <alpine.LFD.2.21.1902190629490.25090@localhost.localdomain>
Date:   Tue, 19 Feb 2019 11:41:21 -0800
In-Reply-To: <alpine.LFD.2.21.1902190629490.25090@localhost.localdomain>
        (Robert P. J. Day's message of "Tue, 19 Feb 2019 06:38:52 -0500
        (EST)")
Message-ID: <xmqqftsj1s7y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>> But perhaps it should be documented as the functionality of the
>> default hook in githooks(5), similarly to how we document
>> hooks.allowunannotated. Patches welcome :)
>
>   sure, i'll take care of that.

Sounds like a sensible way forward.  Thanks, both.
