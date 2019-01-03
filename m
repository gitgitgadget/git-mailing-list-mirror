Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E21061F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 21:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfACVpm (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 16:45:42 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:41328 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbfACVpm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 16:45:42 -0500
Received: by mail-wr1-f53.google.com with SMTP id x10so34912036wrs.8
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 13:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2UY+oM3Fh3tdgYBSfoygjHMElHK9PgbiNH5wsPeWmYI=;
        b=fKPQ2WVdrlpu68X+ItBYNU2ycG7GyO05zrvnXHsMECNN7pgSFmC70St9P3dhMb2d0s
         PCqIXqHYfYeeiYHptMVJ5S3273gTJUppEXEVf8kOrnNsvkMtw7XvQz5+lkf7Vhj5qCUK
         k4NxBjkyFxkBY/XgZEkdElkuCZbkvjchkqMJzb0FxfG6P+8z58GNxOyt6+cykoj+1nZu
         tvk2nP1hJipvSMOYl2ABkbpgsb3obgd1ae/LBOzhk8/5wmABD6L76s2Aw/HoJWxSJdUt
         vKw+S9omt7ARKWsi+bTEYVMmCI22egNf0DBMg4bSNzAyDwvVK5Y8czhRWGQzzFDXkCzd
         H+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2UY+oM3Fh3tdgYBSfoygjHMElHK9PgbiNH5wsPeWmYI=;
        b=rNX1Q+snYTXV2xOAbscx+7/W3tH8wlDjCIi1bJjCJtVW9hJePGKCL0hU4XSDXpoPdk
         8+19A3FCLQi0VFvYoa2tR+WEcavK6raQJgpVM+1hn0osC+OriLgdgM7wkmidCyQXncpY
         X2/t6pWra1UBf/5ZzE6Za5g31LYHyWaRfV2ZmAmaQHx52z0uOOte2mEnG+oq5NKKGHsw
         n/A8AAkiUyhMEQiPfxFzc64zVhCqwzCydu1FO/uTBNFp/7M11s67DoG7DPr3kHsqk6cr
         9Z97X6S+jln0vbQtIUPZ2fD0pL/RMA/eurupEZdAtm0LrM0BLdlkDrTNc68r1ZHMRS5j
         8lSA==
X-Gm-Message-State: AJcUukchTmj17fLGTYKcH7xKGZW4F4BkgrQ/+Bbbedt8NwTDYNmHH4oc
        m47t+KTU31fN1QjfGsMv3Xk=
X-Google-Smtp-Source: ALg8bN4m3BFKB+/nG3LZpQ75X7EDVmA6N9bIiFrZ3C5yeOl0OSyrmVMDLuGrUwmTEqxu2XQ3PPDpeg==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr41644945wrr.201.1546551940102;
        Thu, 03 Jan 2019 13:45:40 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x81sm41981445wmg.17.2019.01.03.13.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 13:45:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     "Stephen P. Smith" <ischis2@cox.net>, git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH 3/3] t0006-date.sh: add `human` date format tests.
References: <20181231003150.8031-1-ischis2@cox.net>
        <20181231003150.8031-4-ischis2@cox.net>
        <xmqqva37j595.fsf@gitster-ct.c.googlers.com>
        <a5412274-028f-3662-e4f5-dbbcad4d9a40@iee.org>
Date:   Thu, 03 Jan 2019 13:45:39 -0800
In-Reply-To: <a5412274-028f-3662-e4f5-dbbcad4d9a40@iee.org> (Philip Oakley's
        message of "Thu, 3 Jan 2019 21:14:04 +0000")
Message-ID: <xmqq1s5th0u4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> On 02/01/2019 18:15, Junio C Hamano wrote:
>> We perhaps can use "test-tool date timestamp", like so
>>
>> 	check_human_date $(test-tool date timestamp "18000 seconds ago") ...
>>
>> or moving the part that munges 18000 into the above form inside
>> check_human_date helper function, e.g.
>>
>> 	check_human_date () {
>> 		commit_date=$(test-tool date timestamp "$1 seconds ago")
>> 		commit_date="$commit_date +0200"
>>                  expect=$2
>> 		...
>> 	}
>>
>> which would let us write
>>
>> 	check_human_date 432000 "$THIS_YEAR_REGEX" # 5 days ago
>
>
> Just a quick bikeshed: if used, would this have a year end 5 day
> roll-over error potential, or will it always use the single date?

Hmph, interesting point.  Indeed, date.c::show_date_normal() decides
to hide the year portion if the timestamp and the current time share
the same year, so on Thu Jan 3rd, an attempt to show a commit made
on Mon Dec 31st of the same week would end up showing the year, so
yes, I agree with you that the above would break.

+TODAY_REGEX='5 hours ago'
+THIS_YEAR_REGEX='[A-Z][a-z][a-z] [A-Z][a-z][a-z] [0-9]* [012][0-9]:[0-6][0-9]'
+MORE_THAN_A_YEAR_REGEX='[A-Z][a-z][a-z] [A-Z][a-z][a-z] [0-9]* [0-9][0-9][0-9][0-9]'

>
> (I appreciate it is just suggestion code, not tested)
