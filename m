Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793794620;
	b=CsX4f6ZhxAG8KV3aedLV0BsQddneDe031eBKM2d3dGn8t42O6IZLLovxqVQy+hj9YQ4w
	 uqUZ8304Ot3MZ5AYI/Y84fnMAzly4y51VFDgal1n4x6qKCbMPjWSzr2NRA2fpevL16G2S
	 B5LmH+pbtDeUeL4NzR2I0nhvnXXtZ3q3c2Mux7P3bQShZvPuZ4gN9u95f+Ld2+azQAxF0
	 nky/vaciuw2HMtt5bBWkkX0XsgZi1Alri5+4bpf/aaIWDETShgzArA4Rb3m/Wr9gcC8yj
	 kbY56rzyuq7coWaUGNbCeLHcKt2ODbCBXeIjNSgSwx968F8Y2I0wqCAG5/zatkvqMrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794620;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=/H47WN507BXy3QWuQsaNH3SVXWjnqctQ4O/NUUAlAPc=;
	b=MCzZp67zc1ZWp5T9XbhoqEkrBGc6x651MWd/74M6h7UnDvbwJ+0u1BiE/2YLzhRty2Ew
	 VOv5jr4LudUiNOxS6AqnB2JI/h8axqqRVGSoV0g+3/c7Pbm5hKG0UIdtQAdEQV12QFULt
	 CcnPhRzn8+ILWBoyGdYQeLXtiTJhlg8eSlQH2YtkER4uk1qj5v6/0zeecZo1/moYUON1m
	 rhwsN2+U2NKILHzTA8rWSjpTYtbllLwQRV1D/UpJHmSxNVjn1MiOL3vMcpkIvqAUtWkok
	 ndtSbqaS7ZgigN/JrR8Np/U9PJ/Z9hirnLofwU+vtdIzJketvTasl5E35Nvrs+Y1a2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=M989K83s;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=y3ACKpht;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077BA606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 12:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 077BA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=M989K83s;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=y3ACKpht
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3CB871400057
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 07:16:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 04 Nov 2026 07:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793794619;
	 x=1793881019; bh=/H47WN507BXy3QWuQsaNH3SVXWjnqctQ4O/NUUAlAPc=; b=
	M989K83s4h3uFX259KbSUfbsXZqUBRxwp6gb4U3r+PgrDNAMCMPocFPQW5ofXgfz
	4QaOBrFaSd42dGLQJ9wvCEVWoh+ZFkhUAcTH1haTAzukEwQPIZiHPLnHKaAPRV/4
	zcTxdtBnqhU9FpExVrX2aLaD60I1Xf5YdpyiraGTr2NeOxneAt1Uj6RbZalPEtwR
	Il+4m1QN0CDeoVFeVsEf93IpkGHW3wHyIwEFUFu4zwxFOJauy/ZgFiYCDKzyYK/S
	M3tEWR8FBnaOOjwv6OiWfD6M5+GuZX6Mh12gV19yj3rkkxL23r2yIM5nMQBh9HDQ
	d9QFbA06j2Z+MhHRBoUX9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793794619; x=
	1793881019; bh=/H47WN507BXy3QWuQsaNH3SVXWjnqctQ4O/NUUAlAPc=; b=y
	3ACKphtDUdD805OKSV16MNQYg+6LZPI8F99Esr1HHLMPCmfVP0hdaivUghf00TrU
	EMSBh5b887rHmsN5qsUphaD4+e118bNFYch+CQFOqWoDIHljBjsRuDYrkGFlLnQE
	x/oiY+WYeMCiXglzqvLeA1GUJqdV0IpW2zjFln122e3oo1YN1bWN5QEhlntX7ilD
	A4pookX31d+j3VUhhYj1P/w669zbpNmbeJ/vu05xwQ7DWoRL7StnfG3e7Khmh6Tc
	Fk+emVbKU0GAi5sjao4zDdbwfRKNnLHquqwfgktbtsrU32IS73sL0sNKF5NtSpFF
	nz+DcCu0JJCOLPRdvXIkQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793794619; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:PNaIVXzSCUlt24QnVeCL0pCvoYAHWfxdLb4v0T7fsWC6tUr
	PSiKEHIlOeoXCEWsR+O/d3MdUiVAPg+gku44mIdctlrNJjq8Oc2YP7xMokW+rv7d
	Gbr2fIK41pAjZWQ2278NkK0EsRr1vfZ00mn3ZY4uckfflnoY5Cz7q9cRJ+s+3QoQ
	fEPkuSpBl2bB+GDtbwvnp6zajeBlYG/JSXmY9gzOYkCQO/8rCT+vpXXOjygeQ0SI
	navoINERterH60Vhfj56gOz2EtbzBEaaZGsgMTqxHKKm+tiGUcK6x/PGaQ62aGyo
	kXgJbRPINXhd0BV0oJm2UfItTNC8wg8v3y+B4uQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:e8a2ArirLsni/0DhmVb3auxgCCL1h9i/7lPqsbDajAM=:UOGDKNqAnIuxJV3bxtVbWxI1d6Zy6UNMlTzGoW918o4=;
X-ME-Sender: <xms:OyLraiciSe8QQufGFvAqa2QhwPzbi-k6xP53qQ50QgNTpWLiV6WcOQ>
    <xme:OyLraiM0Wr1rZU5jHCZ4dCQpk_EUJJXM7pGhwgMLcor5sGtZge5ulEsdM1O2lmUet
    jkg5XPDnlIFUT8a0cH3ANjJ9GLj4Uq_2tO2VkTgooFF6x0naPfUcQ>
X-ME-Received: <xmr:OyLrahKbzEiF_HORhSUSeKe_JYrt_5Y7LEv8WTADg9ryNDZyXTqynxO-E0o4JxlT-0pH-L4>
X-ME-Proxy-Cause: dmFkZTEMDAQu5or8h9slRKfhaVqN3k5yKFI7tST8NxtX4jXEl6ZXbGTM+G1Dn+HZtYP1S8
    MxJ4MfzUUKgsKAPKS4yoavn166IQbUrDWZm5K2qJ1oAL9ln7J6HWzpaEs+E2OcW9MmZu2E
    w6d5ArPcneZ8cYWfOGoaIyVXJxW8svx0NKI351eyBM1zW56axla34XpQ8Knhs5udcAk+Rr
    XCq+kwJ4OIYonEJ0R88REaXw9W3XGoSNLSPQKgdd5HlIZ3N4AFWNY8nSnA3UHMGulXI4HB
    2GaiZkm6fGnHETC80TRG51nX0GMv8YgeQj00uj882Vfb6QwDQLVWFv1qkIpAA06MsOFkbJ
    FqPb5r7pf0IL8S9RF7422CB2NNXAZOM5iLPU6NwdE+bMDE2JEW93a10eFJXbRcwmpqWHWF
    fVwdTEdUCkM1pDm7DkhDpNDkY735c2WieTEMGo4A9AOThku3HCTCRyxv1ZeCF4ZuB/mjHb
    iiyEBw/K+/8wJqogo88Wteyv8lgYpIlC9s3ll3u3ecM6uhVewl22VMBJeCkKWvNvJ3m69z
    9kd1nUN01EObzRNuAwjacLgg8gRLnM9/qiyP1MiTHm6y4V5bYG/kQNxYd3tAWHW6zFbtmo
    GSTuxicZy2FLCJeAi2opjACCoJvFh4jkQWl/g+Nd7dsfndASM7ZjjhdUO5cg
X-ME-Proxy: <xmx:OyLrarF74oo6XQTUStxYtNGOnYwkQ9PgRpLZkvMXLrI_wzzqeyD3-g>
    <xmx:OyLrahQuggywWds3uhh5AlfHDwMMAHRQYc9s-Pm_cqn-PSC2t-oZ4g>
    <xmx:OyLravGB27jUM7edTJL3O6kfzzXJAy8pUgvXSVK1kU6nPIcc35gacw>
    <xmx:OyLral-M9Y8PC1Ks-GuyzqOkL3lUQNlSp4VMLfkehcC0spk0ltUGcQ>
    <xmx:OyLrar9dpuurYkPjZm6z_bvQhOiyv4f_RYQ1OwRvRUOqXr9BxwQUF9G8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 07:16:58 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 65164fc5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Nov 2026 12:16:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 04 Nov 2026 13:16:35 +0100
Subject: [PATCH 2/2] odb/source-loose: fix existence checks for newly
 written objects
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-pks-odb-loose-stale-cache-v1-2-a00d5cdb5e7d@pks.im>
References: <20261104-pks-odb-loose-stale-cache-v1-0-a00d5cdb5e7d@pks.im>
In-Reply-To: <20261104-pks-odb-loose-stale-cache-v1-0-a00d5cdb5e7d@pks.im>
To: git@vger.kernel.org
Cc: Patrick Ohly <patrick.ohly@intel.com>
X-Mailer: b4 0.15.2

The loose object source maintains a cache of object IDs that it uses to
answer existence checks fast. This cache is lazily populated: whenever
we are asked about a specific object ID, we scan the whole sharding
directory it would live in and populate the cache with the objects we
find. Subsequent existence checks are then answered from the cache
without hitting the filesystem.

But when writing a new loose object we don't update that cache. That's
fine in the case where the cache for its sharding directory has not yet
been populated, because we would then populate it on a subsequent read
and thus surface the newly written object. But when it _is_ populated
already, then any subsequent existence check will claim that the object
does not exist at all until the cache is flushed.

This issue can cause git-merge(1) to die in a partial clone because we
try to fetch an object that we have just written, as reported in [1]:

  1. `prefetch_for_content_merges()` performs quick existence checks for
     all blobs that need a content merge to figure out which ones need
     to be fetched from the promisor remote. These lookups populate the
     loose object cache for the respective sharding directories.

  2. We lazily fetch the missing blobs, which writes a new packfile.

  3. We perform the merge and write the resulting blobs as loose
     objects. The cache is not updated, so for all blobs whose sharding
     directory was populated in (1), the object existence checks will
     fail.

  4. When checking out the merge result, `prefetch_cache_entries()`
     performs existence checks for all index entries that need to be
     written to the worktree. But due to the stale cache, the merged
     blobs are reported as missing, and consequently we try to fetch
     them from the promisor remote. This fetch fails because the remote
     will most likely not have them.

This issue bisects to 5946a564cdd (odb/source: make `read_object_info()`
function pluggable, 2026-03-05), because in that commit we stopped
flushing the loose object cache when we try to read a missing object.
That was done intentionally though: a failing read is only retried when
it is a non-QUICK read, whereas the cache only affects QUICK reads. So
flushing the cache for a non-QUICK read wouldn't ever cause us to find
that object.

So the logic described here only ever worked by chance, as the cache was
incoherent after writes even before that commit. It only used to work
because of the interleaving sequence of QUICK and non-QUICK reads: when
we read the lazily-fetched blobs in (3) via a non-QUICK read, the first
read fails because the new packfile has not yet been added to the
"packed" source. On the retry we then used to flush the loose object
cache, and that in turn means that the subsequent existence check in (4)
rescanned the sharding directories and found the merged blobs.

We could in theory fix this by flushing all the loose object caches
again, like we used to do before 5946a564cdd. But that wouldn't address
the root cause: the cache would still be stale unless somebody does a
non-QUICK read for a missing object. Instead, fix the bug by updating
the cache whenever we write a new loose object.

[1]: <yrjh1p92qc7w.fsf@pohly-mobl1.fritz.box>

Reported-by: Patrick Ohly <patrick.ohly@intel.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-loose.c       | 30 +++++++++++++++++++++++++++---
 t/t5616-partial-clone.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/odb/source-loose.c b/odb/source-loose.c
index da8f9767257..bcbd29ce3a0 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -68,6 +68,19 @@ static struct oidtree *odb_source_loose_cache(struct odb_source_loose *loose,
 	return loose->cache;
 }
 
+/*
+ * Mark an object as seen in the loose cache. Note that we only do this in case
+ * the particular subdirectory was scanned already. If it wasn't, then the next
+ * read would populate it anyway.
+ */
+static void loose_cache_mark_seen(struct odb_source_loose *loose,
+				  const struct object_id *oid)
+{
+	uint32_t mask, *bitmap = subdir_seen_bitmap(loose, oid, &mask);
+	if (*bitmap & mask)
+		oidtree_insert(loose->cache, oid, NULL);
+}
+
 static int quick_has_loose(struct odb_source_loose *loose,
 			   const struct object_id *oid)
 {
@@ -824,8 +837,13 @@ static int write_loose_object(struct odb_source_loose *loose,
 			warning_errno(_("failed utime() on %s"), tmp_file.buf);
 	}
 
-	return finalize_object_file_flags(loose->base.odb->repo, tmp_file.buf, filename.buf,
-					  FOF_SKIP_COLLISION_CHECK);
+	ret = finalize_object_file_flags(loose->base.odb->repo, tmp_file.buf, filename.buf,
+					 FOF_SKIP_COLLISION_CHECK);
+	if (ret < 0)
+		return ret;
+
+	loose_cache_mark_seen(loose, oid);
+	return 0;
 }
 
 static int odb_source_loose_write_object(struct odb_source *source,
@@ -967,8 +985,14 @@ static int odb_source_loose_write_object_stream(struct odb_source *source,
 
 	err = finalize_object_file_flags(loose->base.odb->repo, tmp_file.buf, filename.buf,
 					 FOF_SKIP_COLLISION_CHECK);
-	if (!err && compat)
+	if (err < 0)
+		goto cleanup;
+
+	loose_cache_mark_seen(loose, oid);
+
+	if (compat)
 		err = repo_add_loose_object_map(loose, oid, &compat_oid);
+
 cleanup:
 	strbuf_release(&tmp_file);
 	strbuf_release(&filename);
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 7cc6f58a31f..9636652362f 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -747,6 +747,49 @@ test_expect_success 'after fetching descendants of non-promisor commits, gc work
 	git -C partial gc --prune=now
 '
 
+write_many_mergeable_files () {
+	for i in $(test_seq 50)
+	do
+		{
+			echo "$1 $i" &&
+			test_seq 8 | sed "s/^/line /" &&
+			echo "$2 $i"
+		} >"$3/file-$i" || return 1
+	done
+}
+
+test_expect_success 'merge does not lazy-fetch locally written objects' '
+	test_when_finished "rm -rf server client merged" &&
+	git init server &&
+	(
+		cd server &&
+		git config set uploadpack.allowfilter 1 &&
+
+		write_many_mergeable_files top-A bottom-A . &&
+		git add . &&
+		git commit -m A &&
+
+		write_many_mergeable_files top-B bottom-A . &&
+		git commit -a -m B &&
+
+		git checkout -b C main~1 &&
+		write_many_mergeable_files top-A bottom-C . &&
+		echo C >only-in-C &&
+		git add . &&
+		git commit -m C
+	) &&
+
+	git clone --filter=blob:none --branch=main "file://$(pwd)/server" client &&
+	git -C client merge origin/C &&
+
+	mkdir merged &&
+	write_many_mergeable_files top-B bottom-C merged &&
+	for m in merged/*
+	do
+		test_cmp "$m" client/"$(basename "$m")" || return 1
+	done &&
+	test_cmp server/only-in-C client/only-in-C
+'
 
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd

-- 
2.56.0.500.g5d06dc02cd.dirty

