Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A850A3C4165
	for <git@vger.kernel.org>; Tue, 26 May 2026 06:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779778647; cv=pass; b=m9hlw4PkTo9zwYksmcKw0NgfNw+xqFi4OGKr5+jIJdEfQb0ys6u3VcjEO8yD/kcHKRnJmjzFency+tOhy3EJBPQZ/mhVRqASgPiJReVlvt478/Cz2Cd/G2cmF39KyZ7+qpKBRGAhgAMqBqtqvRVLzBurFdjr9v++9cXO7+5rWWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779778647; c=relaxed/simple;
	bh=JW7zEogw0eWVXGo8q06AcSdRFAnNOl/yYm2oYrVAAU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqzLHB4lZtI5tHdezLdn+nWuBEL1+CBCJMOF5O83FG8OTRWjIvRelobGdeJLZvuL3lsOxHyNcalXh1t+TgVS57Xq7S4BlJkWMJr1Sawkt0T4WbUI4N3KIeEFpjUviecrLW/C2bJMUJcz6uHz3C7Sfls3mbyVug9ZIWxMsvn/R7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=TuCSZ1Y1; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="TuCSZ1Y1"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7bd5e373d07so110046037b3.2
        for <git@vger.kernel.org>; Mon, 25 May 2026 23:57:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779778644; cv=none;
        d=google.com; s=arc-20240605;
        b=CFOPqFx+c1y4GU7EvQ/CQiI4QKzGlB1/8EsP4PfF9FndUSEABlbgA/ghLo9wbZgyZm
         fPRhKbQ+ztgcDu2wviUeSFhQ0Gr5rQ55xeRzTw650aUaWSP+62pMbQBcNnevdkUuNJp/
         6QktJUwwJqBdCvaJkSXFb+KDgPvb322Vef9iGJOHSoRuR8OuKanrzlXNM0517MjbJ5dV
         ty84pMEFowGNzhFDu+bghGthtjiy29ni39ff06y+d9IQNg6VqKZVvO8neo8GJl1qr2Rv
         oXkOGLXAUt4BQ+/0xWS7kXK4UxlnnwZsZZs62EkSxBzlx/pwhQB24EID1IfAZD6mfB1t
         SjhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JbvoZcUjk6dIZQpOhVpYvyUHfd6mkcdRNMXNEhdRbW8=;
        fh=ag8nvRGLAlzV8SJ2QYWUEBOCU8mnEfgU8n6NlGudEi8=;
        b=GYHNFYE8RPv5/OdYcpexfwtgELCU1BtJrk8kAqvNmlyz/oG0cOckMF1+n7J0B169kI
         0WyU4tFhzXxLqApocr7EPOi6AfdC6exv1zf5ZWG385Iye1J2S4VBM1T5sUw+obl7kCet
         3AUJiCGxhaqiSa1TOYHqRzkp1Q6KO5e+sh3vPohQuO46tsj6lFEEOkTBfihMeAIf5qlI
         hi7RzGI2p5h/M6tpQJ4P1zHDlXD6t3RDOuDfArE42Si/IK8xndksGduLtQKPpblMr4ES
         A7GZpHXf59bkHjm0qH13Ej5W/1G5Ttb+czNHHZ8BX9bJCah/petGaenFKCA3NRdAv3bJ
         mXqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1779778644; x=1780383444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JbvoZcUjk6dIZQpOhVpYvyUHfd6mkcdRNMXNEhdRbW8=;
        b=TuCSZ1Y1oa2t1avmL1Q2re4uTwRIk38ewHHPtnZ6gUABjSrzoQpx+aawuY/4MTYtoU
         rNF71lnJ9eG0mRDsDEpzAxYGrFjTN13cTDiTMwWgMIZkgTbnY0Pb0KPp8g1SAPv4zUmt
         RUn8T72BZIrQQRDbfMsWrtd5j96mvL2bGaGCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779778644; x=1780383444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbvoZcUjk6dIZQpOhVpYvyUHfd6mkcdRNMXNEhdRbW8=;
        b=OhoTtgtOnrPm5bqygkqoEmABc6m6xvOmzGwdHBywB8DH0CxQ8xU/L9bAqoUoPTo0Gp
         ho7mhbjqv9/boMWOhsIvEOZwNU3fjJ8ZTkI47GzonULVk+iye9JaluSe0C/N37Y2khZr
         DzhfbIhq+Hqv3fPmxxoHuM1jBG2ninQxknx0SkdKUsEE+WLEmRYK9F2Heoranp7T2xSs
         6d8n11/3OFsEdPRFk+KHcd0C8siyL9/grVjG37D0OW0aOgHJMc/whiraV1hPZR1nzD/6
         8WVthd4v1M79eUBeziHIVozcfUn3ZQmu2M9mSwAZ3S5lETKvFzY2ywtAVGzrmn75EFlM
         5wdA==
X-Forwarded-Encrypted: i=1; AFNElJ84KA55jsigL4mZGCysNJKznSKnipxSc+roXWmId6OUs9wZ+LDvwLwqOjvnZAgtPDcmf4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzx2csFEdK4l13OtOP30a4gFMOyKDGfQGuBMEX5d4osJCzrIVL
	0kwyCV7cffZR/Ln79uhh71hV5QL2SIKPRVMHqyM22C3878QZKnB2+MFtjiW4TS0MqcrJSaEJt7l
	08s5E8gbjQ1NoBS+fEADLKtUOcA9hLw79WIKHWd9ivQ==
X-Gm-Gg: Acq92OFcTPgsPJyAMgZ8KlfLNJw9WijNITME6rrl6JQp5Vc0gtoU3K9DDy6d2yzcaHl
	sEROHlpFE+FuSjqlS4iSZkSufJC9wQ5n3hdVgqOglJNMNa5nVk3eyxSi4Nmb2S0RI1WiSLXdVq+
	6ABhFxNkNbOnd6lxLo6MovY5loyFnUk/2u8iNAeqbrr/AWXcpKqpeg04ZIMjIuGbstfBI4b1BgF
	Mo3ZajaH8PudeTqXZSy7hKiisZg8/ewqfc9w6XIqnfIoZEcWDbKEqFmvGs33nrcM/SPW6uYcae3
	WEYX
X-Received: by 2002:a05:690c:360d:b0:7d0:1583:4cb7 with SMTP id
 00721157ae682-7d3353e09a5mr185314007b3.15.1779778644651; Mon, 25 May 2026
 23:57:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
 <pull.2124.v2.git.1779719286.gitgitgadget@gmail.com> <fc38c0f856e93b80073ec3f1b9f641b9ab187e4e.1779719286.git.gitgitgadget@gmail.com>
 <xmqqzf1ncded.fsf@gitster.g>
In-Reply-To: <xmqqzf1ncded.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 26 May 2026 08:57:13 +0200
X-Gm-Features: AVHnY4Jrs-hI5SqTTnpu9SfghY6137TcnuRO3daRobwsrOWzpzgu5BuPD_8KMFk
Message-ID: <CAL71e4OFniTMgG2Sj3LDMdfdZzYh-J71maNcWaobEHri9ox43g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] commit-reach: deduplicate queue entries in paint_down_to_common
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 May 2026 at 00:50, Junio C Hamano <gitster@pobox.com> wrote:
> OK.  I guess an obvious alternative design would be to have an
> associated hashtable for deduping, or tweak prio_queue_get() so
> that it notices duplicated entry just before it returns (i.e.,
> peek and discard until queue->array[0].data is different from
> what you are going to return).  Both would not beat the cheap cost
> of using a single bit per object, I guess ;-)

Yes, I think a hashtable or hashset would work here too. I realize that I
have done a lot of local experimentation with alternative approaches but I
forgot to mention the ones I discarded for various reasons - but that
would be useful information for you to have too. Let me rectify that here.

oidset instead of enqueued flag: Works fine, but is ~15-20% slower end-to-end.
Both are O(1) but the overhead is quite significant compared to a flag.

Peek and discard: the problem here is that the commits are not necessarily
ordered. We can have a sequence of A,B,A if we are unlucky. What I did try
however was an alternative to this - just change the fast-exit heuristic to
overshoot until comparison returns > 0 - i.e. consume some
extra commits in the queue. This works and in my example data we typically
would only need to walk ~16 extra commits with this heuristic, so it's not
bad at all. But the extra comparisons we need to run on each iteration make
it ~15-20% slower.

Another thing I tried was simply tracking the minimum generation seen and
terminate as soon as we have gone past it. This is fast and simple and does
not require deduping, but it only works if we have a commit graph and
generation numbers.

The advantage of the approach with deduping via the ENQUEUED flag and then
just tracking the most recently enqueued commit is that it works independently
of ordering guarantees. All it needs to work is the fact that we can prove
that we have reached a point where queue no longer has any non-stale commits
at all.

Summary:
  Approach        Dedup         Works w/o commit-graph?  Speed
  ENQUEUED flag   yes (1 bit)   yes                      fastest
  Hashtable       yes           yes                      15-20% slower
  Peek-discard    -             -                        broken
  Cmp overshoot   no            yes                      15-20% slower
  Gen overshoot   no            no                       same as ENQUEUED
