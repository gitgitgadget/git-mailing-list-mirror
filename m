Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CF838CFFF
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 02:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774490474; cv=none; b=aNwSOuTRu7ftDr9Dd3c0rvWJ9lgLhZeivg6ePxJzJs6+jQgkY51cZ5yZwBuzKwF3oVz0FOdAw4aZK5JiarMlAK+Qi378Ikj0szdxDrjC1S3Rc7RDz+uTdUWLwq49G7JxtQ+327PWnBZUCPCeBEeCGGOPQPXs3QUpWSzezH/Org4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774490474; c=relaxed/simple;
	bh=W+K07ohit+w9bDjI78fh5uWF0HAuyGMdqjd7cFxtIZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mgnwa9qQoj3VrFA1hxLHakzWrsCLYY4axy+qjbhasAyQYnlb0bwl4jwBBTObaqEM4nmeIiE72B5gfYn26eIunD8nwb7J0NfnVAdim7gYSU6IhJZQH1xJWwv+/gMte8wijp2WKBWdEnz4ijSPjXjYUUMeLgGtZxDEedj6f7es+pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5w/PwHA; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5w/PwHA"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b7ff8fe92so215385f8f.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 19:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774490470; x=1775095270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5UFq2yfcTdspcWYFvRzxgrynzgHWXIv06emgPUFOOm8=;
        b=Z5w/PwHAsKX6NzzcREVflspH+g1TVrXe9i5hEbfIyFTJn9nv331TagSH3Hpi9P05Dk
         JRe7MwkEkseFTFUno+VJo0ZFL5BuEJTFiyLS3KxOSFBsPJ7xcu61y8/yqT2ALJ6HmlAJ
         p3S2SSiobjKQk+rwfVMz7b7ti9cNWAN7ZF2wP93BicdWMSAohbYL9txtOGJq9yfVpiFg
         VXG7ryzOs0oWCExui4gG8E7DS1de/MvIrAjkYn4VOQT7q0KqCKAnHJu3DOx3cqi/jHjY
         3qeB+B8+KhA9lXx3B2okvfF4Jc99hpydJGDPd1fwqkZ/nOTEm0E0qe3wZLr2dHhAmfQ/
         jgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774490470; x=1775095270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UFq2yfcTdspcWYFvRzxgrynzgHWXIv06emgPUFOOm8=;
        b=MtOehpy69CSGRUk4+PRK7RTmH7uKdBZpLjEwsT51RSBpSBpTSGXf2LWSdxGgfXN+9j
         seMWvt89iYhX9kKCKELI6yvDRCvTcqmaNg79SDyyWQkZ/BND4Lj0nVm9+yFhJIJuOG/e
         V+p0aTAirL9EgjMkjXSEFcsc+cscTqBimknaXl2XFNSaeLw7vglJjo7LJI7trQEDUzEs
         aw4VFO3/wdBcWEb79lSBvd+2bCJ6ZHbqqt5RKQO+1tBOPCMYeLe4057qhpw684X0c9ab
         UvloP77EYq+ybHp6rAZpy19o28oGjqGILF8d+A80t7XhXR2vHFBatcGO+beBUzSOwO7Y
         jyyA==
X-Gm-Message-State: AOJu0YyWdcPcoU1qKpsA4pM9hbQdtEYKughyui7+iFoVblRhXaHkimnu
	U5Rnx1PITThUQUAlu4rTm/kbbRwt91fT79rE/1Jp8ZPC81UZ7V88dhv6
X-Gm-Gg: ATEYQzz85atUuf7xkDs35tVcSbhxO9Ao/PiidExtx6XPM6JoOlysddptVZnaxuMFvka
	71AmZP2Uwl7vpkVnraqHAYX0+HQlHNjLD1DN9fPjWKGzZFbGkoiWq6c6qgD7g3sJsFZEroBsH7N
	btJNZuxDgnVSb8b/YQtF+7MQ3NW1tOoYjYTG7+jGvc3NPKnxXYl/Qo3FdQ3PAqMROKSsoXe4/R9
	oiT4mQM6qGrpusU9e+xtLHxdcRistAigooJ/jFtgtguGMdnwOKNBSVrMyQxJPqKvc6SrqWgbjDT
	dXV93xtQhgPA8Sek6Yn15TwdMUSBej48usZ9xPFFgqvJJnLYA3zE3Lv60v73OVPS1G+JXzRMDkR
	oz4D/pkpCSLSKwemXpNVX4WxbA8jpJTZBf9QIDfGmF+hPbMdBEgAwoGVFj67f61atD+xfPFjHib
	a+6BuXL73qxRaHsaWRREFNrks0oXAeuMDH
X-Received: by 2002:a5d:634a:0:b0:43b:8ee9:165f with SMTP id ffacd0b85a97d-43b8ee91723mr4390420f8f.53.1774490469414;
        Wed, 25 Mar 2026 19:01:09 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919e7372sm5225745f8f.34.2026.03.25.19.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 19:01:09 -0700 (PDT)
Date: Thu, 26 Mar 2026 03:01:07 +0100
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC PATCH v2 2/4] pack-write: add helper to fill promisor file
 after repack
Message-ID: <acSTY_i4zAueN9jD@lorenzo-VM>
References: <cover.1774125871.git.lorenzo.pegorari2002@gmail.com>
 <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
 <0bb031e7443bb53abbbb0afaa347285d6d8cf7b8.1774205661.git.lorenzo.pegorari2002@gmail.com>
 <xmqqfr5q44jx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfr5q44jx.fsf@gitster.g>

On Mon, Mar 23, 2026 at 02:30:26PM -0700, Junio C Hamano wrote:
> LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:
> 
> > Create a `copy_all_promisor_files()` helper function used to copy the
> > contents of all ".promisor" files in a `repository` inside another
> > ".promisor" file.
> >
> > This function can be used to preserve the contents of all ".promisor"
> > files inside a new ".promisor" file, for example when a repack happens.
> >
> > This function is written in such a way so that it will read all the
> > ".promisor" files inside the given `repository` line by line, and copy
> > only the lines that are not already present in the destination file. This
> > is done to avoid copying the same lines multiple times that may come from
> > multiple (redundant) packfiles. There might be another better/cleaner way
> > to achieve this.
> 
> In the previous step, we extablished that these "back then their ref
> X used to point at object Y" records are there so that we can
> identify which refs were fetched at the time the packfile was
> downloaded to help debugging.  When repacking, losing these records
> certainly would lose information.
> 
> But would concatenating all into a single file help preserve the
> useful information?  Don't we need do better than that?

Yeah, we absolutely need to! That's why I said that I was not satisfied
at all with the patch (in cover letter of v1). I really needed some
feedback, because I knew that I was doing things wrong.

> A NEEDSWORK comment, as was discussed in another thread or two in
> the recent past, is not necessarily a well thought out fully
> finished specification of an additional piece of work.  "We know
> this has a problem, we may need to do something about it, like
> concatenating to save the contents, perhaps?  We do not know the
> answer, and we do not bother thinking it through right at this
> moment.  It is left to the future developers to figure it out" is
> what a NEEDSWORK comment is about.
> 
> Your first response to such a comment may be "yeah, I agree that it
> is bad to lose information we added to help debugging", but the
> second one should be to wonder if the "like concatenating..." is the
> best approach going forward.
> 
> In other words, we should take a NEEDSWORK comment as a mere
> starting point, and what NEEDS your work begins at thinking what
> needs to be done about the problem raised there.

I fully understand this! Honestly, my biggest weakness that I've
discovered about myself as a dev (through past open-source experience,
e.g. GSoC'25) is that I get hesitant when I have to work on and submit
a patch if I don't have a lot of experience with the codebase. This
happens particularly when I have to take a decision, and not only
complete a task.

In fact, I decided to work on this specific NEEDSWORK issue to get more
experience on promisor remotes (the feature that I want to improve in my
GSoC proposal) before the GSoC coding period... if I get selected, of
course :-).

I will try my best to improve!

> By mixing them up all into a single list, you no longer can tell
> when their ref X was observed to be pointing at object Y anymore.
> You may have two packs originally, with a record for "ref X pointing
> at object Y" in each of them, but by deduping them, you lose the
> information that you cloned at one time, and made an additional
> fetch on another day, and the fact the ref X was pointing at the
> same value at both times.  I am not sure if it is a good
> implementation if the objective of this topic is to preserve
> information that is useful for debugging.

My reasoning was based on the (wrong) assumption that it was impossible
for the same record fo "ref X is pointing at object Y" to appear
multiple times. Obviously then, deduping them is the wrong solution, as
it will lose some debugging information.

> I wonder if it helps to append to each line the file timestamp of
> the .promisor file we took the record originally?  For the sake of
> completeness, we could consider adding the filename as well, but we
> can quickly dismiss it as not so useful ;-)

Related to what I said before about getting hesitant... I actually
thought about (pretty much) exactly this! My original idea was to add
a timestamp of the current time when the repack happened. I discarded it
because I didn't want to add any new information (for no particular
reason tbh) and because I didn't want ".promisor" file content to
potentially become too long if many repacks happen.

Your solution is much cleaner compared to what I originally thought of.

> If repacking already repacked promisor packfile, the records would
> already contain such a timestamp at the end, so the code to copy
> existing records must be prepared to see if the records are the
> <ref, oid> tuple, or <ref, oid, timestamp> tuple, and act
> accordingly.

Makes perfect sense.

> I am *not* saying that without such a "preserve timestamp" column in
> the record, copying existing records to a new .promisor file is
> useless.  But we do not see any explanation why the author thinks
> that it is sufficient to copy existing records while silently
> deduping.  We can implement only one choice backed by series of
> decisions like "timestamp might help" and "original filenames would
> probably not help", and the design should describe what was
> considered and rejected (as opposed to "we didn't think things
> through---we just did what the original NEEDSWORK comment suggested
> doing").

I 100% agree.

> Thanks.

Thank you Junio for your time and feedback,

Lorenzo
