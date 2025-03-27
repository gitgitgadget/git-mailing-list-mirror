Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653D522615
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743068651; cv=none; b=KEtwnJeqn9Bn1d/5L/B4x/qGQGN/WQPBClVhArMgTYDFjH8nqZvvmvBUh6G9nOOlhml5WHKGj0snmG4pGwgYn4ZiMQTu57Ye9BzkZFCsNlwW3ibMTxuBr6PaLGaHjAnAaHCuLx0SvoGsaHgLkJD/seu9oPSHKhJiHadPdOhi3CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743068651; c=relaxed/simple;
	bh=2yQlPbzu6S43DxcKQiOLLzi9/lDy525lBebJTDfRkrk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=uuNcH4eQlAX3XcuKMRElPR6lefpmQCPgc4xmfgXvjVwHCIKLQWS+iKaCT6ksxh0yicimTsoGytIQckmifN5xfpmg3yroBr6m80x043WYJJSjZteofOAU7FOVpJZJC1F5JxLsSS4g9eJSbl2kZyBNItRXKfVNS0iFyRVPmSL1P5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LNVnns72; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DWLK7ee8; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LNVnns72";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DWLK7ee8"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4C3FA11400AD;
	Thu, 27 Mar 2025 05:44:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 27 Mar 2025 05:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743068647;
	 x=1743155047; bh=g2g+nRqSxeC1lrSJXLfhquYm1V8G4VrLx5HmCqyye/s=; b=
	LNVnns72HdK8Gz3V5gSBOEkC6UDzrQ2bfIyk076jF5aCLMQUKTPwfliLP0eNR28T
	T1FDRCZFryFW04l0cD/clutmxxAszsHNIPXtfcaxDVrWc3XLq+laa3NLp49SS/QK
	zha8UBUn5brFLNYnMXTftec7eAVCLPc3+S54DQQ9ueIDYz3mbv3LagA2Eo7muBaG
	2VYUxPBZ32efE4/gkBImJdeymUghwSv7+KcjbQLzOEYAK9YfJAskWU+ocjH0t1Xw
	iFrlW0QRutVUQCmIXHP+EP0mlvlA6qkjqH9/B9EJtF0hnokZ9KZ98mv3JNAK2BYU
	74MJj+qji392ywvJrRdjvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743068647; x=
	1743155047; bh=g2g+nRqSxeC1lrSJXLfhquYm1V8G4VrLx5HmCqyye/s=; b=D
	WLK7ee8Y2jPjFgTUz/Tz2COg5Kj3pbnCWo6I/+C9KSRe04Wt6+kyG0ft7rDzOaj1
	hO86zrsa8/7OBww+dWwFLsf6qSbgO7k81x7sh2NdMj5A8L1THb7diZEJCIByJaCT
	gBlVOkg5IdP50QUoTFZ+s0/O+GdsxO76XRM3ZCPTABXZzccPmmB6hJpUfo3IR+8d
	rywWpBbvwaNC2yWj3Hd4Bl3Dz/YQJTP1+Y0X8sYm+Gn8FU7FSCBAwp+T1W7Epsff
	HR+XDT5RXK0P+rdBJy/DLVxu/iLWloYshCJG4JNjjJ5xq3HRW9Af8xMLhLHewz2a
	qymanI8DtSAuMEkmeps2A==
X-ME-Sender: <xms:5h3lZ0GQGLh1gpIje2XSQInmxSBl3vAoNDPoXC4FeGwFL32dVfv-VQ>
    <xme:5h3lZ9Xt8RVXbOgU09sMm64U86ZYkm0TyfbWUhIwHxXsth5PW_GpyglO1A61Ob7_Z
    5rxMeDt_ZbLwxnuIg>
X-ME-Received: <xmr:5h3lZ-L5a6EiPRQq3JzdxJBdcxVXmNBfVq-uxoy0mMZQcA70aP5l752TDVkYguqgj9Wc86W-wFIkWjaZmemgJXkWUav12or66OJWzmbvteP0zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeehtddufeehvefhffeileeitdevveehieffieeg
    jeekvefftddvleelffegueehleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:5h3lZ2HdtVre-mZZP7WO4yRaCBzo3LBc2Mj5XgS0c-uiRMJq-Drxqw>
    <xmx:5h3lZ6UsBHT_kMt6KJCq18rX4MgW2F5xKzODP7hkOOJIMyFhn6ULEg>
    <xmx:5h3lZ5Pc5eS8TkopEJD17e4p_Cm8R7NzxLAdA3bL8cpa0YVNWXweEw>
    <xmx:5h3lZx2OLD4ILMyUe4O6Eozb5HqZY3LWdE6B8KVwNVEMCYMYdMNwVQ>
    <xmx:5x3lZ8egfb8p21E0mH9cn4AEZQIidodq0mx5XXusn4IA-Amhes4KSZ3Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 05:44:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 01278df7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 09:44:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/10] builtin/cat-file: allow filtering objects in
 batch mode
Date: Thu, 27 Mar 2025 10:43:55 +0100
Message-Id: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANwd5WcC/4WNyw6CMBBFf4XM2jHT0SbVlf9hWGAZZHwAaRsiI
 fy7hcS1y3OSe+4MUYJKhHMxQ5BRo/ZdBt4V4NuquwtqnRmY2BIz4fCM6KuEjb4E+9tDfMI0DbK
 KJAFP5kiepLYiBnJlCNLoZ3u4lplbjakP03Y4mtX+2uZvezRISM6yPZBzTviSF3t9Q7ksyxdsF
 tFWywAAAA==
X-Change-ID: 20250220-pks-cat-file-object-type-filter-9140c0ed5ee1
In-Reply-To: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

at GitLab, we sometimes have the need to list all objects regardless of
their reachability. We use git-cat-file(1) with `--batch-all-objects` to
do this, and typically this is quite a good fit. In some cases though,
we only want to list objects of a specific type, where we then basically
have the following pipeline:

    git cat-file --batch-all-objects --batch-check='%(objecttype) %(objectname)' |
    grep '^commit ' |
    cut -d' ' -f2 |
    git cat-file --batch

This works okayish in medium-sized repositories, but once you reach a
certain size this isn't really an option anymore. In the Chromium
repository for example [1] simply listing all objects in the first
invocation of git-cat-file(1) takes around 80 to 100 seconds. The
workload is completely I/O-bottlenecked: my machine reads at ~500MB/s,
and the packfile is 50GB in size, which matches the 100 seconds that I
observe.

This series addresses the issue by introducing object filters into
git-cat-file(1). These object filters use the exact same syntax as the
filters we have in git-rev-list(1), but only a subset of them is
supported because not all filters can be computed by git-cat-file(1).
Supported are "blob:none", "blob:limit=" as well as "object:type=".

The filters alone don't really help though: we still have to scan
through the whole packfile in order to compute the packfiles. While we
are able to shed a bit of CPU time because we can stop emitting some of
the objects, we're still I/O-bottlenecked.

The second part of the series thus expands the filters so that they can
make use of bitmap indices for some of the filters, if available. This
allows us to efficiently answer the question where to find all objects
of a specific type, and thus we can avoid scanning through the packfile
and instead directly look up relevant objects, leading to a significant
speedup:

    Benchmark 1: cat-file with filter=object:type=commit (revision = HEAD~)
      Time (mean ± σ):     86.444 s ±  4.081 s    [User: 36.830 s, System: 11.312 s]
      Range (min … max):   80.305 s … 93.104 s    10 runs

    Benchmark 2: cat-file with filter=object:type=commit (revision = HEAD)
      Time (mean ± σ):      2.089 s ±  0.015 s    [User: 1.872 s, System: 0.207 s]
      Range (min … max):    2.073 s …  2.119 s    10 runs

    Summary
      cat-file with filter=object:type=commit (revision = HEAD) ran
       41.38 ± 1.98 times faster than cat-file with filter=object:type=commit (revision = HEAD~)

We now directly scale with the number of objects of a specific type
contained in the packfile instead of scaling with the overall number of
objects. It's quite fun to see how the math plays out: if you sum up the
times for each of the types you arrive at the time for the unfiltered
case.

Changes in v2:
  - The series is now built on top of "master" at 683c54c999c (Git 2.49,
    2025-03-14) with "tb/incremental-midx-part-2" at 27afc272c49 (midx:
    implement writing incremental MIDX bitmaps, 2025-03-20) merged into
    it.
  - Rename the filter options to "--filter=" to match
    git-pack-objects(1).
  - The bitmap-filtering is now reusing existing mechanisms that we
    already have in "pack-bitmap.c", as proposed by Taylor.
  - Link to v1: https://lore.kernel.org/r/20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im

Thanks!

Patrick

[1]: https://github.com/chromium/chromium.git

---
Patrick Steinhardt (10):
      builtin/cat-file: rename variable that tracks usage
      builtin/cat-file: wire up an option to filter objects
      builtin/cat-file: support "blob:none" objects filter
      builtin/cat-file: support "blob:limit=" objects filter
      builtin/cat-file: support "object:type=" objects filter
      pack-bitmap: allow passing payloads to `show_reachable_fn()`
      pack-bitmap: add function to iterate over filtered bitmapped objects
      pack-bitmap: introduce function to check whether a pack is bitmapped
      builtin/cat-file: deduplicate logic to iterate over all objects
      builtin/cat-file: use bitmaps to efficiently filter by object type

 Documentation/git-cat-file.adoc |  16 +++
 builtin/cat-file.c              | 212 +++++++++++++++++++++++++++++-----------
 builtin/pack-objects.c          |   3 +-
 builtin/rev-list.c              |   3 +-
 pack-bitmap.c                   |  81 +++++++++++++--
 pack-bitmap.h                   |  22 ++++-
 reachable.c                     |   3 +-
 t/t1006-cat-file.sh             |  77 +++++++++++++++
 8 files changed, 346 insertions(+), 71 deletions(-)

Range-diff versus v1:

 1:  108b50d8a66 =  1:  d16b84702fd builtin/cat-file: rename variable that tracks usage
 2:  4a4a22ac465 !  2:  d3259ff034c builtin/cat-file: wire up an option to filter objects
    @@ Commit message
         been passed by the user, but they will be wired up in subsequent
         commits.
     
    -    Note that we don't use the same `--filter=` name fo the option as we use
    -    in git-rev-list(1). We already have `--filters`, and having both
    -    `--filter=` and `--filters` would be quite confusing. Instead, the new
    -    option is called `--objects-filter`.
    -
         Further note that the filters that we are about to introduce don't
         significantly speed up the runtime of git-cat-file(1). While we can skip
         emitting a lot of objects in case they are uninteresting to us, the
    @@ Documentation/git-cat-file.adoc: OPTIONS
      	end-of-line conversion, etc). In this case, `<object>` has to be of
      	the form `<tree-ish>:<path>`, or `:<path>`.
      
    -+--objects-filter=<filter-spec>::
    -+--no-objects-filter::
    ++--filter=<filter-spec>::
    ++--no-filter::
     +	Omit objects from the list of printed objects. This can only be used in
     +	combination with one of the batched modes. The '<filter-spec>' may be
     +	one of the following:
    @@ builtin/cat-file.c: int cmd_cat_file(int argc,
      			    N_("run filters on object's content"), 'w'),
      		OPT_STRING(0, "path", &force_path, N_("blob|tree"),
      			   N_("use a <path> for (--textconv | --filters); Not with 'batch'")),
    -+		OPT_CALLBACK(0, "objects-filter", &batch.objects_filter, N_("args"),
    ++		OPT_CALLBACK(0, "filter", &batch.objects_filter, N_("args"),
     +			     N_("object filtering"), opt_parse_list_objects_filter),
      		OPT_END()
      	};
    @@ t/t1006-cat-file.sh: test_expect_success PERL '--batch-command info is unbuffere
     +	cat >expect <<-EOF &&
     +	fatal: invalid filter-spec ${SQ}unknown${SQ}
     +	EOF
    -+	test_must_fail git -C repo cat-file --objects-filter=unknown 2>err &&
    ++	test_must_fail git -C repo cat-file --filter=unknown 2>err &&
     +	test_cmp expect err
     +'
     +
    @@ t/t1006-cat-file.sh: test_expect_success PERL '--batch-command info is unbuffere
     +			printf "usage: objects filter not supported: ${SQ}%s${SQ}\n" "$option_name" >expect
     +			;;
     +		esac &&
    -+		test_must_fail git -C repo cat-file --objects-filter=$option 2>err &&
    ++		test_must_fail git -C repo cat-file --filter=$option 2>err &&
     +		test_cmp expect err
     +	'
     +done
 3:  baddbca6de6 !  3:  02c7fc38986 builtin/cat-file: support "blob:none" objects filter
    @@ t/t1006-cat-file.sh: do
     +	filter="$1"
     +
     +	test_expect_success "objects filter: $filter" '
    -+		git -C repo cat-file --batch-check="%(objectname)" --batch-all-objects --objects-filter="$filter" >actual &&
    ++		git -C repo cat-file --batch-check="%(objectname)" --batch-all-objects --filter="$filter" >actual &&
     +		sort actual >actual.sorted &&
     +		git -C repo rev-list --objects --no-object-names --all --filter="$filter" --filter-provided-objects >expect &&
     +		sort expect >expect.sorted &&
 4:  e55fa01810d !  4:  33c5ea58fdc builtin/cat-file: support "blob:limit=" objects filter
    @@ Documentation/git-cat-file.adoc: OPTIONS
      The form '--filter=blob:none' omits all blobs.
     ++
     +The form '--filter=blob:limit=<n>[kmg]' omits blobs of size at least n
    -+bytes or units.  n may be zero.  The suffixes k, m, and g can be used
    -+to name units in KiB, MiB, or GiB.  For example, 'blob:limit=1k'
    -+is the same as 'blob:limit=1024'.
    ++bytes or units.  n may be zero.  The suffixes k, m, and g can be used to name
    ++units in KiB, MiB, or GiB.  For example, 'blob:limit=1k' is the same as
    ++'blob:limit=1024'.
      
      --path=<path>::
      	For use with `--textconv` or `--filters`, to allow specifying an object
 5:  1882ac07c9b !  5:  40e2f7f2f82 builtin/cat-file: support "object:type=" objects filter
    @@ Commit message
     
      ## Documentation/git-cat-file.adoc ##
     @@ Documentation/git-cat-file.adoc: The form '--filter=blob:limit=<n>[kmg]' omits blobs of size at least n
    - bytes or units.  n may be zero.  The suffixes k, m, and g can be used
    - to name units in KiB, MiB, or GiB.  For example, 'blob:limit=1k'
    - is the same as 'blob:limit=1024'.
    + bytes or units.  n may be zero.  The suffixes k, m, and g can be used to name
    + units in KiB, MiB, or GiB.  For example, 'blob:limit=1k' is the same as
    + 'blob:limit=1024'.
     ++
    -+The form '--filter=object:type=(tag|commit|tree|blob)' omits all objects
    -+which are not of the requested type.
    ++The form '--filter=object:type=(tag|commit|tree|blob)' omits all objects which
    ++are not of the requested type.
      
      --path=<path>::
      	For use with `--textconv` or `--filters`, to allow specifying an object
 6:  c8ac9481b39 !  6:  5affa992909 pack-bitmap: expose function to iterate over bitmapped objects
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    pack-bitmap: expose function to iterate over bitmapped objects
    +    pack-bitmap: allow passing payloads to `show_reachable_fn()`
     
    -    Expose a function that allows the caller to iterate over all bitmapped
    -    objects of a specific type. This mechanism allows us to use the object
    -    type-specific bitmaps to enumerate all objects of that type without
    -    having to scan through a complete packfile.
    +    The `show_reachable_fn` callback is used by a couple of functions to
    +    present reachable objects to the caller. The function does not provide a
    +    way for the caller to pass a payload though, which is functionality that
    +    we'll require in a subsequent commit.
     
    -    This functionality will be used in a subsequent commit.
    +    Change the callback type to accept a payload and adapt all callsites
    +    accordingly.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ pack-bitmap.c: static void show_extended_objects(struct bitmap_index *bitmap_git
      	}
      }
      
    --static void init_type_iterator(struct ewah_iterator *it,
    --			       struct bitmap_index *bitmap_git,
    --			       enum object_type type)
    -+static struct ewah_bitmap *ewah_for_type(struct bitmap_index *bitmap_git,
    -+					 enum object_type type)
    - {
    - 	switch (type) {
    - 	case OBJ_COMMIT:
    --		ewah_iterator_init(it, bitmap_git->commits);
    --		break;
    --
    -+		return bitmap_git->commits;
    - 	case OBJ_TREE:
    --		ewah_iterator_init(it, bitmap_git->trees);
    --		break;
    --
    -+		return bitmap_git->trees;
    - 	case OBJ_BLOB:
    --		ewah_iterator_init(it, bitmap_git->blobs);
    --		break;
    --
    -+		return bitmap_git->blobs;
    - 	case OBJ_TAG:
    --		ewah_iterator_init(it, bitmap_git->tags);
    --		break;
    --
    -+		return bitmap_git->tags;
    - 	default:
    - 		BUG("object type %d not stored by bitmap type index", type);
    --		break;
    - 	}
    - }
    - 
    --static void show_objects_for_type(
    --	struct bitmap_index *bitmap_git,
    --	enum object_type object_type,
    +@@ pack-bitmap.c: static void init_type_iterator(struct ewah_or_iterator *it,
    + static void show_objects_for_type(
    + 	struct bitmap_index *bitmap_git,
    + 	enum object_type object_type,
     -	show_reachable_fn show_reach)
    -+static void init_type_iterator(struct ewah_iterator *it,
    -+			       struct bitmap_index *bitmap_git,
    -+			       enum object_type type)
    -+{
    -+	ewah_iterator_init(it, ewah_for_type(bitmap_git, type));
    -+}
    -+
    -+static void for_each_bitmapped_object_internal(struct bitmap_index *bitmap_git,
    -+					       struct bitmap *objects,
    -+					       enum object_type object_type,
    -+					       show_reachable_fn show_reach,
    -+					       void *payload)
    ++	show_reachable_fn show_reach,
    ++	void *payload)
      {
      	size_t i = 0;
      	uint32_t offset;
    --
    - 	struct ewah_iterator it;
    - 	eword_t filter;
    - 
    --	struct bitmap *objects = bitmap_git->result;
    --
    - 	init_type_iterator(&it, bitmap_git, object_type);
    - 
    - 	for (i = 0; i < objects->word_alloc &&
     @@ pack-bitmap.c: static void show_objects_for_type(
      			if (bitmap_git->hashes)
      				hash = get_be32(bitmap_git->hashes + index_pos);
    @@ pack-bitmap.c: static void show_objects_for_type(
     +			show_reach(&oid, object_type, 0, hash, pack, ofs, payload);
      		}
      	}
    - }
      
    -+static void show_objects_for_type(
    -+	struct bitmap_index *bitmap_git,
    -+	enum object_type object_type,
    -+	show_reachable_fn show_reach)
    -+{
    -+	for_each_bitmapped_object_internal(bitmap_git, bitmap_git->result,
    -+					   object_type, show_reach, NULL);
    -+}
    -+
    -+void for_each_bitmapped_object(struct bitmap_index *bitmap_git,
    -+			       enum object_type object_type,
    -+			       show_reachable_fn show_reach,
    -+			       void *payload)
    -+{
    -+	struct bitmap *bitmap = ewah_to_bitmap(ewah_for_type(bitmap_git, object_type));
    -+	for_each_bitmapped_object_internal(bitmap_git, bitmap,
    -+					   object_type, show_reach, payload);
    -+	bitmap_free(bitmap);
    -+}
    -+
    - static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
    - 			     struct object_list *roots)
    +@@ pack-bitmap.c: void traverse_bitmap_commit_list(struct bitmap_index *bitmap_git,
      {
    + 	assert(bitmap_git->result);
    + 
    +-	show_objects_for_type(bitmap_git, OBJ_COMMIT, show_reachable);
    ++	show_objects_for_type(bitmap_git, OBJ_COMMIT, show_reachable, NULL);
    + 	if (revs->tree_objects)
    +-		show_objects_for_type(bitmap_git, OBJ_TREE, show_reachable);
    ++		show_objects_for_type(bitmap_git, OBJ_TREE, show_reachable, NULL);
    + 	if (revs->blob_objects)
    +-		show_objects_for_type(bitmap_git, OBJ_BLOB, show_reachable);
    ++		show_objects_for_type(bitmap_git, OBJ_BLOB, show_reachable, NULL);
    + 	if (revs->tag_objects)
    +-		show_objects_for_type(bitmap_git, OBJ_TAG, show_reachable);
    ++		show_objects_for_type(bitmap_git, OBJ_TAG, show_reachable, NULL);
    + 
    + 	show_extended_objects(bitmap_git, revs, show_reachable);
    + }
     
      ## pack-bitmap.h ##
     @@ pack-bitmap.h: typedef int (*show_reachable_fn)(
    @@ pack-bitmap.h: typedef int (*show_reachable_fn)(
      
      struct bitmap_index;
      
    -@@ pack-bitmap.h: int test_bitmap_pseudo_merges(struct repository *r);
    - int test_bitmap_pseudo_merge_commits(struct repository *r, uint32_t n);
    - int test_bitmap_pseudo_merge_objects(struct repository *r, uint32_t n);
    - 
    -+/*
    -+ * Iterate through all bitmapped objects of the given type and execute the
    -+ * `show_reach` for each of them.
    -+ */
    -+ void for_each_bitmapped_object(struct bitmap_index *bitmap_git,
    -+			       enum object_type object_type,
    -+			       show_reachable_fn show_reach,
    -+			       void *payload);
    -+
    - #define GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL \
    - 	"GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL"
    - 
     
      ## reachable.c ##
     @@ reachable.c: static int mark_object_seen(const struct object_id *oid,
 -:  ----------- >  7:  9de8dff849c pack-bitmap: add function to iterate over filtered bitmapped objects
 7:  86a520477f5 !  8:  67a3cdf5fb9 pack-bitmap: introduce function to check whether a pack is bitmapped
    @@ Commit message
         bitmapped or not. This functionality will be used in a subsequent
         commit.
     
    +    Helped-by: Taylor Blau <me@ttaylorr.com>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## pack-bitmap.c ##
    @@ pack-bitmap.c: struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_in
      
     +int bitmap_index_contains_pack(struct bitmap_index *bitmap, struct packed_git *pack)
     +{
    -+	if (bitmap->pack)
    -+		return bitmap->pack == pack;
    -+
    -+	if (!bitmap->midx->chunk_bitmapped_packs)
    -+		return 0;
    -+
    -+	for (size_t i = 0; i < bitmap->midx->num_packs; i++)
    -+		if (bitmap->midx->packs[i] == pack)
    ++	for (; bitmap; bitmap = bitmap->base) {
    ++		if (bitmap_is_midx(bitmap)) {
    ++			for (size_t i = 0; i < bitmap->midx->num_packs; i++)
    ++				if (bitmap->midx->packs[i] == pack)
    ++					return 1;
    ++		} else if (bitmap->pack == pack) {
     +			return 1;
    ++		}
    ++	}
     +
     +	return 0;
     +}
 8:  56168d29a7c =  9:  c4dc2fe1de2 builtin/cat-file: deduplicate logic to iterate over all objects
 9:  36d88811991 ! 10:  61904db7d35 builtin/cat-file: use bitmaps to efficiently filter by object type
    @@ Commit message
         we can use these bitmaps to improve the runtime.
     
         While bitmaps are typically used to compute reachability of objects,
    -    they also contain one bitmap per object type encodes which object has
    -    what type. So instead of reading through the whole packfile(s), we can
    -    use the bitmaps and iterate through the type-specific bitmap. Typically,
    -    only a subset of packfiles will have a bitmap. But this isn't really
    -    much of a problem: we can use bitmaps when available, and then use the
    -    non-bitmap walk for every packfile that isn't covered by one.
    +    they also contain one bitmap per object type that encodes which object
    +    has what type. So instead of reading through the whole packfile(s), we
    +    can use the bitmaps and iterate through the type-specific bitmap.
    +    Typically, only a subset of packfiles will have a bitmap. But this isn't
    +    really much of a problem: we can use bitmaps when available, and then
    +    use the non-bitmap walk for every packfile that isn't covered by one.
     
         Overall, this leads to quite a significant speedup depending on how many
         objects of a certain type exist. The following benchmarks have been
         executed in the Chromium repository, which has a 50GB packfile with
    -    almost 25 million objects:
    +    almost 25 million objects. As expected, there isn't really much of a
    +    change in performance without an object filter:
     
    -        Benchmark 1: git cat-file --batch-check --batch-all-objects --unordered --buffer --no-objects-filter
    -          Time (mean ± σ):     82.806 s ±  6.363 s    [User: 30.956 s, System: 8.264 s]
    -          Range (min … max):   73.936 s … 89.690 s    10 runs
    +        Benchmark 1: cat-file with no-filter (revision = HEAD~)
    +          Time (mean ± σ):     89.675 s ±  4.527 s    [User: 40.807 s, System: 10.782 s]
    +          Range (min … max):   83.052 s … 96.084 s    10 runs
     
    -        Benchmark 2: git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=tag
    -          Time (mean ± σ):      20.8 ms ±   1.3 ms    [User: 6.1 ms, System: 14.5 ms]
    -          Range (min … max):    18.2 ms …  23.6 ms    127 runs
    +        Benchmark 2: cat-file with no-filter (revision = HEAD)
    +          Time (mean ± σ):     88.991 s ±  2.488 s    [User: 42.278 s, System: 10.305 s]
    +          Range (min … max):   82.843 s … 91.271 s    10 runs
     
    -        Benchmark 3: git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=commit
    -          Time (mean ± σ):      1.551 s ±  0.008 s    [User: 1.401 s, System: 0.147 s]
    -          Range (min … max):    1.541 s …  1.566 s    10 runs
    +        Summary
    +          cat-file with no-filter (revision = HEAD) ran
    +            1.01 ± 0.06 times faster than cat-file with no-filter (revision = HEAD~)
    +
    +    We still have to scan through all objects as we yield all of them, so
    +    using the bitmap in this case doesn't really buy us anything. What is
    +    noticeable in this benchmark is that we're I/O-bound, not CPU-bound, as
    +    can be seen from the user/system runtimes, which combined are way lower
    +    than the overall benchmarked runtime.
     
    -        Benchmark 4: git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=tree
    -          Time (mean ± σ):     11.169 s ±  0.046 s    [User: 10.076 s, System: 1.063 s]
    -          Range (min … max):   11.114 s … 11.245 s    10 runs
    +    But when we do use a filter we can see a significant improvement:
     
    -        Benchmark 5: git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=blob
    -          Time (mean ± σ):     67.342 s ±  3.368 s    [User: 20.318 s, System: 7.787 s]
    -          Range (min … max):   62.836 s … 73.618 s    10 runs
    +        Benchmark 1: cat-file with filter=object:type=commit (revision = HEAD~)
    +          Time (mean ± σ):     86.444 s ±  4.081 s    [User: 36.830 s, System: 11.312 s]
    +          Range (min … max):   80.305 s … 93.104 s    10 runs
     
    -        Benchmark 6: git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=blob:none
    -          Time (mean ± σ):     13.032 s ±  0.072 s    [User: 11.638 s, System: 1.368 s]
    -          Range (min … max):   12.960 s … 13.199 s    10 runs
    +        Benchmark 2: cat-file with filter=object:type=commit (revision = HEAD)
    +          Time (mean ± σ):      2.089 s ±  0.015 s    [User: 1.872 s, System: 0.207 s]
    +          Range (min … max):    2.073 s …  2.119 s    10 runs
     
             Summary
    -          git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=tag
    -           74.75 ± 4.61 times faster than git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=commit
    -          538.17 ± 33.17 times faster than git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=tree
    -          627.98 ± 38.77 times faster than git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=blob:none
    -         3244.93 ± 257.23 times faster than git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=blob
    -         3990.07 ± 392.72 times faster than git cat-file --batch-check --batch-all-objects --unordered --buffer --no-objects-filter
    -
    -    The first benchmark is mostly equivalent in runtime compared to all the
    -    others without the bitmap-optimization introduced in this commit. What
    -    is noticeable in the benchmarks is that we're I/O-bound, not CPU-bound,
    -    as can be seen from the user/system runtimes, which is often way lower
    -    than the overall benchmarked runtime.
    +          cat-file with filter=object:type=commit (revision = HEAD) ran
    +           41.38 ± 1.98 times faster than cat-file with filter=object:type=commit (revision = HEAD~)
    +
    +    This is because we don't have to scan through all packfiles anymore, but
    +    can instead directly look up relevant objects.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ builtin/cat-file.c: static void batch_each_object(for_each_object_fn callback,
     -	for_each_packed_object(the_repository, batch_one_object_packed,
     -			       &payload, flags);
     +
    -+	if (bitmap &&
    -+	    (opt->objects_filter.choice == LOFC_OBJECT_TYPE ||
    -+	     opt->objects_filter.choice == LOFC_BLOB_NONE)) {
    ++	if (bitmap && !for_each_bitmapped_object(bitmap, &opt->objects_filter,
    ++						 batch_one_object_bitmapped, &payload)) {
     +		struct packed_git *pack;
     +
    -+		if (opt->objects_filter.choice == LOFC_OBJECT_TYPE) {
    -+			for_each_bitmapped_object(bitmap, opt->objects_filter.object_type,
    -+						  batch_one_object_bitmapped, &payload);
    -+		} else {
    -+			for_each_bitmapped_object(bitmap, OBJ_COMMIT,
    -+						  batch_one_object_bitmapped, &payload);
    -+			for_each_bitmapped_object(bitmap, OBJ_TAG,
    -+						  batch_one_object_bitmapped, &payload);
    -+			for_each_bitmapped_object(bitmap, OBJ_TREE,
    -+						  batch_one_object_bitmapped, &payload);
    -+		}
    -+
     +		for (pack = get_all_packs(the_repository); pack; pack = pack->next) {
     +			if (bitmap_index_contains_pack(bitmap, pack) ||
     +			    open_pack_index(pack))

---
base-commit: 003c5f45b8447877015b2a23ceab2297638fe1f1
change-id: 20250220-pks-cat-file-object-type-filter-9140c0ed5ee1

