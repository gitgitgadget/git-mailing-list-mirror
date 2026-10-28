Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171507;
	b=GYjdm6TLFYSQtJP2jw0TU8XhPz5sbrhdBaT0+gWdh9U5uGKkC3ZesbSngmCI/tDVEMWs
	 teai8KULUC1rMVO7NjcpVWI+LNHbiSG0SLpOd3m3EwW6xa7vAqs9lgNGodWGg4HqZfCXS
	 TNTbOUZOnaaqhBw5EPBDm8VDkdQ67xXpoUEvXcVNbwGOjjJ52djO8tBBGgXXWK2SVTMTs
	 9Oen9xKROfdBJwIdCITouNXUjSo8DzJws5kOEdXfkLKDIp6Bi0Hby4VRgGimyGoaB1OMV
	 S9Oz5jKZxpKx+uwykUIfVXdQUjhe8VYERksz1kjaucznP4rRqBf7wwRT+XYz86oF8Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171507;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:
	 In-Reply-To:References:To:Cc:X-Mailer;
	bh=FaflnVYqUf5kXHv3kLERPoLpgj7sprbzoI+yERGpMXU=;
	b=ofaQRU1FYlrMklalds8+WJz6OaAeFMt6aIAmd7Ic3A5rUheLJg7bmjI+ruFlsQ6WR5sZ
	 xOA8KC2Q7qZDdp1OcQdvKKYEZ+GNmdnMm4xzWPTxW8vGDiGl78J0PqdVyRTXrxsqgGP7S
	 lw6O1TRiowDGEJCniSspOjUFIApQfAecgol7y+pmdlKHnd4OWCzU2SfxkAa8Qz5UlnU66
	 O3LMn1Z3oQCdUE+f7ftKX5fGup+YZKfnGQB8GP8GTK/aWgRNhwbYaHt0YWTkrJNek7Xnc
	 HHXcR2q9BpZAe3pFQiKmjyir4G0U3ewClA4B7efzwBoxlvonVMmNuzz8soVETSh7Fiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=KEOfdLtd;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=flbGsyFD;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD9A606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCD9A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=KEOfdLtd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=flbGsyFD
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 146827A0179
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 03:11:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 28 Oct 2026 03:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793171505;
	 x=1793257905; bh=FaflnVYqUf5kXHv3kLERPoLpgj7sprbzoI+yERGpMXU=; b=
	KEOfdLtdHiyIGYxEqXnBEi8Tdo4b9tjFGXdCPmQTL1uvP0KJXJqHboL0rsurO4xW
	bxizdXDyt17nz77XCGWwR/yISo0NgtTwSKEvogwWFaJcaWbTtTRqkhK6/GgXk796
	Exj9Ed5CnTnKAE9zItESY3a5zKPoH23lVebljrEe/fch6ETfK4GcGHAjS0/AmEbQ
	zqRchlVU9zRdH1IbP1XTMmZCTm24cJVzupNRrN8slKwWqcLr0YlLhvbMP0sD0cKd
	0ppDIop6Z5y64IvBFI4eZVnM5kJKJJaCDrMjJh+8mp5wyVV3GECGETQKgJoqwEcm
	MUjfHknhOlOfRgKRRIXOYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793171505; x=
	1793257905; bh=FaflnVYqUf5kXHv3kLERPoLpgj7sprbzoI+yERGpMXU=; b=f
	lbGsyFDgmaaDZigwVN7J9aQf3s4d/9EvxstV3uATPJGzMdsg8vWQVk7g+OEXb3hI
	vUwTyGONleM1DTdIUdobNYatQL44Ayv2UyWBd5zArHa4RwCHhflYhJHrZbesK+bB
	3VeNJ3TMCA1wxBvMmZVPd/JeNjMctkMFhuuSeJOYS/Qly7yNhj/IKV9Gxx7Ae4Dx
	mpqkl3KN/5jRq2ri/0E9I3G3elXbQAo/a0akbRIByXFmzYK1pZ+9TctSVFnVyM05
	fM0Ad7X11AtmEoAeYkX07RSsDPD4blgnuJLJxo154Kt8DpZcMXPlYFQqT1bagCO7
	cMiKKiGiFV+roCRTSGaRg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793171505; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:eKGuv70dmZ//QR1jKcTAgO8T0TpiJuQo39XtKUVCSmKurQu
	RPhO0pBKFARMSlehagDk8QBkkyu9mgJnMN0UnBcgWWZHNi+oPsccUEdZiLv4gKrK
	A8sX1oswgkOoMRVOY6u5naIznozJ/QfsQyL5bUnwfndPsPj24IU3ewVgdo0jJSKd
	MOScS3I32nN6QG5iWqqsr+n8KhR2MueE7XAPsLX5mcNJopQkJ+0WNVxeSkafoGzj
	X13FvFlca1Ck350h75CgNVyItAnJ3TgvGe/yP+pOlFHe+x/tA5V5zdTR5mUGbzu0
	eHYnqAgmZTYVIzSMPR6itgv+wLLGTCW5rssULXA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:TQRTFI4tH6prTWvDm/rBCRhfIroJkwTynK/RC5C8n/8=:VJT3CdLg+MtdwlCpOOmxwa+QV9vXOmtQBZDABa8ngoQ=;
X-ME-Sender: <xms:MaDhahZ3OWDMtcJ7AyplpFofX4CynoeexCMMWBwwdt0k_V1Rh_zepA>
    <xme:MaDhauYXUU6CvwfUBVKUCgUK96tq4r7VziuwEfotFEUEam1NA0FlV7AhtEiXe3oTO
    D1-vy1dd2260MBrjFX-WXq18t8NW4cnk_o72NLkdwCKM7dCB88eGOs>
X-ME-Received: <xmr:MaDhahnHUOR0DEw2PCYoWP1DcBcmLfUtY7jQ2ZvDjJeYNJ7_TUbHRA>
X-ME-Proxy-Cause: dmFkZTEqDS4q7/XcTYNIbT8PKCs5r+twvjTiVeh+fNnb81fn4rNcp2kc2sQnixX5W69uYj
    VDCekfM/qIxP83sN15ccugnA40ljPB6e7pQTBLiYStrOzQNQhYvQhUUg7PVOiIMWztFU7z
    EUen7OxumMYxLQ2W1uNSlRY+EfFgsYRQZwtNWMpN4bhT9QSNRBOl2YVeGxWN/ALAPVR1Fl
    HzgA1htoTJIVEQgagKjQAAYVdyO3K6cWgZYfmGmJmiV5o8W1TaYvgBmRqCTUfC0/4mRAC8
    pvRI7fjq4WwOj8o1VRF5S3OJjm3edk3u0G86HuaZQZWWT4qX0wftCY2Z3xS8YPg4pWsRWp
    8xnpcGy8m754Ei0MDUT+ZitbPtHvXe+lyqlzM52mLgLgRmuK0AXsEkQReZIBqbheN39GSS
    gFNO9+65bevR/rpYPUfZksebqkxRV3KjkBpkBUCwqCkJFX7FHFKCupEIBGb1pIXv8UWPNg
    WptKL9v5iOQS2LAknK/Jeiw6Sx2mGCeYDgaPR9zmvdHyUJSkH0CA6tcVkDn9HbF7Woybpc
    WmLB1wf/4aV6I4qzviBdpk1jE5/fY0Jt7eyqaU4i2cw0thWpctxnnaLI/b7HXB+vBUleb4
    DXltZGScMzrAlelbY4OWDoGnG7Mj6+EcLaALzJ+awpag6Eu3GKLNbbH3lRJA
X-ME-Proxy: <xmx:MaDhaqyEKyrYuqsDEM7y-XprC9kHk8c6WXrlmLpOcCeR--PNgbK0ow>
    <xmx:MaDhavOCEG6NrTucRolE5A_EhKTvjSPP3sFv_yoEb8-yVywmrZa6vw>
    <xmx:MaDhauT-ScL6PQQo53sOy8Z9WmLjMf9QVssl7MbEVruyG1Z1ct7UFg>
    <xmx:MaDhatYRR8LjG1TI-r3Jlap1etZkhMFflhbHERVzDYRyMuYyXjAY4A>
    <xmx:MaDhanJzh_NwOY-_Ne7ePWdsUrRnyZLDhgYU1wKRicVqvo1O2SaEZLkj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 03:11:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ef880786 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Oct 2026 07:11:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/6] odb/files: reload alternates on retry again
Date: Wed, 28 Oct 2026 08:11:38 +0100
Message-Id: <20261028-pks-odb-files-reload-alternates-v3-0-011ddb64b626@pks.im>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOyw7CIBBFf6VhLYZHW60r/8O4oDBYtJYGkGia/
 rtQjXHX5Z3ce85MyIMz4NGhmJCDaLyxQwp8UyDZieEC2KiUESOspoSWeLx5bFWLtenBYwe9FQq
 LPoAbREgXpWWtJEldxlCijA60eS6G0/mT/aO9ggwZmxud8cG61/JCpLn3tTGyaosUE6waoFXNG
 d/z+pgWW3NHWRXZP4yvw1iCcVJVjdppXfL2B5vn+Q3azqzRKgEAAA==
X-Change-ID: 20261014-pks-odb-files-reload-alternates-dfc6dc010122
In-Reply-To: <20261020-pks-odb-files-reload-alternates-v1-0-d9e156323836@pks.im>
References: <20261020-pks-odb-files-reload-alternates-v1-0-d9e156323836@pks.im>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>
X-Mailer: b4 0.15.2

Hi,

we recently noticed that we don't reload alternates anymore when an
object cannot be found. This used to be the case, but broke with
5946a564cd (odb/source: make `read_object_info()` function pluggable,
2026-03-05). And while it's a rather uncommon scenario that alternates
are getting rewritten while a Git process runs we managed to hit some
such scenarios in production systems.

In any case, this patch series fixes that. In practice, only the third
commit is really needed to restore functionality. I was a bit unhappy
about the performance impact of this change though, as fixing the logic
regressed us from 185ms when looking up 20k missing objects to 262ms. So
subsequent patches do some optimizations that bring us down to 199ms.

The series is built on top of 47fdf2208c (The 7th batch, 2026-10-19)
with ps/odb-files-alternates-cleanups at f211a3f0b5 (odb/source: drop
`local` flag, 2026-10-15) merged into it.

Changes in v3:
  - Reinstate NEEDSWORK comment.
  - Some typo fixes.
  - Update stat cache before reading the "info/alternates" again, while
    still invalidating it in case we hit an error.
  - Mention the change in behaviour around the error messages when an
    alternate disappears.
  - Link to v2: https://patch.msgid.link/20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im

Changes in v2:
  - We now properly load alternates from the primary object directory
    again even in the case where a quarantine directory is active, based
    on Christian's feedback.
  - I redid how we deduplicate alternates as a result of that. The
    resulting logic is simpler now while still giving the same
    guarantees as before.
  - Link to v1: https://patch.msgid.link/20261020-pks-odb-files-reload-alternates-v1-0-d9e156323836@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (6):
      odb/source-files: rename alternates-related functions
      odb/source-files: always load alternates via primary object directory
      odb/source-files: reload alternates on retry
      odb/source-files: simplify directory duplication detection
      odb/source-files: avoid stat'ing already-known alternates
      odb/source-files: only reload alternates when the file has changed

 odb/source-files.c  | 203 ++++++++++++++++++++++++++++------------------------
 odb/source-files.h  |  21 +++---
 t/t1006-cat-file.sh |  32 +++++++++
 3 files changed, 150 insertions(+), 106 deletions(-)

Range-diff versus v2:

1:  f7b3edcf250 = 1:  7979e39d4b7 odb/source-files: rename alternates-related functions
2:  3515b5acbe1 ! 2:  7c67df43102 odb/source-files: always load alternates via primary object directory
    @@ Metadata
      ## Commit message ##
         odb/source-files: always load alternates via primary object directory
     
    -    The files source tracks a list of object directories. The head of the
    +    The "files" source tracks a list of object directories. The head of the
         list is typically expected to be the primary object directory, whereas
         the tail is the list of alternates linked to it. This assumption does
         not always hold though, as transactions cause us to prepend another
         quarantine object directory to the list.
     
         This is not much of a problem now, but in a subsequent commit we're
    -    about to re-read "objects/info/alternates" when we hit a missing
    -    objects. So we may start calling `prepare_alternates()` in situations
    -    where the head of the list is _not_ the primary object directory, but if
    -    so we would now try to read alternates from the quarantine directory and
    -    not from the primary object directory.
    +    about to re-read "objects/info/alternates" when we hit a missing object.
    +    So we may start calling `prepare_alternates()` in situations where the
    +    head of the list is _not_ the primary object directory, but if so we
    +    would now try to read alternates from the quarantine directory and not
    +    from the primary object directory.
     
         Fix this issue by instead using the path of the "files" source both when
         reading alternates in `prepare_alternates()` and when deduplicating the
3:  da5a24624e8 = 3:  8882555124e odb/source-files: reload alternates on retry
4:  13e4e857f68 ! 4:  64d76b0ac94 odb/source-files: simplify directory duplication detection
    @@ Commit message
             Wall Time    266.5 ms  ±     2.8 ms     262.6 ms  …   276.7 ms            -7.8%
             Memory         5.9 MiB ±     0.1 MiB      5.6 MiB …     6.1 MiB           +5.1%
     
    +    Rename `dirs_paths_icase` to `dir_paths_iscase` to match the naming of
    +    the newly added set.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## odb/source-files.c ##
    @@ odb/source-files.c: static bool odb_files_dir_is_usable(struct odb_source_files
      	/*
     -	 * Prevent the common mistake of listing the same
     -	 * thing twice, or object directory itself.
    -+	 * Prevent the common mistake of listing the same thing twice, or
    -+	 * object directory itself.
    ++	 * Prevent the common mistake of listing the same thing twice,
    ++	 * or object directory itself.
    ++	 *
    ++	 * NEEDSWORK: we're using "core.ignoreCase" to deduplicate
    ++	 * alternates that _may_ be the same. This requires quite a bit
    ++	 * of boilerplate for dubious benefit:
    ++	 *
    ++	 *   - Duplicating alternates should really only lead to
    ++	 *     regressed performance.
    ++	 *
    ++	 *   - We don't properly resolve symlinks or mointpoints, so we
    ++	 *     may still end up duplicating alternates.
    ++	 *
    ++	 *   - The value may be lying, in which case we might
    ++	 *     deduplicate alternates that are in fact not mapping to the
    ++	 *     same directory.
    ++	 *
    ++	 * We should investigate whether we can remove this whole
    ++	 * mechanism outright.
      	 */
     -	if (!hashmap_get_size(&files->dirs_by_path)) {
     +	if (strset_empty(&files->dir_paths)) {
    @@ odb/source-files.h: struct odb_source_files {
     -	 * map is used to detect the case where the same directory is
     -	 * registered multiple times.
     +	 * Set of directory paths that have already been linked into this
    -+	 * source. This map is used to detect the case where the same directory
    ++	 * source. This set is used to detect the case where the same directory
     +	 * is registered multiple times.
      	 */
     -	struct hashmap dirs_by_path;
5:  503d369bc82 ! 5:  387892c5b36 odb/source-files: avoid stat'ing already-known alternates
    @@ Commit message
             Wall Time    260.7 ms  ±     3.4 ms     256.8 ms  …   271.1 ms           -10.0%
             Memory         5.9 MiB ±     0.1 MiB      5.8 MiB …     6.1 MiB           +4.7%
     
    +    Note that this causes a user-visible change in behaviour: when an
    +    alternate was already linked into the "files" backend, its directory
    +    disappears afterwards and we later try to reload alternates, then we now
    +    stop printing the error message that the object directory does not
    +    exist. That feels sufficiently niche to not really matter in practice
    +    though, and other than that the user-observable behaviour remains the
    +    exact same.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## odb/source-files.c ##
    @@ odb/source-files.c: static bool odb_files_dir_is_usable(struct odb_source_files
     -	}
     -
      	/*
    - 	 * Prevent the common mistake of listing the same thing twice, or
    - 	 * object directory itself.
    + 	 * Prevent the common mistake of listing the same thing twice,
    + 	 * or object directory itself.
     @@ odb/source-files.c: static bool odb_files_dir_is_usable(struct odb_source_files *files,
      	if (strset_contains(&files->dir_paths, buf.buf))
      		goto out;
6:  8c4dbb5e7e2 ! 6:  1059c029cf7 odb/source-files: only reload alternates when the file has changed
    @@ odb/source-files.c: static void parse_alternates(const char *string,
     +		fd = open(path, O_RDONLY);
     +		if (fd < 0) {
     +			warn_on_fopen_errors(path);
    -+		} else if (strbuf_read(&buf, fd, 1024) < 0) {
    -+			warning_errno(_("unable to read alternates file '%s'"),
    -+				      path);
     +		} else {
    -+			parse_alternates(buf.buf, '\n', object_dir, out);
    -+			successful = true;
    -+		}
    -+
    -+		if (validity) {
    -+			if (successful)
    ++			if (validity)
     +				stat_validity_update(validity, fd);
    -+			else
    -+				stat_validity_clear(validity);
    ++			if (strbuf_read(&buf, fd, 1024) < 0) {
    ++				warning_errno(_("unable to read alternates file '%s'"),
    ++					      path);
    ++			} else {
    ++				parse_alternates(buf.buf, '\n', object_dir, out);
    ++				successful = true;
    ++			}
     +		}
     +
    ++		if (validity && !successful)
    ++			stat_validity_clear(validity);
     +		if (fd >= 0)
     +			close(fd);
      	}

---
base-commit: c8e565497cff47f6b23a6b96bef6fa82afa11667
change-id: 20261014-pks-odb-files-reload-alternates-dfc6dc010122

