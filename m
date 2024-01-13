Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D050711190
	for <git@vger.kernel.org>; Sat, 13 Jan 2024 01:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uWuSZCF0"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f874219ff9so78481937b3.0
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 17:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705109717; x=1705714517; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dy9k91gUuN4nniwzyLv5+3mP5Ni6wFOQPL4emSScG44=;
        b=uWuSZCF0EGEKsYzb38lFlgl2JQQYDT4AxyNnmZ7K7Y/hFBQFUgVQFDQY3gf/xLZBPN
         C/yO3NfJwnqLDiBxXm+cINV0UyJoBo0cdp5iStua0EcJz6cOZydZSuV1dwguBh0biLtG
         h1X1Uzy/JneFLj15I/wTQugMJMaSVCczcWgEL1Y1kZh/ZhLFRSBVaSfbRikabLizJEab
         cPIdnkkE2vw2jipErZHfa8g8Oen9jOVJsPJ5vG/Yyfxn6TqtpSBTKkwB5JoF+LLjIQZg
         XpdXucDtqI4n2LsW/5Nj028QkO1VHJ56s8+20oe5t7stcOdh8z5z+CUgifKxqMxFtv42
         QUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705109717; x=1705714517;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dy9k91gUuN4nniwzyLv5+3mP5Ni6wFOQPL4emSScG44=;
        b=MFIJJt9rWio4905sx0mlF50GxWyGXB5qLS1+Tcef+On+FQ3DSGwZVnC/m0zem+xCVA
         pMG+4CNyPtzAO6ajfe8PU0CRlGTzbe+6p5a+CSJU/CCdrRRwXBXzwaGvgwgnmtETU4op
         mseB7jjqVZAfEHzGh+ZaBTaTT/4GOmu/IgXAdMDPPID8HPTigM3n46uduE8M4RkzqaN4
         e1sMkPMxePWqyjXi162u/a018/HqoX8Sbu+fxOMbIG9oVa+4uv4/pohlg0ClweH3uTh0
         FVeWQ3QHtEe3JDhASyNrQtZhk93YDPBxjFw2HYfVUNAppeM+6PuBWowoOpwtRuuuxcwP
         Ov7A==
X-Gm-Message-State: AOJu0YxggZvIARgCOpFW8aemADxrM8hAn3UAP8TqPqnHmB0BI39VcxfJ
	cREUHQLlblXdK8JEepRSQs/bxHP5I8EvKXxZgQ==
X-Google-Smtp-Source: AGHT+IHS4FuwOpHaBIy/FBr4Rpki3A+QnATG9HrEMd98ur2rL061CDNL1NoIhboEuGPo1wuLUqzkFuMSESM=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a81:838a:0:b0:5d8:ef49:748 with SMTP id
 t132-20020a81838a000000b005d8ef490748mr1026337ywf.5.1705109716895; Fri, 12
 Jan 2024 17:35:16 -0800 (PST)
Date: Fri, 12 Jan 2024 17:35:15 -0800
In-Reply-To: <xmqqy1cx9dm4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com> <xmqqy1cx9dm4.fsf@gitster.g>
Message-ID: <owlyil3yhv70.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 00/10] Enrich Trailer API
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> This patch series is the first 10 patches of a much larger series I've been
>> working. The main goal of this series is to enrich the API in trailer.h. The
>> larger series brings a number of additional code simplifications and
>> cleanups (exposing and fixing some bugs along the way), and builds on top of
>> this series. The goal of the larger series is to make the trailer interface
>> ready for unit testing. By "trailer API" I mean those functions exposed in
>> trailer.h.
>
> Are there places in the current code that deals with trailers but
> does not use the trailer API (e.g., manually parse and/or insert the
> trailer in an in-core buffer)?

While working on this series I unfortunately did not search for such use
cases (I limited the scope of my work to mainly the interpret-trailers
builtin). But, a quick search just now on master branch turned up
append_signoff() in sequencer.c which constructs a Signed-off-by trailer
manually with a raw strbuf [1].

This is somewhat understandable though, because AFAICS the current
trailer API does not support creating and formatting single trailer
objects.

> Is it part of the larger goal to
> update these places so that we will always use the trailer API to
> touch trailers

That sounds like The Right Thing to do.

> , and if so, have these places been identified?

Not yet, but, it should be easy to check any remaining cases other than
the one I identified up above.

> Obviously the reason why I ask is that testing cannot be the goal by
> itself.

I now seem to recall an offline discussion where I said I wanted to
enrich the API to make other parts of Git also use this new API. Somehow
I've left that motivation out of the cover letter (will include in the
next reroll).

> The "alternative" ...
>
>> As an alternative to this patch series, we could keep trailer.h intact and
>> decide to unit-test the existing "trailer_info_get()" function which does
>> most of the trailer parsing work.
>
> ... may allow you to "test", but it would make it more difficult in
> the future to revamp the trailer API, if it is needed, in order to
> cover code paths that ought to be using but currently bypassing the
> trailer API.

Agreed. I should include this rationale as well in the next cover
letter, thanks.

>> This series breaks up "process_trailers()" into smaller pieces, exposing
>> many of the parts relevant to trailer-related processing in trailer.h. This
>> forces us to start writing unit tests for these now public functions, but
>> that is a good thing because those same unit tests should be easy to write
>> (due to their small(er) sizes), but also, because those unit tests will now
>> ensure some degree of stability across new versions of trailer.h (we will
>> start noticing when the behavior of any of these API functions change).
>
> And helper functions, each of which does one small thing well, may
> be more applicable to other code paths that are currently bypassing
> the API.

Yep.

>> Thanks to the aggressive refactoring in this series, I've been able to
>> identify and fix a couple bugs in our existing implementation. Those fixes
>> build on top of this series but were not included here, in order to keep
>> this series small.
>
> It would be nicer to have a concise list of these fixes (in the form
> of "git shortlog") as a teaser here ;-).  That would hopefully
> entice others into reviewing this part that forms the foundation.

Ah, good idea. Here's a shortlog (with a short summary of each one) of
bug fixes that are forthcoming:

    trailer: trailer replacement should not change its position
      (Summary: If we found a trailer we'd like to replace, preserve its
      position relative to the other trailers found in the trailer
      block, instead of always moving it to the beginning or end of the
      entire trailer block.)

    interpret-trailers: preserve trailers coming from the input
      (Summary: Sometimes, the parsed trailers from the input will be
      formatted differently depending on whether we provide
      --only-trailers or not.  Make the trailers that were not modified
      and are coming directly from the input get formatted the same way,
      regardless of this flag.)

    interpret-trailers: fail if given unrecognized arguments
      (Summary: E.g., for "--where", only accept recognized WHERE_* enum
      values. If we get something unrecognized, fail with an error
      instead of silently doing nothing. Ditto for "--if-exists" and
      "--if-missing".)

The last one is a different class of bug than the first two, and perhaps
less interesting.

Thanks.

[1] https://github.com/git/git/blob/d4dbce1db5cd227a57074bcfc7ec9f0655961bba/sequencer.c#L5299-L5301
