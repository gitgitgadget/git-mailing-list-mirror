Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443833CE49D
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773858020; cv=pass; b=KNza8hDRIyDhPeES6dWDIGyv10imaRSS2IG2LS9QbqisEGNszLttVkbabO3xzIIBNe7GNbGLFxRO1Ufe1GEHkFfidqASUBA/Sl3/Y+5SiZwchuyIl1dbTW2tq55Z+lOHluZgdRt6xzsCiR+x3PtRwwf9zl17bQXNvIq7m2ctogw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773858020; c=relaxed/simple;
	bh=9TzjPvOINW9bzUrgV49jK23yTaX8McVuSEfQdyfXiKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIK0pXKjK4FXLFsgohoXesXGpD6hX+Cf0dIFyPERaeJ3v8vHc21N6ku7edliGMWP6nkAjZzyGHXKDkv7p7F1j46TJh63G3J+DgoLZ9E5iSgfqQw/OZ48clmtu3jtvk5DcBGszk+zjNHcxpYXBMGAtP0XUNlYmMpCMpV8CnTOT00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyb5eWBF; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyb5eWBF"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79a62a2bb8cso2377007b3.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 11:20:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773858018; cv=none;
        d=google.com; s=arc-20240605;
        b=BCh8vUnhIxb76csgXPHnYbl6jeQyQA+1hDSRJKOMQadU02qB2MoEZkRenM/LGyKPIO
         rY1/og7hiQTsiAqRRlREuzV7XCWsOvhSVUYrdnoaJpFHGkzFhhnfGGB4HvS/5HSmKkDj
         mwGQdJit5Irh1PhUjhPzJ6SWY4gmuLJ6cZDA9u/qSWf5/aUj9c1nTLUPdHsKUXTWMinS
         w9SOS01TI7oiQnWNkc/z99lJz4greVp1kThEfaJmj26OPv0z3Vbgrfzyu2xf6ayzTtqN
         8vAIZyXSUOPE7Zmtz8p7elu25DynHMN7TcsWa1xOyJymWJjX5lzHu8rZhA+6b/FVfK9/
         w/pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1L5PRL+slo5wpRyYENBxefORqKwIkY+JFXVD1qQ9Rf0=;
        fh=hdYj/kDeiNxc0CV9ANV1htcOog43EMyhQ9sUUeD7EVE=;
        b=gFcRGLmg53wDkgGXJlJeJmz+8KUKrshG+OikPyi1T7JXgJx0/CHrPq++4lKsMVSCnH
         j6g+OyC2UsL+5pduxk3gu8oPz2sL/bKZNOPf+O94H4GStfr5asl9E1hVHe1YmbHwVVGN
         r0YfloxpydMxmyP8c4a2SST5GpxxqXhLlOhs+xC2Zo9WvyVqcmBFzyclBIGTGJ28bRmU
         4UWyPIWSo+C6kStxsAEl+Uv3+zNPwz9Vjd21LUSL2hoMDY61cJKYYLtBJTTqxp/5VRUS
         zUVmZ2iyRS7o04rwK5H5J6zyDfEJdqvp6Nn9ZdKsUfmLX6g++o/mWb1RwVgRUg0m3Cq3
         IVLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773858018; x=1774462818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1L5PRL+slo5wpRyYENBxefORqKwIkY+JFXVD1qQ9Rf0=;
        b=lyb5eWBFEOZPm2Pe9dSpXOyCNuyduEwBE2Px5aMst3tbJQeIMvLgzcKrzelyg4/NZB
         8bO0eHLonqT4NtmDwHvinLoWLLBIajUZEnEXyyJuTXSBPxNhF3NWRMr6EME5NthbPWgl
         C22zVlejxU8RK6HroJE4vCC0SvwlUChSpuV/Fnjb+kMzQ4YL79GglJP5StHCk2mdYl+5
         SAel39oAdcPuQF7Ozqx7UmeSb8rGHwTZ6WxacdFtXCT1dSUuCmw0sQFDy84jYrDpGSQ3
         aHceeo58HydkuO+TLzL7Z7MmgOxnAWvvjYvDdKXicgD6sxJHnyyZXBPCgG0QPeHXUxEq
         tdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773858018; x=1774462818;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1L5PRL+slo5wpRyYENBxefORqKwIkY+JFXVD1qQ9Rf0=;
        b=BfMfIqIwSSnRG25A6WGtg3tluhyvzxDCERhQiCItoYW9bVbR1q8eRzWzg02xI7Z8bl
         9sOXbcFQzpN7ygd5XBmghfA0GCdT8xyCqks3pvaFdAydeOEGk0qV4V+Ll8k5dF+HVpow
         V/R0fi7gXTfojL78OUSh3aX7Xklk9sVDAyVnBqZ+DobAqxUon6QslU2OZ3hm2Gehme93
         zPCILSB1Zl0DAzXcgoOhg/wCmy05z0WxvhylzACgkdNVIscCUsdpjTZlx6jR2JxcdlIi
         iyGpNC6rz0wKnnsS7jPB6r6w0mpxzMa99CSKpNLGZ19wBQVnrEoLUC4iVbRA0j6sAX4B
         vZqQ==
X-Gm-Message-State: AOJu0YybMdlxlf/Zljjac2Pz/KVZOEmin5RnGjdyYTajzZVYrijdLbEV
	P7b0uxGXoaLNhI95Hv94tMltI7VbF+x5upVztlNPiHl0lpHbk6ScF2l9o1BbRmBnPMeqz4PTt6r
	w3N31LzO++gyYqKRTmWWwL0Eisph/Z9k=
X-Gm-Gg: ATEYQzxUCklg6hxaQPafE4TrP2/67Q6zwmmLH5ugCgOl7voKKorbNZlGG9dYq+A+Mr0
	rOgy8xRqCEK+NxApHx1kQZN4f5U/++wdhHXxRfzwJjfh1Ss5zzGDwYhbJvH76tY1zUgP3kyEOBF
	BvkjNNIYCAyjQSdAIwirPPaJtGm3/ImykpDhcKAbQe8MwVFCLaPG87fGJ8NQRuQ/05faYkUZDlI
	wEoCWlDzVL2QV9UVtyxjXjj4a09pVgHrobWHARDizMetrIAQS/l4pVhYyYdqgqabx93OInOPRKc
	k6jM8k1NTr8lfvZKd6rb/E9i9SqQm5lCvx0OrJO5aBN6TNyBsbBxejPrXKGwjNRuevNFa38Q/ID
	XrYHKLyJKlqqg1aZOB+SpdAk=
X-Received: by 2002:a05:690c:c4f1:b0:798:caad:ac9e with SMTP id
 00721157ae682-79a71cb811bmr43242817b3.61.1773858017984; Wed, 18 Mar 2026
 11:20:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316133426.117684-1-pabloosabaterr@gmail.com>
 <20260317220929.120746-1-pabloosabaterr@gmail.com> <xmqqzf45gm2q.fsf@gitster.g>
In-Reply-To: <xmqqzf45gm2q.fsf@gitster.g>
From: Pablo <pabloosabaterr@gmail.com>
Date: Wed, 18 Mar 2026 19:20:02 +0100
X-Gm-Features: AaiRm50vZYq_ZvtUgCz0uGzkyCRlyDZUAohrbzEzS1kp-RLFGbqg68o1tjtkzwA
Message-ID: <CAN5EUNT7co=ucbBRykXdLJDUdewvoh+cMVbbOOUuRTrv7j2u5A@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH v2] graph: add --max-columns option to limit
 displayed columns
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, karthik.188@gmail.com, 
	jltobler@gmail.com, ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, 
	chandrapratap3519@gmail.com
Content-Type: text/plain; charset="UTF-8"

Thanks for the feedback!

Junio C Hamano (<gitster@pobox.com>) writes:

> "making it difficult"?

I'll correct the typo

> If this <n> refers to the width of graph part only, the option name
> should hint that fact somehow.  Perhaps include the word "graph" in
> it, or something.  As you use the verb "limit" below, perhaps
> "--limit-graph-columns=<n>"?

> I would call this output consuming 5 columns for graph part, not 2.
> For end users, being able to specify 2, i.e., being able to say "I
> tolerate wasting display columns to show up to two ancestry lines"
> (or "two lanes of ancestry information"), is indeed a lot more
> intuitive than having to say "You are allowed to use up to 5 display
> columns", so I do not object to an option that takes "2" as its
> value and produces the above output, but I am not sure if we want to
> have "columns" in the name of such an option; "--limit-graph-lanes=2"?

Yes, it only affects the graph rendering, I'll change the name to be
more clear about it is for the graph only and that what is being
modified are the lanes, "|" + " " not actual single char columns.
What about --graph-limit-lanes and make it imply --graph as you said
if it's clear enough?

> Isn't "no information is lost" a huge exaggeration?  We are losing
> the ancestry information by not drawing graph lines, aren't we?

Yeah, I meant that most of the commit information is not lost, only
where they come from if it's a deeper hidden lane. But what I wanted
to say is that internally I'm not removing any information about the
graph and that every commit will show no matter the lane limit.

> IIRC, Gitk also allows you to click the chopped arrow-head to jump
> to the other end of the omitted ancestry line, which is very useful
> but is hard to do on a terminal output that is not interactive.

Yes, that's why it's been sooo long without being done prob. But I
think this approach is still useful, it can be extended later for more
customization like limiting the lines from the left side or ranges.
For lane rearrangement I would need to study graph.c more and look
forward to refactoring a lot in multiple patches.

> If "git log --max-columns=77" ignores the option because "--graph"
> is not given, it would be confusing to the users.

With the check on 'setup_revision()' users won't be able to
'max-columns=77' if there's no '--graph'

> This needs a bit more commenting to explain where these magic
> numbers come from; they are of the same value 2 but have different
> meanings, right?  Like this (only to illustrate the shape, not
> suggesting what the contents should read):
>
>                 /*
>                  * Each ancestry "lane" occupies 2 columns, and
>                  * we leave two columns before drawing the commit
>                  * title and log message part.
>                  */
>                 int max_column_width =
>                         graph->revs->graph_limit_lanes * 2 + 2;

the magic numbers are because, a lane is two columns '|' + ' ', and
the +2 comes from the truncation mark '.' + ' ', so for a 3 lanes
limit, the padding from the graph should be 3 * 2 + 2 = 8. I'll add a
comment to doc the magic numbers.

> > +
> > +     if (revs->graph_max_columns > 0 && !revs->graph)
> > +             die(_("option '%s' requires '%s'"), "--max-columns", "--graph");
>
> The naming is so selfish.  Among "git log" options that exists and
> that will be added in the future, this design decision declares that
> "--graph" is and will remain to be the only one that may want to
> specify the maximum number of columns to spend.
>
> If the option is named clearly to be related to the "--graph"
> feature, another way to go is to make it imply "--graph".  If the
> user says "I want to limit the graph output to consume no more than
> 10 leftmost columns", it is clear that the user expects the graph to
> be shown.

I'll make the name clearer about what it does and less selfish. I like
the idea about --graph-limit-lanes to imply --graph directly and not
force it to be explicit.
Making --graph-limit-lanes imply --graph removes the check at revision_setup()

I'll send a v3
