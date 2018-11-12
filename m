Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB8871F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 21:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbeKMHoL (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 02:44:11 -0500
Received: from mail-io1-f73.google.com ([209.85.166.73]:46553 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeKMHoL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 02:44:11 -0500
Received: by mail-io1-f73.google.com with SMTP id e144-v6so11222698iof.13
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 13:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=U8or8cNQqWyPgChEZoMV3FsbqmfPz/HKI8EOZOfhI8o=;
        b=tRME/hojvYapymumwhckRkjhvO1aXPndfGbXJbR+0z0NM4Whwuo5VDKUjOLjvuC2Kb
         2d21Qth1o10AjADxJHWV1MGZ26OQWqlY9HrAw6fb3+BrNOketmtYWYFyiwAjuS9Dffp7
         s5jFS0jK1dp3/5O8SbEPRlJvzS1wZuOVpnmbWClEfNWmLwaK+olyso0gGZgHooaw2hqI
         K2tpwv3IuQIOJVJ+pJFMTCF+qM6dLDxhpxh53efNvvwb8/yJVWlJmFmtotscU8c7+SVp
         ket4VDP0vP6HJorLA/R+WWykz0kPmdSC7vz17oP1D/wYAym4ioRStuDc2kGhRzvXYaZS
         DJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U8or8cNQqWyPgChEZoMV3FsbqmfPz/HKI8EOZOfhI8o=;
        b=oC3u4AWTuXekCPA2RHYNzTaLAFDsCWMmEJZWQjWFFq4PISScD8PKn4GxSBcP0aEtOB
         10GTsSzm8qI4ORUamcyrUODmkywT6VqKhVz9y4HL6AcrJTeeTR+QJGbzsKKLQCM1dMAM
         HyHDkq3+79pM7jVRHokFJJkgyNNwGde/TL+TD3q0CLI+lBCncCnoVCXJacTbgdxC6oMT
         k5gSvmPrjF+yiKUE6WjQiMzGKbogxprOsa/IfKWB01KMFGSKyLhdFjwh/bUnHgY/v9Mr
         ZV12R7VQ2gIdsvGKKVRu+eBzqNw3zON4YD/i6x19X+iI0yktYYNGxiS2BpuDugLrvpfa
         66uA==
X-Gm-Message-State: AGRZ1gK690BrXqy1j7TyUVkaB+DCGoJ84DU0Df3SknT7DNwVj7V5nf5b
        iZoOuybGW8seZxFiAg/dQEuW2K/QmuGdKBaxPBa0lcli97qJk8HE1R+1/MQtPOXasQaHeSYpHwX
        6d58YRWyCHSnGXL3YAAKyN/9F7j8Ha6ggn/JQskZymqUN7hEyQua3gI8m2fHMAPc=
X-Google-Smtp-Source: AJdET5dU0Nxt1f4eUf3Ptb4wBjfaKvwtzTehyf58/6o9dTQXjlup1cZ7SNb8rbFC06Yq2p0JtBL+uy4s4uobfw==
X-Received: by 2002:a24:8342:: with SMTP id d63mr820454ite.26.1542059347700;
 Mon, 12 Nov 2018 13:49:07 -0800 (PST)
Date:   Mon, 12 Nov 2018 13:49:04 -0800
In-Reply-To: <cover.1539305180.git.steadmon@google.com>
Message-Id: <cover.1542059029.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1539305180.git.steadmon@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH v3 0/1] Advertise multiple supported proto versions
From:   steadmon@google.com
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a minor iteration on v2, to change an error message to a BUG.

Josh Steadmon (1):
  protocol: advertise multiple supported versions

 builtin/archive.c      |   3 ++
 builtin/clone.c        |   4 ++
 builtin/fetch-pack.c   |   4 ++
 builtin/fetch.c        |   5 ++
 builtin/ls-remote.c    |   5 ++
 builtin/pull.c         |   5 ++
 builtin/push.c         |   4 ++
 builtin/send-pack.c    |   3 ++
 connect.c              |  47 ++++++++---------
 protocol.c             | 112 ++++++++++++++++++++++++++++++++++++++---
 protocol.h             |  17 +++++++
 remote-curl.c          |  28 +++++++----
 t/t5570-git-daemon.sh  |   2 +-
 t/t5700-protocol-v1.sh |   8 +--
 t/t5702-protocol-v2.sh |  16 +++---
 transport-helper.c     |   6 +++
 16 files changed, 214 insertions(+), 55 deletions(-)

Range-diff against v2:
1:  70986cec32 ! 1:  b9968e3fb0 protocol: advertise multiple supported versions
    @@ -358,7 +358,7 @@
     +void register_allowed_protocol_version(enum protocol_version version)
     +{
     +	if (have_advertised_versions_already)
    -+		error(_("attempting to register an allowed protocol version after advertisement"));
    ++		BUG(_("attempting to register an allowed protocol version after advertisement"));
     +
     +	ALLOC_GROW(allowed_versions, nr_allowed_versions + 1,
     +		   alloc_allowed_versions);
    @@ -395,7 +395,6 @@
     +	config_version = get_protocol_version_config();
     +	if (config_version == protocol_v0) {
     +		strbuf_addstr(advert, "version=0");
    -+		trace_printf("Client advert string: %s", advert->buf);
     +		return;
     +	}
     +
    @@ -424,8 +423,6 @@
     +	for (int i = 1; i < tmp_nr; i++)
     +		strbuf_addf(advert, ":version=%s",
     +			    format_protocol_version(tmp_allowed_versions[i]));
    -+
    -+	trace_printf("Client advert string: %s", advert->buf);
     +}
     +
      enum protocol_version determine_protocol_version_server(void)
-- 
2.19.1.930.g4563a0d9d0-goog

