Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C87481F428
	for <e@80x24.org>; Mon, 30 Apr 2018 03:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeD3DbA (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 23:31:00 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34473 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbeD3Da7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 23:30:59 -0400
Received: by mail-wr0-f195.google.com with SMTP id p18-v6so6701415wrm.1
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 20:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=77RzZlq7MYSN6kjyCjwNP8oftuQ5JXDoQuKBygXL+Rg=;
        b=gykVGvZr4WYyaX/XIKpd1S+moXTrwZIjICaFeXxYGbysJrqbQbfxK0PHYWSUBwf8jj
         Na4QsJ1zwEnY626OrTRtj3bZefMdFWxa7TZx2zbT+Q0A9HfRvtPDQh3cyIYZgYhH3mK7
         NmGmdwkANbnwJKsrYLp1/hSuKYyq1bQPzA6PrZc8QRsyo0crYxi8rtWW0VsrzPQjqM9A
         h2Rw6frlvw3P6TBp+qKV/7P7Ed1xZijOTYMS1ElEGIqOpInm6tQ8/3wzYebauitp1BOY
         rUwvvJG1txrWZCFxNVNDf3o7fQeHMgyFCMZvlgvmM88L1lHDtMGmcicnnto8Waewf6JI
         xKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=77RzZlq7MYSN6kjyCjwNP8oftuQ5JXDoQuKBygXL+Rg=;
        b=mF/gJsTrki9oKKqXpDlUJXSIU5dM9YFKeMhr5nUwjDh2uO+vBAw+JIsqmGbV1tedzf
         B+31E99S98rmNSDd5WdhSwvs3I1teQPxLzcpfbMW+JwGNMyyb09gFNb07P0yyfnlCxYB
         fy+Y388n/9S+F4I8cMzl7nVIIeTOZWV7kFG2J1ED7+iDUWn3+2IUO+x2cyWhzGMHK79+
         zY6kT+K/MFbgzB6GbWT4oErRj2KAjuDge7fEIOLFt17k+dTCVCAV23SGO2UTIAJRqc2F
         AsnNDeVYRlbEP2eOmLEkpm9TxY2ehA21jNVB9JCVnBv4O/06xSOuwZi/bcoOdyoUyM2g
         ZPVg==
X-Gm-Message-State: ALQs6tBs5vTpkl6hYhV/pHQKSINeNTzvvTdC9eXlQyBYGuTnzMHbH0Lf
        7i+qU4U1Dd8JNe2lZNMaTpTK//0+
X-Google-Smtp-Source: AB8JxZp0gtmW5Rq61HXtJbaoCtVHp14UeB244bLr0NMgUg177SJsv6NeWEUwkeUDVnTsRskXXlQnuw==
X-Received: by 2002:adf:8a8e:: with SMTP id y14-v6mr7969350wry.267.1525059058249;
        Sun, 29 Apr 2018 20:30:58 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k28-v6sm1104208wrk.46.2018.04.29.20.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Apr 2018 20:30:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Patrick Hemmer <git@stormcloud9.net>, git@vger.kernel.org
Subject: Re: Bug: format-patch MIME boundary not added to cover letter when attach enabled
References: <5e409069-835f-3c85-f55e-c27f534dc9e2@stormcloud9.net>
        <20180430020930.GA13217@genre.crustytoothpaste.net>
Date:   Mon, 30 Apr 2018 12:30:57 +0900
In-Reply-To: <20180430020930.GA13217@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 30 Apr 2018 02:09:31 +0000")
Message-ID: <xmqqzi1lxte6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Sun, Apr 29, 2018 at 09:40:13PM -0400, Patrick Hemmer wrote:
>> When you use `git format-patch --cover-letter --attach`, the cover
>> letter does not have the trailing MIME boundary. RFC2046 states that the
>> last part must be followed by a closing boundary. This causes some email
>> clients (Thunderbird in my case) to discard the message body.
>> This is experienced with git 2.16.3.
>
> Thanks for reporting this.  I can confirm this with a reasonably recent
> next.  Let me see if I can come up with a patch.

Thanks.  It is true that the current output from the tool is corrupt
mime multi-part, and we need to do something about it.

I however have to wonder if it even makes sense for --cover to pay
attention to --attach and produce the cover template that has "BLURB
HERE" etc.  in a multi-part format.  Shouldn't we be making a simple
plain text file instead?
