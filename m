Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007DA1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932666AbeDWXXv (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:23:51 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:46567 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbeDWXXu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 19:23:50 -0400
Received: by mail-wr0-f176.google.com with SMTP id d1-v6so45593240wrj.13
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 16:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=i9fR6kwlmUHIO6yXTs+Jsb/xyvANcqzk8mla4WT18fI=;
        b=hnXHJRZ75yOnqCSLMKxyrzaBy/nAAP5KTqJzWWj2New2LKgyManeYznqIhDewed0O9
         EEhBPVHUcXQs4AMhxiWfxYVn/d0H9PQr18VBbvFeE1zLwSHO26zmmk2i/qnmhVxyJcmD
         8E0Lw8KCc5DWZzWRnn+dyHQ8H8a3dqWTNJcLBM0yY5S3uSDwEUR8aynVXQsFTEsMkJXx
         y9+3aAqklB6i7A60Dn2RZr5uBK7eBC6HboxRAev2QNSqY6WM3f+vI53ZqcQMT50KWvYo
         g0egYta02EMLoTDwX8kPLeoX7RurlK2C7c983h/9ane3rnTXKq3pD4H+sQV+OyCd3Bxm
         9mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=i9fR6kwlmUHIO6yXTs+Jsb/xyvANcqzk8mla4WT18fI=;
        b=n9O2/8tSe+dM7wN+2xfv1O4E0NH+YtHHMainieNEUxzJB3il4vClNGY+JeYZtyKI1D
         wE8AQbcB3PXuG+5BL0gW+OEZbJv4V7GEXJCH1hW+kJuzVFP3CZDv3KG3octSPVZIWPEd
         V/A0PZ5/ETeCUsBJ5kuhEOLMiN6T2pvgRV2AGDtq1OH2akIYWZoUfimsAnDSq96Gow6o
         j9hh8Kq25mu58x+QycK/jMcWt5BlJYW+pKIEvgTa5+hqsiZItPowjo0bAHXibPPaPSXs
         LrAMjq9EskuIQtGuIou1NNMnBHL6aHhis24U27xRpnJK8WGdfLfqeaoq0GQ1/4mSXVEn
         cW/g==
X-Gm-Message-State: ALQs6tAo3uQDowoMRDqQRoCwV6IJ49MEmsKvQMKoJEpKFlQsNR7VJea4
        /7pbIZUMHeHp524ihfTm/1g=
X-Google-Smtp-Source: AIpwx4+GwQYWCqFsj3aIJp7T0LtfTR5OU2KtI9defUPZkWzR4bbDj3pji0a0Ne3KBzvqX7POwBfu8Q==
X-Received: by 10.28.51.6 with SMTP id z6mr10650461wmz.63.1524525828742;
        Mon, 23 Apr 2018 16:23:48 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q21-v6sm13055448wra.24.2018.04.23.16.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 16:23:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        "vmiklos\@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin\@gmx.de" <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v1 1/2] merge: Add merge.renames config setting
References: <20180420133632.17580-1-benpeart@microsoft.com>
        <20180420133632.17580-2-benpeart@microsoft.com>
        <CABPp-BFANBs=tOhS5BFfTMkdQsNYbUDExWK8QB0V=qD9YwZyWw@mail.gmail.com>
        <cd49481c-9665-124a-5f94-791f1a16657d@gmail.com>
        <CABPp-BFqj2TFiHUDsysafq0NHC4MV-QYZVxOZe1TNRrXMOQfng@mail.gmail.com>
        <xmqqwox19ohw.fsf@gitster-ct.c.googlers.com>
        <1fb11850-4c20-5327-a63a-6d1f5aa18ea4@gmail.com>
Date:   Tue, 24 Apr 2018 08:23:47 +0900
In-Reply-To: <1fb11850-4c20-5327-a63a-6d1f5aa18ea4@gmail.com> (Ben Peart's
        message of "Mon, 23 Apr 2018 12:00:49 -0400")
Message-ID: <xmqqy3hd8q2k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

>> I also had to wonder how "merge -s resolve" faired, if the project
>> is not interested in renamed paths at all.
>>
>
> To be clear, it isn't that we're not interested in detecting renamed
> files and paths.  We're just opposed to it taking an hour to figure
> that out!

Yeah, but as opposed to passing "oh, let's see if we can get a
reasonable result without rename detection just this time" from the
command line, configuring merge.renames=false in would mean exactly
that: "we don't need rename detection, just want to skip the cycles
spent for it".  That is why I wondered how well the resolve strategy
would have fit your needs.


