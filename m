Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EC923C8BA
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878346; cv=none; b=ZjJKNEq2C8QDDTL4J8AhmBv9sDQbv+5Efcf5nW6PAHbPhEwFgdRSnWJ3tzMAhxgfsviq1fL1R558N1MHbapD96yCO6riN1i0V2ELpLi99Lh3iL/KputG/pN5q62KIBXPD7+wyJ6ye7wiF+zfFO9VxYTm4jb+K1fDar0dTmZQyMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878346; c=relaxed/simple;
	bh=lQkE7lDZwMutm/KKNhTcyB01T8p4X3OiqmHhPgz2SmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhNFlW59Sx0knS8JU5FllJGc/WopKylZCwIuKEsP3+CcdmUFi/Wfyry5IxpbM5m+IRFifbaIXmhDSBZwO3CIjyzJWs+y7qVW3zln9Tpmm4XJKGHMNBMAHTl6CWZ+4NLdozPcDy09TYBdjjTU+nucy0kDZpOiwxjv17PKdqwpU7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k60sHmJR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k60sHmJR"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4395f81db4dso31967915e9.1
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 03:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739878341; x=1740483141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ND5KqMKDRR7s6yDR+BB4J3UjBDDrybI6fi3O2BwmTac=;
        b=k60sHmJRfT8LeuNvXdwZaFTsTsZJMyzr8XX1+oup8VUTxGoxXTBnb6Q7xW+f8UDSLe
         nuNnxhVyVZwI3rPmPMQKojXWK7yWByMUpWAC1DOXTRohQOGBlzTCKz0EyalU40ce7J8X
         /tu16LhMGYUSnwH5BmAT6V9JU+Mf4IsOpi4hasy3wRSgB7HoNAf34dK+NLiwezN76N9Q
         BT3HtNLH5KU+g0hiUAIYICDJfZUP066bKXPKw6szxLEtevnQdRWiadPmTVaVEBMxqZlr
         9jy3HIJe/1Tk4iRS4hXZOl/xKrXVQ8/E7s8UWTC1gvMlYMjll7hwfcAJLNK/iB0SdVeq
         8cIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739878341; x=1740483141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ND5KqMKDRR7s6yDR+BB4J3UjBDDrybI6fi3O2BwmTac=;
        b=I+Ypa5B9dszFvU8aMY+n03Yn5skqSjnI6YGWwingER2za4eN+yuk11wDQcz/u3EsiN
         dNGmES5zy1gNgspyQlwak7xZmqpfJCkvWvup2cLXSIEgxZz1GKlZGheyfdYjOxnfAsFW
         koSuyGnmDapRofUBRAwdAN+DUcwUNPcw7JgRYRhJ4sNIfF08VNWOT7ctlxsGbgFORQjN
         vyqv2jYAHMJwuK/XTSqphIPwekqnvNp8x0Gf5HP2z12H2dIThOjUK8/r4iQVU8iFupcT
         1q13wM1gwhr+sDR/c4QmckHmSPDtV5J+Mbi+8NOUzYbF54BOzSFkW+2XZ+NNzfcOUar9
         IKCA==
X-Gm-Message-State: AOJu0YxeGKecF0TXxx48l1b0qKOpgRHi/UI2ND0gSLRM2hTOmvsoOx4W
	SVP+Z/pBK1HlZOhjkLLP/DjB+P4NqHrtF17Mnf4w4VZ0sRL5ATbWvV7Y/g==
X-Gm-Gg: ASbGncufgROsrY3Wh4WODYVA++yzsfb/mjtFV9caAgoBDZrPUYIEhHzDbeTl7TEHAB7
	NZdn4/Zj3wQvEToOBNHlOuaHJReMdhL5llxwK35cz9sPOpsql3IYteNJZcNQxWtkc3ESLlaBen9
	gFY1jCVX9O9b6DNENLF/5G0u9EblElJoaAyewq0RoIYOlQH5XAag2nxbo0V/mI0YnM6DwSo61hu
	Y+GESQntLE2YXvdwuFGe3dHuZ9qrxKlp1xaiuBFhFnsDp44ZLmtoEOj9mc0JxL+dgsKQu5T8mZO
	8+NSV3svzgTFtJgl3YJMMnPRfxYcfQ44QRGCloHjcWo+Q+PKq/p914uk1AmSGSGEgPgtYzbvpg=
	=
X-Google-Smtp-Source: AGHT+IFkjSNk5H0M1u2t9US+qrk/mascnwEXyTlaxO/ocH6Aaq/WHGd7WUsQAjmWaC3m8k6AY4dvPw==
X-Received: by 2002:a05:600c:3b20:b0:439:86c4:a8d7 with SMTP id 5b1f17b1804b1-43986c4ab3amr48127505e9.5.1739878340705;
        Tue, 18 Feb 2025 03:32:20 -0800 (PST)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43991c84fa4sm25270825e9.39.2025.02.18.03.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 03:32:19 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Randall S . Becker" <rsbecker@nexbridge.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 0/3] Introduce a "promisor-remote" capability
Date: Tue, 18 Feb 2025 12:32:01 +0100
Message-ID: <20250218113204.2847463-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.48.1.359.ge980fe0aa2
In-Reply-To: <20250127151701.2321341-1-christian.couder@gmail.com>
References: <20250127151701.2321341-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This work is part of some effort to better handle large files/blobs in
a client-server context using promisor remotes dedicated to storing
large blobs. To help understand this effort, this series now contains
a patch (patch 6/6) that adds design documentation about this effort.

Last year, I sent 3 versions of a patch series with the goal of
allowing a client C to clone from a server S while using the same
promisor remote X that S already use. See:

https://lore.kernel.org/git/20240418184043.2900955-1-christian.couder@gmail.com/

Junio suggested to implement that feature using:

"a protocol extension that lets S tell C that S wants C to fetch
missing objects from X (which means that if C knows about X in its
".git/config" then there is no need for end-user interaction at all),
or a protocol extension that C tells S that C is willing to see
objects available from X omitted when S does not have them (again,
this could be done by looking at ".git/config" at C, but there may be
security implications???)"

This patch series implements that protocol extension called
"promisor-remote" (that name is open to change or simplification)
which allows S and C to agree on C using X directly or not.

I have tried to implement it in a quite generic way that could allow S
and C to share more information about promisor remotes and how to use
them.

For now, C doesn't use the information it gets from S when cloning.
That information is only used to decide if C is OK to use the promisor
remotes advertised by S. But this could change in the future which
could make it much simpler for clients than using the current way of
passing information about X with the `-c` option of `git clone` many
times on the command line.

Another improvement could be to not require GIT_NO_LAZY_FETCH=0 when S
and C have agreed on using S.

Changes compared to version 4
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  - The series is rebased on top 0394451348 (The eleventh batch,
    2025-02-14). This is to take into account some recent changes like
    some documentation files using the ".adoc" extension instead of
    ".txt".

  - Patches 1/6, 2/6 and 3/6 from version 4 have been removed, as it
    looks like using redact_non_printables() is not necessary after
    all.

  - Patch 1/3 ("Add 'promisor-remote' capability to protocol v2") has
    a number of small changes:

      - In the protocol-v2 doc, "respectively" is not repeated.

      - In "promisor-remote.c", the useless call to
        redact_non_printables() has been removed.

      - In "promisor-remote.c", a useless "!accept_str" check has been
        removed.

      - In "promisor-remote.h", references to gitprotocol-v2(5) have
        been added to some comments.

      - In "promisor-remote.h", a comment has been improved to say
        that mark_promisor_remotes_as_accepted() is useful on the
        server side.

      - In "t/t5710-promisor-remote-capability.sh", "server2" has been
        replaced with "lop".

  - In patch 2/3 ("promisor-remote: check advertised name or URL"),
    there are also a number of small changes:

      - In "Documentation/config/promisor.adoc", an instance of
        "knownUrl" has been replaced with "knownName" to fix a
        mistake.

      - In "promisor-remote.c", strvec_find_index() has been renamed
        remote_nick_find() and its arguments have been renamed
        accordingly. Its comment doc has also been updated
        accordingly.

      - In "promisor-remote.c", URLs are now compared case
        sensitively, so a call to strcasecmp() has been replaced with
        a call to strcmp().

  - In patch 3/3 ("doc: add technical design doc for large object
    promisors"), there are a few small changes:

      - A paragraph was added to tell that even if used not very
        efficiently LOPs can be useful.

      - A small sentence was added to acknowledge that more discussion
        will be needed before implementing a feature to offload large
        blobs from clients.

Thanks to Junio, Patrick, Eric, Karthik, Kristoffer, brian, Randall
and Taylor for their suggestions to improve this patch series.

CI tests
~~~~~~~~

All the CI tests passed, see:

https://github.com/chriscool/git/actions/runs/13388314841

Range diff compared to version 4
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1:  9e646013be < -:  ---------- version: replace manual ASCII checks with isprint() for clarity
2:  f4b22ef39d < -:  ---------- version: refactor redact_non_printables()
3:  8bfa6f7a20 < -:  ---------- version: make redact_non_printables() non-static
4:  652ce32892 ! 1:  918515f5ee Add 'promisor-remote' capability to protocol v2
    @@ Commit message
         Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    - ## Documentation/config/promisor.txt ##
    + ## Documentation/config/promisor.adoc ##
     @@
      promisor.quiet::
        If set to "true" assume `--quiet` when fetching additional
    @@ Documentation/config/promisor.txt
     +  from its responses to "fetch" and "clone" requests from the
     +  client. See linkgit:gitprotocol-v2[5].
     
    - ## Documentation/gitprotocol-v2.txt ##
    -@@ Documentation/gitprotocol-v2.txt: retrieving the header from a bundle at the indicated URI, and thus
    + ## Documentation/gitprotocol-v2.adoc ##
    +@@ Documentation/gitprotocol-v2.adoc: retrieving the header from a bundle at the indicated URI, and thus
      save themselves and the server(s) the request(s) needed to inspect the
      headers of that bundle or bundles.
      
    @@ Documentation/gitprotocol-v2.txt: retrieving the header from a bundle at the ind
     +"promisor-remote" capability at all in its reply.
     +
     +The "promisor.advertise" and "promisor.acceptFromServer" configuration
    -+options can be used on the server and client side respectively to
    -+control what they advertise or accept respectively. See the
    -+documentation of these configuration options for more information.
    ++options can be used on the server and client side to control what they
    ++advertise or accept respectively. See the documentation of these
    ++configuration options for more information.
     +
     +Note that in the future it would be nice if the "promisor-remote"
     +protocol capability could be used by the server, when responding to
    @@ promisor-remote.c: void promisor_remote_get_direct(struct repository *repo,
     +          }
     +  }
     +
    -+  redact_non_printables(&sb);
    -+
     +  strvec_clear(&names);
     +  strvec_clear(&urls);
     +
    @@ promisor-remote.c: void promisor_remote_get_direct(struct repository *repo,
     +  enum accept_promisor accept = ACCEPT_NONE;
     +
     +  if (!git_config_get_string_tmp("promisor.acceptfromserver", &accept_str)) {
    -+          if (!accept_str || !*accept_str || !strcasecmp("None", accept_str))
    ++          if (!*accept_str || !strcasecmp("None", accept_str))
     +                  accept = ACCEPT_NONE;
     +          else if (!strcasecmp("All", accept_str))
     +                  accept = ACCEPT_ALL;
    @@ promisor-remote.h: void promisor_remote_get_direct(struct repository *repo,
     + * advertisement.
     + * Return value is NULL if no promisor remote advertisement should be
     + * made. Otherwise it contains the names and urls of the advertised
    -+ * promisor remotes separated by ';'
    ++ * promisor remotes separated by ';'. See gitprotocol-v2(5).
     + */
     +char *promisor_remote_info(struct repository *repo);
     +
    @@ promisor-remote.h: void promisor_remote_get_direct(struct repository *repo,
     + * configured promisor remotes, if any, to prepare the reply.
     + * Return value is NULL if no promisor remote from the server
     + * is accepted. Otherwise it contains the names of the accepted promisor
    -+ * remotes separated by ';'.
    ++ * remotes separated by ';'. See gitprotocol-v2(5).
     + */
     +char *promisor_remote_reply(const char *info);
     +
     +/*
    -+ * Set the 'accepted' flag for some promisor remotes. Useful when some
    -+ * promisor remotes have been accepted by the client.
    ++ * Set the 'accepted' flag for some promisor remotes. Useful on the
    ++ * server side when some promisor remotes have been accepted by the
    ++ * client.
     + */
     +void mark_promisor_remotes_as_accepted(struct repository *repo, const char *remotes);
     +
    @@ t/t5710-promisor-remote-capability.sh (new)
     +  check_missing_objects server "$count" "$missing_oids"
     +}
     +
    -+copy_to_server2 () {
    ++copy_to_lop () {
     +  oid_path="$(test_oid_to_path $1)" &&
     +  path="server/objects/$oid_path" &&
    -+  path2="server2/objects/$oid_path" &&
    ++  path2="lop/objects/$oid_path" &&
     +  mkdir -p $(dirname "$path2") &&
     +  cp "$path" "$path2"
     +}
     +
     +test_expect_success "setup for testing promisor remote advertisement" '
    -+  # Create another bare repo called "server2"
    -+  git init --bare server2 &&
    ++  # Create another bare repo called "lop" (for Large Object Promisor)
    ++  git init --bare lop &&
     +
    -+  # Copy the largest object from server to server2
    ++  # Copy the largest object from server to lop
     +  obj="HEAD:foo" &&
     +  oid="$(git -C server rev-parse $obj)" &&
    -+  copy_to_server2 "$oid" &&
    ++  copy_to_lop "$oid" &&
     +
     +  initialize_server 1 "$oid" &&
     +
    -+  # Configure server2 as promisor remote for server
    -+  git -C server remote add server2 "file://$(pwd)/server2" &&
    -+  git -C server config remote.server2.promisor true &&
    ++  # Configure lop as promisor remote for server
    ++  git -C server remote add lop "file://$(pwd)/lop" &&
    ++  git -C server config remote.lop.promisor true &&
     +
    -+  git -C server2 config uploadpack.allowFilter true &&
    -+  git -C server2 config uploadpack.allowAnySHA1InWant true &&
    ++  git -C lop config uploadpack.allowFilter true &&
    ++  git -C lop config uploadpack.allowAnySHA1InWant true &&
     +  git -C server config uploadpack.allowFilter true &&
     +  git -C server config uploadpack.allowAnySHA1InWant true
     +'
    @@ t/t5710-promisor-remote-capability.sh (new)
     +  git -C server config promisor.advertise true &&
     +
     +  # Clone from server to create a client
    -+  GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
    -+          -c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
    -+          -c remote.server2.url="file://$(pwd)/server2" \
    ++  GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
    ++          -c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
    ++          -c remote.lop.url="file://$(pwd)/lop" \
     +          -c promisor.acceptfromserver=All \
     +          --no-local --filter="blob:limit=5k" server client &&
     +  test_when_finished "rm -rf client" &&
    @@ t/t5710-promisor-remote-capability.sh (new)
     +  git -C server config promisor.advertise false &&
     +
     +  # Clone from server to create a client
    -+  GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
    -+          -c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
    -+          -c remote.server2.url="file://$(pwd)/server2" \
    ++  GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
    ++          -c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
    ++          -c remote.lop.url="file://$(pwd)/lop" \
     +          -c promisor.acceptfromserver=All \
     +          --no-local --filter="blob:limit=5k" server client &&
     +  test_when_finished "rm -rf client" &&
    @@ t/t5710-promisor-remote-capability.sh (new)
     +  git -C server config promisor.advertise true &&
     +
     +  # Clone from server to create a client
    -+  GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
    -+          -c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
    -+          -c remote.server2.url="file://$(pwd)/server2" \
    ++  GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
    ++          -c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
    ++          -c remote.lop.url="file://$(pwd)/lop" \
     +          -c promisor.acceptfromserver=None \
     +          --no-local --filter="blob:limit=5k" server client &&
     +  test_when_finished "rm -rf client" &&
    @@ t/t5710-promisor-remote-capability.sh (new)
     +  test_when_finished "rm -rf client" &&
     +  mkdir client &&
     +  git -C client init &&
    -+  git -C client config remote.server2.promisor true &&
    -+  git -C client config remote.server2.fetch "+refs/heads/*:refs/remotes/server2/*" &&
    -+  git -C client config remote.server2.url "file://$(pwd)/server2" &&
    ++  git -C client config remote.lop.promisor true &&
    ++  git -C client config remote.lop.fetch "+refs/heads/*:refs/remotes/lop/*" &&
    ++  git -C client config remote.lop.url "file://$(pwd)/lop" &&
     +  git -C client config remote.server.url "file://$(pwd)/server" &&
     +  git -C client config remote.server.fetch "+refs/heads/*:refs/remotes/server/*" &&
     +  git -C client config promisor.acceptfromserver All &&
    @@ t/t5710-promisor-remote-capability.sh (new)
     +  git -C server config promisor.advertise true &&
     +
     +  # Clone from server to create a client
    -+  GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
    -+          -c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
    -+          -c remote.server2.url="file://$(pwd)/server2" \
    ++  GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
    ++          -c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
    ++          -c remote.lop.url="file://$(pwd)/lop" \
     +          -c promisor.acceptfromserver=All \
     +          --no-local --filter="blob:limit=5k" server client &&
     +
    @@ t/t5710-promisor-remote-capability.sh (new)
     +  # Repack everything twice and remove .promisor files before
     +  # each repack. This makes sure everything gets repacked
     +  # into a single packfile. The second repack is necessary
    -+  # because the first one fetches from server2 and creates a new
    ++  # because the first one fetches from lop and creates a new
     +  # packfile and its associated .promisor file.
     +
     +  rm -f server/objects/pack/*.promisor &&
    @@ t/t5710-promisor-remote-capability.sh (new)
     +  packfile=$(ls pack-*.pack) &&
     +  git -C server unpack-objects --strict <"$packfile" &&
     +
    -+  # Copy new large object to server2
    ++  # Copy new large object to lop
     +  obj_bar="HEAD:bar" &&
     +  oid_bar="$(git -C server rev-parse $obj_bar)" &&
    -+  copy_to_server2 "$oid_bar" &&
    ++  copy_to_lop "$oid_bar" &&
     +
     +  # Reinitialize server so that the 2 largest objects are missing
     +  printf "%s\n" "$oid" "$oid_bar" >expected_missing.txt &&
5:  979a0af1c3 ! 2:  89e20976ba promisor-remote: check advertised name or URL
    @@ Commit message
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    - ## Documentation/config/promisor.txt ##
    -@@ Documentation/config/promisor.txt: promisor.advertise::
    + ## Documentation/config/promisor.adoc ##
    +@@ Documentation/config/promisor.adoc: promisor.advertise::
      promisor.acceptFromServer::
        If set to "all", a client will accept all the promisor remotes
        a server might advertise using the "promisor-remote"
    @@ Documentation/config/promisor.txt: promisor.advertise::
     +  URLs. If set to "knownUrl", the client will accept promisor
     +  remotes which have both the same name and the same URL
     +  configured on the client as the name and URL advertised by the
    -+  server. This is more secure than "all" or "knownUrl", so it
    ++  server. This is more secure than "all" or "knownName", so it
     +  should be used if possible instead of those options. Default
     +  is "none", which means no promisor remote advertised by a
     +  server will be accepted. By accepting a promisor remote, the
    @@ promisor-remote.c: char *promisor_remote_info(struct repository *repo)
      }
      
     +/*
    -+ * Find first index of 'vec' where there is 'val'. 'val' is compared
    -+ * case insensively to the strings in 'vec'. If not found 'vec->nr' is
    -+ * returned.
    ++ * Find first index of 'nicks' where there is 'nick'. 'nick' is
    ++ * compared case insensitively to the strings in 'nicks'. If not found
    ++ * 'nicks->nr' is returned.
     + */
    -+static size_t strvec_find_index(struct strvec *vec, const char *val)
    ++static size_t remote_nick_find(struct strvec *nicks, const char *nick)
     +{
    -+  for (size_t i = 0; i < vec->nr; i++)
    -+          if (!strcasecmp(vec->v[i], val))
    ++  for (size_t i = 0; i < nicks->nr; i++)
    ++          if (!strcasecmp(nicks->v[i], nick))
     +                  return i;
    -+  return vec->nr;
    ++  return nicks->nr;
     +}
     +
      enum accept_promisor {
    @@ promisor-remote.c: char *promisor_remote_info(struct repository *repo)
                return 1;
      
     -  BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
    -+  i = strvec_find_index(names, remote_name);
    ++  i = remote_nick_find(names, remote_name);
     +
     +  if (i >= names->nr)
     +          /* We don't know about that remote */
    @@ promisor-remote.c: char *promisor_remote_info(struct repository *repo)
     +  if (accept != ACCEPT_KNOWN_URL)
     +          BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
     +
    -+  if (!strcasecmp(urls->v[i], remote_url))
    ++  if (!strcmp(urls->v[i], remote_url))
     +          return 1;
     +
     +  warning(_("known remote named '%s' but with url '%s' instead of '%s'"),
    @@ promisor-remote.c: char *promisor_remote_info(struct repository *repo)
     +  struct strvec urls = STRVEC_INIT;
      
        if (!git_config_get_string_tmp("promisor.acceptfromserver", &accept_str)) {
    -           if (!accept_str || !*accept_str || !strcasecmp("None", accept_str))
    +           if (!*accept_str || !strcasecmp("None", accept_str))
                        accept = ACCEPT_NONE;
     +          else if (!strcasecmp("KnownUrl", accept_str))
     +                  accept = ACCEPT_KNOWN_URL;
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "init + fetch with pr
     +  git -C server config promisor.advertise true &&
     +
     +  # Clone from server to create a client
    -+  GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
    -+          -c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
    -+          -c remote.server2.url="file://$(pwd)/server2" \
    ++  GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
    ++          -c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
    ++          -c remote.lop.url="file://$(pwd)/lop" \
     +          -c promisor.acceptfromserver=KnownName \
     +          --no-local --filter="blob:limit=5k" server client &&
     +  test_when_finished "rm -rf client" &&
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "init + fetch with pr
     +
     +  # Clone from server to create a client
     +  GIT_NO_LAZY_FETCH=0 git clone -c remote.serverTwo.promisor=true \
    -+          -c remote.serverTwo.fetch="+refs/heads/*:refs/remotes/server2/*" \
    -+          -c remote.serverTwo.url="file://$(pwd)/server2" \
    ++          -c remote.serverTwo.fetch="+refs/heads/*:refs/remotes/lop/*" \
    ++          -c remote.serverTwo.url="file://$(pwd)/lop" \
     +          -c promisor.acceptfromserver=KnownName \
     +          --no-local --filter="blob:limit=5k" server client &&
     +  test_when_finished "rm -rf client" &&
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "init + fetch with pr
     +  git -C server config promisor.advertise true &&
     +
     +  # Clone from server to create a client
    -+  GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
    -+          -c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
    -+          -c remote.server2.url="file://$(pwd)/server2" \
    ++  GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
    ++          -c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
    ++          -c remote.lop.url="file://$(pwd)/lop" \
     +          -c promisor.acceptfromserver=KnownUrl \
     +          --no-local --filter="blob:limit=5k" server client &&
     +  test_when_finished "rm -rf client" &&
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "init + fetch with pr
     +'
     +
     +test_expect_success "clone with 'KnownUrl' and different remote urls" '
    -+  ln -s server2 serverTwo &&
    ++  ln -s lop serverTwo &&
     +
     +  git -C server config promisor.advertise true &&
     +
     +  # Clone from server to create a client
    -+  GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
    -+          -c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
    -+          -c remote.server2.url="file://$(pwd)/serverTwo" \
    ++  GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
    ++          -c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
    ++          -c remote.lop.url="file://$(pwd)/serverTwo" \
     +          -c promisor.acceptfromserver=KnownUrl \
     +          --no-local --filter="blob:limit=5k" server client &&
     +  test_when_finished "rm -rf client" &&
6:  3a0c134e09 ! 3:  e980fe0aa2 doc: add technical design doc for large object promisors
    @@ Documentation/technical/large-object-promisors.txt (new)
     +a number of current issues in the context of Git clients and servers
     +sharing Git objects.
     +
    ++Even if LOPs are used not very efficiently, they can still be useful
    ++and worth using in some cases because, as we will see in more details
    ++later in this document:
    ++
    ++  - they can make it simpler for clients to use promisor remotes and
    ++    therefore avoid fetching a lot of large blobs they might not need
    ++    locally,
    ++
    ++  - they can make it significantly cheaper or easier for servers to
    ++    host a significant part of the current repository content, and
    ++    even more to host content with larger blobs or more large blobs
    ++    than currently.
    ++
     +I) Issues with the current situation
     +------------------------------------
     +
    @@ Documentation/technical/large-object-promisors.txt (new)
     +to the LOP without the main remote checking them in some ways
     +(possibly using hooks or other tools).
     +
    ++This should be discussed and refined when we get closer to
    ++implementing this feature.
    ++
     +Rationale
     ++++++++++
     +


Christian Couder (3):
  Add 'promisor-remote' capability to protocol v2
  promisor-remote: check advertised name or URL
  doc: add technical design doc for large object promisors

 Documentation/config/promisor.adoc            |  27 +
 Documentation/gitprotocol-v2.adoc             |  54 ++
 .../technical/large-object-promisors.txt      | 656 ++++++++++++++++++
 connect.c                                     |   9 +
 promisor-remote.c                             | 242 +++++++
 promisor-remote.h                             |  37 +-
 serve.c                                       |  26 +
 t/meson.build                                 |   1 +
 t/t5710-promisor-remote-capability.sh         | 312 +++++++++
 upload-pack.c                                 |   3 +
 10 files changed, 1366 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/technical/large-object-promisors.txt
 create mode 100755 t/t5710-promisor-remote-capability.sh

-- 
2.48.1.359.ge980fe0aa2

