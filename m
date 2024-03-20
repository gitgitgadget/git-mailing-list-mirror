Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA3469DF5
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954354; cv=none; b=BOoGUDaKyYPMdMgCQjev3qs9h2Bqr0YN8G22tIozBXFxmQoJcqMkHTnrJT2wKf7Q7Exwkn3hzC1K2OBuDwpRG+JKTS+A6/LXLteRVCgv6RjNlE0PZpPafsCkRatu+/nDbEEEkKaBpiKFzjHgrdMY+xbPhB5V+xDJWdB+otdfYrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954354; c=relaxed/simple;
	bh=CNGgoWYtN9IMveQ68jFA2o/Rld53raiIkc7V0qkd14s=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=QoUah7sJozMNZMelWMWe1iQaYrJQhV9r0A/JqFtI1DKCdNDyr+ZF5SiXH2tqjio3WnZvBA4OXLetyHyhKHxtRaGvS+ThHXyxtD3i8FnXorO73AcNQ2E25IH/ZY1blnevqne/7ttmUI0LZEnzPxqsFT6VtvNT8bYNUduqFQSY2ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luG912Dg; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luG912Dg"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c7476a11e0so197499739f.3
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 10:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710954352; x=1711559152; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2WhOHptTGafZVsw1+T8M4IiWpRwgLtsWVzhFrkwH8Mg=;
        b=luG912DgUNsEyaLckYc0/vv5AWZmFtt8XcO2D6WnduGMBpG/wG2xRv0L/2ivyi6bjo
         OKy/NprGDibiPb15iEE0vcgyYWK8yB8OW8AWqApe0gAvn6pS9i84JCM+SwlxBR1lnW05
         l1XuE8zn6/yyIgoGZcb4EZhj/3uX1kw2+d/Wn/06Tp4vFfaDSneq/cRr5INKi1nwRZC3
         mVAv70PEPyX9XXBzjQETQWTUHYX0Unldpo3qbV377Z0Q5CLPQ78VvLbyo5IkLY5sNMnV
         sw9y2IJhJF+MWX468WCU1WyBqwGnLG1IVzNAyhOoOBHMqkPtGx7eU8KavI7vS2eKilNT
         L1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710954352; x=1711559152;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WhOHptTGafZVsw1+T8M4IiWpRwgLtsWVzhFrkwH8Mg=;
        b=Tv66miN/9FP8E5mf+7yG9YKF1K7Yl8YPTrmi7RJXpXjDFaJbUUoBNXnydT7oEXR0sT
         CJqEhsQb9Rpn1R0EYowNIBtDwxQIrKSjxVOscrqvY/3rpQ7sV/7b4VMPB6chrvv9TiS5
         WvLGxdEAocimoFDiyWSdBAJ5KKVSluJPLapeFRQlGBYM4B8PPirpnedp/8LJLvnPB6WL
         4GYv7RDTqwiupuG4L0cYhQBK6Uco8u1fBbowyHBVfBBW0P/yyAB9Bp8NluUT7fPLKp/w
         /75qyc38WmY0ybGd8QFq+M+KpDvZO2HVCsjiRCvEDvTfB53Vulcv8R1cziZxU6cVYThI
         X1Uw==
X-Gm-Message-State: AOJu0Yyc2CqTVcM6rsCu2r1V6Ex2aOCT+aY8fLwZ7k2UTiztd7PXOF3h
	wAjDCg3W7/1xrSse/hhmaRxaT7T5/HgC67KiUmXuqQ4wlG7LJ7sliKWOuhyd
X-Google-Smtp-Source: AGHT+IE57GfpCxZIA1xkGkDBcNLUnjnIylzdLXAXxnIM4rchxVamOz0Anv5EMInopVZVtehaB6FuGg==
X-Received: by 2002:a5e:c306:0:b0:7cb:6050:805f with SMTP id a6-20020a5ec306000000b007cb6050805fmr18563460iok.1.1710954352048;
        Wed, 20 Mar 2024 10:05:52 -0700 (PDT)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id z18-20020a02ceb2000000b00479d7d5b626sm2113964jaq.156.2024.03.20.10.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 10:05:51 -0700 (PDT)
From: "Eric W. Biederman" <ebiederm@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/3] some transport-helper "option object-format" confusion
References: <20240307084735.GA2072130@coredump.intra.peff.net>
	<20240320093226.GA2445531@coredump.intra.peff.net>
Date: Wed, 20 Mar 2024 12:05:49 -0500
In-Reply-To: <20240320093226.GA2445531@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 20 Mar 2024 05:32:26 -0400")
Message-ID: <87y1ac3kb6.fsf@gmail.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Mar 07, 2024 at 03:47:35AM -0500, Jeff King wrote:
>
>> I happened to be looking at the output of t5801 for an unrelated
>> problem, and I noticed our git-remote-testgit spewing a bunch of shell
>> errors. It turns out that its expectations do not quite match what the
>> transport-helper code produces.
>> 
>> This series brings the test and documentation in line with how the
>> transport-helper code behaves. But I'm not sure if we should be going
>> the other way (see the comments on patch 2 especially), and bringing the
>> transport-helper code in line with the others. Hence the RFC.
>> 
>>   [1/2]: t5801: fix object-format handling in git-remote-testgit
>>   [2/2]: doc/gitremote-helpers: match object-format option docs to code
>
> Here's a non-RFC v2 based on the discussion thus far (thanks brian and
> Eric).
>
> The big change is that instead of changing the docs to match true-less
> "option object-format", the code is changed to match the docs. That
> happens in patch 3 (which subsumes the original patch 1). We continue to
> drop the documentation for the "option object-format sha256" form. But
> now the commit message justifies it better, and we clean up the stale
> code in remote-curl.c.
>
> Patch 1 is a small fix for debugging output that I noticed after getting
> confused. :-/ It's not strictly related and could be taken separately.
>
> Eric mentioned having Git check that the helpers never say
> ":object-format" unless it was negotiated. I stopped short of that. One,
> it's a bit tricky to test (since Git will always ask for object-format,
> you have to teach remote-testgit to optionally send broken output). And
> two, I'm not sure that being strict has much value here. It keeps remote
> helpers honest, but the real losers are old versions that do not
> understand :object-format, which would fail against such a remote. So I
> dunno. It isn't any harder to do it on top later if we want to.

Your sentence has what I was asking for backwards.  It would be healthy
if the code fails when "object-format" has been advertised by the
remote, requested by the transport-helper, and the remote does not send
":object-format".

The check is cheap and should prevent buggy remotes from appearing in
the wild.  I am probably biased but I rather want the information
on what hash algorithm the remote is using when I ask for it.

I can totally imagine someone during development forgetting to send
:object-format and either not noticing something was wrong, or spending
a fair amount of time debugging that they forgot to send it.

It is the kind of bug I can imagine someone making when they are called
away from the keyboard at the wrong moment.

The implementation should just be:

diff --git a/transport-helper.c b/transport-helper.c
index b660b7942f9f..e648f136287d 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1206,6 +1206,7 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
 	struct ref **tail = &ret;
 	struct ref *posn;
 	struct strbuf buf = STRBUF_INIT;
+	bool received_object_format = false;
 
 	data->get_refs_list_called = 1;
 	helper = get_helper(transport);
@@ -1236,9 +1236,13 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
 					die(_("unsupported object format '%s'"),
 					    value);
 				transport->hash_algo = &hash_algos[algo];
+				received_object_format = true;
 			}
 			continue;
 		}
+		else if (data->object_format && !received_object_format) {
+			die(_("missing :object-format"));
+		}
 
 		eov = strchr(buf.buf, ' ');
 		if (!eov)

Am I missing something that makes a bad implementation?

Hmm.  I thought gitremote-helpers.txt said the key value pairs
would precede everything else from a list command.
gitremote-helpers.txt does not mention that.  That looks like
a Documentation oversight.

However remote-curl.c in output_refs prints :object-format before
anything else, and transport-helper.c will malfunction if :object-format
is sent after any of the refs.  As transport->hash_algop is used by
get_oid_hex_algop is used to parse the oids of the refs.

We can probably fix the Documentation like:

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index ed8da428c98b..b6ca29a245f3 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -268,6 +268,8 @@ Support for this command is mandatory.
 	ref. A space-separated list of attributes follows the name;
 	unrecognized attributes are ignored. The list ends with a
 	blank line.
+
+	Keywords should precede everything else in the list.
 +
 See REF LIST ATTRIBUTES for a list of currently defined attributes.
 See REF LIST KEYWORDS for a list of currently defined keywords.

I do agree that the sanity check can be added to your series, so if you
would prefer I can do that.

Eric
