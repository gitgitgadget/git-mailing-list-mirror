Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AE859B52
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710420442; cv=none; b=aYg3FVwM10GvEIk/ba5ysq5YDvENiZzj9y1y8Ya4ZU/F4JpVcUhAxnTvOdXUUfLEg0YKoYSD39wefx+s2Fhq9/W3hRyjWsX09+7sWFS4xqiBudi3XwJktv/2Qc3Rv8ZK/oNx2FlYZjpgmfv64ez4G6IL4u//huLxwIW0A38W8cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710420442; c=relaxed/simple;
	bh=IwtcFJIPJF6LhpjyFka8tKakXxa8O7P+XrO/Qt5svj0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=YRvAYi4HWoKaXWt18KntKW5yz01diN6QQU+78NcxD1Txk3p2FB7J6rayOFjUqMrJSkTH6442O8hTY8zF8grUJgTZLVI074IZnl1Z2/JJQ/sP6zgM4yXHUYCzHQq+Hwimhplz44CZ6BQEp+cut81w6OL3H+c6QQGe+ccfVnD4Yfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbjlWLnm; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbjlWLnm"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c8ccffacbcso9599939f.2
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 05:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710420440; x=1711025240; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GBDTCNC0tTcNcqR0olZATvDEsApMLxbqw76P/ROCGWk=;
        b=fbjlWLnm/VF3IofmMuZ/m4JCuhsB2ELiZQstoc4+pyTAPUpqzeW3ti4vwEKZsH0Of9
         TQb867eeWSyvyOOeieK1Qb9GS/LDgBUO/x12aDBPU3CWwaqdIqYiFLl5jWEwfTHUpwnc
         qhz2eK/sfbf/bFUMrwjbMgNsGvMbylW8H+DcQpOifZirsQ69eD1DL8yp5X28HsbjUfah
         dsdm3W/y1W3qJfNuNM0xYtWxJhXdxJjJA4K3w4g8sa9Bo/J4I4LDI836X60SNrtCLJvu
         R+E3IWX9bgdRXGvpJ8NAHo8HED/eYcl/ItVtu5rK8xxakQf1iQjFgs2M0O+QKjlbXbDh
         tyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710420440; x=1711025240;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBDTCNC0tTcNcqR0olZATvDEsApMLxbqw76P/ROCGWk=;
        b=IQNIiJGjTN29uel291U7z2Zce7pQqKvoCdIPlJ5vnIN6xjGA4HblvF/kEvflG8MSnl
         85qMTTLcVKcO/0SKXPa2D2P02pm/4jg334UU+AqPKZ/seVJQzWGyQOW8Yi8jW8tLuJpA
         iF4FIGmzUlziblT6mj2LUnC4sJVYMvDacEyuYTVgl3Ik231NPY9GvePgdLY/3hEsk5YO
         5t94oSZg+anNCMFXtqXRGL/8LiFdLLhnNv/fC7/M2AJrjjPp9hVAnCedINpothTnwQPB
         U0HRyKFYyosaAKk4zK21U/yOTZrxdUb7vYZL6AnWjZZuRLIYbZaGmHhRrlUq2+5F/rFh
         Ty2g==
X-Forwarded-Encrypted: i=1; AJvYcCX3F+4MR9ZupchSwLLLSNZd7wzxIfIHLj2L4VajAl7zuJVNSuhOf4DQmqOot1Z2Hd/E5IAtHdMw8MUzUMOxMds8q1hW
X-Gm-Message-State: AOJu0Yypt0HIcuXYKc7d5lxUuDWY+6uFJVdKbei9d+qcRQgLsITMrDn2
	jxUTm9JmBkX3omt2vhxcESCRIZPoFMoSFhTMlJ3D1vgV2/4r2/JXb7rEHbLj
X-Google-Smtp-Source: AGHT+IHsWTICo1PbZLetv9L1JQN/jiv0oiww69zxljOZSJCPq/rNdQ3Z/w5yH2irXXSXFgv6+gnaLQ==
X-Received: by 2002:a6b:a01:0:b0:7c8:fadd:c903 with SMTP id z1-20020a6b0a01000000b007c8faddc903mr1937213ioi.0.1710420439891;
        Thu, 14 Mar 2024 05:47:19 -0700 (PDT)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id d73-20020a6bcd4c000000b007c8b1c6f79bsm364778iog.5.2024.03.14.05.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 05:47:19 -0700 (PDT)
From: "Eric W. Biederman" <ebiederm@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] doc/gitremote-helpers: match object-format option
 docs to code
References: <20240307084735.GA2072130@coredump.intra.peff.net>
	<20240307085632.GB2072294@coredump.intra.peff.net>
	<Zeo9oAkL6kxZRugN@tapette.crustytoothpaste.net>
	<20240312074513.GA47852@coredump.intra.peff.net>
	<ZfIWkJieqcPv5jA8@tapette.crustytoothpaste.net>
Date: Thu, 14 Mar 2024 07:47:16 -0500
In-Reply-To: <ZfIWkJieqcPv5jA8@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 13 Mar 2024 21:11:44 +0000")
Message-ID: <87ttl99e0b.fsf@gmail.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2024-03-12 at 07:45:13, Jeff King wrote:
>> So I guess my question was more of: are we thinking this explicit
>> algorithm thing is coming very soon? If so, it might be worth keeping it
>> in the docs. But if not, and it's just a hypothetical future, it may be
>> better to clean things up now. And I ask you as the person who mostly
>> juggles possible future algorithm plans in his head. ;) Of course if the
>> answer is some combination of "I don't really remember what the plan
>> was" and "I don't have time to work on it anytime soon" that's OK, too.

Given the rest of the conversation I thought something about the
object-format option was going to depend upon work that I am doing.

Reading up on object-format this seems to be something that should
be sorted out now.

Fundamentally the object-format code is about a client representing a
SHA256 repository encountering a server representing a SHA1 repository
and detecting and handling that case cleanly.  Or the other way around.

This is a current concern as SHA1 and SHA256 repositories are both
currently supported.

The only future concern is what happens when a client for a SHA256
repository encounters a server serving a SHA1 repository and wants to
switch into a compatibility mode, before it starts sending something
that will confuse the server.

That said I think a lot of think we do a lot of that today in practice
by simply detecting the length of the hash.

In general the plan is that all of the multiple hash interop work
happens on the client and the server worries about handling a single
hash efficiently.

That said I haven't worked with the git protocol so I don't know
what is needed in detail for a client to figure out what the server
is speaking and cleanly abort, or quickly switch to the servers
language.  Jeff do you have any insight into that?

> The answer is that I'm not planning on doing the SHA-1/SHA-256 interop
> work except as part of my employment, since I'm kinda out of energy in
> that area and it's a lot of work, and I don't believe that my employer
> is planning to have me do that anytime soon.  Thus, if nobody else is
> planning on doing it in short order, it probably won't be getting done.
>
> I know Eric was working on some of the interop work, so perhaps he can
> speak to whether he's planning on working in this area soonish.

Soon-ish.

Getting the SHA1/SHA256 interop working is something that I feel pretty
strongly about.  So once I can set aside some time I am going to
push forward with it.

I have code doing with pretty much everything else working and tested
except the actual interop working at this point.  That is I have code
for bi-hash repositories.

Breaking everything into small enough chunks that people don't feel
daunted looking at the code has been a bit of a challenge.  My current
plan is to write some ``unit tests'' (that is tests that test a single
abstraction in the code at a time), so I can feel comfortable feeding
things in much smaller pieces.

Once the core infrastructure is merged for bi-hash repositories then
I plan to work on the actual interop between the repositories.  With
the challenging technical problem I have been looking at is quickly
and efficiently writing a pack in the repository hash, while
retaining a translation to it's original hash.

Once the translation is done the rest is fiddly bits that should come
fairly quickly and should be comparatively easy to review.  AKA things
like the client detecting the other end is using a different hash
algorithm and using that information to send heads in a format the
server understands.


That said I will be happy to help sort out object-format now.
That is maintenance and it has no dependencies that I am aware
of.


...

That said.  Sorting out object-format has no dependencies on anything
else I have been doing.  I will be happy to help sort that out right
now.

Eric




