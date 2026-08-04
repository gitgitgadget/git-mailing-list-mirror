Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F9E3E7BB0
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832199; cv=none; b=RcYpSjUd9UEncJWU4v11bwQzIRUroeWGFeqXbTo1+7ZmZJI6M49Bz+2Vl08ColV9be9t/FFjbx6Sto6XuxbeTbjd9pAa2o+ZNFahJ+O3OQP0nnCtY3ZB+2bvlLqC3C4VuVnYfmjoi3mgHx25flgmFASyMrWBqE/hd2uwTaOzBdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832199; c=relaxed/simple;
	bh=QtOu60qZ2pMT3B+zVK3e+hiXRDB2tR/vKcSza17Qqec=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=URFL8bqcZ1I/NYpSAgCmHvBLTxRDBuJFsXpCV0rFOiDEtPzvowVuctx6GzN9sc3ixHp6bl2bhLZc/DSPv/Ud6wge0VCIJxKTpvOvA0jC2WhV6Ej+2rjpLQgX1WJsH1hR70smbJ8HD5LFDKMgL81MB/gP5nztYxExyPdpjQlyuTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dfgKosVd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AkmfZqus; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dfgKosVd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AkmfZqus"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 4AD251D0016E;
	Tue,  4 Aug 2026 04:29:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 04 Aug 2026 04:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785832196;
	 x=1785918596; bh=ybJWhVzB8wmti3BPBSJ6NwhxP3oTufm8quBMKmaIKAY=; b=
	dfgKosVdjhNOx8IbgzqRQ/BhdeDATSZpxdcFMnOB3ojOhnb6GCOh07h2tSh7IJT6
	UhJTC5PVk1lcwelnMNztp+bl3AkWDDzR82Z2wU26oW05cPqaGiVyygIg5m+2oUHP
	Ufe8H2VDNljmlwy6B4zVf/1iQaty+5lrqQWv1kOLLKTZswgyr9DIw6pqCgZLtKrM
	ue7hCSzl5TRbWJO/bP8qIw2/3bWp3OgzLMHxYBls1228FfgkiiFm2FnlpkoojfZo
	cVvJyf3iil2K5SF0Ufic5GjGx6zazHzuHC/LRM3/kB/qVjPcLrSxuvn/zm7ui3Hy
	HJ17tbcDitXjbNRy+Alkzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785832196; x=
	1785918596; bh=ybJWhVzB8wmti3BPBSJ6NwhxP3oTufm8quBMKmaIKAY=; b=A
	kmfZqus1tLrK/gXN/KUjCPWwIarZW9Pm/JrOL5/agT8EoReaEq6UvQ8psb6eb2kN
	ISStrZDtLT8AJcLDDWvGD26ELIHX0HbJ2MUGdNF/tkmohj9nhyDGaSIOQeD8Nu0w
	CnojkQHg/Hz9fCiSmWBzFoA4qOxabEoMhiqGudTF506T56+ll+Ftq+pVy6zFiXbs
	EgLnsJ1GGGyn9PJcsC66oZesxnWRNESeGu2MR9AWNfYKniOhD7dBPFfIBbYHggsz
	mKq/F5p9gNdskD/NUDPyyym4NHjFZiFYUqvl624ip8rqJDCRacmtwpDvrwzG0wfy
	z4uHLS+2iOWjA5H8boGHQ==
X-ME-Sender: <xms:A6NxapmjWEyoRG8wE7QGT1lPiJ5ixljuDLQgI2IItGBBBGlMo8g7DA>
    <xme:A6Nxar3e8wZabg2FfIYd2DHz58Icx2aXhR5_nr2K8x_I2JlodB41E0gSGsVJOLOEE
    L2gnCa2StT3VA6RAN8qkTZupWWwbw5DDnN--lA380rq0gvjXHktMgE>
X-ME-Received: <xmr:A6NxakqyGbp_BoJD6mN4sQvyb4NTxfyuYpHUHvTXeX7Zgylr3apTgg2lS7bs_SBJGwoBKbwzSZjsLtopqjyPT7qQxt-77vEuZeaz1sKJ>
X-ME-Proxy-Cause: dmFkZTFnqiopGEgo+6IxfjSjwH6ZvzHxiQQceEGxyeobkGbQJIP0tUWyzCgHXRFZKD87XB
    i94NO3rXNsO5FaBdD26k33zncvf/2FkjUtH7PMhf5l3zcUWYNAn8SH7DgOrwghB3oVGuma
    UEl8MroQOI2UNALjeb0SIwwR+ol3iLA3vGsyNjWNE7zQNPy2spmVtHQDgRZz0ID2lT2EUI
    Mrk8oR2iqvCeLpSUs/uDrd05YCczt8yamA95pNbYk8Rq6D5PJHTKqzXCFtXIbdec3ocWUT
    sCZhsrJHqPXjH44sk7cy606RhAI12myBLocG0nbu+Cdqbu7I5181TdvSDifA9aM1pxq/Dm
    rr13g2nAx6MyeLSNj0fe9ADZEtsvw2zlpMV5Ai1NakQOfLQz9PzD6bnL+VpEMx5z5gbd/w
    lxRki1SOsbO/aX6HCP1O7pxXlGH/r+kn25bLSIr0NeRQ3WhZ4n1IjUecMy2RH4u0uZ4qZe
    AFhdnbGUyAsGIfu6JK/vJYBbIgho/4mygb49Z8GkH7kF+rtuFx4502eOfm1mvMlDFfTS/q
    6+Gh0KuP/UsRJE8JwkKW4/5XSQSJAFGTGx1IG0JiUDCjBqBO5OfHLkC+vGqbPVVsvEINYk
    P6ehLmzGPf6J3hm5mImra0GiO6JHVdZqnFc1WWd0fhtAs+PFSyc2jxHT2uJw
X-ME-Proxy: <xmx:A6Nxaodzd7Qz26OCAmXlqpB2F4yW3-crkTNpc8o6R1A39PUMz9r2lQ>
    <xmx:A6NxajqwXGibHoMTkNoU5m7rnF3c2bpHchVgCM3yKVrx5L6_tcamDA>
    <xmx:A6NxapFy2cVrj4obRPgeXc-s0tNFHQOr5fg4KGe9-TYl3-zIKWa11g>
    <xmx:A6NxajshG344IX8eo7QrA-Huvb2QosVVQGOSCEZ6Ngp3gENaOHyk8w>
    <xmx:BKNxamr_5vNayfsC_jCsDkJrSHLqcZZo-FkhGpFOpksEdUI9O8DaeAzJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 04:29:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dd475f06 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Aug 2026 08:29:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/5] odb: make creation of object database pluggable
Date: Tue, 04 Aug 2026 10:29:05 +0200
Message-Id: <20260804-pks-odb-create-on-disk-v2-0-ddf8b59bd207@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6CMBAFf4X07Jq2SAuc/A/DgbarrERKWiQaw
 r9b0KvHSea9WVjEQBhZnS0s4EyR/JBAHjJmu3a4IZBLzCSXimvBYewjeGfABmwnBD+Ao9hDi6U
 udKmEVRVL4zHglV778aX5cnyaO9ppe9uMjuLkw3svz2LzfhF5+heZBXDITe6kKlylK3NO4pEer
 FnX9QOx5tFUywAAAA==
X-Change-ID: 20260710-pks-odb-create-on-disk-ae8757861c69
In-Reply-To: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

Hi,

when creating a new repository we create a couple of on-disk data
structures for the object database. This includes the "objects/"
directory hierarchy with "objects/info" and "objects/pack", which are
specific to the backend.

This patch series makes the creation of the on-disk data structures
pluggable. While we continue to always create "objects/" regardless of
the backend (it's required for a repository to be recognized as such),
the other subdirectories are now created by the backend. This will allow
other backends to plug in their own logic.

The series starts with a small detour into the loose-object map. This
detour is required so that we can defer initialization of the object
database itself to a later point in time.

The series is based on 9a0c4701dc (The 7th batch, 2026-07-22).

Changes in v2:
  - Add a testcase that demonstrates the bug fixed with alternate loose
    object maps.
  - Rename the "inmemory" bakcend to "in-memory".
  - Clarify some commit messages.
  - Link to v1: https://patch.msgid.link/20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (5):
      loose: load loose object map for the correct source
      setup: detangle loading of loose object maps
      setup: defer object database creation
      odb/source: introduce function to map source type to name
      odb: make creation of on-disk structures pluggable

 loose.c                       | 25 +++++++++--------
 loose.h                       |  1 +
 odb/source-files.c            | 19 +++++++++++++
 odb/source-files.h            |  4 ++-
 odb/source-inmemory.h         |  4 ++-
 odb/source-loose.c            |  2 ++
 odb/source-loose.h            |  4 ++-
 odb/source-packed.h           |  4 ++-
 odb/source.c                  | 19 +++++++++++++
 odb/source.h                  | 29 +++++++++++++++++++
 repository.c                  |  2 --
 setup.c                       | 65 ++++++++++++++++++++++++++++++-------------
 setup.h                       |  9 ++++++
 t/t1016-compatObjectFormat.sh | 18 ++++++++++++
 14 files changed, 167 insertions(+), 38 deletions(-)

Range-diff versus v1:

1:  c126882da3 ! 1:  087bbd9fa7 loose: load loose object map for the correct source
    @@ Commit message
         load the map via the common directory. This doesn't make any sense
         though, as the function is called in a loop through all sources, and as
         such the expectation is that we'll load the map that belongs to the
    -    given source.
    +    given source. The consequence is that we'll ignore loose object maps of
    +    any configured alternates.
     
         Fix this bug by instead loading the map via the loose source's path.
     
    +    Helped-by: Toon Claes <toon@iotcl.com>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## loose.c ##
    @@ loose.c: int repo_read_loose_object_map(struct repository *repo)
      	return 0;
      }
      
    +
    + ## t/t1016-compatObjectFormat.sh ##
    +@@ t/t1016-compatObjectFormat.sh: do
    + 		eval signedtag3_${hash}_oid=$(git hash-object -t tag -w ../${hash}_signedtag3) &&
    + 		eval signedtag4_${hash}_oid=$(git hash-object -t tag -w ../${hash}_signedtag4)
    + 	'
    ++
    ++	test_expect_success 'rev-parse maps oid of object borrowed from alternate' '
    ++		for repo in alt borrow
    ++		do
    ++			test_when_finished "rm -rf $repo" &&
    ++			git init --object-format=$hash $repo &&
    ++			git -C $repo config set core.repositoryformatversion 1 &&
    ++			git -C $repo config set extensions.compatObjectFormat $(compat_hash $hash) || exit 1
    ++		done &&
    ++
    ++		git -C alt commit --allow-empty --message A &&
    ++		echo "$(pwd)/alt/.git/objects" >borrow/.git/objects/info/alternates &&
    ++
    ++		oid=$(git -C alt rev-parse HEAD) &&
    ++		git -C alt    rev-parse --output-object-format=$(compat_hash $hash) "$oid" >expect &&
    ++		git -C borrow rev-parse --output-object-format=$(compat_hash $hash) "$oid" >actual &&
    ++		test_cmp expect actual
    ++	'
    + done
    + cd "$base"
    + 
2:  6e06a82905 ! 2:  00a693dd72 setup: detangle loading of loose object maps
    @@ Commit message
         hash is non-zero. This setup sequence has two major downsides:
     
           - We assume that the primary object database is the "files" object
    -        database so that we can extract its "loose" backend. This stops
    -        working with pluggable object databases.
    +        database and unconditionally downcast it. This will cause us to BUG
    +        in case a different object database type was used together with a
    +        compat hash algorithm.
     
           - We require the object database to already have been initialized when
             configuring the object database. This means that we must intermix
3:  183ed0f34c = 3:  1dc1f83d73 setup: defer object database creation
4:  eb997d22d7 ! 4:  de1555ee1f odb/source: introduce function to map source type to name
    @@ odb/source.c
     +	[ODB_SOURCE_FILES] = "files",
     +	[ODB_SOURCE_LOOSE] = "loose",
     +	[ODB_SOURCE_PACKED] = "packed",
    -+	[ODB_SOURCE_INMEMORY] = "inmemory",
    ++	[ODB_SOURCE_INMEMORY] = "in-memory",
     +};
     +
     +const char *odb_source_type_to_name(enum odb_source_type type)
5:  3303124a7d = 5:  cadf131e70 odb: make creation of on-disk structures pluggable

---
base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
change-id: 20260710-pks-odb-create-on-disk-ae8757861c69

