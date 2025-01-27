Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA5C25A658
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737991046; cv=none; b=Yc0+tOivmwPmHYUos0XoJI0YRrbePjzD7P7Use4HWCdWvFGHGzeIX6H6QzRt8384SF8a/OSvIQAxzk1XPwEgFeHzhn/vAHr+zXeMDXCx9pLWpjwxSXZMz6IUPhr2adreYz7V4q6g9uSoz9/f+rqBrAvb8Pgrxcge1K0b1sEecrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737991046; c=relaxed/simple;
	bh=UM+j17nZzEF4en3L0KwTHvGVOI0hm9ZJ2yD+tnC9w5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgHyDmDWVmmBsHSQsVcRsq3tes1wEcm9fx/cRHm8eDLJ9wSN9E+jGTIYnCprN2CJ0PjzJUb1qavAKvoLU4m3D1GRNE5dCtIFk330nxNjR9/CvEwZU3pM6pE9fvYQFUaEKfugVT/BFwqfBOhla03F6y1CTMscgEXAR/wflj2ZowQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GB0fkpMj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB0fkpMj"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so47223035e9.3
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 07:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737991041; x=1738595841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaLgprsB2f7ghuvFXOeSCQ24uEPjY9OmSOH7+CGIst8=;
        b=GB0fkpMjGGMz68nU9MufM9sSEtL84P3Gp4U4pAFbQeuYS8L1Ghf80wWzEgSh6Xp+VC
         DWp4FMIIbxflfKdVJp7HwGVxbJBDEoEYjP7XJx0S3YeioN8EgDQVSlSroMgZ8M+QR0/v
         DkqKijJg9R24F8YxPGL6Ngg0OjP8wl5PQdwdQdOj5VJeU5qk5EufKFeIYHimZ7tt2yE9
         oFkQlTwkyojxqt/icNvBzXYhwD239lC0eNn7bfLo20ulDeQYCbPabYRvhvgJ62EXw0l+
         xFlylu5dHMOo3s3pRZHT8wwzbJouuxSnSy643/fHiRUwYFAbBTJYZRh2n/696QIF6Onc
         z1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737991041; x=1738595841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaLgprsB2f7ghuvFXOeSCQ24uEPjY9OmSOH7+CGIst8=;
        b=LMvXEJIZLChUDkXVBDcOp3ya3C7S/gF1o52fJf/gG4D9rf9kSm6VqYxGSv3OTLTXh0
         ooJ4Oal0v1zbiJYthQtWNNFfALRVkH48AZkoQXXE89mMuZoXhAQbVUwZoawVd52nFYf2
         fX+v/cpCjE2q/O1DH+Kz3UQOQVl0OhFmLH1tjEcsu6rvEQ7H+O5VmKQo4qAAfgFWVgmC
         9x3s0vCtDrtvDe7u8JTs9RV5W2VB6KkphDzXvqqrIXSBJVbLdYIupeEtoXFpsDsHuLQb
         HBZvk6hR2oMq3lFPwLsep2OJ0An9u28HuND184etvAgRyJcFbZjYmiC6SzY0tBpaKVFd
         AnGg==
X-Gm-Message-State: AOJu0YxpPsMr0fumwoZz1z+Fl0C/i2/xY4zB3zz/t8oIQhSUDO6aA/q4
	LRSUNuVS0LJbAZeQKOEbJTNgm7BcqnVOWlZmsyN8Kbg4ZpCeTTdKg/qQlg==
X-Gm-Gg: ASbGncuHzokH/LB2/A/MabzqCJDqPKmqE7wYyVTtujDLhII5zP7gOZzBoeGXPZu67wL
	nEFavlen9KOTJnxBJsS7qM7BOsR1rWB97b0kk4z5gEaxmoGIAvl36MC5/CEFa1w6hXECbvsobQL
	2drBPF+a8QFsf678pn2yYUPetv7BdgQLjyvJkIUb1JYdh+8hwA9NLGQluGnVw4tGXvJYvILm7Xt
	TgGtVACPetorYL1YZ2ZwEebXg1XEZ1tSGgQQa34dnkrVlROwCYA1xg7zFvz/NNfJv/cVuWek4A3
	5SghVilGCBoytTLgOrYlMEr1An+SR5DSArnf98wHe8W6Tz446S7SUAxd4l0trVM=
X-Google-Smtp-Source: AGHT+IGEk5Z1NKkjJwub+utKIpejCJtkjjICNtlJzcz2TajwmSlUgJuBqKtGN8z16pANwYuOmV2K0A==
X-Received: by 2002:a05:600c:350b:b0:431:58cd:b259 with SMTP id 5b1f17b1804b1-438914671fdmr424651035e9.31.1737991040470;
        Mon, 27 Jan 2025 07:17:20 -0800 (PST)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4d34e3sm135269625e9.39.2025.01.27.07.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 07:17:19 -0800 (PST)
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
Subject: [PATCH v4 0/6] Introduce a "promisor-remote" capability
Date: Mon, 27 Jan 2025 16:16:55 +0100
Message-ID: <20250127151701.2321341-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.46.0.rc0.95.gcbf174a634
In-Reply-To: <20241206124248.160494-1-christian.couder@gmail.com>
References: <20241206124248.160494-1-christian.couder@gmail.com>
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

Changes compared to version 3
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  - Patches 1/6 and 2/6 are new in this series. They come from the
    patch series Usman Akinyemi is working on
    (https://lore.kernel.org/git/20250124122217.250925-1-usmanakinyemi202@gmail.com/).
    We need a similar redact_non_printables() function as the one he
    has been working on in his patch series, so it's just simpler to
    reuse his patches related to this function, and to build on top of
    them.

  - Patch 2/5 in version 3 has been removed. It created a new
    strbuf_trim_trailing_ch() function as part of the strbuf API, but
    we can reuse an existing function, strbuf_strip_suffix(), instead.

  - Patch 3/6 is new. It makes the redact_non_printables() non-static
    to be able to reuse it in a following patch.

  - In patch 4/6, the commit message has been improved:

      - Some "should" have been replaced with "may".
      
      - It states early that "If S and C can agree on C using X
        directly, S can then omit objects that can be obtained from X
        when answering C's request."

      - It mentions that "pieces of information that are usually
        outside Git's concern, like proxy configuration, must not be
        distributed over this protocol."

  - In patch 4/6, there are also some code changes:

      - redact_non_printables() is used instead of strbuf_sanitize(),
        see changes in patches 1/6 to 3/6 above.

      - strbuf_strip_suffix() is used instead of
        strbuf_trim_trailing_ch(), see the removal of patch 2/5 in
        version 3 mentioned above.

      - strbuf_split() is used instead of strbuf_split_str() when
        possible to simplifies the code a bit.

  - In patch 4/6, there is also a small change in the tests. In t5710
    testing with multi pack index and especially its incremental write
    are disabled. An issue has been found between the setup code in
    this test script and the multi pack index incremental write.

  - In patch 6/6 (doc: add technical design doc for large object
    promisors) there are a number of changes:

      - "aim to" is used more often to better outline the direction of
        the effort. And in general some similarly small changes have
        been made to make the document more assertive.

      - The "0) Non goal" section has been improved to mention that we
        want to focus for now on using existing object storage
        solutions accessed through remote helpers, and that we don't
        want to discuss data transfer improvements between LOPs and
        clients or servers.

      - A few typos, grammos and such have been fixed.

      - Examples of existing remote helpers to access existing object
        storage solutions have been added.

      - A note has been improved to mention that a protocol
        negotiation might not always happen when fetching.

      - A new note has been added about clients offloading objects
        they created directly to a LOP.

      - A new "V) Future improvements" section has been added.

Thanks to Junio, Patrick, Eric, Karthik, Kristoffer, brian, Randall
and Taylor for their suggestions to improve this patch series.

CI tests
~~~~~~~~

All the CI tests passed, see:

https://github.com/chriscool/git/actions/runs/12989763108

Range diff compared to version 3
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1:  13dd730641 < -:  ---------- version: refactor strbuf_sanitize()
2:  8f2aecf6a1 < -:  ---------- strbuf: refactor strbuf_trim_trailing_ch()
-:  ---------- > 1:  9e646013be version: replace manual ASCII checks with isprint() for clarity
-:  ---------- > 2:  f4b22ef39d version: refactor redact_non_printables()
-:  ---------- > 3:  8bfa6f7a20 version: make redact_non_printables() non-static
3:  57e1481bc4 ! 4:  652ce32892 Add 'promisor-remote' capability to protocol v2
    @@ Commit message
     
         When a server S knows that some objects from a repository are available
         from a promisor remote X, S might want to suggest to a client C cloning
    -    or fetching the repo from S that C should use X directly instead of S
    -    for these objects.
    +    or fetching the repo from S that C may use X directly instead of S for
    +    these objects.
     
         Note that this could happen both in the case S itself doesn't have the
         objects and borrows them from X, and in the case S has the objects but
    @@ Commit message
         omit in its response the objects available on X, is left for future
         improvement though.
     
    -    Then C might or might not, want to get the objects from X, and should
    -    let S know about this.
    +    Then C might or might not, want to get the objects from X. If S and C
    +    can agree on C using X directly, S can then omit objects that can be
    +    obtained from X when answering C's request.
     
         To allow S and C to agree and let each other know about C using X or
         not, let's introduce a new "promisor-remote" capability in the
    @@ Commit message
     
         For now, the URL is passed in addition to the name. In the future, it
         might be possible to pass other information like a filter-spec that the
    -    client should use when cloning from S, or a token that the client should
    -    use when retrieving objects from X.
    +    client may use when cloning from S, or a token that the client may use
    +    when retrieving objects from X.
    +
    +    It is C's responsibility to arrange how it can reach X though, so pieces
    +    of information that are usually outside Git's concern, like proxy
    +    configuration, must not be distributed over this protocol.
     
         It might also be possible in the future for "promisor.advertise" to have
         other values. For example a value like "onlyName" could prevent S from
    @@ promisor-remote.c
      #include "packfile.h"
      #include "environment.h"
     +#include "url.h"
    ++#include "version.h"
      
      struct promisor_remote_config {
        struct promisor_remote *promisors;
    @@ promisor-remote.c: void promisor_remote_get_direct(struct repository *repo,
     +          }
     +  }
     +
    -+  strbuf_sanitize(&sb);
    ++  redact_non_printables(&sb);
     +
     +  strvec_clear(&names);
     +  strvec_clear(&urls);
    @@ promisor-remote.c: void promisor_remote_get_direct(struct repository *repo,
     +          char *decoded_name = NULL;
     +          char *decoded_url = NULL;
     +
    -+          strbuf_trim_trailing_ch(remotes[i], ';');
    -+          elems = strbuf_split_str(remotes[i]->buf, ',', 0);
    ++          strbuf_strip_suffix(remotes[i], ";");
    ++          elems = strbuf_split(remotes[i], ',');
     +
     +          for (size_t j = 0; elems[j]; j++) {
     +                  int res;
    -+                  strbuf_trim_trailing_ch(elems[j], ',');
    ++                  strbuf_strip_suffix(elems[j], ",");
     +                  res = skip_prefix(elems[j]->buf, "name=", &remote_name) ||
     +                          skip_prefix(elems[j]->buf, "url=", &remote_url);
     +                  if (!res)
    @@ promisor-remote.c: void promisor_remote_get_direct(struct repository *repo,
     +          struct promisor_remote *p;
     +          char *decoded_remote;
     +
    -+          strbuf_trim_trailing_ch(accepted_remotes[i], ';');
    ++          strbuf_strip_suffix(accepted_remotes[i], ";");
     +          decoded_remote = url_percent_decode(accepted_remotes[i]->buf);
     +
     +          p = repo_promisor_remote_find(r, decoded_remote);
    @@ serve.c: static struct protocol_capability capabilities[] = {
     +  },
      };
      
    - void protocol_v2_advertise_capabilities(void)
    + void protocol_v2_advertise_capabilities(struct repository *r)
    +
    + ## t/meson.build ##
    +@@ t/meson.build: integration_tests = [
    +   't5703-upload-pack-ref-in-want.sh',
    +   't5704-protocol-violations.sh',
    +   't5705-session-id-in-capabilities.sh',
    ++  't5710-promisor-remote-capability.sh',
    +   't5730-protocol-v2-bundle-uri-file.sh',
    +   't5731-protocol-v2-bundle-uri-git.sh',
    +   't5732-protocol-v2-bundle-uri-http.sh',
     
      ## t/t5710-promisor-remote-capability.sh (new) ##
     @@
    @@ t/t5710-promisor-remote-capability.sh (new)
     +
     +. ./test-lib.sh
     +
    ++GIT_TEST_MULTI_PACK_INDEX=0
    ++GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=0
    ++
     +# Setup the repository with three commits, this way HEAD is always
     +# available and we can hide commit 1 or 2.
     +test_expect_success 'setup: create "template" repository' '
4:  7fcc619e41 = 5:  979a0af1c3 promisor-remote: check advertised name or URL
5:  c25c94707f ! 6:  3a0c134e09 doc: add technical design doc for large object promisors
    @@ Documentation/technical/large-object-promisors.txt (new)
     +effort described in this document to add a set of features to make it
     +easier to handle large blobs/files in Git by using LOPs.
     +
    -+This effort would especially improve things on the server side, and
    ++This effort aims to especially improve things on the server side, and
     +especially for large blobs that are already compressed in a binary
     +format.
     +
    -+This effort could help provide an alternative to Git LFS
    ++This effort aims to provide an alternative to Git LFS
     +(https://git-lfs.com/) and similar tools like git-annex
     +(https://git-annex.branchable.com/) for handling large files, even
     +though a complete alternative would very likely require other efforts
    @@ Documentation/technical/large-object-promisors.txt (new)
     +efforts could also improve the situation on the client side.
     +
     +- In the same way, we are not going to discuss all the possible ways
    -+  to implement a LOP or their underlying object storage.
    ++  to implement a LOP or their underlying object storage, or to
    ++  optimize how LOP works.
     ++
    -+In particular we are not going to discuss pluggable ODBs or other
    ++Our opinion is that the simplest solution for now is for LOPs to use
    ++object storage through a remote helper (see section II.2 below for
    ++more details) to store their objects. So we consider that this is the
    ++default implementation. If there are improvements on top of this,
    ++that's great, but our opinion is that such improvements are not
    ++necessary for LOPs to already be useful. Such improvements are likely
    ++a different technical topic, and can be taken care of separately
    ++anyway.
    +++
    ++So in particular we are not going to discuss pluggable ODBs or other
     +object database backends that could chunk large blobs, dedup the
     +chunks and store them efficiently. Sure, that would be a nice
     +improvement to store large blobs on the server side, but we believe
     +it can just be a separate effort as it's also not technically very
     +related to this effort.
    +++
    ++We are also not going to discuss data transfer improvements between
    ++LOPs and clients or servers. Sure, there might be some easy and very
    ++effective optimizations there (as we know that objects on LOPs are
    ++very likely incompressible and not deltifying well), but this can be
    ++dealt with separately in a separate effort.
     +
     +In other words, the goal of this document is not to talk about all the
     +possible ways to optimize how Git could handle large blobs, but to
    -+describe how a LOP based solution could work well and alleviate a
    -+number of current issues in the context of Git clients and servers
    ++describe how a LOP based solution can already work well and alleviate
    ++a number of current issues in the context of Git clients and servers
     +sharing Git objects.
     +
     +I) Issues with the current situation
    @@ Documentation/technical/large-object-promisors.txt (new)
     +
     +Also each feature doesn't need to be implemented entirely in Git
     +itself. Some could be scripts, hooks or helpers that are not part of
    -+the Git repo. It could be helpful if those could be shared and
    -+improved on collaboratively though.
    ++the Git repo. It would be helpful if those could be shared and
    ++improved on collaboratively though. So we want to encourage sharing
    ++them.
     +
     +1) Large blobs are stored on LOPs
     +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    @@ Documentation/technical/large-object-promisors.txt (new)
     +Rationale
     ++++++++++
     +
    -+LOP remotes should be good at handling large blobs while main remotes
    -+should be good at handling other objects.
    ++LOPs aim to be good at handling large blobs while main remotes are
    ++already good at handling other objects.
     +
     +Implementation
     +++++++++++++++
    @@ Documentation/technical/large-object-promisors.txt (new)
     +2) LOPs can use object storage
     +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     +
    -+A LOP could be using object storage, like an Amazon S3 or GCP Bucket
    -+to actually store the large blobs, and could be accessed through a Git
    ++LOPs can be implemented using object storage, like an Amazon S3 or GCP
    ++Bucket or MinIO (which is open source under the GNU AGPLv3 license) to
    ++actually store the large blobs, and can be accessed through a Git
     +remote helper (see linkgit:gitremote-helpers[7]) which makes the
    -+underlying object storage appears like a remote to Git.
    ++underlying object storage appear like a remote to Git.
     +
     +Note
     +++++
     +
    -+A LOP could be a promisor remote accessed using a remote helper by
    ++A LOP can be a promisor remote accessed using a remote helper by
     +both some clients and the main remote.
     +
     +Rationale
    @@ Documentation/technical/large-object-promisors.txt (new)
     +be more efficient and maintainable to write them using other languages
     +like Go.
     +
    ++Some already exist under open source licenses, for example:
    ++
    ++  - https://github.com/awslabs/git-remote-s3
    ++  - https://gitlab.com/eric.p.ju/git-remote-gs
    ++
     +Other ways to implement LOPs are certainly possible, but the goal of
     +this document is not to discuss how to best implement a LOP or its
     +underlying object storage (see the "0) Non goals" section above).
    @@ Documentation/technical/large-object-promisors.txt (new)
     +++++++++++++++
     +
     +The way to offload to a LOP discussed in 4) above can be used to
    -+regularly offload oversize blobs. About preventing oversize blobs to
    -+be fetched into the repo see 6) below. About preventing oversize blob
    -+pushes, a pre-receive hook could be used.
    ++regularly offload oversize blobs. About preventing oversize blobs from
    ++being fetched into the repo see 6) below. About preventing oversize
    ++blob pushes, a pre-receive hook could be used.
     +
     +Also there are different scenarios in which large blobs could get
     +fetched into the main remote, for example:
    @@ Documentation/technical/large-object-promisors.txt (new)
     +It might not be possible to completely prevent all these scenarios
     +from happening. So the goal here should be to implement features that
     +make the fetching of large blobs less likely. For example adding a
    -+`remote-object-info` command in the `git cat-file --batch*` protocol
    -+might make it possible for a main repo to respond to some requests
    -+about large blobs without fetching them.
    ++`remote-object-info` command in the `git cat-file --batch` protocol
    ++and its variants might make it possible for a main repo to respond to
    ++some requests about large blobs without fetching them.
     +
     +6) A protocol negotiation should happen when a client clones
     +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    @@ Documentation/technical/large-object-promisors.txt (new)
     +Note
     +++++
     +
    -+For fetches instead of clones, see the "What about fetches?" FAQ entry
    -+below.
    ++For fetches instead of clones, a protocol negotiation might not always
    ++happen, see the "What about fetches?" FAQ entry below for details.
     +
     +Rationale
     ++++++++++
    @@ Documentation/technical/large-object-promisors.txt (new)
     +Information that the server could send to the client through that
     +protocol could be things like: LOP name, LOP URL, filter-spec (for
     +example `blob:limit=<size>`) or just size limit that should be used as
    -+a filter when cloning, token to be used with the LOP, etc..
    ++a filter when cloning, token to be used with the LOP, etc.
     +
     +7) A client can offload to a LOP
     +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    @@ Documentation/technical/large-object-promisors.txt (new)
     +the client should be able to offload some large blobs it has fetched,
     +but might not need anymore, to the LOP.
     +
    ++Note
    ++++++
    ++
    ++It might depend on the context if it should be OK or not for clients
    ++to offload large blobs they have created, instead of fetched, directly
    ++to the LOP without the main remote checking them in some ways
    ++(possibly using hooks or other tools).
    ++
     +Rationale
     ++++++++++
     +
    @@ Documentation/technical/large-object-promisors.txt (new)
     +What about using multiple LOPs on the server and client side?
     +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     +
    -+That could perhaps be useful in some cases, but it's more likely for
    -+now than in most cases a single LOP will be advertised by the server
    -+and should be used by the client.
    ++That could perhaps be useful in some cases, but for now it's more
    ++likely that in most cases a single LOP will be advertised by the
    ++server and should be used by the client.
     +
     +A case where it could be useful for a server to advertise multiple
     +LOPs is if a LOP is better for some users while a different LOP is
    @@ Documentation/technical/large-object-promisors.txt (new)
     +is likely to be better connected to them, while users in other parts
     +of the world should pick only LOP B for the same reason."
     +
    -+Trusting the LOPs advertised by the server, or not trusting them?
    -+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ++When should we trust or not trust the LOPs advertised by the server?
    ++~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     +
     +In some contexts, like in corporate setup where the server and all the
     +clients are parts of an internal network in a company where admins
    -+have all the rights on every system, it's Ok, and perhaps even a good
    ++have all the rights on every system, it's OK, and perhaps even a good
     +thing, if the clients fully trust the server, as it can help ensure
     +that all the clients are on the same page.
     +
    @@ Documentation/technical/large-object-promisors.txt (new)
     +from the client when it fetches from them. The client could get the
     +token when performing a protocol negotiation with the main remote (see
     +section II.6 above).
    ++
    ++V) Future improvements
    ++----------------------
    ++
    ++It is expected that at the beginning using LOPs will be mostly worth
    ++it either in a corporate context where the Git version that clients
    ++use can easily be controlled, or on repos that are infrequently
    ++accessed. (See the "Could the main remote be bogged down by old or
    ++paranoid clients?" section in the FAQ above.)
    ++
    ++Over time, as more and more clients upgrade to a version that
    ++implements the "promisor-remote" protocol v2 capability described
    ++above in section II.6), it will be worth it to use LOPs more widely.
    ++
    ++A lot of improvements may also help using LOPs more widely. Some of
    ++these improvements are part of the scope of this document like the
    ++following:
    ++
    ++  - Implementing a "remote-object-info" command in the
    ++    `git cat-file --batch` protocol and its variants to allow main
    ++    remotes to respond to requests about large blobs without fetching
    ++    them. (Eric Ju has started working on this based on previous work
    ++    by Calvin Wan.)
    ++
    ++  - Creating better cleanup and offload mechanisms for main remotes
    ++    and clients to prevent accumulation of large blobs.
    ++
    ++  - Developing more sophisticated protocol negotiation capabilities
    ++    between clients and servers for handling LOPs, for example adding
    ++    a filter-spec (e.g., blob:limit=<size>) or size limit for
    ++    filtering when cloning, or adding a token for LOP authentication.
    ++
    ++  - Improving security measures for LOP access, particularly around
    ++    token handling and authentication.
    ++
    ++  - Developing standardized ways to configure and manage multiple LOPs
    ++    across different environments. Especially in the case where
    ++    different LOPs serve the same content to clients in different
    ++    geographical locations, there is a need for replication or
    ++    synchronization between LOPs.
    ++
    ++Some improvements, including some that have been mentioned in the "0)
    ++Non Goals" section of this document, are out of the scope of this
    ++document:
    ++
    ++  - Implementing a new object representation for large blobs on the
    ++    client side.
    ++
    ++  - Developing pluggable ODBs or other object database backends that
    ++    could chunk large blobs, dedup the chunks and store them
    ++    efficiently.
    ++
    ++  - Optimizing data transfer between LOPs and clients/servers,
    ++    particularly for incompressible and non-deltifying content.
    ++
    ++  - Creating improved client side tools for managing large objects
    ++    more effectively, for example tools for migrating from Git LFS or
    ++    git-annex, or tools to find which objects could be offloaded and
    ++    how much disk space could be reclaimed by offloading them.
    ++
    ++Some improvements could be seen as part of the scope of this document,
    ++but might already have their own separate projects from the Git
    ++project, like:
    ++
    ++  - Improving existing remote helpers to access object storage or
    ++    developing new ones.
    ++
    ++  - Improving existing object storage solutions or developing new
    ++    ones.
    ++
    ++Even though all the above improvements may help, this document and the
    ++LOP effort should try to focus, at least first, on a relatively small
    ++number of improvements mostly those that are in its current scope.
    ++
    ++For example introducing pluggable ODBs and a new object database
    ++backend is likely a multi-year effort on its own that can happen
    ++separately in parallel. It has different technical requirements,
    ++touches other part of the Git code base and should have its own design
    ++document(s).


Christian Couder (4):
  version: make redact_non_printables() non-static
  Add 'promisor-remote' capability to protocol v2
  promisor-remote: check advertised name or URL
  doc: add technical design doc for large object promisors

Usman Akinyemi (2):
  version: replace manual ASCII checks with isprint() for clarity
  version: refactor redact_non_printables()

 Documentation/config/promisor.txt             |  27 +
 Documentation/gitprotocol-v2.txt              |  54 ++
 .../technical/large-object-promisors.txt      | 640 ++++++++++++++++++
 connect.c                                     |   9 +
 promisor-remote.c                             | 244 +++++++
 promisor-remote.h                             |  36 +-
 serve.c                                       |  26 +
 t/meson.build                                 |   1 +
 t/t5710-promisor-remote-capability.sh         | 312 +++++++++
 upload-pack.c                                 |   3 +
 version.c                                     |  18 +-
 version.h                                     |   8 +
 12 files changed, 1371 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/technical/large-object-promisors.txt
 create mode 100755 t/t5710-promisor-remote-capability.sh

-- 
2.46.0.rc0.95.gcbf174a634

