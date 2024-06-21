Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D013783CD4
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 02:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718936687; cv=none; b=hDLvnU+QrLLQ0b/6SO6ROTexv7n0eUd+5hW4jnMhK5qR2zd506/cGQ6apml8RMsR3kKJNmFIUb5AuiyzgNiJRsGNu1HFYX3g7Rz3dJBGrn/M81vOyu7gyWFSRIwx8Lles/iPsqJzpK+Qw0lzZoLeJPBGwYVlDFwwmUUG1ROAILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718936687; c=relaxed/simple;
	bh=6Yv8SgGIGNU3gWzChttUwDb/QReSexNO6aarZPh67qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlJUoKeFf2fJmw0DB8Yrm/LCOaBJwtO38pGCaiEgdzY4pOfsq37oONw1tWmbMZ0TUjTVshWkMzpDzKM8ce8avyqfHHx22H9hMB2A+3sZJg0glKMkaVD4HHI6etmbyUw0UG+NMauIPLliWtNxXdWXoNWUYuCs/A4PukMLUtfLNAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQi4hLyg; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQi4hLyg"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70435f4c330so1387092b3a.1
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 19:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718936685; x=1719541485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=97i7/gexoVi3bCYBzYbp8H5XYZ9OV+CpBR9iccDQ8tM=;
        b=eQi4hLyg8LkUcjNHOGwC8021k7Jl6I7Iv4GpYgellGWWBcUx9q7HPY66tVFLa1JX7p
         H2+VtFUlPpAzFf/b7RXj3kMbPlQDN7/iBdYuDv3utsSbeNKNniKPqdXwTwwoDQ8gmtjS
         4yAQlqfdYT9GDBPFXYYNqrcsAp1O2EPfhdfvQk62aG2L74BXvFgcVdc/XQ6jtDUmhLEV
         RSRh1XN3eO/ZqbpmB+g2oLESr7kLku/u1bOrzeRVt2L+mxsPqU736CpMSxX17drdLtot
         fv6VuJakAX/k+FmzfnvXG3vMPBW18VIda62+QjtuU+NNCQEPsXZFq/NGmRK6Hz9V7UdL
         lCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718936685; x=1719541485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97i7/gexoVi3bCYBzYbp8H5XYZ9OV+CpBR9iccDQ8tM=;
        b=IYeNoP7L6bgFGOkl+SUmvjIKV9oyLGakfnmca0KKYsG67wMOtqKSE8PJLbGp51tawK
         0387mZxPUzzQWEFdRE9onjmmuK04bBcF8IdPT2K9kN7+0C7tS5grcU2q+Ws6d/zD1z0M
         /klgVpAVGPcNWCvZbk5VSk8pGvLqAMQYGYuaKEzj0CEp5RTERf+ktTD9+MdVRXwdFd+b
         Y94/LwG96j5LchKK7NU4uNC4Fy88XpPKZxnWYC6LGFeMlu+lgxafRGi8clR5nl3WFk7n
         f3GWu/mmn2vGOTheN2vVeET7U2vFfyBA98QzWT9mu7870+pL3lultgdbhbzfZSr1jM4b
         Jdzg==
X-Gm-Message-State: AOJu0YwSJh1uQPHAVc8Epf7+QvE9+5rjgjgNSTWPj7F3/z6M0mCTJ0J0
	wTFJ55KDOOniQbAgDd8kTQydCJmwC6M4FFKAWzHyH8IGYHbl7dcJ
X-Google-Smtp-Source: AGHT+IEHGxZ6rkO5jRxvTc9GEKbXOEj1B/ioIslt4tK0xEgo1MknB2+AXQeShf0cf/dH2tgfl7q4UA==
X-Received: by 2002:a05:6a20:2a21:b0:1b5:8ecf:4e7c with SMTP id adf61e73a8af0-1bcbb665465mr6802083637.62.1718936684875;
        Thu, 20 Jun 2024 19:24:44 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819a8f786sm390021a91.34.2024.06.20.19.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 19:24:44 -0700 (PDT)
Date: Fri, 21 Jun 2024 10:24:42 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v4 1/7] fsck: add refs check interfaces to interact
 with fsck error levels
Message-ID: <ZnTkatbhit7vAwwO@ArchLinux>
References: <ZnKKy52QFO2UhqM6@ArchLinux>
 <ZnKLja6bSNLukkTR@ArchLinux>
 <xmqqmsnfwmqy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmsnfwmqy.fsf@gitster.g>

On Thu, Jun 20, 2024 at 10:24:37AM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:

[snip]

> This seems to be doing too many things at once, making the result a
> lot harder to review than necessary.  At this point, nobody checks
> refs and reports problems with refs, so fsck_refs_report() has no
> callers and it is impossible to tell if the function signature of
> it, iow, the set of parameters it receives, is sufficient, for
> example.
> 

I will split this commit into multiple commits in the next version.

> Stepping back a bit, it is true that (1) all existing checks are
> about "objects", and (2) all checks we want to implement around
> "objects" and "refs" can be split cleanly into these two categories?
> 

I am sure that "objects" and "refs" checks cannot be split cleanly into
two categories. Let me elaborate more about this. The git-fsck(1) has
already implicitly checked refs. When executing git-fsck(1) with no
arguments, it will call "builtin/fsck.c::get_default_heads()". It will
traverse every raw ref and use "fsck_handle_ref" to check the refs.

	struct obj *obj;
	obj = parse_object(the_repository, oid);
	if (!obj) {
		...
		errors_found |= ERROR_REACHABLE;
		return 0;
	}

	if (obj->type != OBJ_COMMIT && is_branch(refname)) {
		...
		errors_found |= ERROR_REFS;
	}
	obj->flags |= USED;
	mark_object_reachable(obj);
	return 0;

git-fsck(1) firstly scans the object directory to check every loose
object. If everything is OK, it will set "obj->flags" like the
following:

	obj->flags &= ~(REACHABLE | SEEN);
	obj->flags |= HAS_OBJ;

When an object is marked with "UNREACHABLE" and "UNUSED", it will be
dangling.

When checking objects, git-fsck(1) still checks the refs. But from my
understanding, the main motivation here is mark the "USED" flag
because we want to tell whether an object is dangling and BTY we check
refs. So, we cannot really classify into these two categories. But we can
classify into these two categories from action view. When checking refs,
we look at the refs options; when checking objects, we look at the
objects options. Although we may implicitly check some other things,
this should be OK.

So, I think "fsck_options" is only about options. Because the nature of
the connectivity between refs and commit objects, we cannot make the
boundary so clear.

> I am wondering if there are checks and reports that would benefit
> from having access to both objects and refs (e.g. when checking a
> ref, you may want to see both what the name of the ref is and what
> object the ref points at), in which case, being forced to implement
> such a check-and-report as "object" or "ref" that has access to only
> different subset of information may turn out to be too limiting.
> 

Should "check-and-report" does this? I am doubt. There are some cases we
do look at both object and ref. But "report" should not do this. The
flow git-fsck(1) does is like the following:

	if (some_thing_bad) {
		ret = report(..., message);
	}

Here, "check" will provide dedicated message to report. So If we really
both look at both object and ref, the caller should be responsible for
that. Like the message "refs/heads/foo points at
f665776185ad074b236c00751d666da7d1977dbe which is a tag". The caller
should produce such message. It will call some APIs to get the
information and pass it to the "report" function.

> Yes, I am OK with having substructure in fsck_options, but I am
> doubting if it is a good idea to have a separate fsck_refs_report()
> that can only take "name" that is different from fsck.c::report().
> 
> For example, how would we ensure that refs/heads/foo is allowed to
> point at a commit object and nothing else, and how would we report a
> violation when we find that ref/heads/foo is pointing at a tag,
> i.e., "refs/heads/foo points at
> f665776185ad074b236c00751d666da7d1977dbe which is a tag".  The
> fsck_refs_report() function is not equipped to do that; neither is
> .refs_options.error_func() that only takes "name".
> 

Yes, I am not satisfied with current design either. Actually, there are
many redundant code in new "fsck_refs_report" function. Let's look at
"fsck.c::report()" closely to see what it does.

	static int report(struct fsck_options *options,
				const struct object_id *oid, enum object_type object_type,
				enum fsck_msg_id msg_id, const char *fmt, ...)
	{
		va_list ap;
		struct strbuf sb = STRBUF_INIT;
		enum fsck_msg_type msg_type = fsck_msg_type(msg_id, options);
		int result;

		if (msg_type == FSCK_IGNORE)
			return 0;

		if (object_on_skiplist(options, oid))
			return 0;

		if (msg_type == FSCK_FATAL)
			msg_type = FSCK_ERROR;
		else if (msg_type == FSCK_INFO)
			msg_type = FSCK_WARN;

		prepare_msg_ids();
		strbuf_addf(&sb, "%s: ", msg_id_info[msg_id].camelcased);

		va_start(ap, fmt);
		strbuf_vaddf(&sb, fmt, ap);
		result = options->objs_options.error_func(options, oid, object_type,
								msg_type, msg_id, sb.buf);
		strbuf_release(&sb);
		va_end(ap);

		return result;
	}

It will get the current message "msg_type" which would be configured and
it will convert the "FSCK_FATAL" to "FSCK_ERROR", and "FSCK_INFO" to
"FSCK_WARN". From above code, we can easily know what would the error
(warn) message be the following:

	'object: fsck_describe_object(o, oid): FSCK_MESSAGE: message'.

The "fsck_describe_object" aims to provide meaningful message about the
oid. And "FSCK_MESSAGE" is "msg_id_info[msg_id]".The last field "message"
is the caller-provided message.

So the hardest part to reuse this function is that it receives the
parameters related to object such as `oid` and `object_type`. Actually,
the "fsck_refs_report" could generate such information "refs/heads/foo
points at f665776185ad074b236c00751d666da7d1977dbe which is a tag" like
the following (I use string literal for simplicity here):

	if (some_thing_bad) {
		...
		ret = fsck_refs_report(o, "refs/heads/foo", FSCK_BAD_REF_CONTENT,
			"points at f665776185ad074b236c00751d666da7d1977dbe which is a tag")
	}

It will generate the following output in the current design:

	error: refs/heads/foo: badRefContent: points at
	f665776185ad074b236c00751d666da7d1977dbe which is a tag

So my idea is that we just reuse the "report" function here. The bad
part for current "report" function is that it is highly coupled with the
object check. However, my idea is just like the "fsck_refs_report".

	<name>: <FSCK_MESSAGE_STRING>: <message>

Thus, we may unify the report interface both for refs and objects. And
we don't define two differtn interface:

	1. "fsck_refs_error"
	2. "fsck_objs_error"

Also, we just need to use "fsck_refs_report" and "fsck_objs_report" to
wrap the "report" function here to avoid redundance.

> > +int fsck_refs_report(struct fsck_options *o,
> > +		     const char *name,
> > +		     enum fsck_msg_id msg_id,
> > +		     const char *fmt, ...)
> > ...
> > +	va_start(ap, fmt);
> > +	strbuf_vaddf(&sb, fmt, ap);
> > +	ret = o->refs_options.error_func(o, name, msg_type, msg_id, sb.buf);
> > +	strbuf_release(&sb);
> > +	va_end(ap);
> 
> Perhaps the code and data structure of the entire series may be
> capable of supporting such a check-and-report, but the primary point
> I am making is that among what [1/7] adds, we cannot sanely judge if
> these "refs" related additions are sensible by looking at [1/7].
> 

From my above reply, I guess the current design gives the caller
extensibility to provide customize message. All we do is make code more
clean without redundance.

> Thanks.

Thanks,
Jialuo
