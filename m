Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2AA195811
	for <git@vger.kernel.org>; Sat, 11 Apr 2026 01:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775872756; cv=none; b=f7gJAwbyrvnB1QDg9jo/XTm/+dvrWF+fCY6gOR99/2EAG3Qv84ZPmF+xGkkOEs5gJpeFrY23fxOkDB3kMhNLEtXo7gUB3s8Cv31qRFVK2LkUmqZxi0wJdFKj+ehGXR62dEeWhl5Nzj+tSF5e3i4k1/kZdfQrjPkohyqzXHXZ3bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775872756; c=relaxed/simple;
	bh=cTMWaXSbG7t98qOUFP8K10/O9zBGgZBhlOS1Jp58S/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwmjJEye35AYQzqVwoyyIj/JAtjUE7yzwgW/ppEsFsUEXRfNuQHRQN7eb0pJIsndYUfNGfOGRlxLjcntla18NgMg1GnyRdlrzRAhd/TFv+NL6FX1pzhX6wYxrUJcG1f6evYdprucyeqrDjvNNP4EcqF77yT8YlqajKlQBrHRwsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlzTelDZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlzTelDZ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-483487335c2so28092535e9.2
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 18:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775872753; x=1776477553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=js7H+KM8Dst4U88sfuqVZ5Tz4DwQsJLSt6QcQCHFrT4=;
        b=OlzTelDZIhIjZ5xTTLblqTQKSCSLlzBwnO2M86GsZn+hiR3JD/q4S5t+W/eeQAMU5c
         yoUh9VnU1f8F69RPSu5rZ62FiT16Q6y99vqa/lL+LIM1r5Yv8yM5pxyhtmh/gEKwMgEF
         jopE5KAE0fMWMi022tvINNO8SbIGAhluU7RngvGgfN+j9a6MQ2xrQRlGVQtsKuh7Rqvx
         WjmcodAniUiSOG4g+3a7dZITLXwR0Fwf8GI3hJLcxAIQxs7XZhsGSnbtxfAbaHoQok0B
         Y9GrYZdvFjldUFjknuZYiYzCoObzZnFJ5705DM5oVFIQb/rExKORshwESfupIxGyEF76
         DS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775872753; x=1776477553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=js7H+KM8Dst4U88sfuqVZ5Tz4DwQsJLSt6QcQCHFrT4=;
        b=W31svnj8BihrO5YnA0YmLvgH0NJeYaYQnhE88owopylYOvBX6WG8SU/CZsREdGDxYp
         J2hpvph+0ba9RBIMDG6n9xaoyqhDv2WGsyp14SB4xAroZwvFc1CBuDlEWIcRIOnFUVvr
         LNVDMPrShJ5O+27gcdP5nxeBy33Eel7/UUABJvA073Tndyulm3hrUMiQA9kGVaZ0Shyc
         sdpmLIOYSe4PJlqRWkLsb//Y4YKQza1UG/RJMUvJzq/TTTbY9BJhySfwd4qAW3aX7W1J
         AeilMgPI30ofd0IhLu+Q8Tc8YNpPn9fgnkykiRxJRu1ypWhtcEXmXfMNvdn16PXKtcNb
         I/DA==
X-Forwarded-Encrypted: i=1; AJvYcCVzL0m7ZtUqx9LxpIg/goU3aA94PULhaqk/4+oCQoMFQqDhGcAw8/PIwzykL4n/9Nju6h8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK59C8Xllw6U7TaQ0CWVRO0MVFj0X/n8aMo2aMmD+Qd+6tjKfE
	yvu5hrn7MiGG6sC1JUZa6yIqg6m/Z4Qkx9aESgu000tevpjXxKslSI2dO8i8pUSIe2o=
X-Gm-Gg: AeBDietjLJXXi+WrulBW9R0ty3Z9Fkp055WkT1Q2U64xAG2J77Y+iNudQaG56r3H35t
	dP5Gk3EGKGjt7bijKVXtW7pAV5a3NtN9mwM8nf62kpUMMI1TxPfv/ZeB+01i52Vvc0a2tNvmXKv
	68gk/9eJ8YF5gWtPTKNgGBKdyRY6DFYEiuupBJw0OHuPKE6VLs2s9eG2yO4tcGls5rCQ/+4gagJ
	/iaYFCV/pV9TLrS3+MsBsr8RDB8EgAUXUylN7Ycx1Wbj4Yv91ZLB4uhQ/7PLdZnsU8elrtWlHUb
	2fXTJbMkZ8oKnUjrRyQ/E5guzLp+W/WLafw3lM+Lp2miQjmIbprLR268YgvKcr/K5KPlesmTe+b
	ZEU4ghHL1PUPwrgEIMu0pwQDJKcpAxYP2gHDyX1ecQdYdjcwqf8xVN1ftyQYLXoBLTrKrj9oHVB
	QPslITh5Z5BLWvD6XwR52AVpaNV4Idht5E
X-Received: by 2002:a05:600c:8883:b0:488:b87b:3052 with SMTP id 5b1f17b1804b1-488d689b400mr49561155e9.29.1775872752521;
        Fri, 10 Apr 2026 18:59:12 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5347ea5sm128843775e9.8.2026.04.10.18.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:59:12 -0700 (PDT)
Date: Sat, 11 Apr 2026 03:59:09 +0200
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Tian Yuchen <cat@malon.dev>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC PATCH v5 2/6] repack-promisor add helper to fill promisor
 file after repack
Message-ID: <admq7TA9sEPjskO5@lorenzo-VM>
References: <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>
 <3558bb38956b522c91057598db645eb42ffb48b2.1775861047.git.lorenzo.pegorari2002@gmail.com>
 <xmqqo6jqmlzz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6jqmlzz.fsf@gitster.g>

On Fri, Apr 10, 2026 at 04:30:40PM -0700, Junio C Hamano wrote:
> LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:
> 
> > +	dest_pack = parse_pack_index(repo, dest_oid.hash, dest_idx_name);
> 
> parse_pack_index() has this comment:
> 
>         /*
>          * Parse the pack idx file found at idx_path and create a packed_git struct
>          * which can be used with find_pack_entry_one().
>          *
>          * You probably don't want to use this function! It skips most of the normal
>          * sanity checks (including whether we even have the matching .pack file),
>          * and does not add the resulting packed_git struct to the internal list of
>          * packs. You probably want add_packed_git() instead.
>          */
>         struct packed_git *parse_pack_index(struct repository *r, unsigned char *sha1,
>                                             const char *idx_path);
> 
> The function can return NULL, but this caller does not seem to be
> prepared for it to return NULL (i.e., the loop introduced by the
> repo_for_each_pack() macro we see below, nobody assumes dest_pack
> could be NULL).

That's true. The function is created assuming that the promisor files
are correctly formed, but this is unrelated to the promisor files
content, so it should be checked to avoid any issue. I will add a
`die()` if `parse_pack_index()` returns `NULL`, since this means that
something bad happened considering that we literally just created the
pack that we want to retrieve.

> But what pack index file are we parsing here?

`parse_pack_index()` is used to create a temporary `packed_git` for the
just created pack, so that we can then check if <oid> (for each line of
each ".promisor" file) appears in it (and then append that line to the
".promisor" file of the just created pack).

> Isn't it already part
> of the running system that we should be able to find on the list of
> packfiles in the packfile store?

No, the new pack's `packed_git` doesn't appear in the
`repo_for_each_pack` macro loop, if that is what you are asking.

> Is this because we lack "find a
> packfile on this packfile store by name" API, because what we want
> to find if each of <oid>s we have appear in the particular packfile
> or not, and packfile_list_find_oid() is not sufficiently precise (i.e.
> "the object appears in one of the packfile on the list" is not what
> we want to know, "the object appears in this particular packfile" is)?

Yes, it's pretty much this.

> 	Patrick CC'ed primarily because this part of the API and the
> 	data structures have been reshuffled to add quite a lot of
> 	abstraction since I last looked at the area.
> 
> As close_pack_index(dest_pack) does not release resources held by
> dest_pack itself (even though the region of mmaped memory that is
> pointed at by its index_data member is unmapped), I think that is
> where the memory leak is breaking the CI jobs (see my other message).
>
> But I am not sure if the use of parse_pack_index() - close_pack_index()
> API is the right thing to use here.

I struggled a lot to understand how to deal with a pack opened with
`parse_pack_index()`, considering that this function is only used once
in the codebase. In the end I decided to simply use `close_pack_index()`
as it is done in this other instance where `parse_pack_index()` is used.

Having done more research now, I realized that the issue is that the
code is missing a `free(dest_pack)`. With this line, no leak happens,
and all GitHub Actions-based CI tests are green.

Also, I think that `close_pack_index()` is indeed the correct way to
close a `packed_git` opened with `parse_pack_index()` (instead of using
the generic `close_pack()`, or not closing it at all).


Finally, having looked more deeply at that other instance where
`parse_pack_index()` is used, I believe there actually is a possible
memory leak that might rarely ever happen. Isn't there a `free()`
missing, like this:

---
 http.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index 8ea1b9d1f6..e765852071 100644
--- a/http.c
+++ b/http.c
@@ -2446,8 +2446,10 @@ static int fetch_and_setup_pack_index(struct packfile_list *packs,
 	if (!ret)
 		close_pack_index(new_pack);
 	free(tmp_idx);
-	if (ret)
+	if (ret) {
+		free(new_pack);
 		return -1;
+	}

 	packfile_list_prepend(packs, new_pack);
 	return 0;
--
 
> > +	/* Open the .promisor dest file, and fill dest_content with its content */
> > +	dest_promisor_name = mkpathdup("%s-%s.promisor", packtmp, dest_hex);
> > +	dest = xfopen(dest_promisor_name, "r+");
> > +	while (strbuf_getline(&line, dest) != EOF)
> > +		strset_add(&dest_content, line.buf);
> > +
> > +	repo_for_each_pack(repo, p) {
> > +		FILE *source;
> > +		struct stat source_stat;
> > +
> > +		if (!p->pack_promisor)
> > +			continue;
> > +
> > +		if (not_repacked_basenames &&
> > +			strset_contains(not_repacked_basenames, pack_basename(p)))
> > +			continue;
> > +

Thanks Junio,

Lorenzo
