Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C12817555
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 21:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665369; cv=none; b=ivsCYEAWYZWj+FfPMCRzOHQVbGOza80CB1M7f9oRpxY+IQRVVaYgtFRaZ4/mWxIV2ZaoVuuRpDxj+zygaRgM4pMst8w7XcvUwTJ8k0Fk6tPmzOXQIxVCNDz4yaOU9vGAfB7Oi4j5AC60OHBeGIb9/DKR6A88snvPNKuc56BUL/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665369; c=relaxed/simple;
	bh=sERFl4cq3F1CrvqDb3IkZBC8nsDOq6dTt6YfNYL4Zug=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=fnnvBJCavlcUde2VJSeFH4k2K4l7PfZTaNPOOLUme0kgZlmyVm0FNla8Y5St1PWP+lFGLKkk5ohogeBph/ZEhxF95ypMSZwTvVIma9A4tKuUBOtoeAsOcp0qNFeqh7gy+S/ByXmUeZeVZb4/En0TPWELErYiZbJA5DFyq784MmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBqTSrck; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBqTSrck"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5f3f04b5dbcso3657820a12.1
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 14:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744665364; x=1745270164; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57vJE3XfV9HwCkxZPlYRlMG6uHab/AGmI9HlUEVU+qo=;
        b=XBqTSrckB+YhhykSN0a9+JZJOj7qTi81sdc3QpRZnJ0t5RMmsWxLG48aTkFYgguWpk
         +BklueSl2yei2RGay2IHlc5p7QUPmp1zraLO3ulrBq9hX5Gdx28Z3GMjqRE5jCfDBlWs
         Qe+K1DJXIXZ77z+Bm2SO6f+xtOjrdpXV09t1+EGlf1o1gCmOu3at8PB6Z9drhgL8ZdkO
         m/syv8r4KGwG/PNTmTaoW0PLuoERl9SH30g4U9bS5Q07tT4qds4wE3FfNHpwBKejny/j
         V2QmzhmjdctT/1pWT+6HZkjUKsRzbDjp+xuUY16/yTUTasB21UKy93NTWC5BT7+DawG9
         SPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744665364; x=1745270164;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=57vJE3XfV9HwCkxZPlYRlMG6uHab/AGmI9HlUEVU+qo=;
        b=HR/w9TJITGYxwvSbf6gH0i0tcF36e8ObZCmGSfKl9SUaOK7h/d9m2ZVtN1KXuUrJbE
         8V3Bn1AkuXS2Q+p4JIorgEj4+lhQ8SVX0TvwsXWhi0cs57+PKn4d+svD6tSaTyhfblNL
         ilU9PxlxaRGuhQ1fp4xjeMIBo7Gx416rNWtL10xh57mzTDK9V+ywdw6Aacis0+sRmzD7
         84W8ssuRVV00Kl5RxZdxDiK5I/rhj6YDZjCeZBWg8hQWtksu6u2xGk9MikoaGeLhqUYQ
         KTkohtXftLqFb5FT696b8llQdYdCBalmILeNC+6uu3TAZKvaOn/WNkfSyN8ITPVXf5oC
         OxzA==
X-Gm-Message-State: AOJu0Yx1QdMkph9+bisiw9xBJRfqRemmIocHRIJWutDRuOoAPnaiyUe7
	3oXYrzJ+2mev5iU0ieJhXomOrGHiinPUBowwpu7LVDG4B96ZgdkP
X-Gm-Gg: ASbGncueMse0YAH/CQ27x0pW5O3iFr+zyOc11tihYlzDAXKeO2wP29R6ZCqnpvLfRYB
	RR2Ake5ypDR6Z7Cpa2b/JvkcQcUK7v74t2e31Kg4AQVMkJZSnIz4Qafn+wYcrp4MUrPNlemGsQv
	jigtAigrXv/m5TiELKt7lEVTFOP5ZTBidFKZK2L7xrZYXj7tX5szvtGEHOdt6Ue08caEDJPJlXr
	eZW5dVQ3REPXJYz9iQN0DUqbY97mdUotOc7E4KW2Jmbgmfe+XuGV9cyugY9AHdDqWY8uK9pg9bz
	80BABuEhsx4qBMggVVtOOLZu+JgiJBcGyyzHLmSsYuOwPdk=
X-Google-Smtp-Source: AGHT+IFev/hDeamnVZOWkFMBnhjMfiWuj/uJlpd8KejbdQIA6s3kYEwarqSjzIFkDhUct1TGr3yRDQ==
X-Received: by 2002:a05:6402:4582:b0:5f3:f04b:b5d7 with SMTP id 4fb4d7f45d1cf-5f3f04bb6f3mr7247940a12.18.1744665364127;
        Mon, 14 Apr 2025 14:16:04 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:f62e:e088:2c58:70de])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ee54fb5sm5527518a12.13.2025.04.14.14.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 14:16:03 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/4] meson: add corresponding target for Makefile's
 hdr-check
Date: Mon, 14 Apr 2025 23:15:58 +0200
Message-Id: <20250414-505-wire-up-sparse-via-meson-v3-0-edc6e7f26745@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA57/WcC/4XOTQ6CMBCG4auQrh3TTqkQV97DuChlgEnkJ61WD
 eHuFty40uU7i+ebWQTyTEEcs1l4ihx4HFLoXSZcZ4eWgOvUAiUaqbUEIw082BPcJwiT9YEgsoW
 ewjgAksa61gplWYlETJ4afm78+ZK643Ab/Wtbi2q9fuBclr/hqECCKvLiQMaR1c2p7S1f927sx
 QpH/MLUny8jJsy6KjfOlRbJfGPLsrwBs/MrghUBAAA=
X-Change-ID: 20250330-505-wire-up-sparse-via-meson-2e32dd31208b
In-Reply-To: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 gitster@pobox.com, phillip.wood123@gmail.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7572; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=sERFl4cq3F1CrvqDb3IkZBC8nsDOq6dTt6YfNYL4Zug=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGf9exKmtsoaMG340Ml0BxkzYThZLpB1RhMQk
 AlAe/hAvMLQXYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn/XsSAAoJED7VnySO
 Rox/lRkMAIPGFZ6cJ0d9AjWuaeg/jzt76cFPNe4YS7HjQi2OmlRCyDj34Tv1XViF0M7g8eVo+v7
 1FQql/RaPBC2py1NMQdWU1gDpkjllWnHeGmyMgz+4AlIRNPcoGX443OuIO0Fb03sh9cCRYMqyZF
 /QY5eDG0tdNkskN8hSyLKIyWWC1+vntCM3OkpST6o8fTvd38AJ/ejbXQFq5HxYO4a3rTkuvuHYM
 lbtIaaIP4H7c27O/+FGIU/F/H5c4Llac81aOsyp04cpFMnReXO9I4SdK80WKgAeulTI0Y80wpV7
 YeE/G/ab007B2bxhZF0+iMJfDqG16exD4Bdy58JFW4CKhYVXdLjdGokTYIN420AQKvhiK4SiU5c
 pNjrxYnjUkQ5YnCMTnQTYuEqQsXNsz3k6hFpPI0dWsgbAP5NhDsOj9KvjJYGp2ymjnfucP7HlOw
 MyLQpDgBNBA4nbtqfZGsDlXazuY+vSyWWK4QcW+gzaC1/2icKbjBTvcNKFya20N+G4nokeT5BL5
 9M=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

To bridge the remaining gaps between Makefile and Meson, this patch
series adds 'hdr-check' to Meson to compliment the Makefile's
'hdr-check'.

We also introduce 'headers-check' as an alias to 'hdr-check' as a better
named replacement in both Meson and make and add a note to deprecate
'hdr-check' in the future.

The first two commits are small cleanups, where we re-organize existing
variables to make it easier to add the target. The third commit adds the
'hdr-check' target to Meson. The last commit introduces the
'headers-check' alias to both Meson and the makefile and marks
'hdr-check' to be deprecated.

This is based on master 9d22ac5122 (The third batch, 2025-04-07) with
'es/meson-build-skip-coccinelle' merged in.

---
Changes in v3:
- Some renames:
  - headers_generated -> generated_headers
  - meson -> Meson
  - headers-check -> check-headers
  - headers_check_exclude -> exclude_from_check_headers
- Rewrite 'headers_check_exclude' to also contain dirs so we can skip
  listing individual header files.
- Move 'xdiff/*' to 'third_party_sources' and cleanup
  'exclude_from_check_headers'.
- Use 'echo' instead of 'echo -n'.
- Use `fs.replace_suffix` instead of `str.replace`.
- Link to v2: https://lore.kernel.org/r/20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com

Changes in v2:
- Add 'hdr-check' to meson, while introducing 'headers-check' as
  a replacement alias. Schedule 'hdr-check' to be deprecated in the future.
- Link to v1: https://lore.kernel.org/r/20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com

---
 Makefile                       |  4 +-
 ci/run-static-analysis.sh      |  2 +-
 contrib/coccinelle/meson.build | 29 ++++---------
 meson.build                    | 94 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 105 insertions(+), 24 deletions(-)

Karthik Nayak (4):
      coccinelle: meson: rename variables to be more specific
      meson: move headers definition from 'contrib/coccinelle'
      meson: add support for 'hdr-check'
      makefile/meson: add 'check-headers' as alias for 'hdr-check'

Range-diff versus v2:

1:  ca94103a13 ! 1:  3386caeaf5 coccinelle: meson: rename variables to be more specific
    @@ Metadata
      ## Commit message ##
         coccinelle: meson: rename variables to be more specific
     
    -    In meson, included subdirs export their variables to top level meson
    +    In Meson, included subdirs export their variables to top level Meson
         builds. In 'contrib/coccinelle/meson.build', we define two such
         variables `sources` and `headers`. While these variables are specific to
         the checks in the 'contrib/coccinelle/' directory, they also pollute the
2:  2549f1a5df ! 2:  35f5a580e4 meson: move headers definition from 'contrib/coccinelle'
    @@ Metadata
      ## Commit message ##
         meson: move headers definition from 'contrib/coccinelle'
     
    -    The meson build for coccinelle static analysis lists all headers to
    -    analyse. Due to the way meson exports variables between subdirs, this
    -    variable is also available in the root meson build.
    +    The Meson build for coccinelle static analysis lists all headers to
    +    analyse. Due to the way Meson exports variables between subdirs, this
    +    variable is also available in the root Meson build.
     
         An upcoming commit, will add a new check complimenting 'hdr-check' in
         the Makefile. This would require the list of headers. So move the
    -    'coccinelle_headers' to the root meson build and rename it to 'headers',
    +    'coccinelle_headers' to the root Meson build and rename it to 'headers',
         remove the root path being appended to each header and retain that in
    -    the coccinelle meson build since it is specific to the coccinelle build.
    +    the coccinelle Meson build since it is specific to the coccinelle build.
     
    -    Also move the 'third_party_sources' variable to the root meson build
    +    Also move the 'third_party_sources' variable to the root Meson build
         since it is also a dependency for the 'headers' variable. This also
         makes it easier to understand as the variable is now propagated from the
         top level to the bottom.
    @@ meson.build: builtin_sources = [
     +  ':!t/t[0-9][0-9][0-9][0-9]*',
     +]
     +
    -+headers = []
     +if git.found()
    ++  headers = []
     +  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
     +    headers += header
     +  endforeach
3:  a46db4a81c < -:  ---------- meson: add support for 'hdr-check'
-:  ---------- > 3:  0df83087ac meson: add support for 'hdr-check'
4:  fe0160b6fe ! 4:  b5d10772ff makefile/meson: add 'headers-check' as alias for 'hdr-check'
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    makefile/meson: add 'headers-check' as alias for 'hdr-check'
    +    makefile/meson: add 'check-headers' as alias for 'hdr-check'
     
    -    The 'hdr-check' target in meson and makefile is used to check if headers
    +    The 'hdr-check' target in Meson and makefile is used to check if headers
         can be compiled individually. The naming however isn't readable as 'hdr'
         is not a common shortforme for 'header', neither is it an abbreviation.
     
    -    Let's introduce 'headers-check' as an alternative target for 'hdr-check'
    +    Let's introduce 'check-headers' as an alternative target for 'hdr-check'
         and add a `TODO` to deprecate the latter after 2 releases. Since this
         is an internal tool, we can use a shorter deprecation cycle.
     
         Change existing usage of 'hdr-check' in 'ci/run-static-analysis.sh' to
    -    also use 'headers-check'.
    +    also use 'check-headers'.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ Makefile: HCC = $(HCO:hco=hcc)
      	$(QUIET_HDR)$(CC) $(ALL_CFLAGS) -o /dev/null -c -xc $<
      
     -.PHONY: hdr-check $(HCO)
    -+# TODO: deprecate 'hdr-check' in lieu of 'headers-check' in Git 2.51+
    -+.PHONY: hdr-check headers-check $(HCO)
    ++# TODO: deprecate 'hdr-check' in lieu of 'check-headers' in Git 2.51+
    ++.PHONY: hdr-check check-headers $(HCO)
      hdr-check: $(HCO)
    -+headers-check: hdr-check
    ++check-headers: hdr-check
      
      .PHONY: style
      style:
    @@ ci/run-static-analysis.sh: then
      fi
      
     -make hdr-check ||
    -+make headers-check ||
    ++make check-headers ||
      exit 1
      
      make check-pot
     
      ## meson.build ##
    -@@ meson.build: if headers.length() != 0 and compiler.get_argument_syntax() == 'gcc'
    +@@ meson.build: if git.found() and compiler.get_argument_syntax() == 'gcc'
          hco_targets += hco
        endforeach
      
    -+  # TODO: deprecate 'hdr-check' in lieu of 'headers-check' in Git 2.51+
    ++  # TODO: deprecate 'hdr-check' in lieu of 'check-headers' in Git 2.51+
        alias_target('hdr-check', hco_targets)
    -+  alias_target('headers-check', hco_targets)
    ++  alias_target('check-headers', hco_targets)
      endif
      
      foreach key, value : {


base-commit: 3a956c5f69873611ae5f8dcb9acd117f66b95ddc
change-id: 20250330-505-wire-up-sparse-via-meson-2e32dd31208b

Thanks
- Karthik

