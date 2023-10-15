Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035D3110A
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 03:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="LPGfxsWI"
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBA9D9
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 20:01:31 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5859a7d6556so2505867a12.0
        for <git@vger.kernel.org>; Sat, 14 Oct 2023 20:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1697338891; x=1697943691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P6UpKz4npGFKHpbLiJrv9j/irx8FMeGf5qnH7OfGqcA=;
        b=LPGfxsWImtDRY+rCR9Hlf49qgKzY0zZO2uxNE1DLUs2voW2J/psU/3XsYT1GD8ZBju
         9Rx1pbEO4GcS1Ja7JFUYR+rHfLRMEt4bZgrQEABSqQfbPX4JefHP7GlI/YKmXITAcAiN
         0hyJifT7lN0D+wdnkdu8nQXJEqSbxlH+Aj5fOE7XmCe1iHTUliNjFOl8KC+Y3PbOq49F
         pXP3QGv/kATWmpQHVngF8WJeRjMVNaZrw3TgnyvqGI85c0OP2zdeWWlj02KsFZn4CYh1
         UPtWxQv9Qay+bnGJjW9Xgypfpxo1uVp7fOWfGOZSqLnyZBk0Tfv/8mKVQIy7pji4BmBD
         Yr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697338891; x=1697943691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6UpKz4npGFKHpbLiJrv9j/irx8FMeGf5qnH7OfGqcA=;
        b=RxyzA3H+tNg/SNGIYQTP7lZ3JGkuN1kX6D533uYFcodxQEDI8uB0Okjj9TLZlxOajt
         SzZzaZekh+s3AUvGPBGJrCCewOcyowvcheCkQuz8f73EgAzDfE26w1iEg1iwx3IRNfiX
         OiDLYIz1fTG0twOvMQ3PZr7N6e4EX0mVCbwyBpg+cOUZ+EscItsavQlcsMkqQ0+PQ4tq
         p8Y/WU0AOGyy4XpLy93wv8hL37Wec1mUl98OyXlGFptOVlrE4PhCJwHSKJRzOJFOw0Fa
         DlXbQ3sqPdPzzBVn3V2oO5vtWgs7sIK81eJMaJ1A0KAEs1F6KlTa5K9lyX2TCSxTvIMs
         HG4g==
X-Gm-Message-State: AOJu0Yzt7dPj5RxlRu698kKZnioLOUfwA4QXTYQiuW5l9e+biaqjqyTS
	llMQ00+0mnvIoWeZxzP2eLl72CFvmACyEFx9nFQ=
X-Google-Smtp-Source: AGHT+IFUjAgSu1V7RlvZwLt7baCk1yw2aYn7oiKVA095pByI3rAH7itIKb17pOh7P67w5ZPYrOyT0w==
X-Received: by 2002:a05:6a21:4889:b0:172:629f:455e with SMTP id av9-20020a056a21488900b00172629f455emr13425876pzc.57.1697338890787;
        Sat, 14 Oct 2023 20:01:30 -0700 (PDT)
Received: from initialcommit.io (ip68-7-58-180.sd.sd.cox.net. [68.7.58.180])
        by smtp.gmail.com with ESMTPSA id g12-20020a63be4c000000b005898e4acf2dsm4731261pgo.49.2023.10.14.20.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 20:01:30 -0700 (PDT)
Date: Sat, 14 Oct 2023 20:01:27 -0700
From: Jacob Stopak <jacob@initialcommit.io>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] bugreport: add 'seconds' to default outfile name
Message-ID: <ZStWB1/LX7cTbVGr.jacob@initialcommit.io>
References: <20231014040101.8333-1-jacob@initialcommit.io>
 <xmqq4jitw4nk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4jitw4nk.fsf@gitster.g>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 09:27:27AM -0700, Junio C Hamano wrote:
> Jacob Stopak <jacob@initialcommit.io> writes:
> 
> Is "postfix" a verb that is commonly understood?  I would say
> "append" would be understood by more readers.

It's probably true that "append" or "suffix" (which is used in the code)
would be more easily understood. I'll switch in my updated messages.

> Also, is "calendar"
> hour different from other kinds of hours, perhaps stopwatch hours
> and microwave-oven hours?

Lol! By saying "calendar" I mean "falling on the official boundaries
of", like 11:15:00 - 11:16:00. Unlike the time between 11:15:30 -
11:16:30 which is also a minute, but it's not a "calendar" minute
because it overlaps into the next minute. I guess in this case it's more
of a "clock" minute than a "calendar" minute though ':D... I guess
"calendar" terminology is used more for months/years...

> I personally do not think it is a problem, simply because a quality
> bug report that would capture information necessary to diagnose any
> issue concisely in a readable fashion would take at least 90 seconds
> or more to produce, though.

This is true, when the user intentionally opens the bugreport with the
intent to start filling it out immediately, I assume they would almost
always cross the minute barrier and avoid the issue.

However, there are edge cases like the one I outlined, where the user
might open and close the report quickly, followed by rerunning the
command. This could be someone learning to use the command for the first
time. Or the case where a user only fills in a small part of the report
before closing it and running the command again.

These cases are certainly "the exception" but it seems the program could
be a bit more consistent/intuitive when they do occur.

> Instead of lengthening the filename for all files by 2 digits, the
> command can retry by adding say "+1", "+2", etc. after the failed
> filename to find a unique suffix within the same minute.  It would
> mean that after writing git-bugreport-2023-10-14-0920.txt and you
> start another one without spending enough time, the new one may
> become git-bugreport-2023-10-14-0920+1.txt or something unique.  It
> would be really unlikely that you would run out after failing to
> find a vacant single digit suffix nine times, i.e. trying "+9".  It
> would also help preserve existing user's workflow, e.g. they may
> have written automation that assumes the down-to-minute format and
> it would keep working on their bug reports without breaking.

I agree with all of this, and to me it's a better solution than
_appending_ the second value :). I have a patchset almost ready for this 
so I'll try to submit it later tonight.
