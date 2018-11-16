Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA4DD1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 22:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeKQIs4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 03:48:56 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:52603 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeKQIs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 03:48:56 -0500
Received: by mail-qk1-f202.google.com with SMTP id 92so54826067qkx.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 14:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zHEwdCsRW183KUrpDl+a/y2/o+8luNOjBTSC/m8MbtY=;
        b=GdHSKQz4atk+JPT111FhO9iffvhHZs7aFp/IL8PZNoCcCxLOdKCyuiIJFdoPxiGUaq
         TscpBq/agHw1aSigVvAqDZkoyS1gjszCg42eddnBTetPlf81l2m0NolvJZWV3yok1Z+J
         SkD4u9n/0XBtZMTmCROHQa6FpFRmR1v5zmZ1kVYwsgjXMX0KKcegc1i9uhvGUAVIT6bd
         xmp/nQ4u/TYrt+QDW/VabBdhs+8B+2KOnZSOc1TQGO4f4HjNJvXw9munPFy/R656ydVr
         KrBYd22CeL93P/92IaXtxoMnia48Nstdc55bAd8jA+sKzzCr9BJy04mygTsITZh9+xrX
         wtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zHEwdCsRW183KUrpDl+a/y2/o+8luNOjBTSC/m8MbtY=;
        b=swxW07QTUL3R5RX8vtmAxdzXZ+mQGG/6r8qZE3nYzpms+5UL71+ZxSf3bdl85K5dep
         Zi75k4Q5PUEVBFzLIkTRxeele8nU4/zJ3WLNTxI3jrma7/USrl2WWJQbddZdGUYfAdpa
         9JtybjxKZsDoVzw5lq1ZhTetEy58/WSG7ZJGmYXsdJf97N/1rB0vdHKrWcTDNV/scUHx
         3ZaaWPxfxt/qoGVuGaoHfK8U18irQdR0A8MVBRYZmLZMKlxEEyGOnAewhMjAHpEcCL3k
         knCKeZzGsixvIETvTH3aToyyR7beCddCZOKCJpgHSUgKhzrw5WAo957Mspk7Eb147wzp
         sFnw==
X-Gm-Message-State: AGRZ1gLGBp7YBl1b4VFVoAWazPX0/BBZslCsOBS7f6ExYGgo8MiyLwYd
        GGZ8UqTuh1P1UEshji9PV4LqItzsJLXvbwlgOn1HFlBCGnwttG6/ctE7cgO1FqwkNAw2wELBRJw
        hprHAdHumrL0zU6RoxfwSRr3ZBt765WM9F28EgE0RYdwrxH1+6s3/iWmfBEbpH4M=
X-Google-Smtp-Source: AFSGD/XmFZgut5uGuiSLBMSEtRM2WaP32HdwASMnwFPimdozG3k1xSGA+eLLDmuyVaT/ixRd8/627IRVT6/p9Q==
X-Received: by 2002:ac8:1b55:: with SMTP id p21mr4730383qtk.16.1542407681395;
 Fri, 16 Nov 2018 14:34:41 -0800 (PST)
Date:   Fri, 16 Nov 2018 14:34:37 -0800
In-Reply-To: <cover.1542162201.git.steadmon@google.com>
Message-Id: <cover.1542407348.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1542162201.git.steadmon@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH v5 0/1] Advertise multiple supported proto versions
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, jonathantanmy@google.com,
        szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from V4: remove special cases around advertising version=0.

Add a registry of supported wire protocol versions that individual
commands can use to declare supported versions before contacting a
server. The client will then advertise all supported versions, while the
server will choose the first allowed version from the advertised
list.

Every command that acts as a client or server must now register its
supported protocol versions.


Josh Steadmon (1):
  protocol: advertise multiple supported versions

 builtin/archive.c           |   3 +
 builtin/clone.c             |   4 ++
 builtin/fetch-pack.c        |   4 ++
 builtin/fetch.c             |   5 ++
 builtin/ls-remote.c         |   5 ++
 builtin/pull.c              |   5 ++
 builtin/push.c              |   4 ++
 builtin/receive-pack.c      |   3 +
 builtin/send-pack.c         |   3 +
 builtin/upload-archive.c    |   3 +
 builtin/upload-pack.c       |   4 ++
 connect.c                   |  52 +++++++--------
 protocol.c                  | 122 +++++++++++++++++++++++++++++++++---
 protocol.h                  |  23 ++++++-
 remote-curl.c               |  27 +++++---
 t/t5551-http-fetch-smart.sh |   1 +
 t/t5570-git-daemon.sh       |   2 +-
 t/t5601-clone.sh            |  38 +++++------
 t/t5700-protocol-v1.sh      |   8 +--
 t/t5702-protocol-v2.sh      |  16 +++--
 transport-helper.c          |   6 ++
 21 files changed, 256 insertions(+), 82 deletions(-)

Range-diff against v4:
1:  3c023991c0 ! 1:  60f6f2fbd8 protocol: advertise multiple supported versions
    @@ -21,6 +21,12 @@
         Clients now advertise the full list of registered versions. Servers
         select the first allowed version from this advertisement.
     
    +    Additionally, remove special cases around advertising version=0.
    +    Previously we avoided adding version negotiation fields in server
    +    responses if it looked like the client wanted v0. However, including
    +    these fields does not change behavior, so it's better to have simpler
    +    code.
    +
         While we're at it, remove unnecessary externs from function declarations
         in protocol.h.
     
    @@ -245,18 +251,21 @@
      {
      	struct child_process *conn;
     @@
    + 		    prog, path, 0,
      		    target_host, 0);
      
    - 	/* If using a new version put that stuff here after a second null byte */
    +-	/* If using a new version put that stuff here after a second null byte */
     -	if (version > 0) {
    -+	if (strcmp(version_advert->buf, "version=0")) {
    - 		strbuf_addch(&request, '\0');
    +-		strbuf_addch(&request, '\0');
     -		strbuf_addf(&request, "version=%d%c",
     -			    version, '\0');
    -+		strbuf_addf(&request, "%s%c", version_advert->buf, '\0');
    - 	}
    +-	}
    ++	/* Add version fields after a second null byte */
    ++	strbuf_addch(&request, '\0');
    ++	strbuf_addf(&request, "%s%c", version_advert->buf, '\0');
      
      	packet_write(fd[1], request.buf, request.len);
    + 
     @@
       */
      static void push_ssh_options(struct argv_array *args, struct argv_array *env,
    @@ -264,9 +273,9 @@
     -			     enum protocol_version version, int flags)
     +			     const struct strbuf *version_advert, int flags)
      {
    - 	if (variant == VARIANT_SSH &&
    +-	if (variant == VARIANT_SSH &&
     -	    version > 0) {
    -+	    strcmp(version_advert->buf, "version=0")) {
    ++	if (variant == VARIANT_SSH) {
      		argv_array_push(args, "-o");
      		argv_array_push(args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
     -		argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
    @@ -346,13 +355,13 @@
     -			if (version > 0) {
     -				argv_array_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
     -						 version);
    -+			if (strcmp(version_advert.buf, "version=0")) {
    -+				argv_array_pushf(&conn->env_array,
    -+						 GIT_PROTOCOL_ENVIRONMENT "=%s",
    -+						 version_advert.buf);
    - 			}
    +-			}
    ++			argv_array_pushf(&conn->env_array,
    ++					 GIT_PROTOCOL_ENVIRONMENT "=%s",
    ++					 version_advert.buf);
      		}
      		argv_array_push(&conn->args, cmd.buf);
    + 
     
      diff --git a/protocol.c b/protocol.c
      --- a/protocol.c
    @@ -573,8 +582,7 @@
     +static int get_client_protocol_http_header(const struct strbuf *version_advert,
     +					   struct strbuf *header)
     +{
    -+	if (version_advert->len > 0 &&
    -+	    strcmp(version_advert->buf, "version=0")) {
    ++	if (version_advert->len > 0) {
     +		strbuf_addf(header, GIT_PROTOCOL_HEADER ": %s",
     +			    version_advert->buf);
     +
    @@ -629,6 +637,18 @@
      	if (argc < 2) {
      		error("remote-curl: usage: git remote-curl <remote> [<url>]");
     
    + diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
    + --- a/t/t5551-http-fetch-smart.sh
    + +++ b/t/t5551-http-fetch-smart.sh
    +@@
    + > Accept: */*
    + > Accept-Encoding: ENCODINGS
    + > Pragma: no-cache
    ++> Git-Protocol: version=0
    + < HTTP/1.1 200 OK
    + < Pragma: no-cache
    + < Cache-Control: no-cache, max-age=0, must-revalidate
    +
      diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
      --- a/t/t5570-git-daemon.sh
      +++ b/t/t5570-git-daemon.sh
    @@ -642,6 +662,161 @@
      	>daemon.log &&
      	GIT_OVERRIDE_VIRTUAL_HOST=localhost \
     
    + diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
    + --- a/t/t5601-clone.sh
    + +++ b/t/t5601-clone.sh
    +@@
    + 
    + test_expect_success 'clone myhost:src uses ssh' '
    + 	git clone myhost:src ssh-clone &&
    +-	expect_ssh myhost src
    ++	expect_ssh "-o SendEnv=GIT_PROTOCOL" myhost src
    + '
    + 
    + test_expect_success !MINGW,!CYGWIN 'clone local path foo:bar' '
    +@@
    + 
    + test_expect_success 'bracketed hostnames are still ssh' '
    + 	git clone "[myhost:123]:src" ssh-bracket-clone &&
    +-	expect_ssh "-p 123" myhost src
    ++	expect_ssh "-o SendEnv=GIT_PROTOCOL -p 123" myhost src
    + '
    + 
    + test_expect_success 'OpenSSH variant passes -4' '
    + 	git clone -4 "[myhost:123]:src" ssh-ipv4-clone &&
    +-	expect_ssh "-4 -p 123" myhost src
    ++	expect_ssh "-o SendEnv=GIT_PROTOCOL -4 -p 123" myhost src
    + '
    + 
    + test_expect_success 'variant can be overridden' '
    +@@
    + 	GIT_SSH="$TRASH_DIRECTORY/uplink" &&
    + 	test_when_finished "GIT_SSH=\"\$TRASH_DIRECTORY/ssh\$X\"" &&
    + 	git clone "[myhost:123]:src" ssh-bracket-clone-sshlike-uplink &&
    +-	expect_ssh "-p 123" myhost src
    ++	expect_ssh "-o SendEnv=GIT_PROTOCOL -p 123" myhost src
    + '
    + 
    + test_expect_success 'plink is treated specially (as putty)' '
    +@@
    + 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
    + 	GIT_SSH_VARIANT=ssh \
    + 	git clone "[myhost:123]:src" ssh-bracket-clone-variant-1 &&
    +-	expect_ssh "-p 123" myhost src
    ++	expect_ssh "-o SendEnv=GIT_PROTOCOL -p 123" myhost src
    + '
    + 
    + test_expect_success 'ssh.variant overrides plink detection' '
    + 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
    + 	git -c ssh.variant=ssh \
    + 		clone "[myhost:123]:src" ssh-bracket-clone-variant-2 &&
    +-	expect_ssh "-p 123" myhost src
    ++	expect_ssh "-o SendEnv=GIT_PROTOCOL -p 123" myhost src
    + '
    + 
    + test_expect_success 'GIT_SSH_VARIANT overrides plink detection to plink' '
    +@@
    + }
    + 
    + test_expect_success !MINGW 'clone c:temp is ssl' '
    +-	test_clone_url c:temp c temp
    ++	test_clone_url c:temp "-o SendEnv=GIT_PROTOCOL" c temp
    + '
    + 
    + test_expect_success MINGW 'clone c:temp is dos drive' '
    +@@
    + for repo in rep rep/home/project 123
    + do
    + 	test_expect_success "clone host:$repo" '
    +-		test_clone_url host:$repo host $repo
    ++		test_clone_url host:$repo "-o SendEnv=GIT_PROTOCOL" host $repo
    + 	'
    + done
    + 
    +@@
    + for repo in rep rep/home/project 123
    + do
    + 	test_expect_success "clone [::1]:$repo" '
    +-		test_clone_url [::1]:$repo ::1 "$repo"
    ++		test_clone_url [::1]:$repo "-o SendEnv=GIT_PROTOCOL" ::1 "$repo"
    + 	'
    + done
    + #home directory
    + test_expect_success "clone host:/~repo" '
    +-	test_clone_url host:/~repo host "~repo"
    ++	test_clone_url host:/~repo "-o SendEnv=GIT_PROTOCOL" host "~repo"
    + '
    + 
    + test_expect_success "clone [::1]:/~repo" '
    +-	test_clone_url [::1]:/~repo ::1 "~repo"
    ++	test_clone_url [::1]:/~repo "-o SendEnv=GIT_PROTOCOL" ::1 "~repo"
    + '
    + 
    + # Corner cases
    +@@
    + for tcol in "" :
    + do
    + 	test_expect_success "clone ssh://host.xz$tcol/home/user/repo" '
    +-		test_clone_url "ssh://host.xz$tcol/home/user/repo" host.xz /home/user/repo
    ++		test_clone_url "ssh://host.xz$tcol/home/user/repo" "-o SendEnv=GIT_PROTOCOL" host.xz /home/user/repo
    + 	'
    + 	# from home directory
    + 	test_expect_success "clone ssh://host.xz$tcol/~repo" '
    +-	test_clone_url "ssh://host.xz$tcol/~repo" host.xz "~repo"
    ++	test_clone_url "ssh://host.xz$tcol/~repo" "-o SendEnv=GIT_PROTOCOL" host.xz "~repo"
    + '
    + done
    + 
    + # with port number
    + test_expect_success 'clone ssh://host.xz:22/home/user/repo' '
    +-	test_clone_url "ssh://host.xz:22/home/user/repo" "-p 22 host.xz" "/home/user/repo"
    ++	test_clone_url "ssh://host.xz:22/home/user/repo" "-o SendEnv=GIT_PROTOCOL -p 22 host.xz" "/home/user/repo"
    + '
    + 
    + # from home directory with port number
    + test_expect_success 'clone ssh://host.xz:22/~repo' '
    +-	test_clone_url "ssh://host.xz:22/~repo" "-p 22 host.xz" "~repo"
    ++	test_clone_url "ssh://host.xz:22/~repo" "-o SendEnv=GIT_PROTOCOL -p 22 host.xz" "~repo"
    + '
    + 
    + #IPv6
    +@@
    + do
    + 	ehost=$(echo $tuah | sed -e "s/1]:/1]/" | tr -d "[]")
    + 	test_expect_success "clone ssh://$tuah/home/user/repo" "
    +-	  test_clone_url ssh://$tuah/home/user/repo $ehost /home/user/repo
    ++	  test_clone_url ssh://$tuah/home/user/repo '-o SendEnv=GIT_PROTOCOL' $ehost /home/user/repo
    + 	"
    + done
    + 
    +@@
    + do
    + 	euah=$(echo $tuah | tr -d "[]")
    + 	test_expect_success "clone ssh://$tuah/~repo" "
    +-	  test_clone_url ssh://$tuah/~repo $euah '~repo'
    ++	  test_clone_url ssh://$tuah/~repo '-o SendEnv=GIT_PROTOCOL' $euah '~repo'
    + 	"
    + done
    + 
    +@@
    + do
    + 	euah=$(echo $tuah | tr -d "[]")
    + 	test_expect_success "clone ssh://$tuah:22/home/user/repo" "
    +-	  test_clone_url ssh://$tuah:22/home/user/repo '-p 22' $euah /home/user/repo
    ++	  test_clone_url ssh://$tuah:22/home/user/repo '-o SendEnv=GIT_PROTOCOL -p 22' $euah /home/user/repo
    + 	"
    + done
    + 
    +@@
    + do
    + 	euah=$(echo $tuah | tr -d "[]")
    + 	test_expect_success "clone ssh://$tuah:22/~repo" "
    +-	  test_clone_url ssh://$tuah:22/~repo '-p 22' $euah '~repo'
    ++	  test_clone_url ssh://$tuah:22/~repo '-o SendEnv=GIT_PROTOCOL -p 22' $euah '~repo'
    + 	"
    + done
    + 
    +
      diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
      --- a/t/t5700-protocol-v1.sh
      +++ b/t/t5700-protocol-v1.sh
-- 
2.19.1.1215.g8438c0b245-goog

