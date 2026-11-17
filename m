Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.106
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794929305;
	b=W/BXAwYgOwvGEbrhwxJbBKYrJxJXcCu4kCnALhBkGe5vrU9sy5fz7j2bv/wRdeKOcvCj
	 Z3aB3qT0I+bVvcxlywhVmPVf3N3LycvpIw3ZzL20lEOIavZDJQUcP/suMNAHkwrboA5IV
	 8a6c4rCoGKcuxlsLybudPkC33EDAV84k/J17Q7XZJyTZPH/kiaLYtnX5ZNpVmHjAwhV/z
	 shMMNu+hMuVE9yntIOYywYqt0sQ+ItWFHooO3OvcypxzGgGcd4pS5tCJPOn1Qlr1U/e6k
	 1bSRPDjpFFD5+KD039iYfbDQ4DuriQDxWXmFw2Sz3nK/LmqCu3FlK39lvuUQRjtXRvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929305;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=9AHG8MyQHsX/BmJJ2jZ1iG8BrcRWvqtfJ62RaOXFAgQ=;
	b=4UBre0ZuXfcnLjgFzQdwAHxcxmr0rTzuF8uVluAYpjot4+9htQ1JBTA1iApXdYD44O+s
	 pnDtWIGt5qm9wkdOM5V68q/pz0z31Dpewr6LwgmdEIzB+wscj7kgML9l3kqG/en9YzkEe
	 y/m0clw00n9/K/tKx0sRhpc1AQwuE2sNwj3FH0pQtyUcrGHmVZQOwObxera1q5Zp32sAm
	 OtQ6StwfIQW9vmbqPHPxmZRhqC4ikwjz2X2c+cP/JREXkD2xJL6jxpoPNdJZO48QhbaIv
	 FyjZgOBt1S/70uPw8UTfOYpI8desKcrJ31JO+1zS5IWpGiY1h17YtbihWY5KbGb5n6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=VGJ9dLSa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.106
Received: from sender5-pp-e106.zoho.com (sender5-pp-e106.zoho.com [165.173.182.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F674606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 15:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F674606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=VGJ9dLSa
ARC-Seal: i=1; a=rsa-sha256; t=1794929270; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OguAYc3i4upUDXB0kF2YaZtMH7yE04s7YGNHDLHh+saMOsrHRTUGnvTzMtSA669VFaLA8NeQAu/O1xgFkNoVd4sKsUj3tyBnwY3BZDFwevH0PN8+t2hRxf6UmyFWcKpqW7+ElZIk/AAnNiHH3H3p4U+91Jf4BPovZaBX+eXPxoc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794929270; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9AHG8MyQHsX/BmJJ2jZ1iG8BrcRWvqtfJ62RaOXFAgQ=; 
	b=fbr78HsJLSEqXinXMLsinNS0hWqHB0jUV3NfB03wS2+EYWlS6KaCnLt/9LHVT7yXWJZB5xY2785oVpfvoU+nS061KsVTLJXub8H/n4vBSk+Zwj30rJeW/D26aH7Tpf0K/meg2/HAfLKHOMbh1uBuPy9OPgD67OcU6LTONOXdxuc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=VGJ9dLSaRcqvHDD7Bsb3qEm0MzXoPNPIbe1Trq4CmZebUGq95FKe2hZtDnygNP8SA25v9akS+xtHx90ZskcsH8+Ggqj+6bz8DdJFUri7oWZLC+YyOXWS8w1nnZAskM8u5vw0zPmrhXyoNeBMTMeQI+BcR2cPzz0MwWdLWssydNg=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=9AHG8MyQHsX/BmJJ2jZ1iG8BrcRWvqtfJ62RaOXFAgQ=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794929268411249.93374720290637;
	Tue, 17 Nov 2026 07:27:48 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, "brian m .
 carlson" <sandals@crustytoothpaste.net>, "Eric W . Biederman"
 <ebiederm@xmission.com>, Axel Rasmussen <axelrasmussen@google.com>, Emily
 Shaffer <emilyshaffer@google.com>, Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH 3/3] object-file-convert: copy unknown commit headers
 unchanged
In-Reply-To: <avqypRLPLZZFNqRs@pks.im>
References: <20261112195740.2834341-1-adrian.ratiu@collabora.com>
 <20261112195740.2834341-4-adrian.ratiu@collabora.com>
 <avqypRLPLZZFNqRs@pks.im>
Date: Tue, 17 Nov 2026 17:27:42 +0200
Message-ID: <87cxs3jx5d.fsf@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 16 Nov 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Thu, Nov 12, 2026 at 09:57:40PM +0200, Adrian Ratiu wrote:
>> In a repo with extensions.compatObjectFormat, Git converts commits
>> to the compat format in two places which disagree about headers they
>> don't know:
>> 
>> 1. When a commit is created with commit_tree_extended(), as
>>    "git commit" does, convert_commit_extra_headers() copies unknown
>>    headers unchanged.
>> 
>> 2. When an existing commit object is converted (git hash-object -w)
>>    or when it's read by its compat id, convert_commit_object() fails
>>    on them instead.
>> 
>> So git hash-object refuses such a commit, while git commit --amend
>
> s/git hash-object/git-hash-object(1)/
>
>> records a compat id for it that can't be read back:
>
> s/compat id/compat ID/
>
>>    "Failed to convert object from sha256 to sha1".
>> 
>> The rejection was added in 08a45903cb (object-file-convert: convert
>> commits that embed signed tags, 2023-10-01). Git can't know what an
>> unknown header holds. It might hold an object id that needs
>
> s/object id/object ID/
>

Ack on these and all the other ID / spacing fixes, will do them in v2.

>> converting, so convert_commit_object() rejects all of them.
>> 
>> Some tools rely on such headers though. Jujutsu, for example, writes
>> a "change-id" header in every commit, so none of its commits can be
>> converted.
>> 
>> Make convert_commit_object() copy unknown headers and their
>> continuation lines unchanged, just like convert_commit_extra_headers()
>> so both give the same compat object.
>> 
>> The author, committer, encoding and gpgsig headers were already copied
>> the same, so their separate cases are no longer needed.
>> 
>> A "tree", "parent" or "mergetag" line with nothing after the keyword
>> used to be rejected as unknown and is now copied as well. Such a
>> commit is malformed in both formats anyway.
>
> Hmm. I guess this here might raise some eyebrows. I guess it makes the
> code simpler, but I wonder what the benefit is of converting an object
> that is so obviously corrupt...
>
> ... yeah, after reading the code we'd have to introduce a bunch of extra
> logic to make this work as expected. As far as I can see though we _do_
> reject "tree " without trailing data, but we wouldn't reject "tree"
> without the trailing space.

I looked closer and v1 actually copies "tree " too, because of the
(bufptr + 5) < eol check, "tree \n" never reaches the tree branch. :)

I also found I made mergetag worse: a "mergetag " line with an empty
first line and the tag in continuation lines is also copied, so its
embedded object ID ends up unconverted in the compat object.

Git still treats that header as a mergetag ("git show" reports
"malformed mergetag") and "git commit --amend" refuses to convert it, so
v1 makes the two paths disagree again, just in the other direction.

I can fix this in v2 by changing the three checks to <=, so the
converter classifies headers same as read_commit_extra_header_lines(),
by the key before the first space.

So:

"tree ", "parent " and "mergetag " with an empty or bad value are
rejected, as before this series.

"tree", "parent" and "mergetag" without a space are not those headers as
far as Git is concerned, so they are copied like any unknown
header. That is also what --amend does with them.

I'll also add a test for the empty mergetag case.

>
> We could fix that by introducing a generic format check:
>
>   - The line must have at least a single space separating key and value
>     of the header.
>
>   - The key must only contain characters of a specific set.
>
> Otherwise we might be too lenient and also accept data that doesn't even
> look close to an object header.
>
> But whether that's all worth it is a different question, as said. It's a
> corrupt commit anyway, and we cannot address the root cause of that
> corruption here anyway.

With the above I don't think we need it. A check only in the converter
would reject headers that read_commit_extra_header_lines() accepts and
"git commit --amend" keeps (e.g. bare "x-foo" line), so amend would
again record compat IDs that can't be read back.

If we need such rules, I think fsck is the better place (today it
doesn't look at any header after "committer"). It's a separate topic
though.

>> Alternatives considered:
>> 
>>  - Reject unknown headers in convert_commit_extra_headers() too.
>>    Both paths would then agree, but commits from tools that add
>>    their own headers could not be used in a compat repo.
>
> Yeah, that's certainly a direction we shouldn't go. There's way too many
> tools nowadays with widespread usage that write such unknown headers.
>
>>  - Copy only headers known to hold no object ids. Every tool would
>>    first need to get its headers added to that list.
>
> Agreed, that doesn't seem sensible, either. We don't want to be the
> gatekeeper of who is or who isn't allowed to have their own custom
> header.
>
> A third alternative could have been to try and recognize commit IDs
> automatically. E.g. if you see a 40-character hex string then we treat
> it as a commit ID. But I don't think that's sensible, either, as we
> shouldn't interpret what we don't know.

Agreed, unknown unknowns are such a pain.

>
> A bit of a side note, but I have been wondering multiple times already
> whether we should fix this gap by introducing a well-known object header
> prefix that tells us that the value of that header is indeed an object
> ID, for example something like "x-obj-foobar <oid>". That would make our
> commit graph extensible by third-party-tools without us having to
> understand what that tool even intends to do with that, and we would
> know to treat such object IDs as reachable.
>
> But that's of course a topic that is well outside the scope of this
> patch series.

Yes, I'm trying to keep this series small and just address the immediate
bugs / breakages, to avoid it balooning into 10+ patch series again. :)
