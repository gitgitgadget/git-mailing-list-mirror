Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794915553;
	b=Isup3GavseOgMkYHszbi4qvvd7Z5GeNy/X4rRoLWWOsoqJ0aF0e7hIuovz+Y11wL02qT
	 vWayO0OcOMTy+CVRlevyevaks2xJoOCi7dcTT3jG12x1fAK1Tdice7w8Gscnb6ROHV/jX
	 lxw12NxUZmwhdePU+QXRHzpY3eYMYP4r0LUT/wpkbqiygdTPYWjSpMKnZOKNI+xOhzfYr
	 YtA+K1clktYY194wbSL80hcggx7mIxvsAUJqHasDN11h0PX6j3cpkP9k/+AXK2wCbQAZm
	 1lpDyLerxHuOSQ3QcQvy/xairnPU7J3i5EQk/CgFGBDu8LzO2Io3gSRcKcrGtNs+/eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794915553;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q4/URGTcQCi1wQZsRz9pmKPR9e8gs0mhQhg7Jmwwt4E=;
	b=qqBWIYjzfwqDmSBe5sG30C1Mq4lLPGTukXfdA1MKiVd9Wakf+ZV84MZfVWdSEDJlCBu8
	 4y6pI24RktHKvS6F55gVYBkJNLgIHBFFDUpelGb59aF+shnDsvBN55/XS56SFLsx1YcKC
	 2hrUXuTvbFaTif+knToSdanSNB1vhGAC2vttXzAjI0hIAGrpFUemQQscxe3UFK0/6sAlI
	 /L03zcZjRozM+clbQPUzEigOBgOr/sQq1/xXj1ZoQ1EkEK3qeQcALo6pDRylNd/JAv0ZN
	 gP2Cad6okMJVH8I6zihXQoKXa6R9kdx9mnz2eWiwIsuw0JSk7499hGxYDT2oYyPQ/wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BSkh5z3T;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20217606A333
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 11:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20217606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BSkh5z3T
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso29972835e9.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 03:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794915551; x=1795520351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q4/URGTcQCi1wQZsRz9pmKPR9e8gs0mhQhg7Jmwwt4E=;
        b=BSkh5z3TwE73XrmZIxHBgmsb/5dwaZS1Ba5veAQg9EXl3OSjS4KmT2lL69AH8jbzIZ
         ebXvGfHh9HOXV7+wrXofa+eAgfboVkoyeKa3tkFcsIOkHvfayE0jJbfJIj0MnWDuMz/B
         Sheu7o7ONf4avzQ1ViFvRcSnt0+RvPqi8h5YfoI9q7Ffy5Ulj2Ime9Z1sMDktpv6U1eR
         WbgWAemjW5Tc+Ja+tAt9ofIweo2bP59Fkcz6xKJ4UO+OvqdgF7VF79HrUNPrSMVwVV6t
         cq6xnZrK//DpXtHn7Z6NGVn/KYBcrv8WjEvRH3onlEKqdOWcOtupW85FK9hLzjehXYmL
         UwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794915551; x=1795520351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q4/URGTcQCi1wQZsRz9pmKPR9e8gs0mhQhg7Jmwwt4E=;
        b=mvSK/K8kg8eo8P/VN8eMiUkLfVhk4KqgaX8y/ZTdmv/ycwPJwXUtZcH+8ytINXQcOm
         rAPAxZK49K3XPNdbceVe77QmUgKgTOn/r5Nr1UVOFzt2sUTjfl5L9DwucblBZLCErBQU
         o1XuKxbdxdp6u6qjkCRXUPbWMd/mwRbpqnKLjDkqz4eQa4QoU0PjH3k50qtL4Pl7v6Ya
         N/ag2SiYZFPTWO0FohF5vvDDWHriVlUgQCpZ/lC8QLawKykTFiAPJx0Wt740HzyC5VOB
         KzgmXtssP81PpbmVBCBT9zCnh728ZD54bEqimFL2dG+9UlDZUQiBeMvzfr4vkFkfq8yx
         oy9g==
X-Gm-Message-State: APuU4Z80nqWlFRF5NfzztX9qeGahbPWpdToldk8ZtiXzruDCso7F39nv
	r3S26RVONt/pgOCXn+nTgvtg+QhyvuM13xr7TkdZlnGomPPd2DJUUVTwMlgZIA==
X-Gm-Gg: AYBFou0/B7RqDx/lRisHmCfLzjWaiT/2g+Q9KfD+7GsAWvbUwhasyaW5w3/dAWdUZuK
	c/AZ+6PqNKneVFZ0o2q4JKuYcl51oNOxwW2W3h16o/T666ifvjx1xZCCshNSV9Ea1HjP+TIYqm0
	g6fUFbzSYtEdQs5MQFkMRLJcD41i509n3OVMgu6RCnCtSHXeCX0Ze0L3dXZaBGyhauoWTOb/OdC
	zCwKxFzXfrGtlWu1lonDEzL/B4GdB3mIWq/baBthM/YAu/d1a77gH+RlcBqnVaYHUsxO7trSaV5
	S+dCRe1ZRxH8Y+eCzlwzB2aro4TxqtpU/oGvwZAOIM/NXTxs2SI/piK6klzTb61k1n4wuh6hOAc
	ynh3ZTmXob9fZXQXsLaPdFRpe24paDMcQD8coolWG4o8mS27kk3kt3pGrsvo+AMx+oTiAVBxkJe
	Q9Cy+nr2WqePkSDjRKm1jDvkhbnE0PX3q5IJiIu4Wpu8AiS7+gp1NZzfODdiyHC5ZOTABHxxYQ7
	kCYnZRxZoC3Pq9NUhH+JSVG8nW/yrOy1DXddep2PXNpqDGfmW/EAK+LtwS4vxonXce8ifiCRXa1
	L9za6N3pc6RaV9uG3twlCxwb710qPCEryx6NVhUEwaolchPXiIYgYGFMEQlZT+c=
X-Received: by 2002:a05:600c:3f0a:b0:4a4:3a2d:15da with SMTP id 5b1f17b1804b1-4bb55a702femr265562755e9.15.1794915551335;
        Tue, 17 Nov 2026 03:39:11 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78420edasm93555925e9.9.2026.11.17.03.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:39:10 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 3/5] odb/source-loose: check object size when streaming loose objects
Date: Tue, 17 Nov 2026 12:38:56 +0100
Message-ID: <a8572aa836bcc17a7442ff92abd934155e7f6c74.1794914210.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794914210.git.gitter.spiros@gmail.com>
References: <cover.1793355390.git.gitter.spiros@gmail.com> <cover.1794914210.git.gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

read_istream_loose() inflates a loose object until zlib reports the end
of the stream, but never compares the number of bytes it produced with
the size given in the object header. A corrupt object whose stream is
shorter than its header claims is thus streamed out without any error,
e.g. "git cat-file blob" exits with 0 after writing fewer bytes than
"git cat-file -s" reports. The same happens if the stream is longer than
the header claims.

Keep track of how many bytes we handed out and report the object as
corrupt if that does not match the size from the header once the stream
ends.

The tests create such objects with the loose_obj() helper, which can
already write a bogus size into the header.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 odb/source-loose.c  | 14 ++++++++++++++
 t/t1006-cat-file.sh | 18 ++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/odb/source-loose.c b/odb/source-loose.c
index d77e93e7c4..2233714ac4 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -289,6 +289,8 @@ struct odb_loose_read_stream {
 	char hdr[32];
 	int hdr_avail;
 	int hdr_used;
+	size_t total_read;
+	struct object_id oid;
 };
 
 static ssize_t read_istream_loose(struct odb_stream *_st, char *buf, size_t sz)
@@ -326,6 +328,16 @@ static ssize_t read_istream_loose(struct odb_stream *_st, char *buf, size_t sz)
 
 		if (status == Z_STREAM_END) {
 			git_inflate_end(&st->z);
+			/*
+			 * The object must be exactly as large as its
+			 * header claims.
+			 */
+			if (st->total_read + total_read != st->base.size) {
+				error(_("corrupt loose object '%s'"),
+				      oid_to_hex(&st->oid));
+				st->z_state = ODB_LOOSE_READ_STREAM_ERROR;
+				return -1;
+			}
 			st->z_state = ODB_LOOSE_READ_STREAM_DONE;
 			break;
 		}
@@ -335,6 +347,7 @@ static ssize_t read_istream_loose(struct odb_stream *_st, char *buf, size_t sz)
 			return -1;
 		}
 	}
+	st->total_read += total_read;
 	return total_read;
 }
 
@@ -388,6 +401,7 @@ static int odb_source_loose_read_object_stream(struct odb_stream **out,
 
 	st->mapped = mapped;
 	st->mapsize = mapsize;
+	oidcpy(&st->oid, oid);
 	st->hdr_used = strlen(st->hdr) + 1;
 	st->hdr_avail = st->z.total_out;
 	st->z_state = ODB_LOOSE_READ_STREAM_INUSE;
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index f2b24dd278..622d734ad3 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1513,4 +1513,22 @@ test_expect_success PIPE 'concurrently written alternates are loaded' '
 	)
 '
 
+test_expect_success 'setup blobs with bogus size in header' '
+	git init bogus-size &&
+	echo_without_newline short |
+	loose_obj bogus-size/.git/objects blob 100 >oid-too-big &&
+	echo_without_newline "much longer" |
+	loose_obj bogus-size/.git/objects blob 3 >oid-too-small
+'
+
+test_expect_success 'streaming blob shorter than its header fails' '
+	test_must_fail git -C bogus-size cat-file blob $(cat oid-too-big) >out 2>err &&
+	test_grep "corrupt loose object" err
+'
+
+test_expect_success 'streaming blob longer than its header fails' '
+	test_must_fail git -C bogus-size cat-file blob $(cat oid-too-small) >out 2>err &&
+	test_grep "corrupt loose object" err
+'
+
 test_done
-- 
2.53.0

