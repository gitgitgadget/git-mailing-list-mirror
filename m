Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FFA3EBF1D
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770795791; cv=none; b=dIu7QA5W0cwgLZ+Ah/NH8kHLG1QPyCKKX3jazmYMlQGC6kgCAkD6MNguwbOQbXlDF5+oLyV9owoe9+gBsooMQGXLefUePrG/MB2DTHB+oh/B6KNoF2uKm8Kv5UOIPiExYFCwSMyE99Ibz3/WGgeXrF+eCujuf2Qr/xUuYH9vtXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770795791; c=relaxed/simple;
	bh=VBS4BqQkPviKZfHFMSN7vbJGMEfiT7SMGOEA4u1k4OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1q2PLQF8c720YAPZokLC1+slC2gDk+6NrOCdJz+5RaU6GbmcdGSRi8i0hTOvCwemy9SLOBFQSVnqqTgptZm3Ox3Rhfn2uMAEhGmF2jyESAqiD+Qxxm4jm2a6HBUwAdTy0tHpUQFuurZV1dFXgBjjUwbOWuh+uExvRY8XPP9/wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R5XgGaML; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kh6rjBSb; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R5XgGaML";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kh6rjBSb"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 36C391D001AD;
	Wed, 11 Feb 2026 02:43:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 11 Feb 2026 02:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770795788;
	 x=1770882188; bh=4dD58amYr+hA6M5aDR1GMBFSeuaKHXOjdFgEWIHxn74=; b=
	R5XgGaML14TP3LHyEw0Ap/D3b/pX/ymcgopcIAF2aKkv2rC5PaLlIm5VldkGSkGH
	su7GMEiK7c4Xr7OqjQ0tNpb/DldUCJ4fhqubJyeX1OirL8JJqVzdJYsZbryHv7t3
	LY5H329aC+2GsN7FOasGADkFjnazEEHum2d+CAhTTKThWZuJXOaSswXHNHDRUVj2
	nRiPkUCpaMLe8Mp05dGJIJsGb3CNRxjPDooRCgxVCc3uTvjTXbT4PrGKJ9CCKoVr
	Nqp6LhWRSI0CubwSdg6Mr8DCWe67PT8SwiZ8gNcoxWDpvxjpjBvyRz9wkZoWcQ5u
	8gZ2eqzfGigwAQzf2M6lWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770795788; x=
	1770882188; bh=4dD58amYr+hA6M5aDR1GMBFSeuaKHXOjdFgEWIHxn74=; b=K
	h6rjBSb5Dz066nrHfP4SqKVNQxLUMRwz8qxx9r4k/OCcx350gxfUzYJDyKL4XXCx
	SNHxKQDx8DH2lwWmjzQ44MtGXri3MPSOsFjtn9qlZSxTJIeUaIID4fRJtzA+gcqv
	5c6rzNLKecf4t2Rm5p2JDY9FP+/5GfjP5QPUGiU7NtMv8mma86dWdUwqE8oS3Slt
	4copK8Y6jn2J7lbGxP82cYJmO1F/0FX7carM35Ae+2q65f8rkE1F40Agt5MSMH9i
	vOF2NAREIRHRDz+nCJ2tGG2iVOGWvMdsO//khwYq9BjG37PvKXiYJoBSfBDlu4BB
	oTwGu/d0otjYrt7vPFTTg==
X-ME-Sender: <xms:DDOMaSSVmE3v-WwZDqONQX-gzW6GUrtwOwh-6nhR_UHs_eJ6rG8x-g>
    <xme:DDOMaeyYVDgFHMYxuDk2dItt266FMmthRs_w9Qa_w0CMAP7Ukx5H9AMjAN_1Ozwhb
    ntAgx6EnrJpB3CCsaKHaQOqqyRN8Vvr-J4twjC6L0gn5Ht1YRLUhNw>
X-ME-Received: <xmr:DDOMaU0y4ww6K0e7nzZSg3cZu02TYmm6bzGaEaMgsHv7FUv3yh57ibL309mpwNj3gUyL6WW6zAYdx4LwYYSxOJlR5EDsf67IkEbjFkb2DaPE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdduleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghvrghnrdhmrg
    hrthhinhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhi
    thhhuhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:DDOMac6mCZrHfeEapTnhLzmwIKhFKdPwjlQiShBNfmPK5XMjIlOw2A>
    <xmx:DDOMaXVPIllzMLPnmXVKneQeBR8Pmce_PEUWhAlGx70m1aK3wP1j4A>
    <xmx:DDOMabBAccv4c2oG-wJKHG4X-8oDdU86DVqZ3ya1xyqtS2MVpyaBpQ>
    <xmx:DDOMaW6-gSnF7YAWf_plGS50dy2u49s_MJQGhqrdCxrD8WPcNtXkqw>
    <xmx:DDOMacVaMhRQOtOGbO3o7c2N1eGePPZCZLH7wWSbHF3U3zhz4ifX-JsM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 02:43:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 547189fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 07:43:05 +0000 (UTC)
Date: Wed, 11 Feb 2026 08:42:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Evan Martin <evan.martin@gmail.com>
Subject: Re: [PATCH] meson: regenerate config-list.h when Documentation
 changes
Message-ID: <aYwzAt-dugh_acj9@pks.im>
References: <aYn8XKv2hH2HX2xO@pks.im>
 <20260209215015.25867-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260209215015.25867-1-ben.knoble+github@gmail.com>

On Mon, Feb 09, 2026 at 04:50:06PM -0500, D. Ben Knoble wrote:
> > On Sat, Feb 07, 2026 at 04:59:17PM -0500, D. Ben Knoble wrote:
[snip]
> Only, things are behaving oddly. For example:
> 
>     λ meson setup build2
>     λ ninja -C build2
> 
> works fine, but
> 
>     λ ls -l build2/config*
>     -rw-r--r-- 1 benknoble benknoble 17169  9 févr. 16:39 build2/config-list.h
> 
> I don't see the dependency file.

> Further, re-building seems to get stuck (I get
> similar symptoms if I add or remove a relevant config.adoc file, but let's keep
> it simple for now):
> 
>     λ ninja -C build2
>     ninja: Entering directory `build2'
>     [1/28] Generating GIT-VERSION-FILE with a custom command (wrapped by meson to set env)

With "stuck" you mean that it doesn't do anything, or that it doesn't
actually rebuild?

I guess it kind of makes sense that a new file wouldn't trigger a
rebuild, even though I would have expected a removed one to trigger one.
After all, the dependency file only tracks the set of _existing_ files
so that we know when to rebuild, and of course the dependency file only
gets regenerated in case any of those files changes.

The thing is that build systems like Meson really want to know the list
of files ahead of time so that they can have an optimal build graph. So
we could of course list all the files that we actually depend on. But I
guess that's something we want to avoid?

There's another, alternative approach: you can have a separate build
step that's marked as `build_always_stale: true` that lists all the
config files. This step would then always run, and it would only update
its target file in case any of the files has changed.

Combined with the depfile we'd then rebuild in all cases:

  - When a file gets added or removed, as that would cause the
    `build_always_stale` target to be rewritten.

  - When any of the files changes, because that would cause the
    dependencies in the depfile to change.

Something like the attached patch (note that I don't perform the
necessary changes for the Makefile). I confirmed that it works for all
of the above cases.

Thanks!

Patrick

--- >8 ---

diff --git a/generate-configlist.sh b/generate-configlist.sh
index 75c39ade20..17605e6f77 100755
--- a/generate-configlist.sh
+++ b/generate-configlist.sh
@@ -1,13 +1,6 @@
 #!/bin/sh
 
-SOURCE_DIR="$1"
-OUTPUT="$2"
-
-if test -z "$SOURCE_DIR" || ! test -d "$SOURCE_DIR" || test -z "$OUTPUT"
-then
-	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT>"
-	exit 1
-fi
+set -e
 
 print_config_list () {
 	cat <<EOF
@@ -30,9 +23,50 @@ EOF
 EOF
 }
 
-{
-	echo "/* Automatically generated by generate-configlist.sh */"
-	echo
-	echo
-	print_config_list
-} >"$OUTPUT"
+case "$1" in
+generate)
+	SOURCE_DIR="$2"
+	OUTPUT="$3"
+	DEPFILE="$4"
+
+	if test -z "$SOURCE_DIR" || ! test -d "$SOURCE_DIR" || test -z "$OUTPUT"
+	then
+		echo >&2 "USAGE: $0 generate <SOURCE_DIR> <OUTPUT>"
+		exit 1
+	fi
+
+	if test -n "$DEPFILE"
+	then
+		printf "$OUTPUT: %s\n" "$SOURCE_DIR"/Documentation/*config.adoc \
+			"$SOURCE_DIR"/Documentation/config/*.adoc >"$DEPFILE"
+	fi
+
+	{
+		echo "/* Automatically generated by generate-configlist.sh */"
+		echo
+		echo
+		print_config_list
+	} >"$OUTPUT"
+	;;
+deps)
+	SOURCE_DIR="$2"
+	OUTPUT="$3"
+
+	if test -z "$SOURCE_DIR" || ! test -d "$SOURCE_DIR" || test -z "$OUTPUT"
+	then
+		echo >&2 "USAGE: $0 deps <SOURCE_DIR> <OUTPUT>"
+		exit 1
+	fi
+
+	TMPFILE=$(mktemp "$OUTPUT".XXXXXX)
+	printf "%s\n" "$SOURCE_DIR"/Documentation/*config.adoc \
+		"$SOURCE_DIR"/Documentation/config/*.adoc | sort >"$TMPFILE"
+
+	if ! test -f "$OUTPUT" || ! cmp "$TMPFILE" "$OUTPUT" >/dev/null
+	then
+		mv "$TMPFILE" "$OUTPUT"
+	else
+		rm "$TMPFILE"
+	fi
+	;;
+esac
diff --git a/meson.build b/meson.build
index dd52efd1c8..6b9147a39a 100644
--- a/meson.build
+++ b/meson.build
@@ -716,14 +716,29 @@ if not get_option('breaking_changes')
   builtin_sources += 'builtin/pack-redundant.c'
 endif
 
+configlist_deps = custom_target(
+  output: 'config-list.h.deps',
+  command: [
+    meson.current_source_dir() + '/generate-configlist.sh',
+    'deps',
+    meson.current_source_dir(),
+    '@OUTPUT@',
+  ],
+  build_always_stale: true,
+)
+
 builtin_sources += custom_target(
   output: 'config-list.h',
   command: [
     shell,
     meson.current_source_dir() + '/generate-configlist.sh',
+    'generate',
     meson.current_source_dir(),
     '@OUTPUT@',
+    '@OUTPUT@.d',
   ],
+  depends: [ configlist_deps, ],
+  depfile: 'config-list.h.d',
   env: script_environment,
 )
 
