Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790717;
	b=n8f3iVvOeXUJf9GmLWQKFVmOni3H668kBJnojfNFS41Er00AaaJhWBrbH9CZzmFE23zX
	 P5F/vTq2QrbS1/i02/FRLTYpdSjxf/FHOUSTZmWNX1EXQcy6JsWryY4H0Hk3inkxgKvS9
	 wDmAHC6JBTrWxylWm6C+eh5+1Ji3M0F6y9NN5LlmgaZJyxkoig0ykJnaQRCGASVo1au4N
	 Gv4kECy7LqztWKfndOrpbQaGR65k2tB7rLCzJJnpb1LQ1Apf2wTLHXZgY2xyLTYPL+cuv
	 m8ql9XBOAHCuRHE93daf9iKOBg0aCFpwXqV+s7Dn9UUN9l/p/gZzcupZLx6Bfx4PRZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=z8ptVi8dTppdub7kbdCxz/Mt58sHcDMfzay93AChqMA=;
	b=hOBNTRcBrkXWuVyx7dV5gJKGF0eNITReu6BHJljPbORkIb/B2toNZHRFWitYTihIjhKO
	 iSohGTOzKaP3nBCuMElWQxQULG5KYHXEW32nTQAT4S6PLlSJDScHIxZzhravGTakl8uYr
	 z07OrzsJkMRtMpjfErFV/8owgRuhOArYB4FjWZkmbmxJdQi83BAnfCzxqzu/KHEveGUCy
	 AXYbvCZmrhR/uWRALCUR3Qpa1QPfT0rnbPuvamAaTq7qoEhL68n1deARGkKm/w/JDaG1N
	 1J833Tocu0w6ksXMCe8RvzWwHlfvoBJ9MfbOIGzeQLEstwGIZipzi0PkjLRSqe07rKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mg4xyicN;
	arc=none smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172E5606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 21:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 172E5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mg4xyicN
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4a77761ff8aso737051fac.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792790716; x=1793395516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z8ptVi8dTppdub7kbdCxz/Mt58sHcDMfzay93AChqMA=;
        b=mg4xyicN/4pHnSmezByVbOeo0OlpR75F8FX6aHQhItpKerxFX4YE9+xqXdiUfGnmSp
         t/gx5Uk6p59elJfNCXlCCUgQ89iZmqh02zs2ZtjqVYUACKxTEvxFZwHQjVRicEYz41xN
         3oxkwgEcknH+Ub35AotJ+CFRkR1TImXP3meWDosivt2VDAvu7+Q0XPhscU5/iQmOni04
         MEw/gIuQPuqywMbBjXNTEdNZFc6wVStaJYqaHh6YbD1QNEG55Q5VzqAym8IeHdsD0rAO
         K71mewy9oFS7S+Yuyb4DsYv7Y+D87+SvtAqmijCBAW8wDZuWmO6TpaIEGoIo+HaKzDTT
         o+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792790716; x=1793395516;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z8ptVi8dTppdub7kbdCxz/Mt58sHcDMfzay93AChqMA=;
        b=MLc4PWBIF98avCr9XUx+Wi2LQX4IVeox2wKrJ4hLSMUqQpJ0TwLd5cwE0SZwAiZjo3
         XJtzXP5I3iCZpTEeGbVxsgtX3ypq5V1x8bs16XcE32IIpxVGK1mqyO6hDJMumaDqe8Zz
         qpfo7PyZUvtp5aWfFsPR/BmQGbOy9alqRGT1/t+U2gDQAZWBENdcgC6kbVLQIl3RT3fG
         ElmW+4bZ3D4M25W6oS/z4MvOOx9igR3zKUZk47HL24nIynx94f0qPCW0ZzsOyQmMSeqg
         v25NWb6VjyWtSq54Q8djbuEHIQaKFMQR3baFwEo5LaE9vTnTJlVB/opXjSPLCo8xQpOh
         2OXA==
X-Gm-Message-State: AFq9FYKeo/qp/CZAuz5KyP2ZSMS/GZzMKTQ6ILOcwG2jULZQBUI/nxbJ
	rIcqISEFh/NSW1YogTdoA7VlvzAQ6YVZRNXakUTuQPXA9mfABG4THOPa
X-Gm-Gg: AYBFou1ylMb35P3e2O+fLSv0SttNy1eGfRoKLssSOMprk2o2UPh4om2J5Q5tRE3tS5B
	nRYczQiSLCt7fHcxBlF5K3YePmo5whoj3KbZdc6OIs2Tx+bmFfL2/gW7JIUT5mE2R2JmEvXGd4q
	t9Mn7gJ/bhOZC1M0JRj+MS8nGC6yD+0wEBgxJScZvT/3z96HgIE70Sx8LWiInHQgWKEsC2MBFi8
	x+NVo0JRD9VeY1I/MvDaT/FPwy8+syAb7WYG0Cywwp2XF6+3Ib5TpqnoBngQsxpz+5RNZRc+Am7
	DATG0aNoWWEj76Q5U3VfcdwI26Sy35EV6Q8jXjTllVm+AU/K4IbktNHJkEMnUKtYK19vPhxkKNj
	h0+Zr9YSn8tzVhAD121JM4xetexrCJevXVz3YhvKjCNpAkr7jLokMGFLlZvHW3wLhsElPUYhAjK
	YU5GC1xtvBnOqI5Zp9FkPWZkpk7ixPi6ze9AwsiTbKPG0YmlNa1HUYQ6oXWLO8NYDR0wSebygzI
	i+YCBwSkSNjLOSlqoHO904QD5V6VOV6v/5za4SY632jokAqnPgpQHVfRrGkq5uxNgmJCSg+w4D2
	+oWa
X-Received: by 2002:a05:6870:1690:b0:490:f2cf:2977 with SMTP id 586e51a60fabf-4a83f5159c3mr456428fac.45.1792790715663;
        Fri, 23 Oct 2026 14:25:15 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a84322d21asm111909fac.16.2026.10.23.14.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 14:25:15 -0700 (PDT)
Date: Fri, 23 Oct 2026 16:25:12 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] tmp-objdir: merge loose object index when migrating
 tmpdir
Message-ID: <atufODWNPJMbvMZu@denethor>
References: <20261022234007.3081825-1-jltobler@gmail.com>
 <attQtZ1dVoAnQznP@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <attQtZ1dVoAnQznP@pks.im>

On 26/10/23 02:19PM, Patrick Steinhardt wrote:
> On Thu, Oct 22, 2026 at 06:40:07PM -0500, Justin Tobler wrote:
> > When a repository is configured with a compatibility hash, each loose
> > object write also records a mapping between the object and its
> > compatibility hash in a "loose-object-idx" file. This index is located
> > in the same object database the object is written to. If batch fsync of
> 
> You probably mean "object directory", not "database"?

Ya, "object directory" would be more correct here. Will fix.

> > loose objects is also enabled, the loose objects and index file are
> > instead written to a temporary object directory and expected to be
> > migrated to the primary object directory when the batch transaction
> > commits.
> > 
> > While migrating the loose objects works, the "loose-object-idx" file is
> > unable to be migrated if an index already exists in the primary object
> 
> The naming really throws me off, "index" to me is our staging area. What
> this is is a map. But oh, well, cannot change that now.

Agreed. I may change the commit message to call it a "mapping file" if
that helps in any way.

[snip]
> > Some other approaches I considered:
> >   - Storing the uncommitted object mapping entries in the transaction
> >     without writing a file and only writing on transaction commit. I
> >     chose to keep writing the temp index into the transaction so that
> >     child processes that write to the tempdir could still append entries.
> 
> Is that a theoretical scenario or do we actually have cases where a
> child process wants to write data into the quarantine directory, too?

I think a git-receive-pack(1) can spawn a git-unpack-objects(1) child
process and write loose objects into the quarantine directory.
Consequently, if a repository is configured with a compatibility hash,
these loose objects would also end up writing mapping entries into the
quarantine.

> >   - Also writing mapping entires to the main ODB loose object index.
> >     This also didn't seem like a good apprach because it write entires
> >     that may not ultimately get committed.
> 
> Agreed, we shouldn't commit this before the actual objects exist. I bet
> we don't properly handle this during housekeeping either -- or at least
> I never stumbled over logic that prunes mappings when pruning the
> corresponding objects. But that's a problem to solve another day.

Yep, there doesn't appear to be any existing logic to prune entries from
this mapping file. It can only grow in size. This seemed like a separate
problem altogether though, so I didn't bother tackling that here.

> > diff --git a/loose.c b/loose.c
> > index d6a2bb5ba3..79d4c256e0 100644
> > --- a/loose.c
> > +++ b/loose.c
> > @@ -265,3 +265,75 @@ void loose_object_map_clear(struct loose_object_map **map)
> >  	free(m);
> >  	*map = NULL;
> >  }
> > +
> > +int loose_object_idx_merge(struct repository *repo, const char *src,
> > +			   const char *dst)
> > +{
> > +	struct lock_file lock = LOCK_INIT;
> > +	struct strbuf buf = STRBUF_INIT;
> > +	struct stat st;
> > +	FILE *fp;
> > +	int fd = -1;
> > +	int ret;
> > +
> > +	fp = fopen(src, "r");
> > +	if (!fp) {
> > +		ret = error_errno(_("unable to open %s"), src);
> > +		goto out;
> > +	}
> > +	if (strbuf_getwholeline(&buf, fp, '\n') || strcmp(buf.buf, loose_object_header)) {
> > +		ret = error(_("invalid loose object index %s"), src);
> > +		goto out;
> > +	}
> 
> Curious. Why do we even expect that this file may be broken?

For our intended use case of reading the "loose-object-idx" file from
the quarantine directory and merging its entries to the mapping file in
the primary object directory, I wouldn't expect it to ever be broken.
That is because realistically only a "loose-object-idx" that we create
during the transaction should be written into the quarantine directory.

I chose to be more defensive here because the `loose_object_idx_merge()`
function itself isn't aware of the circumstances regarding its use case.
In theory, another caller could use any mapping file as the source.
Ultimately though I don't feel too strongly either way and am happy to
remove it if we don't like it.

> > +	if (repo_hold_lock_file_for_update_timeout(repo, &lock, dst, 0, -1) < 0) {
> > +		ret = error_errno(_("unable to lock %s"), dst);
> > +		goto out;
> > +	}
> 
> With a timeout of -1 we'll block indefinitely. That doesn't feel like
> the best option to me, as the lockfile may be left over from a previous
> process. And Git locking up indefinitely feels suboptimal to me.

That's fair. I picked this value purely because I was closely following
how `write_one_object()` implements its logic to update the
"loose-object-idx" file.

Would it make sense to make this value configurable? Or would it be fine
to just set it to 1000ms? If we change this here, maybe we should also
change it for `write_one_object()` to match?

> > +	fd = open(dst, O_WRONLY | O_CREAT | O_APPEND, 0666);
> 
> I don't think it's a good idea to append data under the lock. It may
> easily cause us to corrupt the file in case the write succeeds
> partially, only.
> 
> Our usual pattern here is to create the lockfile, write all data into
> the new file and then rename it into place.

So here I was also following how `write_one_object()` handles writing
its mapping entries. I was trying to keep the `loose_object_idx_merge()`
and `write_one_object()` approaches similar. If this really isn't the
write approach though, I can explore adapting the patch to follow our
more typical pattern.

> I'm also a bit surprised that the file isn't sorted. Is a reader
> expected to always read _all_ mappings?

I was surprised by this too. From my understanding, readers are not
expected to consult the "loose-object-idx" file directly, but instead
consult an in-memory hash map that is loaded from the file. When an
entry is not found in map, the file is reloaded to try to pick up any
missing entries.

I see this a preexisting quirk though and am not sure it is something
that needs to be addressed as part of this change.

> > +	if (fd < 0) {
> > +		ret = error_errno(_("unable to open %s"), dst);
> > +		goto out;
> > +	}
> > +	if (fstat(fd, &st) < 0) {
> > +		ret = error_errno(_("unable to stat %s"), dst);
> > +		goto out;
> > +	}
> > +
> > +	/* Create the loose-object-idx if one does not already exist. */
> > +	if (!st.st_size && write_in_full(fd, loose_object_header,
> > +					 strlen(loose_object_header)) < 0) {
> > +		ret = error_errno(_("failed to write loose object index header"));
> > +		goto out;
> > +	}
> > +
> > +	while (!strbuf_getwholeline(&buf, fp, '\n')) {
> > +		if (write_in_full(fd, buf.buf, buf.len) < 0) {
> > +			ret = error_errno(_("failed to write loose object index %s"),
> > +					  dst);
> > +			goto out;
> > +		}
> > +	}
> 
> When merging, wouldn't we have to verify that the object IDs that we're
> adding don't already exist?

So typically a loose object doesn't get written to the object directory
at all if it already exists and thus doesn't create a new mapping entry.
There is a race though where concurrent writes of the same object could
cause the same entry to be appended twice. This is already an existing
problem though as `write_one_object()` also doesn't verify whether the
object is already in the file.

With this patch, I mostly avoided many of these preexisting quirks and
just focused on addressing the underlying bug. If we feel strongly about
it though, I can change the approach.

Thanks,
-Justin
