Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66EB198A30
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 20:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729803283; cv=none; b=eX+A8zJRr4pzZiOIwTZqGhUCphd0DsjWrCvDYDIK6j/7wekvsgoufvquAFXTm54ARdJwio7kaRAi9zeGsftkAXp1PRzGrTdDoEkcrte0xOi6O8KUjquqBxKllvVdS+z/39ufImlUbL9Th5UFyH/z3bAYfSGhqEAwVyTz686cFi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729803283; c=relaxed/simple;
	bh=m6AWigdYB2/NivlOR61jUCsbN/kKwIbv2nysWlOJyGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCaozI3Rwb1I9ushr4PbjwZVvyHRpF509bOMoP8bv6x0r7m+wM+6Jy2kvawPhrgBn00xOYwTv41s8VFIwzC626+/oFBvRzaE9tOrvuZntVIQLuRw1OHyXHybssiIt+fYHOOyb1pYeSpRe9OFPQdGiNl/c7YukKikY+5Au51/UNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/VrwR1s; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/VrwR1s"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cbd57cc35bso20696406d6.1
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 13:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729803279; x=1730408079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ogiwn92Xzf3gN8j4ImvmiacIq0jp5LsHaL+HdCT06xY=;
        b=h/VrwR1sblwVWAus09aLFls9qIViif7aZdvaelddu6oxGD1zKr+h5uPY1pNon9R2BX
         hqC5UDXZMJkUe9D6ZpTCJ8JeyT3FDz5Ek/uLbqDmY048bqzn4vA21JTdXRyi3LNuZ4Bb
         yKXbxpX40MSiX5xUJHoqLZjFxZEMdUTBgMGy/6/q32NK84vSBaTKeZPTO42KhFlr4RC6
         HF2JntSHA90913Ss4HvhuVF60K39zCnB+nzDlo4WUU37D3tsoU5K/aHKamQgAmiuxoc9
         7yBF2EYXkcaieMgb6rb76MoVYlLPA4C07Ekbwk3WO85tJ+rBf8e1WpZl09dlSyq07qx5
         7xSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729803279; x=1730408079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ogiwn92Xzf3gN8j4ImvmiacIq0jp5LsHaL+HdCT06xY=;
        b=FiR90SGeouSxgSrTyKyW+kAAOMLj6pm7p5A8p/oneATZpEdIB9rW8z/A10NLL6eTYJ
         h+fKOcdaz8M7ikw8TyGAKUfAlPk0A/5VI5duMleOWJ/A06kpB5peID+ASGV0z3k2jReh
         iTtcuoUZIMoS3SRFYssKwNVuAlPkwEFRTFfJw/j0b0qmZBlTyq8gkrnEJaKByz1edX11
         Y96yBzdQem562EIZ6JbdD6hqEHDJW+kNr7Z4ffmhN+wTPXhZJvHVLBRMitxDtPal0dsW
         vHeeZowMW8J9epvE/w6sF8HLOhSxIXxWut/X5suFpB4AkLi89dItBgl7KBep94dycNCF
         4q8g==
X-Gm-Message-State: AOJu0YwLWhl4n5KVMzjzjyMLG0nsK6zLi7Xt/kUyCSPoiwmrqHHYrbLq
	2nqa01ssNOkqfyrn2UU+DlYckfe1AlvuuftFZnLg1PBnldSYKaNH6g6OGnEH
X-Google-Smtp-Source: AGHT+IFMf0KPPffM372BvdggdFfR4ZGKCjZUV7Tt4QQWLNIgSR1xXXj2lEJd2uTYkCMbNYE5/QBilg==
X-Received: by 2002:a05:6214:588b:b0:6cb:81ba:8ac1 with SMTP id 6a1803df08f44-6d064fa09f5mr65160676d6.0.1729803277301;
        Thu, 24 Oct 2024 13:54:37 -0700 (PDT)
Received: from PeijianitLabMBP.home ([184.147.230.152])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008b951esm53421556d6.22.2024.10.24.13.54.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Oct 2024 13:54:37 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v4 0/6] cat-file: add remote-object-info to batch-command
Date: Thu, 24 Oct 2024 16:53:53 -0400
Message-ID: <20241024205359.16376-1-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20240628190503.67389-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a continuation of Calvin Wan's (calvinwan@google.com)
patch series [PATCH v5 0/6] cat-file: add --batch-command remote-object-info command at [1].

Sometimes it is useful to get information about an object without having to download
it completely. The server logic for retrieving size has already been implemented and merged in
"a2ba162cda (object-info: support for retrieving object info, 2021-04-20)"[2].
This patch series implement the client option for it.

This patch series add the `remote-object-info` command to `cat-file --batch-command`.
This command allows the client to make an object-info command request to a server
that supports protocol v2. If the server is v2, but does not have
object-info capability, the entire object is fetched and the
relevant object info is returned.

A few questions open for discussions please:

1. In the current implementation, if a user puts `remote-object-info` in protocol v1,
   `cat-file --batch-command` will die. Which way do we prefer? "error and exit (i.e. die)"
   or "warn and wait for new command".

2. Right now, only the size is supported. If the batch command format
   contains objectsize:disk or deltabase, it will die. The question
   is about objecttype. In the current implementation, it will die too.
   But dying on objecttype breaks the default format. We have changed the
   default format to %(objectname) %(objectsize) when remote-object-info is used.
   Any suggestions on this approach?

[1] https://lore.kernel.org/git/20220728230210.2952731-1-calvinwan@google.com/#t
[2] https://git.kernel.org/pub/scm/git/git.git/commit/?id=a2ba162cda2acc171c3e36acbbc854792b093cb7

V1 of the patch series can be found here:
https://lore.kernel.org/git/20240628190503.67389-1-eric.peijian@gmail.com/

v2 of the patch series can be found here:
https://lore.kernel.org/git/20240720034337.57125-1-eric.peijian@gmail.com/

Changes since V3
================

- Fix typos and formatting errors

- Add warning in the git-cat-file doc about the default format

- Add a new test lib file, lib-cat-file.sh. And put the shared code of
t1017-cat-file-remote-object-info.sh and  t1006-cat-file.sh in it.

Thank you.

Eric Ju

Calvin Wan (5):
  fetch-pack: refactor packet writing
  fetch-pack: move fetch initialization
  serve: advertise object-info feature
  transport: add client support for object-info
  cat-file: add remote-object-info to batch-command

Eric Ju (1):
  cat-file: add declaration of variable i inside its for loop

 Documentation/git-cat-file.txt         |  24 +-
 builtin/cat-file.c                     | 119 +++-
 fetch-pack.c                           |  49 +-
 fetch-pack.h                           |  10 +
 object-file.c                          |  11 +
 object-store-ll.h                      |   3 +
 serve.c                                |   4 +-
 t/lib-cat-file.sh                      |  16 +
 t/t1006-cat-file.sh                    |  13 +-
 t/t1017-cat-file-remote-object-info.sh | 739 +++++++++++++++++++++++++
 transport-helper.c                     |  11 +-
 transport.c                            | 115 +++-
 transport.h                            |  11 +
 13 files changed, 1081 insertions(+), 44 deletions(-)
 create mode 100644 t/lib-cat-file.sh
 create mode 100755 t/t1017-cat-file-remote-object-info.sh

Range-diff against v3:
1:  b570dee186 = 1:  41898fe23e fetch-pack: refactor packet writing
2:  e8777e8776 = 2:  b3a1bee551 fetch-pack: move fetch initialization
3:  d00d19cf2c = 3:  d363b0f768 serve: advertise object-info feature
4:  3e1773910c ! 4:  3118061b21 transport: add client support for object-info
    @@ transport-helper.c: static int fetch_refs(struct transport *transport,
      	 */
      	if (data->transport_options.acked_commits) {
      		warning(_("--negotiate-only requires protocol v2"));
    - 		return -1;
    +@@ transport-helper.c: static int fetch_refs(struct transport *transport,
    + 		free_refs(dummy);
      	}
      
     +	/* fail the command explicitly to avoid further commands input. */
     +	if (transport->smart_options->object_info)
     +		die(_("remote-object-info requires protocol v2"));
     +
    - 	if (!data->get_refs_list_called)
    - 		get_refs_list_using_list(transport, 0);
    - 
    ++	if (!data->get_refs_list_called)
    ++		get_refs_list_using_list(transport, 0);
    ++
    + 	count = 0;
    + 	for (i = 0; i < nr_heads; i++)
    + 		if (!(to_fetch[i]->status & REF_STATUS_UPTODATE))
     
      ## transport.c ##
     @@ transport.c: static struct ref *handshake(struct transport *transport, int for_push,
    @@ transport.c: static struct ref *handshake(struct transport *transport, int for_p
     @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
      	struct ref *refs = NULL;
      	struct fetch_pack_args args;
    - 	struct ref *refs_tmp = NULL;
    + 	struct ref *refs_tmp = NULL, **to_fetch_dup = NULL;
     +	struct ref *object_info_refs = NULL;
      
      	memset(&args, 0, sizeof(args));
    @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
     +			ref_itr->exact_oid = 1;
     +			if (i == transport->smart_options->object_info_oids->nr - 1)
     +				/* last element, no need to allocate to next */
    -+				ref_itr -> next = NULL;
    ++				ref_itr->next = NULL;
     +			else
     +				ref_itr->next = alloc_ref("");
      
    @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
      	close(data->fd[0]);
      	if (data->fd[1] >= 0)
      		close(data->fd[1]);
    - 	if (finish_connect(data->conn))
    - 		ret = -1;
    - 	data->conn = NULL;
    --
    - 	free_refs(refs_tmp);
    - 	free_refs(refs);
    - 	list_objects_filter_release(&args.filter_options);
     
      ## transport.h ##
     @@
5:  bb110fbc93 = 5:  2ae81acf2a cat-file: add declaration of variable i inside its for loop
6:  6dd143c164 ! 6:  b5aa6c1888 cat-file: add remote-object-info to batch-command
    @@ Commit message
                 - Get object info, print object info
     
         To summarize, `remote-object-info` gets object info from the remote and
    -    then loop through the object info passed in, print the info.
    +    then loop through the object info passed in, printing the info.
     
         In order for remote-object-info to avoid remote communication overhead
         in the non-buffer mode, the objects are passed in as such:
    @@ Documentation/git-cat-file.txt: newline. The available atoms are:
     -%(objecttype) %(objectsize)`.
     +%(objecttype) %(objectsize)`, except for `remote-object-info` commands which use
     +`%(objectname) %(objectsize)` for now because "%(objecttype)" is not supported yet.
    -+When "%(objecttype)" is supported, default format should be unified.
    ++WARNING: When "%(objecttype)" is supported, the default format WILL be unified, so
    ++DO NOT RELY on the current the default format to stay the same!!!
      
      If `--batch` is specified, or if `--batch-command` is used with the `contents`
      command, the object information is followed by the object contents (consisting
    @@ Documentation/git-cat-file.txt: scripting purposes.
      CAVEATS
      -------
      
    -+Note that since %(objecttype), %(objectsize:disk) and %(deltabase) are currently not supported by the
    -+`remote-object-info` command, we will error and exit when they are in the format string.
    ++Note that since %(objecttype), %(objectsize:disk) and %(deltabase) are
    ++currently not supported by the `remote-object-info` command, we will error
    ++and exit when they are in the format string.
     +
      Note that the sizes of objects on disk are reported accurately, but care
      should be taken in drawing conclusions about which refs or objects are
    @@ object-store-ll.h: int for_each_object_in_pack(struct packed_git *p,
     +
      #endif /* OBJECT_STORE_LL_H */
     
    - ## t/t1017-cat-file-remote-object-info.sh (new) ##
    + ## t/lib-cat-file.sh (new) ##
     @@
    -+#!/bin/sh
    -+
    -+test_description='git cat-file --batch-command with remote-object-info command'
    -+
    -+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    -+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    -+
    -+. ./test-lib.sh
    ++# Library of git-cat-file related functions.
     +
    ++# Print a string without a trailing newline
     +echo_without_newline () {
    -+    printf '%s' "$*"
    ++	printf '%s' "$*"
     +}
     +
    ++# Print a string without newlines and replaces them with a NULL character (\0).
     +echo_without_newline_nul () {
    -+    echo_without_newline "$@" | tr '\n' '\0'
    ++	echo_without_newline "$@" | tr '\n' '\0'
     +}
     +
    ++# Calculate the length of a string removing any leading spaces.
     +strlen () {
    -+    echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
    ++	echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
     +}
    +
    + ## t/t1006-cat-file.sh ##
    +@@ t/t1006-cat-file.sh: test_description='git cat-file'
    + 
    + TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    ++. "$TEST_DIRECTORY"/lib-cat-file.sh
    + 
    + test_cmdmode_usage () {
    + 	test_expect_code 129 "$@" 2>err &&
    +@@ t/t1006-cat-file.sh: do
    + 	'
    + done
    + 
    +-echo_without_newline () {
    +-    printf '%s' "$*"
    +-}
    +-
    +-echo_without_newline_nul () {
    +-	echo_without_newline "$@" | tr '\n' '\0'
    +-}
    +-
    +-strlen () {
    +-    echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
    +-}
    +-
    + run_tests () {
    +     type=$1
    +     oid=$2
    +
    + ## t/t1017-cat-file-remote-object-info.sh (new) ##
    +@@
    ++#!/bin/sh
    ++
    ++test_description='git cat-file --batch-command with remote-object-info command'
    ++
    ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    ++export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    ++
    ++. ./test-lib.sh
    ++. "$TEST_DIRECTORY"/lib-cat-file.sh
     +
     +hello_content="Hello World"
     +hello_size=$(strlen "$hello_content")
-- 
2.47.0

