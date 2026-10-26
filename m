Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793037508;
	b=Z1AxlL8v0PtK1/TdZIOhkk3Ocue0Eiyjy/AX2XeXzEmpYKpf2cqvnwLobFmBBGWssrqq
	 m7zuBYYpTF/wP/MkoZRhm7z7e8tY3aP+FnrxXLQ6wr0YuGs66rtDlTs7Ows7gFaTMpizo
	 SqdvxPGZaJwFWvhOitWC87PKx2QVh76GT3NvsP8iBQ5qM/Q8TrYF0DS6EwRkXbvhpK/Hz
	 YbfnUWFAIqk7tqCXk9RryjYVRWRfhMNctedTNo/a+qqWmKAq7kwPATVKsW7hYOworR5+X
	 B2Vx7NvWB/JLY6KZ1gFqBQCYQf3SxutHIWSEQUbJeTwVUDv70I9RHjWJ31Xwm48lJZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793037508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=LHayMuuPibqGWFRe0dqE0TDnGGhahUcg8tUKHoT6UVc=;
	b=4DRN+NiSiBSk1k9gSNSidd0B6P1X5hbC3sqMMpnjohZBuG5sEO0DKsYd7lBrYZuetlJu
	 AjVkjLa58majj9aHn4iwUKVuu+G9whoj0RzVZfTypaXXGgNQ0yCvdbKazzeZ9LHYqRAWD
	 541kQ+mVJ27qU34tZ4Z6Se2BeeKfDVSUvV9f28UbnSKdGbVrZotAbpzqmwGAoeBBj0A3c
	 YQtO6Aluq7cGHBIwaCplbS+GzuRyGhRwxSeVA+rD++CcJmK3bN5XX22qdB8tZmMdmOwvc
	 5XWdPE+jLzmeX5A9Ph2S2jsK0DJFruuheNJ6uMbtYSFToAe3j9jv+Dr+xOCeZOSCAag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aHKaZNUf;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F53606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 17:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70F53606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aHKaZNUf
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-82109f51565so1476923a34.2
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 10:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793037507; x=1793642307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LHayMuuPibqGWFRe0dqE0TDnGGhahUcg8tUKHoT6UVc=;
        b=aHKaZNUfPueWW2vnNpdlJzfoob50kXnO0KYKpPWQtfgnklyspgEV1JZg2uyqLmbtPt
         zI/a3YjytUHpocxp7kiwXY3GV400N40HfuDi1qZltGmqyRm4qs7XXgfdrmR4XFwiLzZT
         EMRyGWcOq/InRe7ACdzN5KAsur0SCG4MjalKYSdju+qf2quFmgIgTLf/bwQA8Z8JCJiE
         L9JQRzs7I+HwA6JJuhplPo4DIQbWR/a8t8qEhkNdTKdxE6G5jHlThVTarQ41zZIaDfEB
         KvdaXMsGzY714lkabyWpZupZ7K0FdqRJ6scK9/X5EXooGJDJ+RScrREei7C3pDcLt+RE
         VSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793037507; x=1793642307;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LHayMuuPibqGWFRe0dqE0TDnGGhahUcg8tUKHoT6UVc=;
        b=NOFZaLRq6L8TBWL7ZgT4NV3a9zYRFgW0hBmVK6On7ko8jNDsFOY1mjpmXbRbqr1NlA
         k7DCoZpYCay162EblL4OJpr3wk5xC45IGQqFJuyi1dhDxnesD3D2ncyCrSxFmYp1FWgv
         FQbw4anKT236ikC3auQR0ok7fUpq7MFOznUVb6b/UXAoeyDHsHb8wumiWfFEukfobbuP
         C2aRT9ycH1qAE3R9N09ZbilYBwmvyCS5AiOaM5G8QwpCNnOrpQ+TRoq7CVEXYvS6WW5p
         LmBB73lGwLugwVjgMvR7fTTr7iX0+Kdkkf6+x+haN4zEVkkymxIjIX7p8AoigmYhz2i5
         hI9A==
X-Gm-Message-State: AFq9FYJe9jNCmAhQhRBElRNEUW+CxJQHyk+X/KiAQr/+pZgyss9rVm1X
	23jJRSVy1VERZS7RdCpkL1OLjeppVCWTOgFMPiBUvIMusXRbKfxbxyJZ
X-Gm-Gg: AYBFou0mxsttFP+Ao73YslgLMGg+ZL5GHmrVGEp/v4mCzDzVy1fP/lPE1oy3eOAhyot
	4rC4irM0cMJht4MtlKJLaxQrpitplW9luIrbApRtmzfLisEliafd5KBvUF+kDkYtH92S4dZBqN5
	E3f4q4Ndtk/B08luWSLaR6MTyeIVAwrmN9wBiN7oEZJB3rhVvaAEDjYMMI+99/NeJzrHDbqXu0y
	HpnWXKA1KAlr0dx2JBHzrvjZciF45Jsi0XMQ83HnGWn1sLYxdFywsRwC6eBOThis9w44YJoLkCD
	NRJLQbf/bTOahOeRC0ukKp7j13z0ApbmE7w37axxNS5arvb00JfWdZgJW+kXV0k/Ohrmj7mqgS8
	8y/1/UwWlshRoB//XZ8E84FWE7fZ1+0TPjrsMOmToBc1w2M8GPitKUA7edZdyRcw7Pt7AsZsXoo
	lOQZm/z7bu5hw9W5XNxQ4QDWeOmf/xhkBb/GxghuIDI6ig+QTtawHdgE9Sg0ElCo5itgXV29ach
	Qj/twduqYAwcTMzqR5bSaFAs5X/op/LHOMCTt0RZ9cr4d3xZ1ubW2F7Aj8rLFVmZx/iWdRXK11C
	yAX+jQ==
X-Received: by 2002:a05:6830:2684:b0:7fa:ab72:9df9 with SMTP id 46e09a7af769-850fdb42e49mr6820068a34.17.1793037507065;
        Mon, 26 Oct 2026 10:58:27 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850f8458a4asm8443055a34.3.2026.10.26.10.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 10:58:26 -0700 (PDT)
Date: Mon, 26 Oct 2026 12:58:24 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] tmp-objdir: merge loose object index when migrating
 tmpdir
Message-ID: <at92UF0G-6R89NPm@denethor>
References: <20261022234007.3081825-1-jltobler@gmail.com>
 <attQtZ1dVoAnQznP@pks.im>
 <atufODWNPJMbvMZu@denethor>
 <at71hkqG7AbVCdnK@pks.im>
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
In-Reply-To: <at71hkqG7AbVCdnK@pks.im>

On 26/10/26 07:39AM, Patrick Steinhardt wrote:
> On Fri, Oct 23, 2026 at 04:25:12PM -0500, Justin Tobler wrote:
> > On 26/10/23 02:19PM, Patrick Steinhardt wrote:
> > > On Thu, Oct 22, 2026 at 06:40:07PM -0500, Justin Tobler wrote:
> > > > +	if (strbuf_getwholeline(&buf, fp, '\n') || strcmp(buf.buf, loose_object_header)) {
> > > > +		ret = error(_("invalid loose object index %s"), src);
> > > > +		goto out;
> > > > +	}
> > > 
> > > Curious. Why do we even expect that this file may be broken?
> > 
> > For our intended use case of reading the "loose-object-idx" file from
> > the quarantine directory and merging its entries to the mapping file in
> > the primary object directory, I wouldn't expect it to ever be broken.
> > That is because realistically only a "loose-object-idx" that we create
> > during the transaction should be written into the quarantine directory.
> > 
> > I chose to be more defensive here because the `loose_object_idx_merge()`
> > function itself isn't aware of the circumstances regarding its use case.
> > In theory, another caller could use any mapping file as the source.
> > Ultimately though I don't feel too strongly either way and am happy to
> > remove it if we don't like it.
> 
> Ah. You mean because we're called with arbitrary paths we want to verify
> whether our callers know what they're doing, and consequently we check
> whether the files look like a mapping file? Still a bit funny, but with
> that context it at least doesn't feel too unreasonable.

Your understanding is correct. This may be more defensive that
realistically neccessary. Probably doesn't matter too much either way
though.

> > > > +	if (repo_hold_lock_file_for_update_timeout(repo, &lock, dst, 0, -1) < 0) {
> > > > +		ret = error_errno(_("unable to lock %s"), dst);
> > > > +		goto out;
> > > > +	}
> > > 
> > > With a timeout of -1 we'll block indefinitely. That doesn't feel like
> > > the best option to me, as the lockfile may be left over from a previous
> > > process. And Git locking up indefinitely feels suboptimal to me.
> > 
> > That's fair. I picked this value purely because I was closely following
> > how `write_one_object()` implements its logic to update the
> > "loose-object-idx" file.
> > 
> > Would it make sense to make this value configurable? Or would it be fine
> > to just set it to 1000ms? If we change this here, maybe we should also
> > change it for `write_one_object()` to match?
> 
> Yeah, I think that'd be a good idea.

Ok, I'll update to use 1000ms in the next version.

[snip]
> > > When merging, wouldn't we have to verify that the object IDs that we're
> > > adding don't already exist?
> > 
> > So typically a loose object doesn't get written to the object directory
> > at all if it already exists and thus doesn't create a new mapping entry.
> > There is a race though where concurrent writes of the same object could
> > cause the same entry to be appended twice. This is already an existing
> > problem though as `write_one_object()` also doesn't verify whether the
> > object is already in the file.
> > 
> > With this patch, I mostly avoided many of these preexisting quirks and
> > just focused on addressing the underlying bug. If we feel strongly about
> > it though, I can change the approach.
> 
> I feel strongly that this mechanism is quite broken in its current form:
> 
>   - The file is unsorted, making lookups inefficient.
> 
>   - We don't deduplicate at all.
> 
>   - We never prune entries.
> 
>   - Writes are not atomic.

Ya, I completely agree. There are quite a few existing problems here.

> The first three are conceptual issues that we'd have to fix to ever make
> this feature usable. But that certainly doesn't have to happen as part
> of this patch series.
> 
> The last part though shouldn't be too hard to fix, and you make the
> problem worse because you add a second writer that uses the same broken
> pattern. So that's a part I'd like to see fixd as part of this series,
> but I won't insist on it.

That's fair. I'll update in the next version to make writing the
"loose-object-idx" file here atomic. I'm not entirely sure if I should
go ahead and update the code in `write_one_object()` to also be atomic
though.

One concern I have is operations that may write many loose objects,
would rewrite the "loose-object-idx" file for each object written. If
the mapping file becomes quite large, I suppose this could create a
significant performance regression. If these loose object writes were
batched in a transaction, we could wait to write the final mapping file
at transaction commit, but that may not always be the case.

Right now this feature isn't really usable to begin with, so maybe it
doesn't matter too much either way. For now, I'll proceed with just
updating the mapping file writer adding in this patch to be atomic.

-Justin
