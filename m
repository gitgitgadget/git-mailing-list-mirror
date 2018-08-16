Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61B6F1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 22:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbeHQBa4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 21:30:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53914 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeHQBa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 21:30:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so5838060wmh.3
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 15:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8axQpIqYt17gMmOJQgYQURADaxOxi/WieolvwM2SGIY=;
        b=jLohjKc2pW3Rj+3deVq3oQzWYsDRsbsba6teWOTCUs3/MNj3EgCg6VWwo2ZbV/c2xL
         haVvGCjqFqii6uquRvefwn2hYM8iuOas7c6K0cqRR//vfYUc06MTS4LBD9/qaNUPFlSS
         hP8mxA+iTVNFX8UIi6z96jvfqdmKJ830/O7NUiyeOPqEYq+AE3nyjoLDixbSPC0upaJC
         tE+GJuiTX+2nT+Q29cz+Ibsp+PIVjVcaM35yac8S09qne8pwTlaqWaKPWpoBEDUi5mBj
         5CGAbM8vpJ8TwMIJPGtDcuhwrh7hWFVaqAXS6Iouew1PFVL/pUaoK9MDuBwzGejzajh7
         c3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8axQpIqYt17gMmOJQgYQURADaxOxi/WieolvwM2SGIY=;
        b=fWbb4nDOWDo8Qem66bFq4Ib00W61ddqV6r63HYkCHGazUAmUpT+XS8FhxGVLzdGuHi
         GatUusJ7FWzqQpDCYnfat37hmwSEo8ZIlqYKL4Q3DMQyXKyCIKzS+iQ9zYvbl2/oglmS
         oD7WPC3tQ1TXS/4Y27sOg3HQo6vt5pMkzVvLOdq1vTjIQtk0nAPGUsy3sQmYVlkePbFV
         Wm6iMwQUf9dIvVvkUNFAKlS3DurIoiAIlZnO6armOIsmO4iPFbOdLG672/u9cd6gdk46
         xrrPfrWeC/m9Jtsd07KaGsExHCCzR5S92UEfXsCzvWtEqzSLOps3cMlivN/EgEJXc7pP
         0FLw==
X-Gm-Message-State: AOUpUlH6I30w55MBvuzgYYSrTqlwYtDPUney0Xww0n9DU9RRnfsel34O
        auNVW5Za4+SLUNe38ISLT0s=
X-Google-Smtp-Source: AA+uWPziAIBsrBy0i0oYBIK0ekr9KkiWpUfrfculn1ZE7lTh7H9GpKi+3Bhgs+FL0B5HpIDEPlIQMw==
X-Received: by 2002:a1c:1c92:: with SMTP id c140-v6mr15994607wmc.155.1534458600183;
        Thu, 16 Aug 2018 15:30:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r18-v6sm1370080wmh.28.2018.08.16.15.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 15:29:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?Q?Pawe?= =?utf-8?Q?=C5=82?= Paruzel 
        <pawelparuzel95@gmail.com>, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] config.txt: clarify core.checkStat = minimal
References: <CACsJy8AYQL3oDLyt14eJ1emynngqKQv9GXju56gU9u4mHrFHOg@mail.gmail.com>
        <20180816155647.10459-1-pclouds@gmail.com>
        <xmqqin4afdoj.fsf@gitster-ct.c.googlers.com>
        <CACsJy8C2r5y0m88yrRQHQ-_QNXemy2pfcjxYK0zSd0J3fFy3rQ@mail.gmail.com>
Date:   Thu, 16 Aug 2018 15:29:59 -0700
In-Reply-To: <CACsJy8C2r5y0m88yrRQHQ-_QNXemy2pfcjxYK0zSd0J3fFy3rQ@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 16 Aug 2018 20:19:01 +0200")
Message-ID: <xmqqy3d6c5co.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Aug 16, 2018 at 7:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>>
>> > The description of this key does not really tell what 'minimal' mode
>> > checks exactly. More information about this mode can be found in the
>> > commit message of c08e4d5b5c (Enable minimal stat checking -
>> > 2013-01-22).
>> >
>>
>> While I agree that we need to do _something_, I am not sure if this
>> change adds sufficient value.  I _think_ those who wonder if they
>> want to configure this want to know what are _not_ looked at
>> (relative to the "default") more than what are _still_ looked at,
>> partly because the description of "default" is already bogus and
>> says "check all fields", which is horrible for two reasons.  It is
>> unclear what are in "all" fields in the first place, and also we do
>> not look at all fields (e.g. we do not look at atime for obvious
>> reasons).
>>
>> So perhaps
>>
>>         When this configuration variable is missing or is set to
>>         `default`, many fields in the stat structure are checked to
>>         detect if a file has been modified since Git looked at it.
>>         Among these fields, when this configuration variable is set
>>         to `minimal`, sub-second part of mtime and ctime, the uid
>>         and gid of the owner of the file, the inode number (and the
>>         device number, if Git was compiled to use it), are excluded
>>         from the check, leaving only the whole-second part of mtime
>>         (and ctime, if `core.trustCtime` is set) and the filesize to
>>         be checked.
>>
>> or something?
>
> Perfect. I could wrap it in a patch, but I feel you should take
> authorship for that one. I'll leave it to you to create this commit.

If I find time after today's integration cycle, perhaps I can get to
it, but not until then (so the above won't be in today's pushout).

Thanks for reading it over.


