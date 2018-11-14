Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B9FB1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 02:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeKNMbV (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 07:31:21 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:36267 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeKNMbV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 07:31:21 -0500
Received: by mail-vs1-f74.google.com with SMTP id r133so2416245vsc.3
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 18:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DAjq8NMXDjvMfH78ZqIMgqNaAUMZblgt6SA7auXWEDk=;
        b=isCppZaVoohvE0C7D2zBBazM3SRextLKST0/q9i0hK4w+QfYwhHo38yMMZL4R2qCP2
         +D3wHpQQGpkdwVzi8jVr9IksPmAZVLUrw7YLoDqck5dGf7sq3iVrD07I0D8ZNGX203gE
         sl0Ftioh3HqaAeOof5yE8UvmUTUgteZ3qSohf2JRrPZ9yTJ8syag0alXcL9kYPi38j/s
         4IVv6qzNxI0nj89dolQNdfHI6i/WQf+qN6/mAeg9qJwr/P6Ju+gVHq+MYzZf7V5fTAQ9
         hTv++RT6kdSlkLs0PJuNfm1b/O0t8E5Tfa0TYZAzjXsoVWtED3yjJ+ZKtVyx4BcfI410
         mwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DAjq8NMXDjvMfH78ZqIMgqNaAUMZblgt6SA7auXWEDk=;
        b=dsNWo10V72hy9tI7TGbrdrIT1dJNDDy9S7ZnQhvNZAsGzlkGB+YSyAGVubOp4XlHPN
         lXw4dmIdGFFt6bQP/I8ubFdYCFhUfPSrxf0xxSQ9VYd66eUyyAwzVHelkutrtNIY8fVx
         QvP/gYdf0Uo9BSGEsajFx9LPsk58ZH6N8Iq47y06EptO9XATgY4EnLZ6USxpLuys7QPf
         mmMl1iYJEbBOSJZBYMMaKG9flonK/YfX/4WmgaW6Di3FW3leHPQrX+8ZSrNjBluM2Idf
         LVp7es5HAA/k6g29QLeMFZR5HH1+qD6z4ewjuJX3ZvMASDTW5jGsdg8c1U3gYDx7sJW4
         9ZiQ==
X-Gm-Message-State: AGRZ1gIQiAbammSsP1qAaiz7fGPM+ZmvVGRGWobfptB5U43Kup093IMB
        U9NM1++hLo7LbYsJceUAyEWJCQlZEgfywQf+yjyN0dxBsPfBviYOO+05zCcWyqnHhESqaa+u7to
        cBXe6r9P/kPgtffCSlw25Wt0tCCLvsu9UGFFO3A3qb6LSK+vnVUWcBTBlzGgum4E=
X-Google-Smtp-Source: AJdET5dM/QFKsT75Lz7b/qlrKNU2nXe2mufl20WoO2qN4qmneovt+XrMvSS2g4EmU/vU+nP0U8XCFyDGgVEtVg==
X-Received: by 2002:ab0:e01:: with SMTP id g1mr31460uak.21.1542162613440; Tue,
 13 Nov 2018 18:30:13 -0800 (PST)
Date:   Tue, 13 Nov 2018 18:30:09 -0800
In-Reply-To: <cover.1542059029.git.steadmon@google.com>
Message-Id: <cover.1542162201.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1542059029.git.steadmon@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH v4 0/1] Advertise multiple supported proto versions
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jonathantanmy@google.com, gitster@pobox.com,
        szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix several bugs identified in v3, clarify commit message, and clean up
extern keyword in protocol.h.

Josh Steadmon (1):
  protocol: advertise multiple supported versions

 builtin/archive.c        |   3 +
 builtin/clone.c          |   4 ++
 builtin/fetch-pack.c     |   4 ++
 builtin/fetch.c          |   5 ++
 builtin/ls-remote.c      |   5 ++
 builtin/pull.c           |   5 ++
 builtin/push.c           |   4 ++
 builtin/receive-pack.c   |   3 +
 builtin/send-pack.c      |   3 +
 builtin/upload-archive.c |   3 +
 builtin/upload-pack.c    |   4 ++
 connect.c                |  47 +++++++--------
 protocol.c               | 122 ++++++++++++++++++++++++++++++++++++---
 protocol.h               |  23 +++++++-
 remote-curl.c            |  28 ++++++---
 t/t5570-git-daemon.sh    |   2 +-
 t/t5700-protocol-v1.sh   |   8 +--
 t/t5702-protocol-v2.sh   |  16 +++--
 transport-helper.c       |   6 ++
 19 files changed, 237 insertions(+), 58 deletions(-)

Range-diff against v3:
1:  b9968e3fb0 ! 1:  3c023991c0 protocol: advertise multiple supported versions
    @@ -4,22 +4,25 @@
     
         Currently the client advertises that it supports the wire protocol
         version set in the protocol.version config. However, not all services
    -    support the same set of protocol versions. When connecting to
    -    git-receive-pack, the client automatically downgrades to v0 if
    -    config.protocol is set to v2, but this check is not performed for other
    -    services.
    +    support the same set of protocol versions. For example, git-receive-pack
    +    supports v1 and v0, but not v2. If a client connects to git-receive-pack
    +    and requests v2, it will instead be downgraded to v0. Other services,
    +    such as git-upload-archive, do not do any version negotiation checks.
     
    -    This patch creates a protocol version registry. Individual operations
    -    register all the protocol versions they support prior to communicating
    -    with a server. Versions should be listed in preference order; the
    -    version specified in protocol.version will automatically be moved to the
    -    front of the registry.
    +    This patch creates a protocol version registry. Individual client and
    +    server programs register all the protocol versions they support prior to
    +    communicating with a remote instance. Versions should be listed in
    +    preference order; the version specified in protocol.version will
    +    automatically be moved to the front of the registry.
     
         The protocol version registry is passed to remote helpers via the
         GIT_PROTOCOL environment variable.
     
         Clients now advertise the full list of registered versions. Servers
    -    select the first recognized version from this advertisement.
    +    select the first allowed version from this advertisement.
    +
    +    While we're at it, remove unnecessary externs from function declarations
    +    in protocol.h.
     
         Signed-off-by: Josh Steadmon <steadmon@google.com>
    @@ -165,6 +168,20 @@
      	git_config(git_push_config, &flags);
      	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
     
    + diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
    + --- a/builtin/receive-pack.c
    + +++ b/builtin/receive-pack.c
    +@@
    + 
    + 	packet_trace_identity("receive-pack");
    + 
    ++	register_allowed_protocol_version(protocol_v1);
    ++	register_allowed_protocol_version(protocol_v0);
    ++
    + 	argc = parse_options(argc, argv, prefix, options, receive_pack_usage, 0);
    + 
    + 	if (argc > 1)
    +
      diff --git a/builtin/send-pack.c b/builtin/send-pack.c
      --- a/builtin/send-pack.c
      +++ b/builtin/send-pack.c
    @@ -179,6 +196,42 @@
      	argc = parse_options(argc, argv, prefix, options, send_pack_usage, 0);
      	if (argc > 0) {
     
    + diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
    + --- a/builtin/upload-archive.c
    + +++ b/builtin/upload-archive.c
    +@@
    + #include "builtin.h"
    + #include "archive.h"
    + #include "pkt-line.h"
    ++#include "protocol.h"
    + #include "sideband.h"
    + #include "run-command.h"
    + #include "argv-array.h"
    +@@
    + 	if (argc == 2 && !strcmp(argv[1], "-h"))
    + 		usage(upload_archive_usage);
    + 
    ++	register_allowed_protocol_version(protocol_v0);
    ++
    + 	/*
    + 	 * Set up sideband subprocess.
    + 	 *
    +
    + diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
    + --- a/builtin/upload-pack.c
    + +++ b/builtin/upload-pack.c
    +@@
    + 	packet_trace_identity("upload-pack");
    + 	read_replace_refs = 0;
    + 
    ++	register_allowed_protocol_version(protocol_v2);
    ++	register_allowed_protocol_version(protocol_v1);
    ++	register_allowed_protocol_version(protocol_v0);
    ++
    + 	argc = parse_options(argc, argv, NULL, options, upload_pack_usage, 0);
    + 
    + 	if (argc != 1)
    +
      diff --git a/connect.c b/connect.c
      --- a/connect.c
      +++ b/connect.c
    @@ -311,7 +364,7 @@
     +static enum protocol_version *allowed_versions;
     +static int nr_allowed_versions;
     +static int alloc_allowed_versions;
    -+static int have_advertised_versions_already = 0;
    ++static int version_registration_locked = 0;
     +
     +static const char protocol_v0_string[] = "0";
     +static const char protocol_v1_string[] = "1";
    @@ -357,8 +410,8 @@
      
     +void register_allowed_protocol_version(enum protocol_version version)
     +{
    -+	if (have_advertised_versions_already)
    -+		BUG(_("attempting to register an allowed protocol version after advertisement"));
    ++	if (version_registration_locked)
    ++		BUG("late attempt to register an allowed protocol version");
     +
     +	ALLOC_GROW(allowed_versions, nr_allowed_versions + 1,
     +		   alloc_allowed_versions);
    @@ -384,13 +437,23 @@
     +	string_list_clear(&version_list, 0);
     +}
     +
    ++static int is_allowed_protocol_version(enum protocol_version version)
    ++{
    ++	int i;
    ++	version_registration_locked = 1;
    ++	for (i = 0; i < nr_allowed_versions; i++)
    ++		if (version == allowed_versions[i])
    ++			return 1;
    ++	return 0;
    ++}
    ++
     +void get_client_protocol_version_advertisement(struct strbuf *advert)
     +{
    -+	int tmp_nr = nr_allowed_versions;
    ++	int i, tmp_nr = nr_allowed_versions;
     +	enum protocol_version *tmp_allowed_versions, config_version;
     +	strbuf_reset(advert);
     +
    -+	have_advertised_versions_already = 1;
    ++	version_registration_locked = 1;
     +
     +	config_version = get_protocol_version_config();
     +	if (config_version == protocol_v0) {
    @@ -409,20 +472,19 @@
     +	}
     +
     +	if (tmp_allowed_versions[0] != config_version)
    -+		for (int i = 1; i < nr_allowed_versions; i++)
    ++		for (i = 1; i < nr_allowed_versions; i++)
     +			if (tmp_allowed_versions[i] == config_version) {
    -+				enum protocol_version swap =
    -+					tmp_allowed_versions[0];
    -+				tmp_allowed_versions[0] =
    -+					tmp_allowed_versions[i];
    -+				tmp_allowed_versions[i] = swap;
    ++				SWAP(tmp_allowed_versions[0],
    ++				     tmp_allowed_versions[i]);
     +			}
     +
     +	strbuf_addf(advert, "version=%s",
     +		    format_protocol_version(tmp_allowed_versions[0]));
    -+	for (int i = 1; i < tmp_nr; i++)
    ++	for (i = 1; i < tmp_nr; i++)
     +		strbuf_addf(advert, ":version=%s",
     +			    format_protocol_version(tmp_allowed_versions[i]));
    ++
    ++	free(tmp_allowed_versions);
     +}
     +
      enum protocol_version determine_protocol_version_server(void)
    @@ -447,7 +509,8 @@
      			if (skip_prefix(item->string, "version=", &value)) {
      				v = parse_protocol_version(value);
     -				if (v > version)
    -+				if (v != protocol_unknown_version) {
    ++				if (v != protocol_unknown_version &&
    ++				    is_allowed_protocol_version(v)) {
      					version = v;
     +					break;
     +				}
    @@ -459,29 +522,46 @@
      --- a/protocol.h
      +++ b/protocol.h
     @@
    +  * 'protocol.version' config.  If unconfigured, a value of 'protocol_v0' is
    +  * returned.
       */
    - extern enum protocol_version get_protocol_version_config(void);
    - 
    +-extern enum protocol_version get_protocol_version_config(void);
    ++enum protocol_version get_protocol_version_config(void);
    ++
     +/*
     + * Register an allowable protocol version for a given operation. Registration
     + * must occur before attempting to advertise a version to a server process.
     + */
    -+extern void register_allowed_protocol_version(enum protocol_version version);
    ++void register_allowed_protocol_version(enum protocol_version version);
     +
     +/*
     + * Register allowable protocol versions from the GIT_PROTOCOL environment var.
     + */
    -+extern void register_allowed_protocol_versions_from_env(void);
    ++void register_allowed_protocol_versions_from_env(void);
     +
     +/*
     + * Fill a strbuf with a version advertisement string suitable for use in the
     + * GIT_PROTOCOL environment variable or similar version negotiation field.
     + */
    -+extern void get_client_protocol_version_advertisement(struct strbuf *advert);
    -+
    ++void get_client_protocol_version_advertisement(struct strbuf *advert);
    + 
      /*
       * Used by a server to determine which protocol version should be used based on
    -  * a client's request, communicated via the 'GIT_PROTOCOL' environment variable
    +@@
    +  * request a particular protocol version, a default of 'protocol_v0' will be
    +  * used.
    +  */
    +-extern enum protocol_version determine_protocol_version_server(void);
    ++enum protocol_version determine_protocol_version_server(void);
    + 
    + /*
    +  * Used by a client to determine which protocol version the server is speaking
    +  * based on the server's initial response.
    +  */
    +-extern enum protocol_version determine_protocol_version_client(const char *server_response);
    ++enum protocol_version determine_protocol_version_client(const char *server_response);
    + 
    + #endif /* PROTOCOL_H */
     
      diff --git a/remote-curl.c b/remote-curl.c
      --- a/remote-curl.c
-- 
2.19.1.930.g4563a0d9d0-goog

