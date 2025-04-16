Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B822DFA49
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744805781; cv=none; b=QtNP9X+C4SFXINQHHODrhACvOoxK8YeYRmqM1Zp210NS5Yq+ReLeY8IvaCBsNRtdnD2oM89FTNlZIjkpz0o14zcxRCztvl8ErPq4aW/Ovk7exK8VMfgK112AjOoQPKKg+9Ftkj5YnkOQkfD47D40GF3dzUBDJo4o8k5hDbsuql8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744805781; c=relaxed/simple;
	bh=cqBpCYKrUVPraLvNehbwUDSx3Y8YelzUKUwrez2EI2E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=OOyvUEp+Rgc0K8oG7sl81pFoNz0D0cQLWs+4KS2oQHcBXhbmUdh2D7dDk9JnX/sVXaFLDZQoNSMRU7cVGLY9sxaSjQzzSphOFboD3VPTCEhM+9VZO7T6qbH4tnW5QPrn6i0p/3f+4vTz54KANXNsj/nv7mgVCGkXi32SEr5AMKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=obmDEyHB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i5U3g7Gp; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="obmDEyHB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i5U3g7Gp"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4C77025401E8;
	Wed, 16 Apr 2025 08:16:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 16 Apr 2025 08:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744805778;
	 x=1744892178; bh=Oklb3nGLDO21velSXt+iEfDY8Dxx5/ydnIGNx78zgYs=; b=
	obmDEyHBal+6XNHYCegalR9x/QNIueaqMSPaDZApfY0wyMKedTUQRQzwlW1WHRuk
	NElXWkcMVtlIvLmaEEdWXhuzJQCNVfHRamU49VJzKrw4EIgOjeFfz5D4kKFlsRoD
	vSmxA3KB9XgFIBu0dAKn5gdJ4TFOTXTdB7+pZRD8llGe9QO7KPZ2aIM6aAEjuV6q
	RUmxkQPbvwYJVmjQpKb4XnrFaBvGXWUswksAAW8t7+RWjaAZJRlHum3NHBbBT8hX
	Or5+FYYmdhgiiwkZQUg22lv43arbwrJU/NnPvZ08O0SGNBvvxsEiEiHQOoGfW4Pv
	FnMeKut/J0cmp1uc1UrMXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744805778; x=
	1744892178; bh=Oklb3nGLDO21velSXt+iEfDY8Dxx5/ydnIGNx78zgYs=; b=i
	5U3g7GpiZ5g/WLKMq7EbJ6eyOXMfFvh76seYerEl9QvbNgUxQgdEnN8rBqDti574
	a6Zh7COS3Y77xUX4qoT5NisBK9oZ5UI/DMlRQv5Hy+5NkHQlqE8ervUtwiSBZBBq
	hej0OsK6qngAO97ZM5HNTcCTO7WUn+DJTVuQNohpM7haT4VxXzOakh6if0bsGUXB
	0isFJNAG7kPnnRE14Io8Ft79CH1MQv7G7WSFdQOsMYxMtK1PmCOiwWCoDZd8ePc6
	qwh2VZwIOEYO9EoodqXbakCb9THYPYCUdIpCrEYPeZ/Z7ajA/PO4kx7WVnUyH49H
	Rpz5OKSo1xJKUWZRXzvWA==
X-ME-Sender: <xms:kZ__Z8KJ8G-jFMSQY36-KtJAzhP-8ICD34hSEdBI_xxbcgcALxFMAQ>
    <xme:kZ__Z8IP_UehO4NPJhLRhoqiJSW1i6PjyFHh_7x6F9-K402E7ffFCQJokei2cAHSi
    53APwGSOZuEJw3xew>
X-ME-Received: <xmr:kZ__Z8tZIL1fdoSzhB0NaC5AA11oxmFRYSyhKCkn1lkgPOe6xLv0RCb8mC1WWYiNw8u36KEvMgmcpx8B6U5vAvzCG9yYvJ-uGn_5CWcViBloDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeifeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedt
    heefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlh
    hinhesghhmgidruggv
X-ME-Proxy: <xmx:kZ__Z5YJeq1pId2Mq_BxuIJxZ-OXzCzNNDnL--0KsgEvuvSqKvfsOA>
    <xmx:kZ__ZzadHqixOqDyVuWNmHiZWNA_oY_6fk7rDJEtyM7wL8sVFfOl_A>
    <xmx:kZ__Z1AQ9lhctxv4LMLJW96aI19JZaImKEzurheIs7I9c6gGCJvl3Q>
    <xmx:kZ__Z5Zjys-d96CoMTyhwklpA5OguIGGFCx5a6UlX3-iJcfDSnG6mg>
    <xmx:kp__Z8ptl9ElwHBgNaHaRo8X4qsEkRXWC2uIYIkctxeA1hMxQ5vIjJoJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 08:16:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9021f45d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Apr 2025 12:16:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/4] Drop Perl dependency in a couple of subsystems
Date: Wed, 16 Apr 2025 14:16:06 +0200
Message-Id: <20250416-b4-pks-drop-perl-v2-0-bdd0492e9498@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIef/2cC/2WNwQ7CIBBEf6XZs2uAgtSe/A/TQ4Wt3agtAdNoG
 v5dbLx5fDOZNyskikwJ2mqFSAsnnqcCaleBG/vpSsi+MCihjNDiiBeN4ZbQxzlgoHhHY7WxUtW
 aagdlFiIN/NqU567wyOk5x/f2sMhv+pNJ8y9bJAp0h977QVrTmOZU+j0/oMs5fwCdEkkTrQAAA
 A==
X-Change-ID: 20250409-b4-pks-drop-perl-574571234e3c
In-Reply-To: <20250415-b4-pks-drop-perl-v1-0-c6addf175858@pks.im>
References: <20250415-b4-pks-drop-perl-v1-0-c6addf175858@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

this patch series is a follow-up to my recent series that got rid of our
strict dependency on Perl for running our test suite [1]. The goal of it
is to remove the dependency on Perl in a couple more areas:

  - git-filter-branch(1)

  - git-request-pull(1)

  - Building our documentation.

With these converted you can get a fully-functioning Git distribution
with only a small handful of features missing:

  - gitweb.

  - Scripts to import repositories from GNU Arch, CVS and Subversion.

  - git-send-email.

  - Our Perl bindings, obviously.

  - The netrc credential helper from "contrib/".

None of these feel critical for day-to-day usage of Git, so Perl is now
a truly-optional dependency of Git.

The series is built on top of 485f5f86361 (The fourth batch, 2025-04-08)
with ps/test-wo-perl-prereq at 7a7b6022670 (t5703: refactor test to not
depend on Perl, 2025-04-03) merged into it.

Changes in v2:
  - Loosen up semantics when parsing "^{}" from git-ls-remote(1) so that
    the new behaviour matches the old one.
  - Fix indentation of a couple of case statements.
  - Remove explicit `in "$@"` in a for loop.
  - Link to v1: https://lore.kernel.org/r/20250415-b4-pks-drop-perl-v1-0-c6addf175858@pks.im

Thanks!

Patrick

[1]: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>

---
Patrick Steinhardt (4):
      filter-branch: stop depending on Perl
      request-pull: stop depending on Perl
      Documentation: stop depending on Perl to massage user manual
      Documentation: stop depending on Perl to generate command list

 Documentation/Makefile      |   8 ++--
 Documentation/cmd-list.perl |  80 ----------------------------------
 Documentation/cmd-list.sh   | 104 ++++++++++++++++++++++++++++++++++++++++++++
 Documentation/fix-texi.perl |  15 -------
 Documentation/fix-texi.sh   |  21 +++++++++
 Documentation/meson.build   |   4 +-
 git-filter-branch.sh        |  37 ++++++++--------
 git-request-pull.sh         |  74 ++++++++++++++++---------------
 meson.build                 |   2 +-
 t/t5150-request-pull.sh     |   6 ---
 10 files changed, 191 insertions(+), 160 deletions(-)

Range-diff versus v1:

1:  d0aa04cb2e9 = 1:  b48e33ada07 filter-branch: stop depending on Perl
2:  0fc604b849d ! 2:  31f54bd63e4 request-pull: stop depending on Perl
    @@ git-request-pull.sh: fi
     +	while read sha1 ref
     +	do
     +		case "$ref" in
    -+		*"^{}")
    -+			ref="${ref%"^{}"}"
    ++		*"^"?*)
    ++			ref="${ref%"^"*}"
     +			deref=true
     +			;;
     +		*)
3:  75dd9df3d83 = 3:  788fb204917 Documentation: stop depending on Perl to massage user manual
4:  9c4b5c330b4 ! 4:  c770a80762b Documentation: stop depending on Perl to generate command list
    @@ Documentation/cmd-list.sh (new)
     +	while read line
     +	do
     +		case "$state" in
    -+			0)
    -+				case "$line" in
    -+				git*\(*\)|scalar*\(*\))
    -+					mansection="${line##*\(}"
    -+					mansection="${mansection%\)}"
    -+					;;
    -+				NAME)
    -+					state=1;;
    -+				esac
    -+				;;
    -+			1)
    -+				if test "$line" = "----"
    -+				then
    -+					state=2
    -+				fi
    -+				;;
    -+			2)
    -+				description="$line"
    -+				break
    ++		0)
    ++			case "$line" in
    ++			git*\(*\)|scalar*\(*\))
    ++				mansection="${line##*\(}"
    ++				mansection="${mansection%\)}"
     +				;;
    ++			NAME)
    ++				state=1;;
    ++			esac
    ++			;;
    ++		1)
    ++			if test "$line" = "----"
    ++			then
    ++				state=2
    ++			fi
    ++			;;
    ++		2)
    ++			description="$line"
    ++			break
    ++			;;
     +		esac
     +	done <"$path"
     +
    @@ Documentation/cmd-list.sh (new)
     +	fi
     +
     +	case "$description" in
    -+		"$command - "*)
    -+			text="${description#$command - }"
    ++	"$command - "*)
    ++		text="${description#$command - }"
     +
    -+			printf "linkgit:%s[%s]::\n\t" "$command" "$mansection"
    -+			case "$attributes" in
    -+				*" deprecated "*)
    -+					printf "(deprecated) "
    -+					;;
    -+			esac
    -+			printf "$text.\n\n"
    -+			;;
    -+		*)
    -+			echo >&2 "Description does not match $command: $description"
    -+			exit 1
    ++		printf "linkgit:%s[%s]::\n\t" "$command" "$mansection"
    ++		case "$attributes" in
    ++		*" deprecated "*)
    ++			printf "(deprecated) "
     +			;;
    ++		esac
    ++		printf "$text.\n\n"
    ++		;;
    ++	*)
    ++		echo >&2 "Description does not match $command: $description"
    ++		exit 1
    ++		;;
     +	esac
     +}
     +
    @@ Documentation/cmd-list.sh (new)
     +build_dir="$2"
     +shift 2
     +
    -+for out in "$@"
    ++for out
     +do
     +	category="${out#cmds-}"
     +	category="${category%.adoc}"

---
base-commit: b09b3d4791ed248fed65de18cd6d8c084f7f0280
change-id: 20250409-b4-pks-drop-perl-574571234e3c

