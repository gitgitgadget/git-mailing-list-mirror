Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723886;
	b=HDsStf7d9NgP5X9JPnhZ7ctpPiXFf2anudGJQeGAur49sanOk1g4iH3oh92QEuRHD2eK
	 GgTy0YbIfelHW68JWA6hv9VvctlW/BIuuglENaOa7D7MxUr3xbdF7szckjL8AWZEmNKzi
	 5v7j4Q/mfGy/kprFQFT0gOGuAb/5m8KGZXNX5a17gBANhRMdZRyZ2zDSCBjomDo6G1yBH
	 Fu/RPigUvdnTgbjewwXG27Q0VKxsUtHKHMw26pJs8JqOXtLbQGVB/hgQ1S0+4ZZODmJzk
	 BY3HCGYVyRB1srCvNgA+EfYH7Ed2R7o/yqHzKviKiXGMxXDByOHGkOBXASp3pgJgnYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723886;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-FEAS-BEC-Info:X-FEAS-Client-IP:
	 X-FE-Last-Public-Client-IP:X-FE-Policy-ID:X-FE-Hostname:
	 DKIM-Signature;
	bh=fKKKxGmcazzVNV4KZRj+SXTf05hXUqUpH9fT/DZw4WI=;
	b=ank+OtgHUTYuBQYxB9Yt/J42XIQrOqUCQv31NafIqZxV7MNkQD/Z9gGeWM+x0/ibdGuA
	 3ahYAocBX8YzCCse1PmAqqXsN1UuBfz1tZM8KzgMulymmWgBgHm8Ie65OKW3naUld+vRr
	 2vsATwsSbRJa33nxWv+qXibVPQRjLH5/kTvr/O/3XlxcHn3mXFTAraaxNoFEYwz9Ns+BJ
	 kKyNaDBXuR+g4GXFlpGmr9YNCjqdxWCcghs65AzsWuNFlCM4l/l0IQf87VhtLrAkOXqbg
	 hQ8FesPuu+G7cZhgDdz84TbsZ7pp7CqDagPSShxanZJu3aZrHR6XDwrYHbIT49UEYeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=UHoJxSVk;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ECF606A337
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 20:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26ECF606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=UHoJxSVk
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6AQKBBWB024201-6AQKBBWD024201
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 26 Nov 2026 22:11:11 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xWfoF-00CmMq-1r;
	Thu, 26 Nov 2026 22:11:11 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 22:11:10 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id b308b325;
	Thu, 26 Nov 2026 20:11:10 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Junio C Hamano <gitster@pobox.com>, Julia Evans <julia@jvns.ca>, Tuomas
 Ahola <taahol@utu.fi>
Subject: [PATCH v4 0/2] guides: keep Documentation/Makefile and command-list.txt in sync
Date: Thu, 26 Nov 2026 22:11:08 +0200
Message-ID: <20261126201110.9046-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260909052501.8448-1-taahol@utu.fi>
References: <20260909052501.8448-1-taahol@utu.fi>
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
Content-Type: text/plain
X-ClientProxiedBy: ex19-09.utu.fi (130.232.247.49) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsH
 BUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIW0hYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhZW0gCHQQBCSgC
 HgYbRgsJSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=fKKKxGmcazzVNV4KZRj+SXTf05hXUqUpH9fT/DZw4WI=;
 b=UHoJxSVk/YetqAnLSGOrCP+p21qJ7cF/+vLw3WnMGBwyUCrSz2bn0eooboDctF0yyPT2xQwRseGW
	cHoUp4qXrVsjjcmOnwzoUaQdcV+UZ+5m3L/2NGqw4aLohwExN1oUQTK2rIFZRZql5azuO0GpyTqI
	ecErY2uDSFW4urkiUJ4fJ7V3aDFvZSWD/AxMiTAuzXRnym3JPHoxe9/4+3rkqcUd4z6MEutez3mj
	t0UOwbbfFAoUDAuzDtMe1fbIO8STXUcS4URU53qerIef8lR5eWC10T04vaZ2Wh5+J2wTXMmYQdim
	tsLzJEzEyoRuhJo/rAyVsYF8TDPWZcjq/I8Yuw==

A new linter test has been added to Documentation/lint-manpages.sh
to ensure that all non-command manual pages (concept guides and
interface manuals) listed in Documentation/Makefile are present in
command-list.txt.

Changes in v4:

* [1/2]: Rebased to 0ffa3e35c7 (The 15th batch, 2026-11-04)
* [2/2]: Changed the signature of extract_variable()
  	 to extract_variable <Makefile> <variable>...

Changes in v3:

* [2/2]:
   - Exempt obsoleted gittutorial-2(7).
   - Even more defensive quotation.

Changes in v2:

* [1/2]: Use command-list.txt as the area identifier.
* [2/2]: Protect variables against whitespace breakage per review comment.

synthetic-base: master + je/doc-remove-gittutorial-2

Tuomas Ahola (2):
  command-list.txt: add gitformat-loose(5) and gitpacking(7)
  lint-docs: ensure command-list.txt lists all guides

 Documentation/lint-manpages.sh | 29 +++++++++++++++++++----------
 command-list.txt               |  2 ++
 2 files changed, 21 insertions(+), 10 deletions(-)

Intervall-diff mot v3:
1:  9a1ba61ac0 ! 1:  a21c0e2bf7 command-list.txt: add gitformat-loose(5) and gitpacking(7)
    @@ command-list.txt: gitformat-bundle                        developerinterfaces
      gitformat-pack                          developerinterfaces
      gitformat-signature                     developerinterfaces
      gitglossary                             guide
    -@@ command-list.txt: gitk                                    mainporcelain
    - gitmailmap                              userinterfaces
    +@@ command-list.txt: gitmailmap                              userinterfaces
    + gitmergeconflicts                       guide
      gitmodules                              userinterfaces
      gitnamespaces                           guide
     +gitpacking                              guide
2:  5d36d75859 ! 2:  4e41401866 lint-docs: check the guide list in command-list.txt
    @@ Metadata
     Author: Tuomas Ahola <taahol@utu.fi>
     
      ## Commit message ##
    -    lint-docs: check the guide list in command-list.txt
    +    lint-docs: ensure command-list.txt lists all guides
     
         Since 2135e1ad70 (command-list.txt: add missing 'gitcredentials' and
         'gitremote-helpers', 2020-08-05) there has been a comment in
    @@ Commit message
         command-list.txt.  However, there is no linter script to enforce that.
     
         Adapt Documentation/lint-manpages.sh to fill that role.  Extract
    -    MAN5_TXT and MAN7_TXT from the Makefile and check command-list.txt
    +    MAN5_TXT and MAN7_TXT from the docs Makefile and check command-list.txt
         against them.  Exempt gitweb.conf(5) and gittutorial-2(7) from the
    -    new linter routine.
    +    new linter routine as deliberate omissions.
     
         Signed-off-by: Tuomas Ahola <taahol@utu.fi>
     
    - ## Documentation/Makefile ##
    -@@ Documentation/Makefile: MAN7_TXT += gittutorial-2.adoc
    - MAN7_TXT += gittutorial.adoc
    - MAN7_TXT += gitworkflows.adoc
    - 
    -+MAN_GUIDES = $(patsubst %.adoc,%,$(MAN5_TXT) $(MAN7_TXT))
    -+
    - HOWTO_TXT += $(wildcard howto/*.adoc)
    - 
    - DOC_DEP_TXT += $(wildcard *.adoc)
    -
      ## Documentation/lint-manpages.sh ##
     @@
      #!/bin/sh
      
      extract_variable () {
    -+	file="${2:-../Makefile}"
    -+	directory="$(dirname "$file")"
    - 	(
    +-	(
     -		cat ../Makefile
    -+		cat "$file"
    - 		cat <<EOF
    +-		cat <<EOF
    ++	file="$1"
    ++	directory="$(dirname "$file")"
    ++	shift
    ++	for i in "$@"
    ++	do
    ++		(
    ++			cat "$file"
    ++			cat <<EOF
      print_variable:
      	@\$(foreach b,\$($1),echo XXX \$(b:\$X=) YYY;)
      EOF
    - 	) |
    +-	) |
     -	make -C .. -f - print_variable 2>/dev/null |
    -+	make -C "$directory" -f - print_variable 2>/dev/null |
    - 	sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p'
    +-	sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p'
    ++		) |
    ++		make -C "$directory" -f - print_variable 2>/dev/null |
    ++		sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p'
    ++	done
      }
      
      check_missing_docs () (
    @@ Documentation/lint-manpages.sh: check_missing_docs () (
      
      		if ! test -f "$v.adoc"
     @@ Documentation/lint-manpages.sh: check_extraneous_docs () {
    - BUILT_INS="$(extract_variable BUILT_INS)"
    - ALL_COMMANDS="$(extract_variable ALL_COMMANDS)"
    - EXCLUDED_PROGRAMS="$(extract_variable EXCLUDED_PROGRAMS)"
    -+MAN_GUIDES="$(extract_variable MAN_GUIDES ./Makefile)"
    + 	)
    + }
    + 
    +-BUILT_INS="$(extract_variable BUILT_INS)"
    +-ALL_COMMANDS="$(extract_variable ALL_COMMANDS)"
    +-EXCLUDED_PROGRAMS="$(extract_variable EXCLUDED_PROGRAMS)"
    ++BUILT_INS="$(extract_variable ../Makefile BUILT_INS)"
    ++ALL_COMMANDS="$(extract_variable ../Makefile ALL_COMMANDS)"
    ++EXCLUDED_PROGRAMS="$(extract_variable ../Makefile EXCLUDED_PROGRAMS)"
    ++MAN_GUIDES="$(extract_variable Makefile MAN5_TXT MAN7_TXT | sed -e 's/\.adoc//')"
      
      findings=$(
      	if ! check_missing_docs

base-commit: 0ffa3e35c7c82ab8d0de226149fb03b3f7674d05
-- 
ta/command-list-guides-sync-lint

