Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 707611F597
	for <e@80x24.org>; Wed, 25 Jul 2018 08:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbeGYJlj (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 05:41:39 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:41226 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbeGYJlj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 05:41:39 -0400
Received: by mail-wr1-f41.google.com with SMTP id j5-v6so6512873wrr.8
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 01:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=B/pw+RQaucT0F11hFXs0WQDspz8PH2DRBdpRQq3dqx0=;
        b=BGGOfJhybD09dAwDAE87W3cxg1Vn955G3e6iXwKUA1wsp27CICZHUTpzYDYvIA5/oI
         /7O2kGE5VdLaGhDwNw6TeAoHqDYS30VPE56wz9UR2gQWiVMZUzNaIpG7QGcDi0DcZ3sa
         JLjytZJo0FR3oC9tdu1lmTqB55Foa9X8IU5N950aghYwvE+zOQb+4xNSrJ4uH0bUATLl
         N3fbru0RjSrH6vf67QuhI5f8vvIKUH2uyxbB4mdJdxdBdL+3MgJZD7IxxaO9/OS8tunp
         5nllyfK4xbv96fh+J6KcDx/W4h/WykdkOwKQyoDR/b9cujeRo1Mc+6wbbpmFbB8KoJUN
         MttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=B/pw+RQaucT0F11hFXs0WQDspz8PH2DRBdpRQq3dqx0=;
        b=IoDYqPIKRsBAe6cuxBa/ZO4hSI0hbcJgaMtQ+VfWQeMfbSsHsDHzHePrP1SFOBswlH
         PgPLELi205gkmAq32mxPgxLxHN5qBeDiXUZ4yQVWfczXm8YyyUtSqURRlsMvo0HwUsax
         T/6TUiqplNV5PbJTIXRokx84PMejMv4P0T5VD0OIncjZnzrH/2hzKxwfinifKu4V3ELI
         DHipXj5AMGw0jdpMxm7+ciQLqM4xRZLVLS42syvvipTh2tFff4POC5rcp+H/fNX38aXy
         gAZMuPo2EsMpa503CptpuB8v6P8O4GtRyH3EFSL6XmuuR5qdjwI9ddcU/NFC3U9SOEV/
         xYZQ==
X-Gm-Message-State: AOUpUlFRAVKwYRDcmhfqOh2Z0HenoLA6jan3l7NjvMz6V3X57Lx0qF+7
        igYo6F85qVhZLZ1r+UXlOpuqNteSKfg=
X-Google-Smtp-Source: AAOMgpcN0YdwcWJjUeEhx7Aso4RQM/v2+lL08Stw7w2tfOdgtlBY+u/Dy/GYYegjInN2xsw5oC6qcg==
X-Received: by 2002:adf:ecc6:: with SMTP id s6-v6mr14419219wro.160.1532507459031;
        Wed, 25 Jul 2018 01:30:59 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v1-v6sm35836323wrs.34.2018.07.25.01.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 01:30:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>,
        keccak@noekeon.org,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] doc hash-function-transition: pick SHA-256 as NewHash
Date:   Wed, 25 Jul 2018 08:30:24 +0000
Message-Id: <20180725083024.16131-3-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180725083024.16131-1-avarab@gmail.com>
References: <20180725083024.16131-1-avarab@gmail.com>
In-Reply-To: <xmqqzhygwd5o.fsf@gitster-ct.c.googlers.com>
References: <xmqqzhygwd5o.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The consensus on the mailing list seems to be that SHA-256 should be
picked as our NewHash, see the "Hash algorithm analysis" thread as of
[1]. Linus has come around to this choice and suggested Junio make the
final pick, and he's endorsed SHA-256 [3].

This follow-up change changes occurrences of "NewHash" to
"SHA-256" (or "sha256", depending on the context). The "Selection of a
New Hash" section has also been changed to note that historically we
used the the "NewHash" name while we didn't know what the new hash
function would be.

This leaves no use of "NewHash" anywhere in git.git except in the
aforementioned section (and as a variable name in t/t9700/test.pl, but
that use from 2008 has nothing to do with this transition plan).

1. https://public-inbox.org/git/20180720215220.GB18502@genre.crustytoothpaste.net/
2. https://public-inbox.org/git/CA+55aFwSe9BF8e0hLk9pp3FVD5LaVY5GRdsV3fbNtgzekJadyA@mail.gmail.com/
3. https://public-inbox.org/git/xmqqzhygwd5o.fsf@gitster-ct.c.googlers.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .../technical/hash-function-transition.txt    | 186 +++++++++---------
 1 file changed, 96 insertions(+), 90 deletions(-)

diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index 5ee4754adb..8fb2d4b498 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -59,14 +59,11 @@ that are believed to be cryptographically secure.
 
 Goals
 -----
-Where NewHash is a strong 256-bit hash function to replace SHA-1 (see
-"Selection of a New Hash", below):
-
-1. The transition to NewHash can be done one local repository at a time.
+1. The transition to SHA-256 can be done one local repository at a time.
    a. Requiring no action by any other party.
-   b. A NewHash repository can communicate with SHA-1 Git servers
+   b. A SHA-256 repository can communicate with SHA-1 Git servers
       (push/fetch).
-   c. Users can use SHA-1 and NewHash identifiers for objects
+   c. Users can use SHA-1 and SHA-256 identifiers for objects
       interchangeably (see "Object names on the command line", below).
    d. New signed objects make use of a stronger hash function than
       SHA-1 for their security guarantees.
@@ -79,7 +76,7 @@ Where NewHash is a strong 256-bit hash function to replace SHA-1 (see
 
 Non-Goals
 ---------
-1. Add NewHash support to Git protocol. This is valuable and the
+1. Add SHA-256 support to Git protocol. This is valuable and the
    logical next step but it is out of scope for this initial design.
 2. Transparently improving the security of existing SHA-1 signed
    objects.
@@ -87,26 +84,26 @@ Non-Goals
    repository.
 4. Taking the opportunity to fix other bugs in Git's formats and
    protocols.
-5. Shallow clones and fetches into a NewHash repository. (This will
-   change when we add NewHash support to Git protocol.)
-6. Skip fetching some submodules of a project into a NewHash
-   repository. (This also depends on NewHash support in Git
+5. Shallow clones and fetches into a SHA-256 repository. (This will
+   change when we add SHA-256 support to Git protocol.)
+6. Skip fetching some submodules of a project into a SHA-256
+   repository. (This also depends on SHA-256 support in Git
    protocol.)
 
 Overview
 --------
 We introduce a new repository format extension. Repositories with this
-extension enabled use NewHash instead of SHA-1 to name their objects.
+extension enabled use SHA-256 instead of SHA-1 to name their objects.
 This affects both object names and object content --- both the names
 of objects and all references to other objects within an object are
 switched to the new hash function.
 
-NewHash repositories cannot be read by older versions of Git.
+SHA-256 repositories cannot be read by older versions of Git.
 
-Alongside the packfile, a NewHash repository stores a bidirectional
-mapping between NewHash and SHA-1 object names. The mapping is generated
+Alongside the packfile, a SHA-256 repository stores a bidirectional
+mapping between SHA-256 and SHA-1 object names. The mapping is generated
 locally and can be verified using "git fsck". Object lookups use this
-mapping to allow naming objects using either their SHA-1 and NewHash names
+mapping to allow naming objects using either their SHA-1 and SHA-256 names
 interchangeably.
 
 "git cat-file" and "git hash-object" gain options to display an object
@@ -116,7 +113,7 @@ object database so that they can be named using the appropriate name
 (using the bidirectional hash mapping).
 
 Fetches from a SHA-1 based server convert the fetched objects into
-NewHash form and record the mapping in the bidirectional mapping table
+SHA-256 form and record the mapping in the bidirectional mapping table
 (see below for details). Pushes to a SHA-1 based server convert the
 objects being pushed into sha1 form so the server does not have to be
 aware of the hash function the client is using.
@@ -125,19 +122,19 @@ Detailed Design
 ---------------
 Repository format extension
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
-A NewHash repository uses repository format version `1` (see
+A SHA-256 repository uses repository format version `1` (see
 Documentation/technical/repository-version.txt) with extensions
 `objectFormat` and `compatObjectFormat`:
 
 	[core]
 		repositoryFormatVersion = 1
 	[extensions]
-		objectFormat = newhash
+		objectFormat = sha256
 		compatObjectFormat = sha1
 
 The combination of setting `core.repositoryFormatVersion=1` and
 populating `extensions.*` ensures that all versions of Git later than
-`v0.99.9l` will die instead of trying to operate on the NewHash
+`v0.99.9l` will die instead of trying to operate on the SHA-256
 repository, instead producing an error message.
 
 	# Between v0.99.9l and v2.7.0
@@ -155,36 +152,36 @@ repository extensions.
 Object names
 ~~~~~~~~~~~~
 Objects can be named by their 40 hexadecimal digit sha1-name or 64
-hexadecimal digit newhash-name, plus names derived from those (see
+hexadecimal digit sha256-name, plus names derived from those (see
 gitrevisions(7)).
 
 The sha1-name of an object is the SHA-1 of the concatenation of its
 type, length, a nul byte, and the object's sha1-content. This is the
 traditional <sha1> used in Git to name objects.
 
-The newhash-name of an object is the NewHash of the concatenation of its
-type, length, a nul byte, and the object's newhash-content.
+The sha256-name of an object is the SHA-256 of the concatenation of its
+type, length, a nul byte, and the object's sha256-content.
 
 Object format
 ~~~~~~~~~~~~~
 The content as a byte sequence of a tag, commit, or tree object named
-by sha1 and newhash differ because an object named by newhash-name refers to
-other objects by their newhash-names and an object named by sha1-name
+by sha1 and sha256 differ because an object named by sha256-name refers to
+other objects by their sha256-names and an object named by sha1-name
 refers to other objects by their sha1-names.
 
-The newhash-content of an object is the same as its sha1-content, except
-that objects referenced by the object are named using their newhash-names
+The sha256-content of an object is the same as its sha1-content, except
+that objects referenced by the object are named using their sha256-names
 instead of sha1-names. Because a blob object does not refer to any
-other object, its sha1-content and newhash-content are the same.
+other object, its sha1-content and sha256-content are the same.
 
-The format allows round-trip conversion between newhash-content and
+The format allows round-trip conversion between sha256-content and
 sha1-content.
 
 Object storage
 ~~~~~~~~~~~~~~
 Loose objects use zlib compression and packed objects use the packed
 format described in Documentation/technical/pack-format.txt, just like
-today. The content that is compressed and stored uses newhash-content
+today. The content that is compressed and stored uses sha256-content
 instead of sha1-content.
 
 Pack index
@@ -255,10 +252,10 @@ network byte order):
   up to and not including the table of CRC32 values.
 - Zero or more NUL bytes.
 - The trailer consists of the following:
-  - A copy of the 20-byte NewHash checksum at the end of the
+  - A copy of the 20-byte SHA-256 checksum at the end of the
     corresponding packfile.
 
-  - 20-byte NewHash checksum of all of the above.
+  - 20-byte SHA-256 checksum of all of the above.
 
 Loose object index
 ~~~~~~~~~~~~~~~~~~
@@ -266,7 +263,7 @@ A new file $GIT_OBJECT_DIR/loose-object-idx contains information about
 all loose objects. Its format is
 
   # loose-object-idx
-  (newhash-name SP sha1-name LF)*
+  (sha256-name SP sha1-name LF)*
 
 where the object names are in hexadecimal format. The file is not
 sorted.
@@ -292,8 +289,8 @@ To remove entries (e.g. in "git pack-refs" or "git-prune"):
 Translation table
 ~~~~~~~~~~~~~~~~~
 The index files support a bidirectional mapping between sha1-names
-and newhash-names. The lookup proceeds similarly to ordinary object
-lookups. For example, to convert a sha1-name to a newhash-name:
+and sha256-names. The lookup proceeds similarly to ordinary object
+lookups. For example, to convert a sha1-name to a sha256-name:
 
  1. Look for the object in idx files. If a match is present in the
     idx's sorted list of truncated sha1-names, then:
@@ -301,8 +298,8 @@ lookups. For example, to convert a sha1-name to a newhash-name:
        name order mapping.
     b. Read the corresponding entry in the full sha1-name table to
        verify we found the right object. If it is, then
-    c. Read the corresponding entry in the full newhash-name table.
-       That is the object's newhash-name.
+    c. Read the corresponding entry in the full sha256-name table.
+       That is the object's sha256-name.
  2. Check for a loose object. Read lines from loose-object-idx until
     we find a match.
 
@@ -318,25 +315,25 @@ for all objects in the object store.
 
 Reading an object's sha1-content
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-The sha1-content of an object can be read by converting all newhash-names
-its newhash-content references to sha1-names using the translation table.
+The sha1-content of an object can be read by converting all sha256-names
+its sha256-content references to sha1-names using the translation table.
 
 Fetch
 ~~~~~
 Fetching from a SHA-1 based server requires translating between SHA-1
-and NewHash based representations on the fly.
+and SHA-256 based representations on the fly.
 
 SHA-1s named in the ref advertisement that are present on the client
-can be translated to NewHash and looked up as local objects using the
+can be translated to SHA-256 and looked up as local objects using the
 translation table.
 
 Negotiation proceeds as today. Any "have"s generated locally are
 converted to SHA-1 before being sent to the server, and SHA-1s
-mentioned by the server are converted to NewHash when looking them up
+mentioned by the server are converted to SHA-256 when looking them up
 locally.
 
 After negotiation, the server sends a packfile containing the
-requested objects. We convert the packfile to NewHash format using
+requested objects. We convert the packfile to SHA-256 format using
 the following steps:
 
 1. index-pack: inflate each object in the packfile and compute its
@@ -351,12 +348,12 @@ the following steps:
    (This list only contains objects reachable from the "wants". If the
    pack from the server contained additional extraneous objects, then
    they will be discarded.)
-3. convert to newhash: open a new (newhash) packfile. Read the topologically
+3. convert to sha256: open a new (sha256) packfile. Read the topologically
    sorted list just generated. For each object, inflate its
-   sha1-content, convert to newhash-content, and write it to the newhash
-   pack. Record the new sha1<->newhash mapping entry for use in the idx.
+   sha1-content, convert to sha256-content, and write it to the sha256
+   pack. Record the new sha1<->sha256 mapping entry for use in the idx.
 4. sort: reorder entries in the new pack to match the order of objects
-   in the pack the server generated and include blobs. Write a newhash idx
+   in the pack the server generated and include blobs. Write a sha256 idx
    file
 5. clean up: remove the SHA-1 based pack file, index, and
    topologically sorted list obtained from the server in steps 1
@@ -388,16 +385,16 @@ send-pack.
 
 Signed Commits
 ~~~~~~~~~~~~~~
-We add a new field "gpgsig-newhash" to the commit object format to allow
+We add a new field "gpgsig-sha256" to the commit object format to allow
 signing commits without relying on SHA-1. It is similar to the
-existing "gpgsig" field. Its signed payload is the newhash-content of the
-commit object with any "gpgsig" and "gpgsig-newhash" fields removed.
+existing "gpgsig" field. Its signed payload is the sha256-content of the
+commit object with any "gpgsig" and "gpgsig-sha256" fields removed.
 
 This means commits can be signed
 1. using SHA-1 only, as in existing signed commit objects
-2. using both SHA-1 and NewHash, by using both gpgsig-newhash and gpgsig
+2. using both SHA-1 and SHA-256, by using both gpgsig-sha256 and gpgsig
    fields.
-3. using only NewHash, by only using the gpgsig-newhash field.
+3. using only SHA-256, by only using the gpgsig-sha256 field.
 
 Old versions of "git verify-commit" can verify the gpgsig signature in
 cases (1) and (2) without modifications and view case (3) as an
@@ -405,24 +402,24 @@ ordinary unsigned commit.
 
 Signed Tags
 ~~~~~~~~~~~
-We add a new field "gpgsig-newhash" to the tag object format to allow
+We add a new field "gpgsig-sha256" to the tag object format to allow
 signing tags without relying on SHA-1. Its signed payload is the
-newhash-content of the tag with its gpgsig-newhash field and "-----BEGIN PGP
+sha256-content of the tag with its gpgsig-sha256 field and "-----BEGIN PGP
 SIGNATURE-----" delimited in-body signature removed.
 
 This means tags can be signed
 1. using SHA-1 only, as in existing signed tag objects
-2. using both SHA-1 and NewHash, by using gpgsig-newhash and an in-body
+2. using both SHA-1 and SHA-256, by using gpgsig-sha256 and an in-body
    signature.
-3. using only NewHash, by only using the gpgsig-newhash field.
+3. using only SHA-256, by only using the gpgsig-sha256 field.
 
 Mergetag embedding
 ~~~~~~~~~~~~~~~~~~
 The mergetag field in the sha1-content of a commit contains the
 sha1-content of a tag that was merged by that commit.
 
-The mergetag field in the newhash-content of the same commit contains the
-newhash-content of the same tag.
+The mergetag field in the sha256-content of the same commit contains the
+sha256-content of the same tag.
 
 Submodules
 ~~~~~~~~~~
@@ -497,7 +494,7 @@ Caveats
 -------
 Invalid objects
 ~~~~~~~~~~~~~~~
-The conversion from sha1-content to newhash-content retains any
+The conversion from sha1-content to sha256-content retains any
 brokenness in the original object (e.g., tree entry modes encoded with
 leading 0, tree objects whose paths are not sorted correctly, and
 commit objects without an author or committer). This is a deliberate
@@ -516,7 +513,7 @@ allow lifting this restriction.
 
 Alternates
 ~~~~~~~~~~
-For the same reason, a newhash repository cannot borrow objects from a
+For the same reason, a sha256 repository cannot borrow objects from a
 sha1 repository using objects/info/alternates or
 $GIT_ALTERNATE_OBJECT_REPOSITORIES.
 
@@ -524,20 +521,20 @@ git notes
 ~~~~~~~~~
 The "git notes" tool annotates objects using their sha1-name as key.
 This design does not describe a way to migrate notes trees to use
-newhash-names. That migration is expected to happen separately (for
+sha256-names. That migration is expected to happen separately (for
 example using a file at the root of the notes tree to describe which
 hash it uses).
 
 Server-side cost
 ~~~~~~~~~~~~~~~~
-Until Git protocol gains NewHash support, using NewHash based storage
+Until Git protocol gains SHA-256 support, using SHA-256 based storage
 on public-facing Git servers is strongly discouraged. Once Git
-protocol gains NewHash support, NewHash based servers are likely not
+protocol gains SHA-256 support, SHA-256 based servers are likely not
 to support SHA-1 compatibility, to avoid what may be a very expensive
 hash reencode during clone and to encourage peers to modernize.
 
 The design described here allows fetches by SHA-1 clients of a
-personal NewHash repository because it's not much more difficult than
+personal SHA-256 repository because it's not much more difficult than
 allowing pushes from that repository. This support needs to be guarded
 by a configuration option --- servers like git.kernel.org that serve a
 large number of clients would not be expected to bear that cost.
@@ -547,7 +544,7 @@ Meaning of signatures
 The signed payload for signed commits and tags does not explicitly
 name the hash used to identify objects. If some day Git adopts a new
 hash function with the same length as the current SHA-1 (40
-hexadecimal digit) or NewHash (64 hexadecimal digit) objects then the
+hexadecimal digit) or SHA-256 (64 hexadecimal digit) objects then the
 intent behind the PGP signed payload in an object signature is
 unclear:
 
@@ -562,7 +559,7 @@ Does this mean Git v2.12.0 is the commit with sha1-name
 e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7 or the commit with
 new-40-digit-hash-name e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7?
 
-Fortunately NewHash and SHA-1 have different lengths. If Git starts
+Fortunately SHA-256 and SHA-1 have different lengths. If Git starts
 using another hash with the same length to name objects, then it will
 need to change the format of signed payloads using that hash to
 address this issue.
@@ -574,24 +571,24 @@ supports four different modes of operation:
 
  1. ("dark launch") Treat object names input by the user as SHA-1 and
     convert any object names written to output to SHA-1, but store
-    objects using NewHash.  This allows users to test the code with no
+    objects using SHA-256.  This allows users to test the code with no
     visible behavior change except for performance.  This allows
     allows running even tests that assume the SHA-1 hash function, to
     sanity-check the behavior of the new mode.
 
- 2. ("early transition") Allow both SHA-1 and NewHash object names in
+ 2. ("early transition") Allow both SHA-1 and SHA-256 object names in
     input. Any object names written to output use SHA-1. This allows
     users to continue to make use of SHA-1 to communicate with peers
     (e.g. by email) that have not migrated yet and prepares for mode 3.
 
- 3. ("late transition") Allow both SHA-1 and NewHash object names in
-    input. Any object names written to output use NewHash. In this
+ 3. ("late transition") Allow both SHA-1 and SHA-256 object names in
+    input. Any object names written to output use SHA-256. In this
     mode, users are using a more secure object naming method by
     default.  The disruption is minimal as long as most of their peers
     are in mode 2 or mode 3.
 
  4. ("post-transition") Treat object names input by the user as
-    NewHash and write output using NewHash. This is safer than mode 3
+    SHA-256 and write output using SHA-256. This is safer than mode 3
     because there is less risk that input is incorrectly interpreted
     using the wrong hash function.
 
@@ -601,7 +598,7 @@ The user can also explicitly specify which format to use for a
 particular revision specifier and for output, overriding the mode. For
 example:
 
-git --output-format=sha1 log abac87a^{sha1}..f787cac^{newhash}
+git --output-format=sha1 log abac87a^{sha1}..f787cac^{sha256}
 
 Selection of a New Hash
 -----------------------
@@ -611,6 +608,10 @@ collisions in 2^69 operations. In August they published details.
 Luckily, no practical demonstrations of a collision in full SHA-1 were
 published until 10 years later, in 2017.
 
+It was decided that Git needed to transition to a new hash
+function. Initially no decision was made as to what function this was,
+the "NewHash" placeholder name was picked to describe it.
+
 The hash function NewHash to replace SHA-1 should be stronger than
 SHA-1 was: we would like it to be trustworthy and useful in practice
 for at least 10 years.
@@ -630,14 +631,19 @@ Some other relevant properties:
 4. As a tiebreaker, the hash should be fast to compute (fortunately
    many contenders are faster than SHA-1).
 
-Some hashes under consideration are SHA-256, SHA-512/256, SHA-256x16,
+Some hashes under consideration were SHA-256, SHA-512/256, SHA-256x16,
 K12, and BLAKE2bp-256.
 
+Eventually in July 2018 SHA-256 was chosen to be the NewHash. See the
+thread starting at <20180609224913.GC38834@genre.crustytoothpaste.net>
+for the discussion
+(https://public-inbox.org/git/20180609224913.GC38834@genre.crustytoothpaste.net/)
+
 Transition plan
 ---------------
 Some initial steps can be implemented independently of one another:
 - adding a hash function API (vtable)
-- teaching fsck to tolerate the gpgsig-newhash field
+- teaching fsck to tolerate the gpgsig-sha256 field
 - excluding gpgsig-* from the fields copied by "git commit --amend"
 - annotating tests that depend on SHA-1 values with a SHA1 test
   prerequisite
@@ -664,7 +670,7 @@ Next comes introduction of compatObjectFormat:
 - adding appropriate index entries when adding a new object to the
   object store
 - --output-format option
-- ^{sha1} and ^{newhash} revision notation
+- ^{sha1} and ^{sha256} revision notation
 - configuration to specify default input and output format (see
   "Object names on the command line" above)
 
@@ -672,7 +678,7 @@ The next step is supporting fetches and pushes to SHA-1 repositories:
 - allow pushes to a repository using the compat format
 - generate a topologically sorted list of the SHA-1 names of fetched
   objects
-- convert the fetched packfile to newhash format and generate an idx
+- convert the fetched packfile to sha256 format and generate an idx
   file
 - re-sort to match the order of objects in the fetched packfile
 
@@ -680,30 +686,30 @@ The infrastructure supporting fetch also allows converting an existing
 repository. In converted repositories and new clones, end users can
 gain support for the new hash function without any visible change in
 behavior (see "dark launch" in the "Object names on the command line"
-section). In particular this allows users to verify NewHash signatures
+section). In particular this allows users to verify SHA-256 signatures
 on objects in the repository, and it should ensure the transition code
 is stable in production in preparation for using it more widely.
 
 Over time projects would encourage their users to adopt the "early
 transition" and then "late transition" modes to take advantage of the
-new, more futureproof NewHash object names.
+new, more futureproof SHA-256 object names.
 
 When objectFormat and compatObjectFormat are both set, commands
-generating signatures would generate both SHA-1 and NewHash signatures
+generating signatures would generate both SHA-1 and SHA-256 signatures
 by default to support both new and old users.
 
-In projects using NewHash heavily, users could be encouraged to adopt
+In projects using SHA-256 heavily, users could be encouraged to adopt
 the "post-transition" mode to avoid accidentally making implicit use
 of SHA-1 object names.
 
 Once a critical mass of users have upgraded to a version of Git that
-can verify NewHash signatures and have converted their existing
+can verify SHA-256 signatures and have converted their existing
 repositories to support verifying them, we can add support for a
-setting to generate only NewHash signatures. This is expected to be at
+setting to generate only SHA-256 signatures. This is expected to be at
 least a year later.
 
 That is also a good moment to advertise the ability to convert
-repositories to use NewHash only, stripping out all SHA-1 related
+repositories to use SHA-256 only, stripping out all SHA-1 related
 metadata. This improves performance by eliminating translation
 overhead and security by avoiding the possibility of accidentally
 relying on the safety of SHA-1.
@@ -742,16 +748,16 @@ using the old hash function.
 
 Signed objects with multiple hashes
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-Instead of introducing the gpgsig-newhash field in commit and tag objects
-for newhash-content based signatures, an earlier version of this design
-added "hash newhash <newhash-name>" fields to strengthen the existing
+Instead of introducing the gpgsig-sha256 field in commit and tag objects
+for sha256-content based signatures, an earlier version of this design
+added "hash sha256 <sha256-name>" fields to strengthen the existing
 sha1-content based signatures.
 
 In other words, a single signature was used to attest to the object
 content using both hash functions. This had some advantages:
 * Using one signature instead of two speeds up the signing process.
 * Having one signed payload with both hashes allows the signer to
-  attest to the sha1-name and newhash-name referring to the same object.
+  attest to the sha1-name and sha256-name referring to the same object.
 * All users consume the same signature. Broken signatures are likely
   to be detected quickly using current versions of git.
 
@@ -760,11 +766,11 @@ However, it also came with disadvantages:
   objects it references, even after the transition is complete and
   translation table is no longer needed for anything else. To support
   this, the design added fields such as "hash sha1 tree <sha1-name>"
-  and "hash sha1 parent <sha1-name>" to the newhash-content of a signed
+  and "hash sha1 parent <sha1-name>" to the sha256-content of a signed
   commit, complicating the conversion process.
 * Allowing signed objects without a sha1 (for after the transition is
   complete) complicated the design further, requiring a "nohash sha1"
-  field to suppress including "hash sha1" fields in the newhash-content
+  field to suppress including "hash sha1" fields in the sha256-content
   and signed payload.
 
 Lazily populated translation table
@@ -772,7 +778,7 @@ Lazily populated translation table
 Some of the work of building the translation table could be deferred to
 push time, but that would significantly complicate and slow down pushes.
 Calculating the sha1-name at object creation time at the same time it is
-being streamed to disk and having its newhash-name calculated should be
+being streamed to disk and having its sha256-name calculated should be
 an acceptable cost.
 
 Document History
-- 
2.17.0.290.gded63e768a

