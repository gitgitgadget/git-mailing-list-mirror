Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5123914E9
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776155250; cv=pass; b=dQI+r/vFqvNy8WyGdjR5XJroo/M4MSOYLafvfISDhaJoqrAq2A/khdE+tgZm79zbHrBxjfJHPLYlBz3UblXU+cmFtZnc8PZSVZrM+Gj6Yj2ilO3ZvGVv33dZFOkHCv9ACczhtP9fem1k1mhAhxO+IlXkMKNQKoWLTTI6Z9w9J+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776155250; c=relaxed/simple;
	bh=scPoOZ578b4XDRo2Tq9tFiEoBlhuUfbjBeVeaXnEZjU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHX6kW1MNIALiOxAQ3Ih3W98z7MbltLD/enbLW3leTrZMdubLka68vsH94fWPM9hYUu3aiM0m/fRBLzun8Z89oFDIzQW82GZXCXzCv8CVn26wIFQ9yLvGk0TvbphSmOrlu7ZZdZNW7hfJa5av0iUaH3xYngS+Ll4DRucLChRTbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNxv5IW5; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNxv5IW5"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-6055a0414d7so1534118137.2
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 01:27:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776155248; cv=none;
        d=google.com; s=arc-20240605;
        b=BDw9QFJtHaavYFCZ+OmqbMRe54pbpSDyM0xIoKkU37a7oquvzTuZkuCykcVaCw/6mY
         h6TkLlHoE7zVPSTh9hJRYWAs/VYeW+i1SPckDHy4tpJBAYGutziS7/oEyhFnrJNijd6w
         FgZjKNKykFxL/17c6tUYrGdDG9Cg8zgqZo3r5FbnAmRdtbPC6b9ayQI77WSv7mqsT3/3
         fxEykAdeBqf+NHCiDXD/Zu2++wjZ6KyGrw4meIGv1xWlYNju9lY1+VPUvlnhAy/GTJu1
         ddiEKXsbhkob+DSQSC9udCyW61cK0Y2jeZR5/2SNu2L/FNHynuzB6+dwxJcpcKvNOYKs
         AHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=oD22w3IKY3vu5lAl0HWYBxhVC0uY03ppqDbJuo/LA3Y=;
        fh=eCa99xhef/7vLKQmo7jzMbhQ2lMwf1k7qINbhP9NDhg=;
        b=BQpeFn0a/L03hArmgfg7KVlhTQ0MV2dyUvrXGFgj7Ycyu3nxuzpo7UZorY+2ryU+aO
         eCSc4MGYHumGLmXFTYDwiTXF9/dYy9WqKk6nkp0wIv9xJ1Z+5CmJ9PJ2EBfGk3VdBpiD
         rBTJcBZgXSqgChu1N4fsMZpQbxU1uSqupG1tDV8MpkWxHb6vnelXS7vBO8qs7qCqZjqL
         u7jDHqXdasxbNW0GDJoKEH2CBApWEIwVky2/Dp3ix49UARNXjUuz6gb6YTtW78357BHL
         JY1Tu41hsJl9M+cXOU8VHFaPOuZdd3Hs8QavLvxhrIEjfy69D4YScZr4p96Lz8qqBF+I
         fGRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776155248; x=1776760048; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oD22w3IKY3vu5lAl0HWYBxhVC0uY03ppqDbJuo/LA3Y=;
        b=JNxv5IW5CSJeKvc1vvcFdBTT5s2zrq6xk8nYFOXL/t4ErY6MVEqc3IacFezB4OkRm6
         DphSAKoZ2lh7uC9Pr9NCmsgxUCw5jTk/JJSD+xqZ00E0261XBjGI+pHWu9BTztF//JTr
         GB/rKVxunE2HGUr7B3kURJ2rgkHX9SiFUoxUZkHIMrpPy000SeBf/J9rmWoio4nK5z89
         27RCTALE8wmy7CkTBR/k8RSYg03sK9WABDx+HHjPE+lCkbLFrDWzcXhUdx/TohLYAUKo
         /zqUYoSCdhBxuXO3nK7v/tVCWNPhUSk3Lt75xdaV57e2valvL7iwUGZluXcPOZS2DFk7
         y+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776155248; x=1776760048;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oD22w3IKY3vu5lAl0HWYBxhVC0uY03ppqDbJuo/LA3Y=;
        b=qtIbx0bvez8hYRW5ShsI4QFF7Oz80Y6tNiSZPd15eS30o3+KkR+98Al2ZOXgbxt6f3
         oA0C/vIgqOWrqbxvLgZkmLS+Z4oqjH9DsjK7i0tL6+XImbl/gZ9LldJI3tMb4p+gr0+T
         0DSVK8EOqqRjtOJRZ7gWXMD7lUbUjw8WDc6u3BO+xwDhLH7G6GumqowjlM2Sr4j5VgU1
         7y0rCzU2ZqFHwlPpyaXcb/FK9T4AqFP8cnrpGv7cULYEbxEeGOeZXRjKIQxfeOlafni0
         uxjFjnt2HLnRyzBPXC5JgfayBR9vEETKsdWXMLurRKCFjHoUqlQupmm8EwirZSt9vvzh
         umkw==
X-Forwarded-Encrypted: i=1; AFNElJ+P0H75wWf75lqowTtiYXqevlXDb6/RU3EzBhcFw664+mmaMz/OXGJa//kaqmBEqSTjzM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBY8AqVxLlgVI0sSy43s+cSiEEOebwPfsJD2sPsTkYLzRQsMdz
	MAa5BFwCupV5ISfixy+FxQQ7D4AxydjpOMGEeSVqvIhuUL0NFp4I8tpvJCCpn5JhvR1aPw40RqO
	nY81T4I6azdD5KYPX0KbqVQNtD7bgZdY=
X-Gm-Gg: AeBDietr+uXaavr/EvKNjtiLnSZttgiuqyV8RxgYs0VA4H+ByZsV7g7aklOZstv0cd7
	hIDzIc6g2pxPPOoPnQy8Oym/zIKd0vB/QXrYJDXDlCWLoTzym/QzN+VgvdPd3c/1xMvJbS8vLTp
	N9GWby5jQ0XpuYm4VX2BrrqNCavkSJ2GoNGMt4me5oweSuHcNxXJzBHbminFpXtpRfItghFihNH
	ZVTuDSaoColDv+hcysbcviP39qkAz+65IcdxIL3vBIMB5TrJOUXfl+7ppIrFDAbLpo90twEvSGE
	N4KgtaNilC4+EQr6plE3yzAUYwgCGJLK+TcM6vM1Dg==
X-Received: by 2002:a05:6102:10c9:b0:611:7c7b:4d40 with SMTP id
 ada2fe7eead31-6117c7b5221mr205664137.30.1776155248053; Tue, 14 Apr 2026
 01:27:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Apr 2026 01:27:26 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Apr 2026 01:27:26 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im> <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Apr 2026 01:27:26 -0700
X-Gm-Features: AQROBzDAssJ4MfiZ93cdy18QpnBcrx8c5GaSPDrWkjaChsC-VA439AMMXya8qPA
Message-ID: <CAOLa=ZSrThty13-C_WVa5dvakZAtidwOXWnUrOA4LGX93DvmGQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] odb: introduce "in-memory" source
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000a066c8064f675e3e"

--000000000000a066c8064f675e3e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:
[snip]

> Range-diff versus v2:
>
>  1:  b18e427c69 !  1:  155b2cdf81 odb: introduce "in-memory" source
>     @@ odb/source-inmemory.h (new)
>      +struct cached_object_entry;
>      +
>      +/*
>     -+ * An inmemory source that you can write objects to that shall be made
>     ++ * An in-memory source that you can write objects to that shall be made
>      + * available for reading, but that shouldn't ever be persisted to disk. Note
>      + * that any objects written to this source will be stored in memory, so the
>      + * number of objects you can store is limited by available system memory.
>     @@ odb/source-inmemory.h (new)
>      +struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb);
>      +
>      +/*
>     -+ * Cast the given object database source to the inmemory backend. This will
>     ++ * Cast the given object database source to the in-memory backend. This will
>      + * cause a BUG in case the source doesn't use this backend.
>      + */
>      +static inline struct odb_source_inmemory *odb_source_inmemory_downcast(struct odb_source *source)
>      +{
>      +	if (source->type != ODB_SOURCE_INMEMORY)
>     -+		BUG("trying to downcast source of type '%d' to inmemory", source->type);
>     ++		BUG("trying to downcast source of type '%d' to in-memory", source->type);
>      +	return container_of(source, struct odb_source_inmemory, base);
>      +}
>      +
>     @@ odb/source.h: enum odb_source_type {
>       	/* The "files" backend that uses loose objects and packfiles. */
>       	ODB_SOURCE_FILES,
>      +
>     -+	/* The "inmemory" backend that stores objects in memory. */
>     ++	/* The "in-memory" backend that stores objects in memory. */
>      +	ODB_SOURCE_INMEMORY,
>       };
>
>  2:  8fd337da90 !  2:  c66edd10a8 odb/source-inmemory: implement `free()` callback
>     @@ odb/source-inmemory.h
>      +};
>
>       /*
>     -  * An inmemory source that you can write objects to that shall be made
>     +  * An in-memory source that you can write objects to that shall be made
>  3:  f4ae2a2bde =  3:  a86549f39c odb: fix unnecessary call to `find_cached_object()`
>  4:  8600b88530 =  4:  49ac739dd2 odb/source-inmemory: implement `read_object_info()` callback
>  5:  ab33c0b7ee !  5:  321ef11be3 odb/source-inmemory: implement `read_object_stream()` callback
>     @@ odb/source-inmemory.c: static int odb_source_inmemory_read_object_info(struct od
>
>      +struct odb_read_stream_inmemory {
>      +	struct odb_read_stream base;
>     -+	const void *buf;
>     ++	const unsigned char *buf;

Okay this does make more sense.

>      +	size_t offset;
>      +};
>      +
>     @@ odb/source-inmemory.c: static int odb_source_inmemory_read_object_info(struct od
>      +
>      +	if (buf_len > inmemory->base.size - inmemory->offset)
>      +		bytes = inmemory->base.size - inmemory->offset;
>     -+	memcpy(buf, inmemory->buf, bytes);
>     ++
>     ++	memcpy(buf, inmemory->buf + inmemory->offset, bytes);
>     ++	inmemory->offset += bytes;

Now, we also use the offset correctly.

>      +
>      +	return bytes;
>      +}
>  6:  983f886eeb !  6:  506df5e488 odb/source-inmemory: implement `write_object()` callback
>     @@ odb.c: int odb_pretend_object(struct object_database *odb,
>       void *odb_read_object(struct object_database *odb,
>
>       ## odb/source-inmemory.c ##
>     +@@
>     + #include "git-compat-util.h"
>     ++#include "object-file.h"
>     + #include "odb.h"
>     + #include "odb/source-inmemory.h"
>     + #include "odb/streaming.h"
>      @@ odb/source-inmemory.c: static int odb_source_inmemory_read_object_stream(struct odb_read_stream **out,
>       	return 0;
>       }
>     @@ odb/source-inmemory.c: static int odb_source_inmemory_read_object_stream(struct
>      +	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
>      +	struct cached_object_entry *object;
>      +
>     ++	hash_object_file(source->odb->repo->hash_algo, buf, len, type, oid);
>     ++
>      +	ALLOC_GROW(inmemory->objects, inmemory->objects_nr + 1,
>      +		   inmemory->objects_alloc);
>      +	object = &inmemory->objects[inmemory->objects_nr++];
>  7:  68edefa269 <  -:  ---------- odb/source-inmemory: implement `write_object()` callback
>  8:  18d451152b !  7:  21eef34c1b odb/source-inmemory: implement `write_object_stream()` callback
>     @@ odb/source-inmemory.c: static int odb_source_inmemory_write_object(struct odb_so
>      +			goto out;
>      +		}
>      +
>     -+		memcpy(data, buf, bytes_read);
>     ++		memcpy(data + total_read, buf, bytes_read);
>      +		total_read += bytes_read;
>      +	}
>      +
>  9:  cee53b9853 !  8:  504e34d116 cbtree: allow using arbitrary wrapper structures for nodes
>     @@ cbtree.c: int cb_each(struct cb_tree *t, const uint8_t *kpfx, size_t klen,
>
>
>       ## cbtree.h ##
>     +@@
>     +  *
>     +  * This is adapted to store arbitrary data (not just NUL-terminated C strings
>     +  * and allocates no memory internally.  The user needs to allocate
>     +- * "struct cb_node" and fill cb_node.k[] with arbitrary match data
>     +- * for memcmp.
>     +- * If "klen" is variable, then it should be embedded into "c_node.k[]"
>     ++ * "struct cb_node" and provide `key_offset` to indicate where the key can be
>     ++ * found relative to the `struct cb_node` for memcmp.
>     ++ * If "klen" is variable, then it should be embedded into the key.
>     +  * Recursion is bound by the maximum value of "klen" used.
>     +  */

We fix up the comments here also.

>     + #ifndef CBTREE_H
>      @@ cbtree.h: struct cb_node {
>       	 */
>       	uint32_t byte;
> 10:  8ad5b81b13 =  9:  9bdd475a92 oidtree: add ability to store data
> 11:  1ed2d23137 ! 10:  956b989529 odb/source-inmemory: convert to use oidtree
>     @@ odb/source-inmemory.h
>      +struct oidtree;
>
>       /*
>     -  * An inmemory source that you can write objects to that shall be made
>     +  * An in-memory source that you can write objects to that shall be made
>      @@ odb/source-inmemory.h: struct cached_object_entry {
>        */
>       struct odb_source_inmemory {
> 12:  99fbb1cc35 ! 11:  bec1428116 odb/source-inmemory: implement `for_each_object()` callback
>     @@ odb/source-inmemory.c: static int odb_source_inmemory_read_object_stream(struct
>      +	if ((opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) ||
>      +	    (opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY && !source->local))
>      +		return 0;
>     ++	if (!inmemory->objects)
>     ++		return 0;
>      +
>      +	return oidtree_each(inmemory->objects,
>      +			    opts->prefix ? opts->prefix : &null_oid, opts->prefix_hex_len,
> 13:  c87a621f39 = 12:  32dada3c27 odb/source-inmemory: implement `find_abbrev_len()` callback
> 14:  9b88f0c07b = 13:  43127840c0 odb/source-inmemory: implement `count_objects()` callback
> 15:  3c9493f2bb = 14:  439acbd068 odb/source-inmemory: implement `freshen_object()` callback
> 16:  f2b6317104 ! 15:  12c1b6ffd2 odb/source-inmemory: stub out remaining functions
>     @@ odb/source-inmemory.c: static int odb_source_inmemory_freshen_object(struct odb_
>      +static int odb_source_inmemory_begin_transaction(struct odb_source *source UNUSED,
>      +						 struct odb_transaction **out UNUSED)
>      +{
>     -+	return error("inmemory source does not support transactions");
>     ++	return error("in-memory source does not support transactions");
>      +}
>      +
>      +static int odb_source_inmemory_read_alternates(struct odb_source *source UNUSED,
>     @@ odb/source-inmemory.c: static int odb_source_inmemory_freshen_object(struct odb_
>      +static int odb_source_inmemory_write_alternate(struct odb_source *source UNUSED,
>      +					       const char *alternate UNUSED)
>      +{
>     -+	return error("inmemory source does not support alternates");
>     ++	return error("in-memory source does not support alternates");
>      +}
>      +
>      +static void odb_source_inmemory_close(struct odb_source *source UNUSED)
> 17:  81da5d5048 = 16:  ef37a61e7f odb: generic in-memory source
>  -:  ---------- > 17:  51b51e0382 t/unit-tests: add tests for the in-memory object source

The range diff looks good. I'll have a look at the unit test patch
independently. Thanks

--000000000000a066c8064f675e3e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 93884ae82dcac4e6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uZCttd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meVRsREFDVmg1U2ZxL2pnZTdRK0lxY1RIMGFzZGJORApJbDNIY0NyZUQz
azRJalIyRXlRV0dHSWlSM0pWaG1VMkpDMnVMVjFwZ3E2ZTFGWmpMV0lMQmNRYmR1QU9DR3pnClB3
bEFaby9jSTJ0dEltZ3JWRlBMTWxvTzM0M25CZlcybTkxVTR1cVBJb1gyVnZCaUQ1RktoTkx2THZn
bUN3QlMKNHFsMTZoTDU2ekNpbzcwV1prMDcwcWw0T3gzLzFpYWFZTEFCQmtFdWtNTzBkVlJnQnBB
d0loWWxLam5sUjdGRQoyWlZvalBreTA0N0RDM2lqRHhJV1RJNkY3V3d3bGRLWDBVemNRdFY1RTAz
TVVXanZjMEZaTTAyK1VPT1NVMk0zCm1rQ0I1MDNDbktuakdvKzlYa1l0Um1uV1JGbSt0eUpTYm5z
ZDBwQW9CQlVHWU16RmN3ZUJsQ01XejZjV1JpS0sKL1AwYlF3WDY4Nnk2VGwrbnZDUGxEZWlFZ3JD
Sk5Xb0pCaE1vbHJJNUduSUxhYnZoMmRhSGgyODNCbDB3VTg0dQpaRkxaMTgwNGtTV3J5dmxqMzRN
aWRXMUJva0wwSTBVTW10dzFKejlNUEZPRzdCMGVRWE1OM3dUdyttbEtERUhHCkNvekEzYmF2R2RY
S1VFNlk4UkppRWF6WUFzOHR4VEdONk42b2daRT0KPVg4eDgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a066c8064f675e3e--
