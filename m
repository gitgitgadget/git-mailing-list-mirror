Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ACD75809
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833295; cv=none; b=gTACgv6h6EBHCEeLk+PUmfY1swFUInwpkSHrXc3BUreqx7e4YcxuW/Ttw0JR4hEtrtDv7dtiqOFS8aMKG8vqqD51WZEINSntr2laxW0DNr/1gzwbmr4Cv69FK826+o548+jjWj5aBmN5m1NULJ0eQ9x+7PBU2eQSiPDzuf+haH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833295; c=relaxed/simple;
	bh=cs18/+vgXmLDjFTNiDuEiSACuQMq14y4czQq4pREp6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n12aMmcDhiqj+Ql/rJoHHHilFYlw0dBH4EJBIZTAM2wNbIWmH8IAtPC4ZgArJyt9iY9c1U3VpbBY5RQHX6K6GYSX4y+/Dypqba6SfjM78TgQregtFTHXy3gIUaYJ7/TElczpG2kS8w7SIK/6Mq+TogT3NU9JESAsbvTtGe3d63A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=owryM9HK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owryM9HK"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso24340595e9.3
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 08:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775833291; x=1776438091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PUa+ToJWIxqHn7wB9J6DACwEvtWN5pavzxJBPt7lTM0=;
        b=owryM9HKOrYhAnikr6G5IsdnIVUN1Ic2AORzhegx/oxaWgPgQmRfKpYa/1bixFjVXR
         vjH51KURwIn/prl1HD+E0Q3xyscODMe9RxsNXG0Vrk3jQYPFIH9UP5Wff83FOJJmCLhR
         l9CmZUyPMHTDkhUJcfftnnCG8k9o9maMKXsIkn8ajsXuJa4RksLjroifuI5uGg9oF1oa
         LkkDk+ZxJKJZb8K1HBbP1waa2QTZdr5WMaWziFFtQALOmI5s7Xq7qoK4ON8hn2Uh4p2U
         O6Opn3xnkjnh9/8UFj/Jd0hGOUPRJNiz3JtP+gzJOz4jwSme3qGjksPD+GRWaN0j+yjl
         QG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775833291; x=1776438091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUa+ToJWIxqHn7wB9J6DACwEvtWN5pavzxJBPt7lTM0=;
        b=fniCFbQ617o0ysxYZqqRB/FznqyTBUyQb/1GAfCtdKrNKi2zwlb816KA3BhkPn0CuU
         5ikygBKh/XUKFxXaevTUQOwdS24cgD74wLIf5usrGFBuSRPZr/uXebNqUZrKnFYtPMFs
         XJdp5QlUWg3mFq44CQda97CiMinedqBqy9GaZlL2Og1BrNI8JPUXuzFpRWKycXZlgTys
         Copl66NfP6yUNTY47iLwYslkZanH60X8G3Wx6S7i48ZAEvQjXWRM+buSFIe/IDW0ZKcp
         NeT3LUdopyjXo2cmFh7sBnwmurIyRkMAXdYqcd0u+CHVc4FjrqQNpt3Sh0GHmHRGDje+
         6VCQ==
X-Gm-Message-State: AOJu0YxWcgIqPuMOSjGjdVFWcMoQ+TGNHilLhBeO8wohj6ShANURvqVi
	OrFnqqCgw95TnJmiUO8ygLHe7xqz/pgKzH8Y7zm9peY1BbHakWXan1lpJwc8FfSTQCE=
X-Gm-Gg: AeBDiet6wUEAwpcunOOImNObab8ksxuT85tc0klNCVRroEt8tYzpRJ+k6S2meAnXSYr
	aJt4fKiC53M+HRuKBnLsss5fizpW2DLdmB1x7PbKffHXTX+7J0lt92QnyGmxLCjA8KJAACtT55+
	g7NyAARz+WhKke2eeDDwvjnFWKxpn04SPnvjwjoQPnyYlDgey9NZ2jFK+4NKpvOYFb9idxQAaj+
	dbTR//dz1An3iAKRu8ma68VnsuZWByYvb2kzYkc5l42j3oZbASLpVBOlfFRru1BYaaOZ3Q+JT3c
	CnhO4f4lYR8aagjmUSwdoAEDeiADGiOVbylwEZcwDIERf6op+DsbumravMwECMcFCTCfYeUizlz
	AsMn6NZD8S3Cht5BSqIAkbCtzyBICD0DnyP7YX8HxAkdgrJylJWx9TquVYA99munGSIfxLDM2xM
	EUquK7KS27F8p4iNlgK31/BlPLxPqqkUBRLagJZP6QdUbelDxvOQeNFd3fB7iz+qzA4L/hLdkJt
	2C8DPm0
X-Received: by 2002:a05:600c:4f95:b0:488:be58:bb5b with SMTP id 5b1f17b1804b1-488d686c443mr48687605e9.24.1775833290240;
        Fri, 10 Apr 2026 08:01:30 -0700 (PDT)
Received: from lorenzo-VM (host-79-19-37-238.retail.telecomitalia.it. [79.19.37.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5344e28sm84339805e9.7.2026.04.10.08.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:01:29 -0700 (PDT)
Date: Fri, 10 Apr 2026 17:01:26 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Tian Yuchen <cat@malon.dev>
Subject: [GSoC PATCH v4 0/5] preserve promisor files content after repack
Message-ID: <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>

The goal of this patch is to solve the NEEDSWORK comment added by
5374a290 (fetch-pack: write fetched refs to .promisor, 14/10/2019). This
is done by adding a helper function that takes the content of all
.promisor files in the `repository`, and copies it inside the first
.promisor file created by the repack.

Also, I added a comment explaining what is the purpose of the content of
the .promisor files, since this wasn't explained anywhere (I found
information regarding this only in the message of the previously cited
commit).

Finally, I added some tests to "t7700-repack.sh" and
"t7703-repack-geometric.sh" that check if the content of .promisor files
are correctly copied into the .promisor files created by a repack.


If Eric Sunshine, Tian Yuchen (for the patch 2/5 "pack-write: add helper
to fill promisor file after repack") and Junio Hamano (for all patches)
want to be added with a `<Reviewed-by>` tag, please let me know (and, of
course, thanks a lot for the help)!


QUESTION:
The "CodingGuidelines" explicitly state that:
 "A C file must directly include the header files that declare the
  functions and the types it uses, except for the functions and types
  that are made available to it by including one of the header files
  it must include by the previous rule"
where "the previous rule" is (if I understand correctly), the one related
to "<git-compat-util.h>". From what I understand then, I should have
added an include for "strmap.h" (which is needed for `strset`), correct?
And if I am correct, shouldn't "strbuf.h", "hash.h", "odb.h",
"string-list.h" and "strvec.h" also be included?


V4 DIFF:
 * `copy_promisor_content()` now prints timestamps in Unix time format.
 * `copy_promisor_content()` now doesn't use a list of `strbuf`, but
   instead uses the more lightweight `string_list`.
 * improved the tests.
 * fixed issue (that showed up in the GitHub Actions-based CI) where
   sometimes the 2 packs created in the second new test inside "t7700"
   were not both repacked into a single new pack. 


LorenzoPegorari (5):
  pack-write: add explanation to promisor file content
  pack-write: add helper to fill promisor file after repack
  repack-promisor: preserve content of promisor files after repack
  t7700: test for promisor file content after repack
  t7703: test for promisor file content after geometric repack

 Documentation/git-repack.adoc |   4 +-
 pack-write.c                  |   9 +++
 repack-promisor.c             | 146 +++++++++++++++++++++++++++++++---
 t/t7700-repack.sh             |  60 ++++++++++++++
 t/t7703-repack-geometric.sh   |  33 ++++++++
 5 files changed, 237 insertions(+), 15 deletions(-)

Range-diff against v3:
1:  eb1964dca8 = 1:  b4990fcdf0 pack-write: add explanation to promisor file content
2:  3cd1542919 ! 2:  34c4e79311 pack-write: add helper to fill promisor file after repack
    @@ Commit message
         stored as lines structured like this: "<oid> <ref>".
     
         Create a `copy_promisor_content()` helper function that allows this
    -    debugging info to not be lost after a `repack`, by coping it inside a new
    -    ".promisor" file.
    +    debugging info to not be lost after a `repack`, by copying it inside a
    +    new ".promisor" file.
     
         The function logic is the following:
          * Take all ".promisor" files contained inside the given `repo`.
    @@ Commit message
            (intended to be used for packfiles that have not been repacked).
          * Read each line of the remaining ".promisor" files, which can be:
             * "<oid> <ref>" if the ".promisor" file was never repacked. If so,
    -          add the time at which the ".promisor" file was last modified <time>
    -          to the line to create the string: "<oid> <ref> <time>".
    +          add the time (in Unix time) at which the ".promisor" file was last
    +          modified <time> to the line, to obtain: "<oid> <ref> <time>".
             * "<oid> <ref> <time>" if the ".promisor" file was repacked. If so,
               don't modify it.
          * Ignore the line if its <oid> is not present inside the
    @@ Commit message
         The function assumes that the contents of all ".promisor" files are
         correctly formed.
     
    -    The time of last data modification is used in place of the time of file
    -    creation, because the former is much easier to obtain than the latter
    -    one.
    +    The time of last data modification, for never-repacked ".promisor" file,
    +    can be used when comparing the entries in it with entries in another
    +    ".promisor" file that did get repacked. With these timestamps, the
    +    debugger will be able to tell at which time the refs at the remote
    +    repository pointed at what object. Also, when looking at already
    +    repacked ".promisor" files, the same ref may appear multiple times, and
    +    having timestamps will help understanding what happened over time.
     
         Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
     
    @@ repack-promisor.c: static int write_oid(const struct object_id *oid,
     + * Each line of a never repacked .promisor file is: "<oid> <ref>" (as described
     + * in the write_promisor_file() function).
     + * After a repack, the copied lines will be: "<oid> <ref> <time>", where <time>
    -+ * is the time at which the .promisor file was last modified.
    ++ * is the time (in Unix time) at which the .promisor file was last modified.
     + * Only the lines whose <oid> is present inside "<packtmp>-<dest_hex>.idx" will
     + * be copied.
     + * The contents of all .promisor files are assumed to be correctly formed.
    @@ repack-promisor.c: static int write_oid(const struct object_id *oid,
     +		source = xfopen(source_promisor_name.buf, "r");
     +
     +		while (strbuf_getline(&line, source) != EOF) {
    -+			struct strbuf **parts;
    ++			struct string_list line_sections = STRING_LIST_INIT_DUP;
     +			struct object_id oid;
     +
     +			/* Split line into <oid>, <ref> and <time> (if <time> exists) */
    -+			parts = strbuf_split_max(&line, ' ', 3);
    ++			string_list_split(&line_sections, line.buf, " ", 3);
     +
     +			/* Ignore the lines where <oid> doesn't appear in the dest_pack */
    -+			strbuf_rtrim(parts[0]);
    -+			get_oid_hex_algop(parts[0]->buf, &oid, repo->hash_algo);
    -+			if (!find_pack_entry_one(&oid, dest_pack))
    ++			get_oid_hex_algop(line_sections.items[0].string, &oid, repo->hash_algo);
    ++			if (!find_pack_entry_one(&oid, dest_pack)) {
    ++				string_list_clear(&line_sections, 0);
     +				continue;
    ++			}
     +
     +			/* If <time> doesn't exist, retrieve it and add it to line */
    -+			if (!parts[2]) {
    -+				struct tm tm;
    -+				localtime_r(&source_stat.st_mtim.tv_sec, &tm),
    -+				strbuf_addch(&line, ' ');
    -+				strbuf_addftime(&line, "%Y/%m/%d-%H:%M:%S", &tm, 0, 0);
    -+			}
    ++			if (line_sections.nr < 3)
    ++				strbuf_addf(&line, " %lld", (long long int)source_stat.st_mtim.tv_sec);
     +
     +			/*
     +			 * Add the finalized line to dest_to_write and dest_content if it
    @@ repack-promisor.c: static int write_oid(const struct object_id *oid,
     +				strbuf_addch(&dest_to_write, '\n');
     +			}
     +
    -+			strbuf_list_free(parts);
    ++			string_list_clear(&line_sections, 0);
     +		}
     +
     +		err = ferror(source);
3:  c16b1198fd = 3:  72ef2378b9 repack-promisor: preserve content of promisor files after repack
4:  8e58c1263d ! 4:  0aceaed480 t7700: test for promisor file content after repack
    @@ Metadata
      ## Commit message ##
         t7700: test for promisor file content after repack
     
    -    Add tests that checks if the content of ".promisor" files are correctly
    +    Add tests that check if the content of ".promisor" files are correctly
         copied inside the ".promisor" files created by a repack.
     
    +    The `-f` flag is used when repacking to ensure that all the packs
    +    (created with `test_commit_bulk`) are repacked into a single new pack.
    +
         Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
     
      ## t/t7700-repack.sh ##
    @@ t/t7700-repack.sh: test_expect_success 'pending objects are repacked appropriate
      '
      
     +test_expect_success 'check one .promisor file content after repack' '
    -+	test_when_finished rm -rf prom_test &&
    ++	test_when_finished rm -rf prom_test prom_before_repack &&
     +	git init prom_test &&
     +	path=prom_test/.git/objects/pack &&
     +
     +	(
    -+		test_commit_bulk -C prom_test --start=1 1 &&
    -+		
    ++		test_commit_bulk -C prom_test 1 &&
    ++
     +		# Simulate .promisor file by creating it manually
     +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
     +		oid=$(git -C prom_test rev-parse HEAD) &&
    -+		echo "$oid ref" >$prom &&
    ++		echo "$oid ref" >"$prom" &&
     +
    -+		# Save the current .promisor content, repack, and check if correct
    -+		prom_before_repack=$(cat $prom) &&
    -+		git -C prom_test repack -a -d &&
    -+		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
    -+		# $prom should contain "$prom_before_repack <date>"
    -+		test_grep "$prom_before_repack " $prom &&
    ++		# Repack, and check if correct
    ++		git -C prom_test repack -a -d -f &&
    ++		prom=$(ls $path/*.promisor) &&
    ++		# $prom should contain "$oid ref <time>"
    ++		test_grep "$prom_before_repack " "$prom" &&
     +
     +		# Save the current .promisor content, repack, and check if correct
    -+		cat $prom >prom_before_repack &&
    -+		git -C prom_test repack -a -d &&
    -+		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
    ++		cp "$prom" prom_before_repack &&
    ++		git -C prom_test repack -a -d -f &&
    ++		prom=$(ls $path/*.promisor) &&
     +		# $prom should be exactly the same as prom_before_repack
    -+		test_cmp prom_before_repack $prom
    ++		test_cmp prom_before_repack "$prom"
     +	)
     +'
     +
     +test_expect_success 'check multiple .promisor file content after repack' '
    -+	test_when_finished rm -rf prom_test &&
    ++	test_when_finished rm -rf prom_test prom_before_repack &&
     +	git init prom_test &&
     +	path=prom_test/.git/objects/pack &&
     +
     +	(
     +		# Create 2 packs and simulate .promisor files by creating them manually
    -+		test_commit_bulk -C prom_test --start=1 1 &&
    ++		test_commit_bulk -C prom_test 1 &&
     +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
    -+		oid=$(git -C prom_test rev-parse HEAD) &&
    -+		echo "$oid ref" >$prom &&
    -+		prom_before_repack1=$(cat $prom) &&
    -+		test_commit_bulk -C prom_test --start=1 1 &&
    -+		prom=$(ls -t $path/*.pack | head -n 1 | sed "s/\.pack/.promisor/") &&
    -+		oid=$(git -C prom_test rev-parse HEAD) &&
    -+		echo "$oid ref" >$prom &&
    -+		prom_before_repack2=$(cat $prom) &&
    ++		oid1=$(git -C prom_test rev-parse HEAD) &&
    ++		echo "$oid1 ref1" >"$prom" &&
    ++		test_commit_bulk -C prom_test 1 &&
    ++		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/; \|$prom|d") &&
    ++		oid2=$(git -C prom_test rev-parse HEAD) &&
    ++		echo "$oid2 ref2" >"$prom" &&
     +
    -+		# Repack, and check if correct compared to previous saved .promisor content
    -+		git -C prom_test repack -a -d &&
    -+		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
    -+		# $prom should contain "$prom_before_repack1 <date>" & "$prom_before_repack2 <date>"
    -+		test_grep "$prom_before_repack1 " $prom &&
    -+		test_grep "$prom_before_repack2 " $prom &&
    ++		# Repack, and check if correct
    ++		git -C prom_test repack -a -d -f &&
    ++		prom=$(ls $path/*.promisor) &&
    ++		# $prom should contain "$oid1 ref1 <time>" & "$oid2 ref2 <time>"
    ++		test_grep "$oid1 ref1 " "$prom" &&
    ++		test_grep "$oid2 ref2 " "$prom" &&
     +
     +		# Save the current .promisor content, repack, and check if correct
    -+		cat $prom >prom_before_repack &&
    -+		git -C prom_test repack -a -d &&
    -+		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
    ++		cp "$prom" prom_before_repack &&
    ++		git -C prom_test repack -a -d -f &&
    ++		prom=$(ls $path/*.promisor) &&
     +		# $prom should be exactly the same as prom_before_repack
    -+		test_cmp prom_before_repack $prom
    ++		test_cmp prom_before_repack "$prom"
     +	)
     +'
     +
5:  1533fa96a8 ! 5:  d9f6341481 t7703: test for promisor file content after geometric repack
    @@ t/t7703-repack-geometric.sh: test_expect_success 'geometric repack works with pr
     +	(
     +		# Create 2 packs with 3 objs each, and manually create .promisor files
     +		test_commit_bulk -C prom_test --start=1 1 &&  # 3 objects
    -+		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
    -+		oid=$(git -C prom_test rev-parse HEAD) &&
    -+		echo "$oid ref" >$prom &&
    -+		prom_before_repack1=$(cat $prom) &&
    ++		prom1=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
    ++		oid1=$(git -C prom_test rev-parse HEAD) &&
    ++		echo "$oid1 ref1" >"$prom1" &&
     +		test_commit_bulk -C prom_test --start=2 1 &&  # 3 objects
    -+		prom=$(ls -t $path/*.pack | head -n 1 | sed "s/\.pack/.promisor/") &&
    -+		oid=$(git -C prom_test rev-parse HEAD) &&
    -+		echo "$oid ref" >$prom &&
    -+		prom_before_repack2=$(cat $prom) &&
    ++		prom2=$(ls $path/*.pack | sed "s/\.pack/.promisor/; \|$prom1|d") &&
    ++		oid2=$(git -C prom_test rev-parse HEAD) &&
    ++		echo "$oid2 ref2" >"$prom2" &&
     +
    -+		# Create 2 packs with 12 and 24 objs, and manually create .promisor files
    ++		# Create 1 pack with 12 objs, and manually create .promisor file
     +		test_commit_bulk -C prom_test --start=3 4 &&  # 12 objects
    -+		prom=$(ls -t $path/*.pack | head -n 1 | sed "s/\.pack/.promisor/") &&
    -+		oid=$(git -C prom_test rev-parse HEAD) &&
    -+		echo "$oid ref" >$prom &&
    -+		prom_before_repack3=$(cat $prom) &&
    -+		test_commit_bulk -C prom_test --start=7 8 &&  # 24 objects
    -+		prom=$(ls -t $path/*.pack | head -n 1 | sed "s/\.pack/.promisor/") &&
    -+		oid=$(git -C prom_test rev-parse HEAD) &&
    -+		echo "$oid ref" >$prom &&
    -+		prom_before_repack4=$(cat $prom) &&
    ++		prom3=$(ls $path/*.pack | sed "s/\.pack/.promisor/; \|$prom1|d; \|$prom2|d") &&
    ++		oid3=$(git -C prom_test rev-parse HEAD) &&
    ++		echo "$oid3 ref3" >"$prom3" &&
     +
    -+		# Geometric repack, and check if correct compared to previous saved .promisor content
    ++		# Geometric repack, and check if correct
     +		git -C prom_test repack --geometric 2 -d &&
    -+		prom=$(ls -t $path/*.pack | head -n 1 | sed "s/\.pack/.promisor/") &&
    -+		# $prom should have repacked only the first 2 small packs, so it should only contain
    -+		# the following: "$prom_before_repack1 <date>" & "$prom_before_repack2 <date>"
    -+		test_grep "$prom_before_repack1 " $prom &&
    -+		test_grep "$prom_before_repack2 " $prom &&
    -+		test_grep ! $prom_before_repack3 $prom &&
    -+		test_grep ! $prom_before_repack4 $prom
    ++		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/; \|$prom3|d") &&
    ++		# $prom should have repacked only the first 2 small packs, so it should only
    ++		# contain the following: "$oid1 ref1 <time>" & "$oid2 ref2 <time>"
    ++		test_grep "$oid1 ref1 " "$prom" &&
    ++		test_grep "$oid2 ref2 " "$prom" &&
    ++		test_grep ! "$oid3 ref3" "$prom"
     +	)
     +'
     +
-- 
2.53.0.585.ge25071d955

