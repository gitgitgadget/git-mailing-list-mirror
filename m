Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563E62AE7A
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787141874; cv=none; b=InG4R0/SJAIXAD4WQfxxg9drfu+y2QrOir/9vvJFkPDqBtYMLCIQlLScZKj517cLQ/BE7vB6S1j4Xhe9fORdDsyPooJ02VuVK4LEOxYHWSgOHvye50sGiL5FdKuM48RCwySHKycWbTFpQYrTqU7IoB6NdhfPpGY1trP4M8Gp758=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787141874; c=relaxed/simple;
	bh=rl1+aoov0Fw/a1iUaVx/3TAyf3TUkHqR0V+aC9uyl6w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=rVP2uggaAtOM4gcu7chvNMA8KEv6FMNvO4uh+t5QDx5MszRnu1JwWZhOahFt0HODD+taRy2VSfZ0Vs5w4dnn0Q0I+rA6qReIwaG2b7jnInxNDFvWOpBJW7Ce2iUsURXDx+5R+dfpdqXWvRRMK+3zP7/6ZLsVJ1ELIHL6/NvwBuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fkd7DD6W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hVFneJvS; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fkd7DD6W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hVFneJvS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 81981EC01AA;
	Wed, 19 Aug 2026 08:17:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 19 Aug 2026 08:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787141870;
	 x=1787228270; bh=GUxmM5PXQi+DHatNtCuRY0MmIxjjwaS6Awate4g+zoY=; b=
	Fkd7DD6W024MdO/oqRGkwdZNLLY/ctxZgrk3EIGK3az9KUC84RM2Cb8cprhyGyWJ
	kyvMR0gN9GwHfKWIymje8nUKTGNGISLr46ZvX6JMBR46J+nmNUqycQnsHme2585G
	VB1Nofbde/amCtf6NtOqdjYfxgWyHGuPMHxyarLEGrS03lpRNSLS4ljUOV9ANfgi
	I6ignWdLwmh0fCOWMQWZa30w5vsBL2w+ifU4cP5G1NR6ZbrpaRmGpypEUvGNtvtp
	Cr7Cuu62RX2MII+9TPswTmt6jl8lAoSU2cHwE69sqsHeqOoKfbv4PrjtJXMvPWKB
	8ibx+i8q75Nf52TPU/31NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787141870; x=
	1787228270; bh=GUxmM5PXQi+DHatNtCuRY0MmIxjjwaS6Awate4g+zoY=; b=h
	VFneJvS7NS5lP6ghNsdxO4psQeJSmkIgsA00Ca7yeNI4aQu+TWHCLrhF/JfExWM5
	YxGVklG5KTnhpS5zse+rZZHAkUvqUkhQGYkGaAd4i2RwpE6vyi6Iije88TXSEu+8
	RrVzbUh2085mlUzbThFuMfKMKnSugDbtMX6DjWMT8gSHOlIhSwyJVmeugBEFEubl
	Hev01jvE46X2eRbcwOfrOZlWs4e9WGZcKHL+w1o8xQnF0nJPcj3vFSCmz321PjAT
	ZIEJ9DCOIXmcmHrK5lJFuAFZWJsXZfgqRrKJrEJLoaxKwfLzberXjFlGC0uvwYMY
	Z1nKZnOTk+vC6/ZWGhrGA==
X-ME-Sender: <xms:7p6Fah6OFZjSEPZyoQlMTErBdZBe02Aw_91B0lACellhco7I2bfSTw>
    <xme:7p6Fak4WGP-6a56Q5Bl1GPz6ltYTyL_8bwpfpAJZ9dnQvb_-uPWEl53RWJ3yLfAmL
    0AWyFGX1apJSHyUmFIKlAQSMy2FTG8QVQAkpuM3UONPW2Jc2-oJvQ>
X-ME-Received: <xmr:7p6FamGJfKmK4aDR00vWbSDPmJCt89LkdgQPccPgNLt0l9Y-7J-m12D2Ljnzz1A8K4QLmyQtPxNTdiUBTPZgoWFF3rPzQKU3XHsq1wVX>
X-ME-Proxy-Cause: dmFkZTEgAo3dmEZslPk2oE0XA+SeS39lfPKSa2esJJ9avyE3FrLo5GIZEIcU7TQJqUaK4s
    cNf49PdG54e97pBkhQe/1U7BOBlL8G4o0Roo0YS9HTEdjD+tOe+w8sG9Vxg/QEt/iFnzt6
    Bzygd2ZL/IpISe7hPyYGR06rdXKmC6wCq3mThBkc6miva8Xi+Tysa/mdEeXwRsCgWidflQ
    66easKAcd6NUM6ZiO9u7u6+04pdO5C9aaT+0HJzk1l2dNAxgCjUZYaFsNdx88UaxvffhKJ
    Okrs0/qKY8W8LD4Wd/0B5lrGR+Ir1MjbBZ6dX/+10JjzyJeWsPXPd9f23n1Jxy6UBRZkZp
    ib+0zl3S48Sq1Vx/D5wiLpEXVIZg4UGTmNctMu8bu5jsVhg3ky3JiSTVIY4IjExsNiVrTf
    SBhbRbTNByLGHq9xonic4eGdMWtc1j3EOLUIRXYARK5iE5WBjAspPdnfkg0J4aPS3R2YZt
    ZQzLPLZPj2lCcamwU8929wdQPHxq8+LgjMP7UH0DHIz781dH9OXhNNCWDN3/z+4K05sQjw
    JUQWRujNOHCELDJ3wVPkn2UGIhzYcRZL4xoj9npO2u6puCJL9qdh6H8qRAoHCUmey+g5Y9
    CSluduYLG6aMyHek9gsoWkOBk2AN3NtLf0ZdqC9zUVRqt9LCuFsxj8gbJg6A
X-ME-Proxy: <xmx:7p6FalTtufjoMTS5L3Qs1h86AEeLx02Qgtns6O5Pa0LT_YKt-8OXBw>
    <xmx:7p6FansCmn1CVZhH3Ib3BIvp98CBPqGXVGQYI251amugFc4RvSXjfw>
    <xmx:7p6Fasx7yWli1YQaLBeDqqubjzdOdJ8Qu6g_wGMqkwX797DHbHr0vg>
    <xmx:7p6Fap6wp_Nzeq8q9gbZFxE55zhhYIz1q_6h3IFxhwjKx7K9KyoVHw>
    <xmx:7p6FalQDEjaMGvc01ZAgnAWGGkGBI6V9OXPsVw5csWVHjol6NE_9-kaI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 08:17:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9bf53b54 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Aug 2026 12:17:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/5] odb: handle `OBJECT_INFO_DIE_IF_CORRUPT`
 generically
Date: Wed, 19 Aug 2026 14:17:18 +0200
Message-Id: <20260819-pks-odb-generic-corrupt-objects-v2-0-a984e3a0ad6f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OSw6CMBCGr2Jm7Zi28tKV9zAsoB1gNFLSAaIh3
 N2CF3D5Jd//WEAoMAlcDwsEmlnY9xHM8QC2q/qWkF1kMMpkqtAFDk9B72psqY9Ji9aHMA0j+vp
 BdhRMTZXkLjM6cReILUOght/7wr38sUy7u9VuRscy+vDZL8x68/5fmzUqJGvOSZrlqVbNLSZO/
 IJyXdcv6B22L90AAAA=
X-Change-ID: 20260818-pks-odb-generic-corrupt-objects-52a47d6214d9
In-Reply-To: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
References: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

when looking up an object with `OBJECT_INFO_DIE_IF_CORRUPT` fails we
want to die in case the object exists but is corrupted. This flag is
handled in two different spots right now:

  - `do_oid_object_info_extended()` calls `has_packed_and_bad()` to
    check whether the object is known to be corrupt in any packfile.
    This function reaches into the internals of the packed source and
    thus breaks the abstraction provided by our object sources.

  - The loose source handles the flag itself and dies directly in
    `read_object_info_from_path()`, which means that we die even in
    cases where another source may still have a good copy of the
    object.

Besides being inconsistent, it also ties us to the specific backend used
by the database sources because `has_packed_and_bad()` assumes that they
use the "files" backend. Any other backend will instead cause us to die
when calling `odb_source_files_downcast()`, even if the object was
simply nonexistent.

This series fixes these issues and makes the check backend-agnostic by
extending semantics of `odb_source_read_object_info()`: on the one hand
it now distinguishes whether an object is missing or corrput, and on the
other hand it starts to return an error message to the caller.

Changes in v2:
  - Adapt the series to use an `enum odb_read_status` with negative
    error codes exclusively, as suggested by Junio. This results in a
    rather big restructure of the series.
  - Link to v1: https://patch.msgid.link/20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (5):
      odb/source-packed: flag known-bad objects as corrupt and not missing
      odb/source: introduce error status when reading objects
      odb/source: let callers discern missing and corrupt objects
      odb/source: allow `read_object_info()` to bubble up error messages
      odb: handle `OBJECT_INFO_DIE_IF_CORRUPT` generically

 builtin/pack-objects.c        |  8 +++---
 midx.c                        | 10 ++++---
 midx.h                        |  3 ++-
 odb.c                         | 63 ++++++++++++++++++++++++++++---------------
 odb.h                         | 17 +++++++++---
 odb/source-files.c            | 31 ++++++++++++++++-----
 odb/source-inmemory.c         | 11 ++++----
 odb/source-loose.c            | 52 ++++++++++++++++++++---------------
 odb/source-packed.c           | 58 ++++++++++++++++++++++++++++-----------
 odb/source.h                  | 34 ++++++++++++++---------
 packfile.c                    | 29 ++++++--------------
 packfile.h                    |  4 +--
 t/helper/test-read-midx.c     |  2 +-
 t/t1060-object-corruption.sh  | 18 +++++++++++++
 t/unit-tests/u-odb-inmemory.c |  5 ++--
 15 files changed, 224 insertions(+), 121 deletions(-)

Range-diff versus v1:

1:  ea7d64242a < -:  ---------- odb/source: discern missing and corrupt objects
2:  f4944112b3 < -:  ---------- odb/source-inmemory: signal missing objects via positive return
3:  9080d7f138 ! 1:  c821c3b004 odb/source-packed: flag known-bad objects as corrupt and not missing
    @@ Metadata
      ## Commit message ##
         odb/source-packed: flag known-bad objects as corrupt and not missing
     
    -    When reading a packed object that doesn't verify we mark it as bad and
    -    indicate to the caller that we failed reading the object despite the
    -    fact that it supposedly exists. This matches the semantics we have now
    -    established in a preceding commit, where we discern failure to read a
    -    corrupt object from a missing object.
    +    When reading packed objects we know to tell apart missing objects and
    +    corrupt objects by returning a positive error code in the former case,
    +    and a negative one in the latter case. We do that by distinguishing
    +    between errors returned by `find_pack_entry()`, which yields the offset
    +    of the object, and `packed_object_info()`, which reads the object
    +    contents.
     
    -    What doesn't work yet though is when a call tries to read an object that
    -    has already been marked as corrupt in a previous call. In that case,
    -    `find_pack_entry()` will tell us that the object in question does not
    -    exist, and consequently we'll not flag the object as corrupt but as
    -    missing.
    +    But even though we already distinguish those cases when reading packed
    +    objects, the logic is broken in case a caller tries to read an object
    +    that has been marked as corrupt. In that case, `find_pack_entry()` will
    +    tell us that the object in question does not exist, and consequently
    +    we'll not flag the object as corrupt but as missing.
     
         Fix this issue by bubbling up whether the object is corrupt and, if so,
    -    which packfile contains the corrupted object. We don't yet need the
    -    latter information about the specific packfile, so we could've just as
    -    well made this a `bool *corrupted` pointer. But we'll need information
    -    about the containing packfile in a subsequent commit.
    +    which packfile contains the corrupted object.
    +
    +    Note that we don't yet need the information about the specific packfile,
    +    so we could've just as well made this a `bool *corrupted` pointer. But
    +    we'll need information about the containing packfile in a subsequent
    +    commit so that we can generate a proper error message telling the user
    +    which packfile contains the broken object.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ odb/source-packed.c: static int odb_source_packed_read_object_info(struct odb_so
     -	if (!find_pack_entry(packed, oid, &e))
     +	if (!find_pack_entry(packed, oid, &e, &bad_pack)) {
     +		/*
    -+		 * The lookup may have failed because the object is known to
    -+		 * be corrupt in one of our packfiles, in which case the
    -+		 * corresponding pack entries are skipped. Report the object
    -+		 * as corrupt instead of as missing in that case.
    ++		 * The lookup may have failed because the object is known to be
    ++		 * corrupt in one of the packfiles. Report the object as
    ++		 * corrupt instead of missing in that case.
     +		 */
     +		if (bad_pack)
     +			return -1;
-:  ---------- > 2:  602249a58e odb/source: introduce error status when reading objects
4:  db2bd77c61 ! 3:  269fb8e6a6 odb/source-loose: distinguish missing and corrupt objects
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    odb/source-loose: distinguish missing and corrupt objects
    +    odb/source: let callers discern missing and corrupt objects
     
    -    The loose source returns a negative value from its `read_object_info()`
    -    callback both when the object is missing and when the object exists but
    -    cannot be read. Consequently, callers cannot tell apart whether the
    -    object does not exist in this source at all or whether it is corrupt.
    +    As explained in the preceding commits, reading objects can either fail
    +    because the object truly does not exist or because it exists, but its
    +    data is corrupt. Some callers do care about this distinction, but there
    +    is no way to tell these two cases apart right now.
     
    -    Adapt the code to return a positive value for missing objects according
    -    to the new calling convention.
    +    Introduce a new `ODB_READ_NOT_FOUND` value that ought to be returned by
    +    the backends in case the object truly does not exist and adapt backends
    +    to use it.
     
    -    This also allows us to get rid of the separate `corrupt:` label, as we
    -    can now clearly distinguish between corrupt and missing objects in the
    -    function ourselves. This makes us handle failures to read loose objects
    -    more consistently, as not all failure cases were jumping that label.
    -
    -    Note that there's one call to `die()` when the object type is invalid
    -    that should arguably be converted to an error, too. But adapting that
    -    call results in quite a lot of broken tests, so this is left as-is for
    -    now.
    +    Note that we don't yet return this error from `odb_read_object_info()`
    +    itself. This will be fixed in a subsequent commit.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    + ## odb.h ##
    +@@ odb.h: enum odb_read_status {
    + 	ODB_READ_OK = 0,
    + 	/* The read resulted in a generic error. */
    + 	ODB_READ_ERROR = -1,
    ++	/* The object could not be found. */
    ++	ODB_READ_NOT_FOUND = -2,
    + };
    + 
    + /*
    +
    + ## odb/source-files.c ##
    +@@ odb/source-files.c: static enum odb_read_status odb_source_files_read_object_info(struct odb_source
    + 							      enum object_info_flags flags)
    + {
    + 	struct odb_source_files *files = odb_source_files_downcast(source);
    ++	enum odb_read_status ret_packed, ret_loose;
    + 
    +-	if (!odb_source_read_object_info(&files->packed->base, oid, oi, flags) ||
    +-	    !odb_source_read_object_info(&files->loose->base, oid, oi, flags))
    ++	ret_packed = odb_source_read_object_info(&files->packed->base, oid, oi, flags);
    ++	if (!ret_packed)
    + 		return 0;
    + 
    +-	return -1;
    ++	ret_loose = odb_source_read_object_info(&files->loose->base, oid, oi, flags);
    ++	if (!ret_loose)
    ++		return 0;
    ++
    ++	/*
    ++	 * Reading the packed object may have failed even though the object
    ++	 * exists, for example because it is corrupt. Report this failure to
    ++	 * the caller in case neither of the sources was able to read the
    ++	 * object, and prefer the error of the packed source in case both
    ++	 * reads have failed.
    ++	 */
    ++	if (ret_packed != ODB_READ_NOT_FOUND)
    ++		return ret_packed;
    ++	return ret_loose;
    + }
    + 
    + static int odb_source_files_read_object_stream(struct odb_read_stream **out,
    +
    + ## odb/source-inmemory.c ##
    +@@ odb/source-inmemory.c: static enum odb_read_status odb_source_inmemory_read_object_info(struct odb_sour
    + 
    + 	object = find_cached_object(inmemory, oid);
    + 	if (!object)
    +-		return -1;
    ++		return ODB_READ_NOT_FOUND;
    + 
    + 	populate_object_info(inmemory, oi, object);
    + 	return 0;
    +
      ## odb/source-loose.c ##
     @@ odb/source-loose.c: static int read_object_info_from_path(struct odb_source_loose *loose,
      		struct stat st;
      
      		if ((!oi || (!oi->disk_sizep && !oi->mtimep)) && (flags & OBJECT_INFO_QUICK)) {
     -			ret = quick_has_loose(loose, oid) ? 0 : -1;
    -+			ret = quick_has_loose(loose, oid) ? 0 : 1;
    ++			ret = quick_has_loose(loose, oid) ? 0 : ODB_READ_NOT_FOUND;
      			goto out;
      		}
      
      		if (lstat(path, &st) < 0) {
     +			if (errno == ENOENT) {
    -+				ret = 1;
    ++				ret = ODB_READ_NOT_FOUND;
     +				goto out;
     +			}
     +
    @@ odb/source-loose.c: static int read_object_info_from_path(struct odb_source_loos
     -			error_errno(_("unable to open loose object %s"), oid_to_hex(oid));
     -		ret = -1;
     +		if (errno == ENOENT) {
    -+			ret = 1;
    ++			ret = ODB_READ_NOT_FOUND;
     +			goto out;
     +		}
     +
    @@ odb/source-loose.c: static int read_object_info_from_path(struct odb_source_loos
     -corrupt:
     -	if (ret && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
     +out:
    -+	if (ret < 0 && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
    ++	if (ret && ret != ODB_READ_NOT_FOUND && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
      		die(_("loose object %s (stored in %s) is corrupt"),
      		    oid_to_hex(oid), path);
      
    @@ odb/source-loose.c: static int read_object_info_from_path(struct odb_source_loos
      	if (stream_to_end)
      		git_inflate_end(stream_to_end);
      	if (map)
    -@@ odb/source-loose.c: static int odb_source_loose_read_object_info(struct odb_source *source,
    +@@ odb/source-loose.c: static enum odb_read_status odb_source_loose_read_object_info(struct odb_source
      	 * second time.
      	 */
      	if (flags & OBJECT_INFO_SECOND_READ)
     -		return -1;
    -+		return 1;
    ++		return ODB_READ_NOT_FOUND;
      
      	odb_loose_path(loose, &buf, oid);
      	return read_object_info_from_path(loose, buf.buf, oid, oi, flags);
    -@@ odb/source-loose.c: static int for_each_object_wrapper_cb(const struct object_id *oid,
    - 	if (data->request) {
    - 		struct object_info oi = *data->request;
    - 
    --		if (read_object_info_from_path(data->loose, path, oid, &oi, 0) < 0)
    -+		if (read_object_info_from_path(data->loose, path, oid, &oi, 0))
    +
    + ## odb/source-packed.c ##
    +@@ odb/source-packed.c: static enum odb_read_status odb_source_packed_read_object_info(struct odb_source
    + 		 */
    + 		if (bad_pack)
      			return -1;
    +-		return 1;
    ++		return ODB_READ_NOT_FOUND;
    + 	}
      
    - 		return data->cb(oid, &oi, data->cb_data);
    -@@ odb/source-loose.c: static int for_each_prefixed_object_wrapper_cb(const struct object_id *oid,
    - 		struct object_info oi = *data->request;
    + 	/*
    +
    + ## t/unit-tests/u-odb-inmemory.c ##
    +@@ t/unit-tests/u-odb-inmemory.c: void test_odb_inmemory__read_missing_object(void)
    + 	const char *end;
      
    - 		if (odb_source_read_object_info(&data->loose->base,
    --						oid, &oi, 0) < 0)
    -+						oid, &oi, 0))
    - 			return -1;
    + 	cl_must_pass(parse_oid_hex_algop(RANDOM_OID, &oid, &end, repo.hash_algo));
    +-	cl_must_fail(odb_source_read_object_info(&source->base, &oid, NULL, 0));
    ++	cl_assert_equal_i(odb_source_read_object_info(&source->base, &oid, NULL, 0),
    ++			  ODB_READ_NOT_FOUND);
      
    - 		return data->cb(oid, &oi, data->cb_data);
    + 	odb_source_free(&source->base);
    + }
5:  0c9be02ab4 < -:  ---------- odb/source-files: signal mark objects via positive return
6:  f633262bd4 ! 4:  7de629151d odb/source: allow `read_object_info()` to bubble up error messages
    @@ builtin/pack-objects.c: static int force_object_loose(struct odb_source *source,
      
     
      ## odb.c ##
    -@@ odb.c: static int do_oid_object_info_extended(struct object_database *odb,
    +@@ odb.c: static enum odb_read_status do_oid_object_info_extended(struct object_database *
      	if (is_null_oid(real))
      		return -1;
      
    @@ odb.c: static int do_oid_object_info_extended(struct object_database *odb,
      		return 0;
      
      	odb_prepare_alternates(odb);
    -@@ odb.c: static int do_oid_object_info_extended(struct object_database *odb,
    +@@ odb.c: static enum odb_read_status do_oid_object_info_extended(struct object_database *
      		struct odb_source *source;
      
      		for (source = odb->sources; source; source = source->next)
    @@ odb.c: static int do_oid_object_info_extended(struct object_database *odb,
      				return 0;
      
      		/*
    -@@ odb.c: static int do_oid_object_info_extended(struct object_database *odb,
    +@@ odb.c: static enum odb_read_status do_oid_object_info_extended(struct object_database *
      		if (!(flags & OBJECT_INFO_QUICK)) {
      			for (source = odb->sources; source; source = source->next)
      				if (!odb_source_read_object_info(source, real, oi,
    @@ odb.c: static int do_oid_object_info_extended(struct object_database *odb,
     
      ## odb/source-files.c ##
     @@ odb/source-files.c: static void odb_source_files_prepare(struct odb_source *source,
    - static int odb_source_files_read_object_info(struct odb_source *source,
    - 					     const struct object_id *oid,
    - 					     struct object_info *oi,
    --					     enum object_info_flags flags)
    -+					     enum object_info_flags flags,
    -+					     struct strbuf *errmsg)
    + static enum odb_read_status odb_source_files_read_object_info(struct odb_source *source,
    + 							      const struct object_id *oid,
    + 							      struct object_info *oi,
    +-							      enum object_info_flags flags)
    ++							      enum object_info_flags flags,
    ++							      struct strbuf *errmsg)
      {
      	struct odb_source_files *files = odb_source_files_downcast(source);
    - 	int ret_packed, ret_loose;
    + 	enum odb_read_status ret_packed, ret_loose;
      
     -	ret_packed = odb_source_read_object_info(&files->packed->base, oid, oi, flags);
     +	ret_packed = odb_source_read_object_info(&files->packed->base, oid, oi,
    @@ odb/source-files.c: static void odb_source_files_prepare(struct odb_source *sour
      		return 0;
      
     -	ret_loose = odb_source_read_object_info(&files->loose->base, oid, oi, flags);
    -+	ret_loose = odb_source_read_object_info(&files->loose->base, oid, oi,
    -+						 flags, ret_packed < 0 ? NULL : errmsg);
    ++	ret_loose = odb_source_read_object_info(&files->loose->base, oid, oi, flags,
    ++						ret_packed == ODB_READ_NOT_FOUND ? errmsg : NULL);
      	if (!ret_loose)
      		return 0;
      
     
      ## odb/source-inmemory.c ##
     @@ odb/source-inmemory.c: static void populate_object_info(struct odb_source_inmemory *source,
    - static int odb_source_inmemory_read_object_info(struct odb_source *source,
    - 						const struct object_id *oid,
    - 						struct object_info *oi,
    --						enum object_info_flags flags UNUSED)
    -+						enum object_info_flags flags UNUSED,
    -+						struct strbuf *errmsg UNUSED)
    + static enum odb_read_status odb_source_inmemory_read_object_info(struct odb_source *source,
    + 								 const struct object_id *oid,
    + 								 struct object_info *oi,
    +-								 enum object_info_flags flags UNUSED)
    ++								 enum object_info_flags flags UNUSED,
    ++								 struct strbuf *errmsg UNUSED)
      {
      	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
      	const struct inmemory_object *object;
    @@ odb/source-loose.c: static int read_object_info_from_path(struct odb_source_loos
      	ret = 0;
      
      out:
    -+	if (ret < 0 && errmsg)
    -+		strbuf_addf(errmsg, _("loose object %s (stored in %s) is corrupt"),
    +-	if (ret && ret != ODB_READ_NOT_FOUND && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
    +-		die(_("loose object %s (stored in %s) is corrupt"),
    +-		    oid_to_hex(oid), path);
    ++	if (ret && ret != ODB_READ_NOT_FOUND) {
    ++		if ((flags & OBJECT_INFO_DIE_IF_CORRUPT))
    ++			die(_("loose object %s (stored in %s) is corrupt"),
     +			    oid_to_hex(oid), path);
    -+
    - 	if (ret < 0 && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
    - 		die(_("loose object %s (stored in %s) is corrupt"),
    - 		    oid_to_hex(oid), path);
    ++		if (errmsg)
    ++			strbuf_addf(errmsg, _("loose object %s (stored in %s) is corrupt"),
    ++				    oid_to_hex(oid), path);
    ++	}
    + 
    + 	if (stream_to_end)
    + 		git_inflate_end(stream_to_end);
     @@ odb/source-loose.c: static int read_object_info_from_path(struct odb_source_loose *loose,
    - static int odb_source_loose_read_object_info(struct odb_source *source,
    - 					     const struct object_id *oid,
    - 					     struct object_info *oi,
    --					     enum object_info_flags flags)
    -+					     enum object_info_flags flags,
    -+					     struct strbuf *errmsg)
    + static enum odb_read_status odb_source_loose_read_object_info(struct odb_source *source,
    + 							      const struct object_id *oid,
    + 							      struct object_info *oi,
    +-							      enum object_info_flags flags)
    ++							      enum object_info_flags flags,
    ++							      struct strbuf *errmsg)
      {
      	struct odb_source_loose *loose = odb_source_loose_downcast(source);
      	static struct strbuf buf = STRBUF_INIT;
    -@@ odb/source-loose.c: static int odb_source_loose_read_object_info(struct odb_source *source,
    - 		return 1;
    +@@ odb/source-loose.c: static enum odb_read_status odb_source_loose_read_object_info(struct odb_source
    + 		return ODB_READ_NOT_FOUND;
      
      	odb_loose_path(loose, &buf, oid);
     -	return read_object_info_from_path(loose, buf.buf, oid, oi, flags);
    @@ odb/source-loose.c: static int for_each_object_wrapper_cb(const struct object_id
      	if (data->request) {
      		struct object_info oi = *data->request;
      
    --		if (read_object_info_from_path(data->loose, path, oid, &oi, 0))
    -+		if (read_object_info_from_path(data->loose, path, oid, &oi, 0, NULL))
    +-		if (read_object_info_from_path(data->loose, path, oid, &oi, 0) < 0)
    ++		if (read_object_info_from_path(data->loose, path, oid, &oi, 0, NULL) < 0)
      			return -1;
      
      		return data->cb(oid, &oi, data->cb_data);
    @@ odb/source-loose.c: static int for_each_prefixed_object_wrapper_cb(const struct
      		struct object_info oi = *data->request;
      
      		if (odb_source_read_object_info(&data->loose->base,
    --						oid, &oi, 0))
    -+						oid, &oi, 0, NULL))
    +-						oid, &oi, 0) < 0)
    ++						oid, &oi, 0, NULL) < 0)
      			return -1;
      
      		return data->cb(oid, &oi, data->cb_data);
    @@ odb/source-packed.c
      static int find_pack_entry(struct odb_source_packed *store,
      			   const struct object_id *oid,
     @@ odb/source-packed.c: static int find_pack_entry(struct odb_source_packed *store,
    - static int odb_source_packed_read_object_info(struct odb_source *source,
    - 					      const struct object_id *oid,
    - 					      struct object_info *oi,
    --					      enum object_info_flags flags)
    -+					      enum object_info_flags flags,
    -+					      struct strbuf *errmsg)
    + static enum odb_read_status odb_source_packed_read_object_info(struct odb_source *source,
    + 							       const struct object_id *oid,
    + 							       struct object_info *oi,
    +-							       enum object_info_flags flags)
    ++							       enum object_info_flags flags,
    ++							       struct strbuf *errmsg)
      {
      	struct odb_source_packed *packed = odb_source_packed_downcast(source);
      	struct packed_git *bad_pack = NULL;
    -@@ odb/source-packed.c: static int odb_source_packed_read_object_info(struct odb_source *source,
    - 		 * corresponding pack entries are skipped. Report the object
    - 		 * as corrupt instead of as missing in that case.
    +@@ odb/source-packed.c: static enum odb_read_status odb_source_packed_read_object_info(struct odb_source
    + 		 * corrupt in one of the packfiles. Report the object as
    + 		 * corrupt instead of missing in that case.
      		 */
     -		if (bad_pack)
     -			return -1;
    --		return 1;
    +-		return ODB_READ_NOT_FOUND;
     +		if (bad_pack) {
     +			ret = -1;
     +			goto out;
     +		}
     +
    -+		ret = 1;
    ++		ret = ODB_READ_NOT_FOUND;
     +		goto out;
      	}
      
    @@ odb/source-packed.c: static int odb_source_packed_read_object_info(struct odb_so
     +	ret = 0;
     +
     +out:
    -+	if (bad_pack && errmsg)
    ++	if (ret < 0 && bad_pack && errmsg)
     +		strbuf_addf(errmsg, _("packed object %s (stored in %s) is corrupt"),
     +			    oid_to_hex(oid), bad_pack->pack_name);
     +
    @@ odb/source.h: enum odb_source_type {
      
      /*
     @@ odb/source.h: struct odb_source {
    - 	 *   - A negative value in case the object exists in this source, but
    - 	 *     reading its object info has failed, for example because its
    - 	 *     on-disk state is corrupt.
    -+	 *
    -+	 * In case reading the object has failed and `errmsg` is non-NULL, the
    -+	 * callback is expected to populate it with a human-readable message
    -+	 * that describes the failure.
    + 	 *     already surfaced the object without reloading any on-disk state.
    + 	 *
    + 	 * The callback is expected to return an `enum odb_read_status`. Please
    +-	 * refer to the individual values that can be returned.
    ++	 * refer to the individual values that can be returned. In case reading
    ++	 * the object has failed with a generic error and `errmsg` is non-NULL,
    ++	 * the callback is expected to populate it with a human-readable
    ++	 * message that describes the failure.
      	 */
    - 	int (*read_object_info)(struct odb_source *source,
    - 				const struct object_id *oid,
    - 				struct object_info *oi,
    --				enum object_info_flags flags);
    -+				enum object_info_flags flags,
    -+				struct strbuf *errmsg);
    + 	enum odb_read_status (*read_object_info)(struct odb_source *source,
    + 						 const struct object_id *oid,
    + 						 struct object_info *oi,
    +-						 enum object_info_flags flags);
    ++						 enum object_info_flags flags,
    ++						 struct strbuf *errmsg);
      
      	/*
      	 * This callback is expected to create a new read stream that can be
     @@ odb/source.h: static inline void odb_source_prepare(struct odb_source *source,
    -  * Returns 0 on success, a positive value in case the object is missing in the
    -  * source and a negative value in case the object exists, but reading it has
    -  * failed.
    + /*
    +  * Read an object from the object database source identified by its object ID.
    +  * Please refer to `enum odb_read_status` for the individual error codes.
     + *
    -+ * In case reading the object has failed and `errmsg` is non-NULL it will be
    -+ * populated with a human-readable message that describes the failure.
    ++ * In case reading the object has failed with a generic error and `errmsg` is
    ++ * non-NULL it will be populated with a human-readable message that describes
    ++ * the failure.
       */
    - static inline int odb_source_read_object_info(struct odb_source *source,
    - 					      const struct object_id *oid,
    - 					      struct object_info *oi,
    --					      enum object_info_flags flags)
    -+					      enum object_info_flags flags,
    -+					      struct strbuf *errmsg)
    + static inline enum odb_read_status odb_source_read_object_info(struct odb_source *source,
    + 							       const struct object_id *oid,
    + 							       struct object_info *oi,
    +-							       enum object_info_flags flags)
    ++							       enum object_info_flags flags,
    ++							       struct strbuf *errmsg)
      {
     -	return source->read_object_info(source, oid, oi, flags);
     +	return source->read_object_info(source, oid, oi, flags, errmsg);
    @@ t/unit-tests/u-odb-inmemory.c: void test_odb_inmemory__read_missing_object(void)
      	const char *end;
      
      	cl_must_pass(parse_oid_hex_algop(RANDOM_OID, &oid, &end, repo.hash_algo));
    --	cl_assert(odb_source_read_object_info(&source->base, &oid, NULL, 0) > 0);
    -+	cl_assert(odb_source_read_object_info(&source->base, &oid, NULL, 0, NULL) > 0);
    +-	cl_assert_equal_i(odb_source_read_object_info(&source->base, &oid, NULL, 0),
    ++	cl_assert_equal_i(odb_source_read_object_info(&source->base, &oid, NULL, 0, NULL),
    + 			  ODB_READ_NOT_FOUND);
      
      	odb_source_free(&source->base);
    - }
7:  a82f4341e1 ! 5:  4af62fe3bf odb: handle `OBJECT_INFO_DIE_IF_CORRUPT` generically
    @@ Commit message
         In the preceding commits we've carved out the infrastructure to make
         this mechanism fully generic. On the one hand, all backends now tell us
         whether the object is missing or corrupt via their return values. And
    -    on the other hand, they have been tought to provide a readable error
    +    on the other hand, they have been taught to provide a readable error
         message to the caller.
     
         Adapt `do_oid_object_info_extended()` to use those new mechanisms. This
    @@ odb.c
      #include "path.h"
      #include "promisor-remote.h"
      #include "quote.h"
    -@@ odb.c: static int do_oid_object_info_extended(struct object_database *odb,
    - 				       const struct object_id *oid,
    - 				       struct object_info *oi, unsigned flags)
    +@@ odb.c: static enum odb_read_status do_oid_object_info_extended(struct object_database *
    + 							const struct object_id *oid,
    + 							struct object_info *oi, unsigned flags)
      {
     +	struct strbuf corrupt_err = STRBUF_INIT;
      	const struct object_id *real = oid;
    ++	enum odb_read_status ret;
      	int already_retried = 0;
     +	bool corrupt = false;
    -+	int ret;
      
      	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
      		real = lookup_replace_object(odb->repo, oid);
    -@@ odb.c: static int do_oid_object_info_extended(struct object_database *odb,
    +@@ odb.c: static enum odb_read_status do_oid_object_info_extended(struct object_database *
      	while (1) {
      		struct odb_source *source;
      
    @@ odb.c: static int do_oid_object_info_extended(struct object_database *odb,
     +							  corrupt_err.len ? NULL : &corrupt_err);
     +			if (!ret)
     +				goto out;
    -+			if (ret < 0)
    ++			if (ret != ODB_READ_NOT_FOUND)
     +				corrupt = true;
     +		}
      
      		/*
      		 * When the object hasn't been found we try a second read and
    -@@ odb.c: static int do_oid_object_info_extended(struct object_database *odb,
    +@@ odb.c: static enum odb_read_status do_oid_object_info_extended(struct object_database *
      		 * caches or reload on-disk state.
      		 */
      		if (!(flags & OBJECT_INFO_QUICK)) {
    @@ odb.c: static int do_oid_object_info_extended(struct object_database *odb,
     +								  corrupt_err.len ? NULL : &corrupt_err);
     +				if (!ret)
     +					goto out;
    -+				if (ret < 0)
    ++				if (ret != ODB_READ_NOT_FOUND)
     +					corrupt = true;
     +			}
      		}
      
      		/*
    -@@ odb.c: static int do_oid_object_info_extended(struct object_database *odb,
    +@@ odb.c: static enum odb_read_status do_oid_object_info_extended(struct object_database *
      		}
      
      		if (flags & OBJECT_INFO_DIE_IF_CORRUPT) {
    @@ odb.c: static int do_oid_object_info_extended(struct object_database *odb,
      		}
     -		return -1;
     +
    -+		ret = -1;
    ++		ret = corrupt ? ODB_READ_ERROR : ODB_READ_NOT_FOUND;
     +		goto out;
      	}
     +
    @@ odb.c: static int do_oid_object_info_extended(struct object_database *odb,
     
      ## odb/source-loose.c ##
     @@ odb/source-loose.c: static int read_object_info_from_path(struct odb_source_loose *loose,
    - 	if (ret < 0 && errmsg)
    - 		strbuf_addf(errmsg, _("loose object %s (stored in %s) is corrupt"),
    + 	ret = 0;
    + 
    + out:
    +-	if (ret && ret != ODB_READ_NOT_FOUND) {
    +-		if ((flags & OBJECT_INFO_DIE_IF_CORRUPT))
    +-			die(_("loose object %s (stored in %s) is corrupt"),
    ++	if (ret && ret != ODB_READ_NOT_FOUND && errmsg)
    ++		strbuf_addf(errmsg, _("loose object %s (stored in %s) is corrupt"),
      			    oid_to_hex(oid), path);
    --
    --	if (ret < 0 && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
    --		die(_("loose object %s (stored in %s) is corrupt"),
    --		    oid_to_hex(oid), path);
    +-		if (errmsg)
    +-			strbuf_addf(errmsg, _("loose object %s (stored in %s) is corrupt"),
    +-				    oid_to_hex(oid), path);
    +-	}
     -
      	if (stream_to_end)
      		git_inflate_end(stream_to_end);

---
base-commit: 18e66859d87fb4b76599f73460b54f0848c76b16
change-id: 20260818-pks-odb-generic-corrupt-objects-52a47d6214d9

