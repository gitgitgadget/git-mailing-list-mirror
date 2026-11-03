Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728907;
	b=bDdv/uH18EIX1g92ilJs5c3ngIXoWcbmoJ9LBdkG0shjFP4ntNMiZuUJFdfIKECAGj7/
	 FQIPdv4UPDGd1FfoFBBpKFCfyqYaGbAZXF3nYH1UUqxh71r4MAZIFYO5dQAHeUy6Q8NJp
	 Re/KiU0n9C9pNdOmxixHon0tuP5V3ZQXSHsMp+0C2FME5l86BzUXMcrQ4fqCJ5SNav9nt
	 1asvEG8KZOOh/6kiA8xDgZbJOlVcJ3/s2JF3hJ15Qw2zbObBoCxE1XJiCurTHcpaumw/j
	 O4HqQ1pdxAhCzUyvQQa8RJUxQc+4GeQbUxHprLTiL5p3xoOnoRJMq8V1D0BjPHxzvaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728907;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=aZCKfPEtVFJqd2+3nhtlwX4hl8ffgEJkDOpx30HKOP4=;
	b=eJyet/uZP4RG2eoMwpbI/T2BR/6nSAXoCEMyVi0VM244Flw2ZytYmYGCgmuF/KsOEQXG
	 L5n0nTER+BvVuNfSPkvCsLBCRxTymD0DYGOnXuxNuEtmwaQloYBUXRxc08H5oS3GDmpYp
	 xOQ2c0wepCxEAANUjdaNWp4V8zhWUqQWVFF336tenrXi5FMgvJW42kS9Hwjynbda3TsPD
	 OuWhMl9Z8+WcoCnkdOVGmqKyx1KVznK5NdBtPWJHx3w/GTL3v0ZrqjHWMsY58WQgU/wvg
	 06kjl3hygsmz2u5/tQKDwoI/ClWSXESNZa0+hv21BGUG5TU1F/17vNjjfLv5wn/Lw3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=VipEx2KQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=b4HUKP9E;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2DE606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 18:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F2DE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=VipEx2KQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=b4HUKP9E
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BB152EC05F8
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 13:01:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 03 Nov 2026 13:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793728906; x=1793815306; bh=aZCKfPEtVF
	Jqd2+3nhtlwX4hl8ffgEJkDOpx30HKOP4=; b=VipEx2KQ3m3XXtMUmFzQkfI7j6
	giCxB1Cytw8K8esce423SPaQm9MCTG6f+LzXIWW10K/0xBbEu2zZonDNHAVLOCbn
	BUUklhl+r9kS5QXVb4sZ9ejES4X8sMpNUXB2v/2Yhmcu4Bwyae7th0rW8UhyXk+6
	mYv5Ao4SHf/8oBkaFU37LzmA5CKU4sOKgU1ZnQUIUhgcU30ik4+GHOx9kHq3O8fr
	WES8kdnvBrhrp/pQZHjVk/fqmojvEUwwbAEf4F40MwilTMXxfmNHCjaB+tJ7b920
	WmpwxpbNrSOSG5mNkvpzidLwGcHenuG2xuXXIXa+/rEMkyEd/nNieAqaiJ9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793728906; x=1793815306; bh=aZCKfPEtVFJqd2+3nhtlwX4hl8ffgEJkDOp
	x30HKOP4=; b=b4HUKP9EBodKFBJfIgxEiAbSTsEROQZdeJGr84rRoq01y/VstSq
	DL8dGijtQSikBs5WF0VZs1Kbh9QxZE8RYmwBOZvpYQi2ekJFBv6YXFgPZ5lxoDlm
	6yYWfIM2bxjmSAK+z0koXEcfC18zgkaiWTSAjJc3xH13nb7pMDEeEMa2+W+bUpx2
	JXzfULrB8fA2LC8inpazUvjRPagy5CKiypC6gZahuHwP3EGC/f9LqI25dUOBD4Rg
	PTzRP1Bcn5dgPyo+6ePUUauD3ZCYX51+s7OxlxrYMJNqINVXZkkVl1HSAivpGz4T
	tmRdoQqFhBnc2xbp3wzEcIyCoursMcAv+uQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793728906; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:FRvLZRqW09j9ghOAKfLd6WeVDeweTDnj+CWSqPOEbIzcWh2
	dp27Hbu6EOO0wuTXiXgn5fxXDp0pM7xGRj3fNY+Owz5Q5oOj3zwYMees0lATXYsd
	tHu57JJBcecj75uJFFLfbb54eoXaYfCmVpviRLKEI06RJFMesDTFC5Pbv6NxKnWp
	PNACa/N2yKZ2EWQxOHwZl3oC3UGbzfeLJWfsiovFM2Z9eaZtdwusnEwR9okp9Em8
	ylRiwR15wAMh5+teXqsMZFJHwGL1LCS3WivIxUIviPLWrRVtWmp86AoMve+68dmq
	dCmx/W/WN9g8maDXYrFi8Qpm2LPNVIwbUVo9yWg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:c5LK8g6z88HkAC2HFp0UD7n9pZQ3UIU5R5aE2Hnep5I=:wDn9n2Idrrx663K3ePBmPFFhSOxQcGpX01CC9r05jEQ=;
X-ME-Sender: <xms:iiHqahbIaJWwvIM1102s_EaNCCmnP_L-4QT1OyL3lBjbSe7u8QTduA>
    <xme:iiHqaq_VXHzCqXU7y98sXz3FEU401w0_i-RsTH5K1oFFi4Sz11edAM69stI3NUChl
    H9aCP5TDQUgrEo09Gl_QHKA5APubRKChg_I4hX6VHxcZj7FCrJnzA>
X-ME-Received: <xmr:iiHqankK9KGseXvt4sgTYaWHS2gJ6ldw2J88flqWrQXtMhh1GU01b5ephG5rbl-O7nuNIMj8pZFE_jOao8yoU09vMYyai3fMHCdQ>
X-ME-Proxy-Cause: dmFkZTGG6xqd6bsi50wyxwOSBBjhjDg9gScVaS2uBrA/yIS0e/mQcmA38aLq7BUBislLa5
    Vd/F7jN8hx5b+D7oHY4AgXDklYxRVd3zetPLHn2CHbSJCZWpXTuV3782BIebNpm3Yx2ypM
    ZCDXCQ6Ts0XRMe+zn5qQNhM41jg5RKe3Xz4QltOiO+ity5WN9hfhfz/JMPEGdLKNGymCoX
    yiyc5R+rkAKkKhk2vOs1jHTV8htHgrj4Vwtg1BZH5vmTLqwfYWOWtlFaqZcYEmF9+A7WCn
    +nDEv4qG5d9522WBnSf8j+T0HowyHxOKF/mxg4jkehIQGX5XcNLUef1ks8seVGsaBL9ZKx
    zPHLS1pe9YGBvFkZGnXMVIlx6oZevzI5DIYvEwOO6SxaJdHMxJ5wA7/qIolrfCyb5eWR1C
    k1eLZXtAEcj1rFcKknp8jUCVGe7a8dt9kcK56/ddXdY6yHPxIBYT0Nsnuyiz6xrc5ayiG5
    7PBLJsEkgaqx0dUg4bH9Va4cUIHl3JoC5S85tj5ZbBpjwQ2q4O/BXNSHgAfjVg1DRzxhEE
    U1OpTK4u75D8wafZFYLoLq35JtI5C3SlJaU97zyPS0co3oO+m49e5u5Ipa9Rs7VuedziPg
    sijcfiEsNtNgJ5f6q0AzwRHPxPfIvRJHERqkJK9Nb7M2ZQB4UIF73IbHvqWA
X-ME-Proxy: <xmx:iiHqavzgadkDNdm8jLhMpBhocHZoRcW9m658cPEmpUBheT7OklgrQA>
    <xmx:iiHqah5jBySh5WKgekmw0UkU-8hWXj2c_K4T1tlVXl0-3ctshdrsCg>
    <xmx:iiHqavXde2-FwIrS4mMLV5874KsnULDdG8iE5kfO1nIIXybFl-T5sw>
    <xmx:iiHqapKbCp7ayUTpN6zWL3ODKh8r63VAeJru83cMnmBl23Dg-G1MNg>
    <xmx:iiHqaon-bywW8p2FmLVVOVMs_b1AY2xdVSwsKRy0V_n3C_nQflZV-vML>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 13:01:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,
  siddharthasthana31@gmail.com,  kaartic.sivaraam@gmail.com,  ps@pks.im
Subject: Re: [Outreachy PATCH v2 1/2] notes-utils: use the passed repository
 for notes refs
In-Reply-To: <CAOLa=ZSPHDWAUmqUev9PRdEB03cUW=NWrbXHjRyma6yUmV7Yng@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 3 Nov 2026 03:45:18 -0600")
References: <20261031104526.46711-1-okhuomonajayi54@gmail.com>
	<20261103084930.15532-1-okhuomonajayi54@gmail.com>
	<20261103084930.15532-2-okhuomonajayi54@gmail.com>
	<CAOLa=ZSPHDWAUmqUev9PRdEB03cUW=NWrbXHjRyma6yUmV7Yng@mail.gmail.com>
Date: Tue, 03 Nov 2026 10:01:44 -0800
Message-ID: <xmqqjymt94l3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
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

Karthik Nayak <karthik.188@gmail.com> writes:

> Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:
>
>> Keep USE_THE_REPOSITORY_VARIABLE because
>> init_copy_notes_for_rewrite() still uses the_repository.

Unfortunately, this is a highly misleading comment to leave here.

The next person would be misled into thinking that it would be just
a matter of giving a "struct repository *r" argument to that
function to lift the USE_THE_REPOSITORY_VARIABLE declaration from
there.

Looking at what <notes-utils.h> exports, the file has quite some way
to go to be free from the_repository.

 * create_notes_commit() takes "struct repository *" to pretend as
   if it can work with any repository, but the first function it
   calls is write_notes_tree() that eventually calls into
   odb_write_object() with hardcoded the_repository->objects.

 * commit_notes() calls the above create_notes_commit() and shares
   the same problem.

 * init_copy_notes_for_rewrite(), in addition to having its own
   reference to the_repository, calls load_notes_trees() that makes
   calls to init_notes() that works only on the_repository.

 * copy_note_for_rewrite() calls copy_note() which calls add_note(),
   which eventually calls into load_subtree() that can only work
   with the_repository.

In short, I think adding "struct repository *" to anything in
<notes-utils.h> is not yet a productive exercise at this point,
before cleaning up what is in the underlying things exported from
<notes.h>.

This is a tangent but there are precedents to mark the functions
that still work only on the_repository or the_hash_algo:

    $ git grep 'ifdef *USE_THE' \*.h
    environment.h:# ifdef USE_THE_REPOSITORY_VARIABLE
    hash.h:#ifdef USE_THE_REPOSITORY_VARIABLE
    hex.h:#ifdef USE_THE_REPOSITORY_VARIABLE
    path.h:# ifdef USE_THE_REPOSITORY_VARIABLE
    repository.h:#ifdef USE_THE_REPOSITORY_VARIABLE

Perhaps we need similar protection to forbid use of these functions
that still assume the_repository is available in this file?

 notes-utils.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git c/notes-utils.h w/notes-utils.h
index c54b1fe141..1503991cf6 100644
--- c/notes-utils.h
+++ w/notes-utils.h
@@ -7,6 +7,9 @@ struct commit_list;
 struct object_id;
 struct repository;
 
+/* most of the things in notes.h still only work with the_repository */
+# ifdef USE_THE_REPOSITORY_VARIABLE
+
 /*
  * Create new notes commit from the given notes tree
  *
@@ -52,4 +55,5 @@ void finish_copy_notes_for_rewrite(struct repository *r,
 				   struct notes_rewrite_cfg *c,
 				   const char *msg);
 
+# endif
 #endif
