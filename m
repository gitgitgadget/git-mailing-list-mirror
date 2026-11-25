Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634861;
	b=nO737aDJtAYvwwyejBqIim7eHLF5fgfyyJ85b2Y0w2G1rutXbzigqZkrFmay/aeWSSAC
	 WnvVwGBcWYogWsi8bxYNNUtydnbKLaZiVuAiyoL2ZWa3sT7ycAt8QsWlqwZ4UFa4enexT
	 FmZ189s86jnnR23zH9bgf9ZbUlT0bzXZXdtjZaRAZQ55x6qj/EQWMSr5hqM9UA+QUAJQq
	 9C4zIEOd792f3CCr049hi0CYGh2E6aE/fVNqzU5+rSi8qTXY0I1BMmzVtTvHCzZEWsGC3
	 ImAOPm4nF+ZwJCkSPp1fUVh29znHOy0T/Xm9GAO6RRIU+ty3wf3B00ehdHaCcmnYsGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634861;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ZJvwAGl/eW1ROJ7OtJgs6hJuNfJv0HFxGw2LR1ZyhqM=;
	b=LnWeG7spGJ3n1MgTgvDyyt0T23n3kjQtxmaZzy5Ry4mXf9HYfNhXk2t7wCpUoaTGrR5T
	 7aVEdhM/VVDV3GvKdsLBAJI6NdO3ngX4o8ZoQyqjaJAl/Sog9dwZcsb+GMgzrXTD8YXze
	 rcnCXzMOI/gmWzwmU78n5ARN5i359Iq4fwAgTu5q3yWQaHgE4Q/ntxqnbEGO1zdCgSCcX
	 NwcxwWExkLrO2v6q5XN/xy3c6YvW3+VeXEhsEjKGiVl9p42i114jWoX+M5jmZK6fkx85g
	 eo/mV24Q/znifWtySwSXvB4tC3bDVlahAeXShtkx/M8s50E8eKh9HOy2Fg8NplNYlVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ahuZXhu6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2Iv9iAJ6;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C760606A333
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 19:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C760606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ahuZXhu6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2Iv9iAJ6
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9B77D140034F
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 14:27:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 25 Nov 2026 14:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795634859; x=1795721259; bh=ZJvwAGl/eW
	1ROJ7OtJgs6hJuNfJv0HFxGw2LR1ZyhqM=; b=ahuZXhu6mKTA78cAtu8wlU/LfE
	/u81NV8jAB5soHAfa0YsbESaEahoQQ937AMX7bu/EJJYthhbLcBpKMbW4SQCncOY
	poYEcwwp0M6712D40vgzsW2uaqmTEHBlbOzOTi/Xo1B0yqB6Omet0zjnyn3ESPjX
	j1JTDdw2sse6/139wklJUllf7XW35Pn7yYgGo49IomE9Yq9gAjQhZtDVZ5VsZ3dF
	LhxDeri4+6b636BimAA+x9W5wvBYiIo/JJLdFbUi5mVuZ/b8SsoMRB9k0yN6i6Ri
	8Z1LAFW1MN+8KPfXk75l06i061/5j0yvt4bxamYHsvv7WUAniPvJ27/v3KZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795634859; x=1795721259; bh=ZJvwAGl/eW1ROJ7OtJgs6hJuNfJv0HFxGw2
	LR1ZyhqM=; b=2Iv9iAJ6vQtxG/6uMU7QSAFJ2k2Eecx0r2MlOlNp/dQqOOUEcnj
	E6BO5GhGc8DLbddk4zU8RhkeZ4mFlAwaXcP0mIurT2KLKiM/scRs4yJuQ04D+6Nb
	s54rE3VjDL5TIdfyz4sMb0iDFcxBuwJC9vIDKBW2gTqDLUvnxYGZVftS2IMcaCOy
	ORAAERV4uJEDqBMGK0Qkiy+FEx3hsBLCH+2IVG1rtRg5vcswNkZh/XNaja2vQ5bb
	LSmHdycROsjXfqzro+iKbPvq19UY0yLmD/n61Os9AGuR+97olZ/2i9NsCZevV8IL
	oNOFKNZ4IhMNdSnVIMVfSb2TN5qqoj7e2hA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795634859; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:gbMczGpBrkKmFLKHhs60Qyli15/cpUeC8AJ5dhouxabeXwz
	Ro2E/SzyRjkKwHOvd/aQG6HP4er5dBFLdc0UBaP6doWjVbbHAZBvCxW0cPQU3Ay4
	nFVMun+oDS07QHrAB3/oWEYcvxhGvinJ5M8VV1elcyX4+zoQkzcUq7CFzyzxrrV+
	ukJOV8Cp6Gj6DEszs8yuWpZvJQq6vVMvOKmjBu13m5+iSUmVGYP5HjkjAc5XP5FN
	paPZ44DskjUPw9rzGvgZl5L7ERUpYSKbYY93T93sru9RazB8xtoG/mtqgwvbbR8N
	S5hMml7HOnbxnZBWPpfBnh3VEA0Hk5j027KWWZw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:x99Y/m8PNjmgmatxz6WCt5ZiTght42xSAduNamkLq60=:5wGPfE3TpwEeaJSLhbAhdd6/sGXIPXwFxh7mkRAVLHU=;
X-ME-Sender: <xms:qzYHa-WRYrXv0xgDaFnsiFAev6JyBDWfygW5BHfNmXK_CsVeF_hwJw>
    <xme:qzYHa-Qdmdanj-MNXuBYqJiqQTIJ9UDj5CwD9NNUPQ4r1JnwYIiZuAm04VSK7z3uT
    B_05eZmfYdgDgEF-SCQv0ha0AutnXzE6_2KFanoRmZYOK0uJgpiwfU>
X-ME-Received: <xmr:qzYHa8Ps_34pHrxcNhV9Fmok-ws1x4ZvqqNcW1-OL0lS6i1EtHCvnP5JTpDvEUk1GbJwQlYV1k0svC4buMiJ4o4uIkyxU0U7jTuz73Q>
X-ME-Proxy-Cause: dmFkZTGwXHPSE2GoHLbKxsTwTJU1wpaGnFSuu6o9svnNYyUXe4iFlNEQl1gw+nzBUL7Rwy
    sgLb2zf01B6FCHrbM4BF5jzNo9SPfY2zR1wxc2ca9tZ741s4aBuYmckPWx207/I9g9fHvI
    ZfOEHEPSrnXcH8EtbjkRd5ti2jDwxL31S08aUla4NdK9On927qxzpAMCoAB7kUGOXzr+BT
    gQQcCqJ6b1vzQ0ayZ+FHFd3EfUHDnPkiqQ5nxMtXYCbUXDypfarh7Ef2hrKIc8BfVLdy/T
    VXPOPH8wNbvNftMgLBnf12+nnKHip1ZtkBKhNAxix17OmWH7hZpFxpQAgJtWXZLmxpBTrm
    I6ovTMHqn+jss6/AH/ZxNA0tmLivdNlystsBlk0DADu5NsLzFAyGBo7uCUR+aWtf7wG2l+
    5j1Y8h3PYtGyvBpbR3mlRPBXaeBYmIa2tQnEUdziGBQWSET7jKT/vLlQ4kV3WFy8qWvLej
    ti/+jRQPZR1INczr68WqE6RPjjLdS1wyY3WxkLJMpL/GF+7lkqiLntnsJhwBQ19c/W5vX5
    bgYM3JEQQlU4MKfdrRW70mTsqkMA/EdpG9On2XEbr567Pzu6nUmgt06dEgp29gJy8G/xlp
    wLbTEjrXgj5O6qXEhcB4vbUcJz62Grxb8HqrUudzZ/VaCPSgT3u0ooBcZ59A
X-ME-Proxy: <xmx:qzYHa8RwYEMaIstrGPS7f1vkjSFHSlvuKI2lxBZfj8Atw4gkRRseUg>
    <xmx:qzYHa6jqhaiS3qXQnCsGhrok6qmIPEiSI5LYjbg3pJN14pUQV0Djpw>
    <xmx:qzYHa1_456MQOxyWtmcuXzWyvh9dqO0A5KYcIIm4aiauzBjl8ooXXQ>
    <xmx:qzYHaxGRhpqIe01EjXGlz190SIUw7maN5dAg8zPBgMgkBAYLr692hg>
    <xmx:qzYHa_IjFu0HbIuedOwvDo1SN4RS7MDPg-pzbc2yJRpGlaQicldPmNws>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 14:27:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Adithya Chakilam via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Martin Fick <mfick@nvidia.com>,  Christian Couder
 <christian.couder@gmail.com>,  Adithya Chakilam <achakilam@nvidia.com>
Subject: Re: [PATCH v2 2/2] repack: also copy loose objects excluded by
 --filter-to-loose
In-Reply-To: <0f1f0356b46e59cb588b046540034e09dfa7fe7d.1795571091.git.gitgitgadget@gmail.com>
	(Adithya Chakilam via GitGitGadget's message of "Wed, 25 Nov 2026
	01:44:51 +0000")
References: <pull.2314.git.1794607911.gitgitgadget@gmail.com>
	<pull.2314.v2.git.1795571091.gitgitgadget@gmail.com>
	<0f1f0356b46e59cb588b046540034e09dfa7fe7d.1795571091.git.gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 11:27:38 -0800
Message-ID: <xmqqwlq01zkl.fsf@gitster.g>
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

"Adithya Chakilam via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
> index bcd7c1fe54..1cba380177 100644
> --- a/Documentation/git-repack.adoc
> +++ b/Documentation/git-repack.adoc
> @@ -192,6 +192,10 @@ depth is 4095.
>  	not rewritten. All objects are written before any existing
>  	pack is removed.
>  
> +	Loose objects in this repository that the filter excludes are
> +	copied to `<directory>` as well, and with `-d` the source copies are
> +	removed once everything has been written.
> +

Does this format correctly?  Have you tried "make doc" and checked the
rendered results?

Find and imitate how the next entry `--drop-filtered::` adds second and
subsequent paragraphs by prefixing them with a line with a lone '+' on
it, and not indenting them.

>  --drop-filtered::
>  	Delete the local objects that match the `--filter` specification
>  	instead of keeping them in a separate packfile, reclaiming the

> diff --git a/repack-filtered.c b/repack-filtered.c
> index b33274b5b8..180c28a758 100644
> --- a/repack-filtered.c
> +++ b/repack-filtered.c
> + ...
> +int move_loose_filtered_objects(struct repository *repo,
> +				const struct list_objects_filter_options *filter,
> +				const char *dest_objdir,
> +				struct oidset *moved)
> +{
> +	struct odb_source_files *files =
> +		odb_source_files_downcast(repo->objects->source);
> +	struct oidset loose = OIDSET_INIT;
> +	struct oidset omitted = OIDSET_INIT;
> +	struct oidset_iter iter;
> +	const struct object_id *oid;
> +	struct strbuf src = STRBUF_INIT;
> +	struct strbuf dst = STRBUF_INIT;
> +	struct strbuf tmp = STRBUF_INIT;
> +	int ret = 0;
> +
> +	if (filter->choice != LOFC_BLOB_LIMIT)
> +		return 0;

This silently turns move_loose_filtered_objects() into a no-op for every
filter other than 'blob:limit', doesn't it?  That contradicts both the
proposed commit message and the documentation.

In particular, suppose a repository has a loose blob and the user runs

    git repack -a -d --filter=blob:none --filter-to-loose=../dst/objects

The main pack-objects invocation excludes all blobs,
write_filtered_pack() passes --stdin-packs without --unpacked so it only
sees existing packs, and move_loose_filtered_objects() returns 0
immediately.  The loose blob is neither copied to the destination nor
removed from the source.  The code should support LOFC_BLOB_NONE at
least and document and reject unsupported filters, no?

> +	ret = for_each_loose_file_in_source(&files->dirs->loose->base,
> +					    collect_loose_oid, NULL, NULL,
> +					    &loose);
> +	if (ret)
> +		goto out;
> +	ret = list_objects_filter__filter_oidset(repo, filter, &loose,
> +						 &omitted);
> +	if (ret)
> +		goto out;

Enumerating every loose object on disk and filtering purely by size
ignores reachability, pack membership, and the index.  Note that in
cmd_repack(), move_loose_filtered_objects() runs after the main pack and
any cruft pack have been written, yet before generated_pack_install()
and prune_packed_objects() have removed loose copies of newly packed
objects.

Consider three cases where a loose blob larger than the blob:limit
threshold exists in the source repository.

 * with --cruft -a -d, write_cruft_pack() packs an unreachable loose
   blob into the new cruft pack, leaving its loose file on disk until
   prune_packed_objects() runs later.  Because
   move_loose_filtered_objects() runs beforehand and checks every loose
   file, it copies that unreachable blob to the destination, breaking
   the invariant tested in [1/2] that unreachable objects in cruft packs
   are left alone.  Am I mistaken?

 * with -a -d (without --cruft), an unreachable loose blob is never
   packed, yet move_loose_filtered_objects() copies it into the
   destination and remove_moved_loose_objects() unlinks the source copy
   immediately, bypassing normal prune expiration and polluting the
   destination with unreachable objects.

 * in a non-bare repository where a large loose blob is staged in the
   index, pack-objects --indexed-objects keeps that blob in the main
   pack rather than filtering it out, yet move_loose_filtered_objects()
   still copies it to the destination.

In order to move only truly filtered-out reachable objects, a walk from
the refs over reachable objects, or filtering after packs are installed,
excluding any object that ended up in the kept/new/cruft packs or index,
is needed, instead of walking all loose files indiscriminately, no?

> +	oidset_iter_init(&omitted, &iter);
> +	while ((oid = oidset_iter_next(&iter))) {
> +		odb_loose_path(files->dirs->loose, &src, oid);
> +		dest_loose_path(&dst, dest_objdir, oid);
> +
> +		/*
> +		 * Only the destination decides whether the copy is needed;
> +		 * the object being present in the source says nothing.
> +		 */
> +		if (!access(dst.buf, F_OK)) {
> +			oidset_insert(moved, oid);
> +			continue;
> +		}

As noted on [1/2], if dest_objdir is the source repository's own object
directory, dst and src refer to the same file, so access() succeeds and
remove_moved_loose_objects() unlinks the only copy of the loose object.

> +		if (safe_create_leading_directories(repo, dst.buf) < 0) {
> +			ret = error_errno(_("unable to create leading directories of '%s'"),
> +					  dst.buf);
> +			goto out;
> +		}
> +		strbuf_reset(&tmp);
> +		strbuf_addf(&tmp, "%s.tmp-%"PRIuMAX, dst.buf,
> +			    (uintmax_t)getpid());
> +		if (copy_file(repo, tmp.buf, src.buf, 0444) ||
> +		    finalize_object_file(repo, tmp.buf, dst.buf)) {

Two issues:

 * copy_file() maps mode 0444 to 0666 (masked by umask), so the written
   loose object is writable instead of read-only 0444 as created by
   normal loose-object writes.  As we do not specify what the
   destination directory really is (other than "it looks like an object
   directory with a bunch of loose object files in it"), it might be OK
   that such details are not identical to real object files, but I
   suspect that it is not your intention to offer a poor imitation of
   it.

 * Naming the temporary file <oid>.tmp-<pid> uses O_EXCL against a fixed
   PID name and does not match the tmp_obj_ prefix that fsck ignores, so
   a crashed run leaves a file that triggers "bad sha1 file" warnings in
   'git fsck' and can block a later run with the same PID.

Using a tmp_obj_XXXXXX template with git_mkstemp_mode(..., 0444) and
copy_fd() would avoid both of these problems.

> +void remove_moved_loose_objects(struct repository *repo,
> +				const struct oidset *moved)
> +{
> +	struct odb_source_files *files =
> +		odb_source_files_downcast(repo->objects->source);
> +	struct strbuf path = STRBUF_INIT;
> +	struct oidset_iter iter;
> +	const struct object_id *oid;
> +
> +	oidset_iter_init(moved, &iter);
> +	while ((oid = oidset_iter_next(&iter))) {
> +		odb_loose_path(files->dirs->loose, &path, oid);
> +		unlink(path.buf);
> +	}
> +	strbuf_release(&path);
> +}

Unlike prune_packed_objects() that use unlink_or_warn(), this silently
ignores unlink() errors.  It also leaves empty 2-hex 'fan-out'
subdirectories behind, which may or may not matter.

> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 1b74d40551..d48ab73293 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -547,6 +547,44 @@ setup_loose_src () {
>  	fi
>  }
>  ...
> +test_expect_success '--filter-to-loose leaves an identical existing destination object alone' '
> +	setup_loose_src &&
> +
> +	test-tool genrandom big 2k |
> +	GIT_OBJECT_DIRECTORY=loose-dst.git/objects git hash-object -w --stdin &&
> +
> +	path=loose-dst.git/objects/$(test_oid_to_path $big) &&
> +	test_path_is_file $path &&
> +
> +	ls -i $path >before &&
> +	git -C loose-src.git -c repack.writebitmaps=false repack -a -d \
> +		--filter=blob:limit=1k --filter-to-loose=../loose-dst.git/objects &&
> +
> +	ls -i $path >after &&
> +	test_cmp before after &&
> +	git -C loose-dst.git fsck
> +'

I am not sure what this wants to test.  Does this test [1/2]'s
unpack-objects code path, rather than the access() + copy_file() in
move_loose_filtered_objects() that is new code in this patch?

Also 'ls -i' as a measure of testing file identity is not portable (some
platforms lack the notion of i-num) and nowhere else in the t/ directory
do we use it.  Perhaps 'test-tool chmtime' or something would serve as a
substitute?
