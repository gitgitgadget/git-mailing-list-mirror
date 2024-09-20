Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8201D1E521
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842127; cv=none; b=n9bkVW6d0lS8YwMb/90EFD8c7qSRemY7fTTT+XClcb4hTDol3oG9xV8JJooR4KhN5uc6xToJCp0hQxoSKhYtb5YURdH9M41yzdHmmQIHvbaI8O2eZAz9SBfyyAmWHzcjPs6d4PG4UIEm6SFfQUa553wkXIJsZdnJrZnzZ4uqb40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842127; c=relaxed/simple;
	bh=JkR9atTMAZECaGiuLmHusINrp0LouZjngJ47fU4gMbk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZn603vbsZJ2OSkkrtJHZeBphZrOKhmlmQUK6YAhLBGGNFs+cWkuZjwrO/GPir3i+syQs5TchVFj7EVP+6UhNMiA11lAtIMdZQcW4GE0NtYuAfymwNL3vzeDuIl+XIjab2k03/lcb9OYe9dot1rEY9UEZMcYZR9+QnIHqo7a4vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=fdT92RRc; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="fdT92RRc"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-82aa7c3b3dbso113526939f.2
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 07:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726842124; x=1727446924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9zy3YzMZNyD+HH2CiMSiFvlr1ZUp6WyU2dgqwMYmG5s=;
        b=fdT92RRcr+GxVZKNCHLe1JKIL9IRF/rQJ9PCw7k560Ax6FdFgGG147WGAsSOnwOL4N
         f25Q8VNMtvo2eqmsdGMrxIO94+fJCet61fsI6OE4WV26ZQEDpNGML+5TPawUGgYhCd20
         LMSgmmOAXw+FApfvRUzxXENLTtlzd+E44DeF1F+THCNiUTyc6KNgTG0CfAbW9leHZlRR
         OuXSksLWbeLnriU54oM1Jq9I5SjrTZ5uHT0AkI2YMhFJhPHrsZcQ2g4MVjBy+/EHylZI
         aCESqHMyLWSU6sGLODqS4P5KLGpeoKU4wJM9KT98qwgOImdwA4/hFFNQlMhXKhru/AFm
         qGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726842124; x=1727446924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zy3YzMZNyD+HH2CiMSiFvlr1ZUp6WyU2dgqwMYmG5s=;
        b=UQQnx8auptctWF2d/Jbc88ovr164zv8jmjSK1pchLENcG+sJPoFbnZ/DwWp5XypQYO
         95V89VkStZQN9k8RPc7ls/PVZNTJDIRT3orTIQnc4msBxZtf4tU7lc0JhQX/3Ozif92b
         jiifzMWLKfCIfa581peQwiTIR0ilgny1dj/++pODllKosgmn9c6wJxUpK6ogygOTGlbG
         RtGM8zA36bSKYvvbvhMBIqSq5nuqmlULGM7Fv+gp90JcxJLkLmDVH9L7WxQ1eW7hKwr3
         jYYh4GMnQq4rMfp9d+gSPsomPXJXwSnwRs0JDc1NbjkERt7+gggIu4UoNoMYFnOxhyEo
         1beQ==
X-Gm-Message-State: AOJu0YyBvL8l7wC6Fvqe22efTXZlpUdeaoBZUmHcjGz6p1CKoCsXSPIQ
	pGMMyxPRrqzKFTra7BbbPP3U+1jA+vGzV+VuNSY0KnJvJk7Wtg9YmbPlBnakrr6ZWFA5ixRLXc6
	Gi8g8EQ==
X-Google-Smtp-Source: AGHT+IHhlUb34bRfJwwb/6EmflEFtzPr8ZjXQ0HYBvacJQTLcnmzRwVEVZM+AuEgc2Jn/fauRXcMEA==
X-Received: by 2002:a05:6602:628b:b0:82c:edd4:f0a6 with SMTP id ca18e2360f4ac-8320b31a9c4mr248861839f.12.1726842124064;
        Fri, 20 Sep 2024 07:22:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82d492b34b6sm379610239f.23.2024.09.20.07.22.03
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 07:22:03 -0700 (PDT)
Date: Fri, 20 Sep 2024 10:22:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [TOPIC 09/11] Bundle-URI on fetch / resume-able clone
Message-ID: <Zu2FCF+BOrshAzxN@nand.local>
References: <Zu2DmS30E0kKug2a@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zu2DmS30E0kKug2a@nand.local>

Bundle-URI on fetch / resume-able clone
=======================================

(moderator: Toon; notetaker: Taylor)

* Toon: we have bundle-uris, which allow us to download bundles before
	cloning. What would it take to do them on fetch, too?
* Toon: Complex; you might end up downloading a lot of bundles that you
	don't need.
* Toon: there was a bundle token that could be used by the client to
	determine whether or not it needs the bundle. Unfortunately, since you
	don't know what amount of history you're missing, the bundle in and of
	itself may not be sufficient.
* Toon: How do we make bundles more efficient on fetch and aware of what
	the clients do and don't have.
* Johannes: In VFS for Git, the set of bundles is "opinionated" and
	regenerated often (e.g., weekly, daily, hourly, etc.). We don't really
	care about oversharing, because it's fast enough to download those
	static files.
* Toon: That's true for the server, not for a singular client.
* Johannes: right, but it's to protect the server. If you don't care
	about having too-big of a bundle, it's OK because you can just fetch
	the last hour and then see what you still need on top of that.
* Johannes: there is logic to determine what you need to download based
	on the time that you last fetched, etc.
* Elijah: are they thin packs? Yes.
* Patrick: the heuristics that we have to advertise what kind of bundles
	are on the server is not sufficient enough to determine which bundles
	the client may or may not want to download. The client must guess.
* Jonathan: ISTM that the property list for the bundles as they are
	today should probably be considered a starting point (as in "part of a
	feature"). The heuristics need to be extended.
* Jonathan: at Google we use packfile-URIs, and one of the advantages of
	how that works is that since the packfiles are advertised after the
	normal fetch negotiation, you get a curated list. For bundle-uris,
	need something analogous to the fetch negotiation for the client to be
	able to make a similar decision of which bundle to download.
* brian: extending the feature to store timestamps, then you could store
	the last fetch on the system would inform some better selection of
	which bundles to clone down during a fetch.
* brian: Would make a big difference for folks in environments which do
	not benefit from reliable Internet connections.
* Toon: Sure... but you have to put a lot of pressure to keep those
	bundles up-to-date on the server side.
* Jonathan: one of the advantages of bundles over packs is that they
	have information about the references. One potential property could be
	"here's the length of this header" and then having the client download
	it to examine whether or not it wants such a bundle.
* Patrick: probably would want to cache those on the client so that
	we're able to avoid re-downloading these every single time.
* Toon: resumability
* Jonathan: protocol supports it, just hasn't been implemented. Someone
	needs to just get it done. :)
* Beyond that, the main complication is how you store the state and what
	the UX is for resuming. But a person implementing it can figure those
	things out.
* Brian: broken-proxy situations require some configurability of where
	your bundles can be downloaded from.
