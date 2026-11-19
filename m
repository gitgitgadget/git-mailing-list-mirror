Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795097931;
	b=feaTkpXycMG9oXbB2kbTZineEl6fpNg4w6lBm9iPPo4Oa+bAXjUWvCuf6EZ/J6HhZwu1
	 F2ErPmfY8itlnvEHUqfXBcpL8HcTJ6+OrvA/CWSUr19YvExMPgOE6+lzOoomDfEbt3gHS
	 +v94DKapxNVcngIMrBHLJsxJ8g02v3RvdJuHocZqV+AdMAToXua9L/d81p8YFnmqb/r6Y
	 lrgtAbpx3K3Fo/5CRuFUA4RWYiQOv4XPhtKhk7XVeV10lj1/exA0y6jPUzt3ILF5fwDSa
	 5ZR4Utl3PndiLyl5W5U/jM+v27aM2eTuK9/YECrpq3Nlft+5wwdV7hnBw+BmMRyDtCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097931;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SqI/mq8mq5EgQWI84tM7now9SXUXIShiLVTxy6ia9Tk=;
	b=4Tj7qhAdyWZq6VRNd9koRvZ2+1zEv75NXDVLAofMPg8DTlMj7/AMQeuGm9Ucjd6fe0p0
	 E28YyMD16aJnpykEI1X1fcT1qXwAkEjF2Yg7CKD4N3nWwlZmfPHTu0Yp97dBF5YPiyyDI
	 ShdJIsK2UrmPhEIBjUtN4QhUOyZxpQFzhf0U9x9w+dACXwKXGW+xyI6Y1hzkx9f6D9hLX
	 6buxD99I8hPASjXAf8Pz5w9s+wadzbyoV+JjhdbDtBdgCAM0zNTXoF9W/rH2MFrykM1KC
	 exar9npuxooZQIpauGeVCpMxL9tL40ZMGJ+n5LOp+ZRyFaiOlVYG+T7u/DilER1RU1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=bNUjYVCC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDB6606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 14:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABDB6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=bNUjYVCC
ARC-Seal: i=1; a=rsa-sha256; t=1795097915; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Qk7IrqZnGTRh/cjY1dpfBqMH9RImQykL1rMKHcwlVv85zAMAjxgXU1OqB8T3mR+tqSfpHO4wbXpLoFtm9bWGQfsoqE5zVbMX4X68eXnRc68cvNtbswrfLmEI2AzHH+Xi/bmkpc15tnevAUiQtvgNfIncw3z6+xtcRhuSQumrOsA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795097915; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SqI/mq8mq5EgQWI84tM7now9SXUXIShiLVTxy6ia9Tk=; 
	b=Kw5II3W3k0DMWpWZSrrf0UC3aHvp/B07bnAuzS7ogx/Wdjm7bvNCTpZP0S56HphnbG0p+W5HbamNFQPQ5KM/ECgkoghSUhi7JkYTrpkNg+u9ieKv+iNncJirbGXK610GxPi9GrYiGdkPtH1GrUBBN2jdDd2ouEGzEzjDVn1zGbY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=bNUjYVCChUiDSv/D0xfIJBYk4zUtOGWLLAXCXgbWGxOjyANRwap0QIbcUzmDhYguWo3jwVqfDyL2s8ku8/6Vs7+8R3gTOHbBkZxj2ye+7PSQZIldjqV0B38MHjfyVjIcd6bm0n2rGOUEXfgFSz0a0AhfpyNnf8DtBDY+uYlLpVs=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=SqI/mq8mq5EgQWI84tM7now9SXUXIShiLVTxy6ia9Tk=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795097910666694.4242395797012;
	Thu, 19 Nov 2026 06:18:30 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 0/3] compatObjectFormat: fix a BUG(), wrong ID and unknown headers
Date: Thu, 19 Nov 2026 16:18:19 +0200
Message-ID: <cover.1794932695.git.adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261112195740.2834341-1-adrian.ratiu@collabora.com>
References: <20261112195740.2834341-1-adrian.ratiu@collabora.com>
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

Hello all,

This is v2 of the compatObjectFormat fixes found while testing sha1-sha256
interop between Git, Gitoxide and Jujutsu.

Because patch 3 drops a check that 08a45903cb (object-file-convert: convert
commits that embed signed tags, 2023-10-01) added on purpose, I'd still welcome
a look from Eric or Brian.

Changes in v2:
 * Check repo_oid_to_algop() for "< 0" and reword the note on which
   rev-parse forms are covered. The test now writes the object before
   enabling compat instead of copying it into the object directory by
   hand. (Patrick)
 * Match the "tree ", "parent " and "mergetag " headers by their key,
   like read_commit_extra_header_lines() does. (Patrick)
 * Minor casing, spacing, doc and commit msg fixes (Patrick)

v1: https://lore.kernel.org/git/20261112195740.2834341-1-adrian.ratiu@collabora.com/

Many thanks,
Adrian

Adrian Ratiu (3):
  setup: reject compatObjectFormat == objectFormat
  rev-parse: die when --output-object-format cannot map an object
  object-file-convert: copy unknown commit headers unchanged

 builtin/rev-parse.c           |  8 +++++---
 object-file-convert.c         | 35 ++++++++++++++++++++++-------------
 setup.c                       |  7 +++++++
 t/t1016-compatObjectFormat.sh | 34 ++++++++++++++++++++++++++++++++++
 t/t1302-repo-version.sh       | 14 ++++++++++++++
 t/t1500-rev-parse.sh          | 14 ++++++++++++++
 6 files changed, 96 insertions(+), 16 deletions(-)

Range-diff against v1:
1:  53c814a1e1 ! 1:  f74a0fd67a setup: reject compatObjectFormat == objectFormat
    @@ setup.c: int verify_repository_format(const struct repository_format *format,
      
     +	if (format->compat_hash_algo == format->hash_algo) {
     +		strbuf_addf(err, _("'%s' is '%s', the same as the object format"),
    -+			    "extensions.compatobjectformat",
    ++			    "extensions.compatObjectFormat",
     +			    hash_algos[format->hash_algo].name);
     +		return -1;
     +	}
    @@ t/t1302-repo-version.sh: abort 0 noop-v1
     +	test_expect_success "compatObjectFormat equal to objectFormat $hash" "
     +		test_when_finished 'rm -rf same' &&
     +		git init --object-format=$hash same &&
    -+		git -C same config core.repositoryformatversion 1 &&
    -+		git -C same config extensions.compatObjectFormat $hash &&
    ++		git -C same config set core.repositoryformatversion 1 &&
    ++		git -C same config set extensions.compatObjectFormat $hash &&
     +		test_must_fail git -C same rev-parse --git-dir 2>err &&
    -+		test_grep \"'extensions.compatobjectformat' is '$hash', the same as the object format\" err &&
    -+		git config --file=same/.git/config --unset extensions.compatObjectFormat &&
    ++		test_grep \"'extensions.compatObjectFormat' is '$hash', the same as the object format\" err &&
    ++		git config unset --file=same/.git/config extensions.compatObjectFormat &&
     +		git -C same rev-parse --git-dir
     +	"
     +done
2:  066fc59207 ! 2:  5b91372748 rev-parse: die when --output-object-format cannot map an object
    @@ Commit message
         rev-parse: die when --output-object-format cannot map an object
     
         "git rev-parse --output-object-format=<compat-format>" should print
    -    an object compat id when extensions.compatObjectFormat is enabled.
    +    the compat ID of an object when extensions.compatObjectFormat is
    +    enabled.
     
    -    Git however doesn't record a compat id for every object, e.g. for
    +    Git however doesn't record a compat ID for every object, e.g. for
         objects received by a fetch that goes through index-pack.
    -    For such objects, rev-parse silently prints the wrong id: it prints
    -    the storage id where the compat id is expected and exits with 0.
    +    For such objects, rev-parse silently prints the wrong ID: it prints
    +    the storage ID where the compat ID is expected and exits with 0.
     
         This happens because rev-parse ignores the repo_oid_to_algop() return
         value. When no mapping is found, that function fails and leaves the
    -    id unchanged, so the storage id is what gets printed.
    +    ID unchanged, so the storage ID is what gets printed.
     
         Fix it to die with the same message as pack-objects. The other callers
         of repo_oid_to_algop() already check its result.
     
    -    This only covers a single revision argument, the one case where
    -    rev-parse converts its output. Other forms, such as "A..B" or "A^@",
    -    print storage ids whatever --output-object-format says. That is left
    -    for a separate change.
    -
    -    The test copies a loose object into the repository by hand, so it
    -    doesn't depend on whether fetch writes compat mappings.
    +    Note that this only covers the case where the user asks for a single
    +    revision, as it is the only case where rev-parse passes the desired
    +    output hash explicitly. All the other cases, like for example when the
    +    user passes a range, do not use the desired output hash at all. Fixing
    +    that would be a bigger change though, so it is left for a future patch
    +    series.
     
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
    @@ builtin/rev-parse.c: int cmd_rev_parse(int argc,
     -						  output_algo, &oid);
     +			if (output_algo &&
     +			    repo_oid_to_algop(the_repository, &oid,
    -+					      output_algo, &oid))
    ++					      output_algo, &oid) < 0)
     +				die(_("cannot map object %s to %s"),
     +				    oid_to_hex(&oid), output_algo->name);
      			if (verify)
    @@ t/t1500-rev-parse.sh: test_expect_success RUST 'rev-parse --show-object-format i
      '
      
     +test_expect_success RUST 'rev-parse --output-object-format with unmapped object' '
    -+	test_when_finished "rm -rf plain compat" &&
    -+	git init --object-format=sha256 plain &&
    -+	git init --object-format=sha256 compat &&
    -+	git -C compat config extensions.compatobjectformat sha1 &&
    -+	oid=$(echo unmapped | git -C plain hash-object -w --stdin) &&
    -+	# copy the object by hand, so that no compat mapping is written for it
    -+	path=$(test_oid_to_path $oid) &&
    -+	mkdir compat/.git/objects/${path%/*} &&
    -+	cp plain/.git/objects/$path compat/.git/objects/$path &&
    ++	test_when_finished "rm -rf unmapped" &&
    ++	git init --object-format=sha256 unmapped &&
    ++	# write the object before enabling compat, so it gets no compat mapping
    ++	oid=$(echo unmapped | git -C unmapped hash-object -w --stdin) &&
    ++	git -C unmapped config set extensions.compatObjectFormat sha1 &&
     +	echo $oid >expect &&
    -+	git -C compat rev-parse --output-object-format=sha256 $oid >actual &&
    ++	git -C unmapped rev-parse --output-object-format=sha256 $oid >actual &&
     +	test_cmp expect actual &&
    -+	test_must_fail git -C compat rev-parse --output-object-format=sha1 $oid >actual 2>err &&
    ++	test_must_fail git -C unmapped rev-parse --output-object-format=sha1 $oid >actual 2>err &&
     +	test_must_be_empty actual &&
     +	test_grep "cannot map object $oid to sha1" err
     +'
3:  a171e86b54 ! 3:  26080a7a38 object-file-convert: copy unknown commit headers unchanged
    @@ Commit message
         don't know:
     
         1. When a commit is created with commit_tree_extended(), as
    -       "git commit" does, convert_commit_extra_headers() copies unknown
    +       git-commit(1) does, convert_commit_extra_headers() copies unknown
            headers unchanged.
     
    -    2. When an existing commit object is converted (git hash-object -w)
    -       or when it's read by its compat id, convert_commit_object() fails
    +    2. When an existing commit object is converted (git-hash-object(1) -w)
    +       or when it's read by its compat ID, convert_commit_object() fails
            on them instead.
     
    -    So git hash-object refuses such a commit, while git commit --amend
    -    records a compat id for it that can't be read back:
    +    So git-hash-object(1) refuses such a commit, while "git commit --amend"
    +    records a compat ID for it that can't be read back:
            "Failed to convert object from sha256 to sha1".
     
         The rejection was added in 08a45903cb (object-file-convert: convert
         commits that embed signed tags, 2023-10-01). Git can't know what an
    -    unknown header holds. It might hold an object id that needs
    +    unknown header holds. It might hold an object ID that needs
         converting, so convert_commit_object() rejects all of them.
     
         Some tools rely on such headers though. Jujutsu, for example, writes
    @@ Commit message
         converted.
     
         Make convert_commit_object() copy unknown headers and their
    -    continuation lines unchanged, just like convert_commit_extra_headers()
    +    continuation lines unchanged, just like convert_commit_extra_headers(),
         so both give the same compat object.
     
         The author, committer, encoding and gpgsig headers were already copied
         the same, so their separate cases are no longer needed.
     
    -    A "tree", "parent" or "mergetag" line with nothing after the keyword
    -    used to be rejected as unknown and is now copied as well. Such a
    -    commit is malformed in both formats anyway.
    +    The "tree ", "parent " and "mergetag " cases only matched a line with
    +    something after the space. That didn't matter while all other lines
    +    were rejected, but they would now be copied. For a "mergetag " line
    +    whose tag starts on the next line, the object ID in the tag would be
    +    copied unconverted, even though Git reads that header as a mergetag and
    +    convert_commit_extra_headers() refuses to convert it.
    +
    +    Match these headers by their key alone instead, the way
    +    read_commit_extra_header_lines() does. Such a line with an empty or bad
    +    value is then rejected, as before. A "tree", "parent" or "mergetag"
    +    line without a space is not one of these headers to Git, so it is
    +    copied like any other unknown header, which is also what
    +    convert_commit_extra_headers() does.
     
         Alternatives considered:
     
    @@ Commit message
            Both paths would then agree, but commits from tools that add
            their own headers could not be used in a compat repo.
     
    -     - Copy only headers known to hold no object ids. Every tool would
    +     - Copy only headers known to hold no object IDs. Every tool would
            first need to get its headers added to that list.
     
    -    The test writes a commit with an unknown header with "git hash-object",
    -    amends it with "git commit", and checks that both commits map to the
    -    same objects in the SHA-1 and the SHA-256 repo.
    +     - Convert values that look like object IDs. Any other hex string
    +       could be taken for one, and Git shouldn't interpret headers it
    +       doesn't know.
    +
    +     - Also reject lines that don't look like "<key> <value>". This would
    +       make the two paths disagree again, because
    +       convert_commit_extra_headers() copies such lines, so
    +       "git commit --amend" would record compat IDs that can't be read
    +       back.
     
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## object-file-convert.c ##
    +@@ object-file-convert.c: static int convert_commit_object(struct repository *repo,
    + 		if (!eol)
    + 			return error(_("bad %s in commit"), "line");
    + 
    +-		if (((bufptr + 5) < eol) && !memcmp(bufptr, "tree ", 5))
    ++		if (((bufptr + 5) <= eol) && !memcmp(bufptr, "tree ", 5))
    + 		{
    + 			if (((bufptr + tree_entry_len) != eol) ||
    + 			    parse_oid_hex_algop(bufptr + 5, &oid, &p, from) ||
    +@@ object-file-convert.c: static int convert_commit_object(struct repository *repo,
    + 					     "tree", oid_to_hex(&oid));
    + 			strbuf_addf(out, "tree %s\n", oid_to_hex(&mapped_oid));
    + 		}
    +-		else if (((bufptr + 7) < eol) && !memcmp(bufptr, "parent ", 7))
    ++		else if (((bufptr + 7) <= eol) && !memcmp(bufptr, "parent ", 7))
    + 		{
    + 			if (((bufptr + parent_entry_len) != eol) ||
    + 			    parse_oid_hex_algop(bufptr + 7, &oid, &p, from) ||
    +@@ object-file-convert.c: static int convert_commit_object(struct repository *repo,
    + 
    + 			strbuf_addf(out, "parent %s\n", oid_to_hex(&mapped_oid));
    + 		}
    +-		else if (((bufptr + 9) < eol) && !memcmp(bufptr, "mergetag ", 9))
    ++		else if (((bufptr + 9) <= eol) && !memcmp(bufptr, "mergetag ", 9))
    + 		{
    + 			struct strbuf tag = STRBUF_INIT, new_tag = STRBUF_INIT;
    + 
     @@ object-file-convert.c: static int convert_commit_object(struct repository *repo,
      			strbuf_release(&tag);
      			strbuf_release(&new_tag);
    @@ object-file-convert.c: static int convert_commit_object(struct repository *repo,
     -			/* Unknown line fail it might embed an oid */
     -			return -1;
     +			/*
    -+			 * Copy all other headers unchanged. author, committer, encoding and gpgsig
    -+			 * hold no object ids. For unknown headers we can't tell, so copy them too,
    -+			 * like convert_commit_extra_headers() does when the commit is written. Both
    -+			 * must give the same compat object.
    ++			 * Copy all other headers unchanged. author, committer,
    ++			 * encoding and gpgsig hold no object IDs. For unknown
    ++			 * headers we can't tell, so copy them too, like
    ++			 * convert_commit_extra_headers() does when the commit
    ++			 * is written. Both must give the same compat object.
    ++			 *
    ++			 * This means that a header holding object IDs is
    ++			 * copied without converting them. Any such header added
    ++			 * to Git needs its own case above, like parent or
    ++			 * mergetag, and the same conversion in
    ++			 * convert_commit_extra_headers().
     +			 *
    -+			 * This means that a header holding object ids is copied without converting
    -+			 * them. Any such header added to Git needs its own case above, like parent
    -+			 * or mergetag, and the same conversion in convert_commit_extra_headers().
    ++			 * The cases above match a header by its key alone, as
    ++			 * read_commit_extra_header_lines() does, so that e.g. a
    ++			 * "mergetag " line with nothing after the space is
    ++			 * still handled as a mergetag instead of being copied.
     +			 */
     +			strbuf_add(out, bufptr, (eol - bufptr) + 1);
      		}
    @@ object-file-convert.c: static int convert_commit_object(struct repository *repo,
     
      ## t/t1016-compatObjectFormat.sh ##
     @@ t/t1016-compatObjectFormat.sh: do
    - 		eval signedtag3_${hash}_oid=$(git hash-object -t tag -w ../${hash}_signedtag3) &&
      		eval signedtag4_${hash}_oid=$(git hash-object -t tag -w ../${hash}_signedtag4)
      	'
    + 
     +	test_expect_success "create a $hash commit with an unknown header" '
     +		git cat-file commit $(commit2_oid $hash) >../${hash}_commit2 &&
     +		awk "{ print } /^committer / { print \"x-unknown one\"; print \" two\" }" \
    @@ t/t1016-compatObjectFormat.sh: do
     +		eval unknownheader_${hash}_oid=$oid &&
     +		git branch unknownheader $oid
     +	'
    ++
     +	test_expect_success "amend a $hash commit with an unknown header" '
     +		git checkout unknownheader &&
     +		git commit --amend -m "Amend a commit with an unknown header" &&
    @@ t/t1016-compatObjectFormat.sh: do
     +		oid=$(git rev-parse HEAD) &&
     +		eval unknownheader2_${hash}_oid=$oid
     +	'
    - 
    ++
    ++	test_expect_success "reject a $hash commit with an empty mergetag line" '
    ++		git cat-file tag committag >../${hash}_committag &&
    ++		{
    ++			sed -n "/^committer /q;p" ../${hash}_commit2 &&
    ++			grep "^committer " ../${hash}_commit2 &&
    ++			echo "mergetag " &&
    ++			sed "s/^/ /" ../${hash}_committag &&
    ++			echo &&
    ++			echo message
    ++		} >../${hash}_emptymergetag &&
    ++		test_must_fail git hash-object -t commit -w ../${hash}_emptymergetag 2>err &&
    ++		test_grep "Failed to convert object" err
    ++	'
    ++
      	test_expect_success 'rev-parse maps oid of object borrowed from alternate' '
      		for repo in alt borrow
    + 		do
     @@ t/t1016-compatObjectFormat.sh: compare_oids 'blob' more "$more_sha1_oid" "$more_sha256_oid"
      compare_oids 'blob' another "$another_sha1_oid" "$another_sha256_oid"
      compare_oids 'tree' tree2 "$tree2_sha1_oid" "$tree2_sha256_oid"
-- 
2.56.1

