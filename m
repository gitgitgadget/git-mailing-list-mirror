Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB1351F404
	for <e@80x24.org>; Tue, 11 Sep 2018 20:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeILByf (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 21:54:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46268 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbeILByf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 21:54:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id a108-v6so27421546wrc.13
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 13:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=w/wYs9TeCrfcnzqB341fjpsPH2zWz1ZqveNaFehhEBs=;
        b=VzSeRJsUJeO5rWEfK8whCDwyDtutCzNIExGiXdg8DkGCYJjBfAMcOVOTW5O/cMTqM6
         5q7fHgKLxBcWVnXme6iVrSlm/5ZvbN2GOxSDv/Dx+LwIs2ZlG0teklBOXdQpF1tP8/1q
         UY0z62NBLuZPORxY5/THtW/aMMcgaZ/kyMgOdD2z+8vnwJH2UuZuD3hdMHb9IvtT+4W8
         8e8DJupTDlN3nSy8LCNlXIazjaM2kQDlTZOFSxjXAfocLlp3eBxZ9GuqfjbXt1RccBTz
         1lIn4h5xQ1WmKiOYqRbP8RJPQPnc3AWK/OyO0Jp3Vj3+8QQWW/ah0JR0WxCw4t6+vieU
         gS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=w/wYs9TeCrfcnzqB341fjpsPH2zWz1ZqveNaFehhEBs=;
        b=tOsx35IXMyRau4X+XyJ9VFiu1CUPumAtdsUHQdpdvRiick23rus8jEsqyWdkjxlNJd
         M2dHsHJwu2kU70v4aKWZ94alQBo8GY+mggR7n6R5zoTF40adTbYwB7dGxs9vTc7ZDQhn
         Xx7z9qdkqeYtmcip8pxoCMaZSh8sFJMChepggbIUH4Zj+EY+Fio7ojuKWXC3aXrPvDZa
         LuZxtDRxe7MbmzhFhcDIOSyVdm4X217zJjWGroejkS+EzYggdQY2igpi81VhrLljltsd
         KxOvBIFrN1+Lxvyf3SJs4i8EqGkDdJA0RaOdC/cd8bC8IpeI7zlJf7QfBivhzZzdTq2y
         U9ig==
X-Gm-Message-State: APzg51DvHviIodTwRwSS7KE07UlyMvnU0CH3iXIzu4WlXyMpyW1LzOcN
        xTCzDQovPeEf0RarzEUJaQw=
X-Google-Smtp-Source: ANB0VdavHnBDIzJtHNhSKUCq0tOD3z/s/DiY0y2RFl/nsJG/h+sD8y2Nl0A6c5+of9EhM2JFAB/WrQ==
X-Received: by 2002:a05:6000:108:: with SMTP id o8mr1923543wrx.196.1536699209756;
        Tue, 11 Sep 2018 13:53:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 142-v6sm2892445wme.35.2018.09.11.13.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 13:53:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] string-list: remove unused function print_string_list
References: <xmqqy3c8rh3d.fsf@gitster-ct.c.googlers.com>
        <20180911184850.24891-1-sbeller@google.com>
        <xmqq1s9zq1gm.fsf@gitster-ct.c.googlers.com>
        <xmqqworromq4.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZZwH1sORNsBZORF_c5V0U2NVLQa9JBY-Z5ksRS3yBT7w@mail.gmail.com>
Date:   Tue, 11 Sep 2018 13:53:28 -0700
In-Reply-To: <CAGZ79kZZwH1sORNsBZORF_c5V0U2NVLQa9JBY-Z5ksRS3yBT7w@mail.gmail.com>
        (Stefan Beller's message of "Tue, 11 Sep 2018 12:47:11 -0700")
Message-ID: <xmqq8t47oiwn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> >>
>> >> [1] https://public-inbox.org/git/1421343725-3973-1-git-send-email-kuleshovmail@gmail.com/
>> >> Signed-off-by: Stefan Beller <sbeller@google.com>
>> >
>> > I'll add a blank line before the sign-off.  Is this an example that
>> > our "where is the existing trailer?" code misbehaving?
>>
>> I am still curious about this one.
>
> No, it's me who is misbehaving. ;-)

Whew.  That lets me worried about one fewer things ;-)  Thanks.

