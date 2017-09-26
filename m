Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F11020281
	for <e@80x24.org>; Tue, 26 Sep 2017 23:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032770AbdIZX4r (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 19:56:47 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:43203 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966844AbdIZX4q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 19:56:46 -0400
Received: by mail-pf0-f181.google.com with SMTP id y29so6334547pff.0
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 16:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JwrWs/MiZda2q1ukNpZgEb2jfP428mk45aZ3IWqafsc=;
        b=ULF0ePzZ8AeShiXn+0WMYxQi4PFwSe0cK/Htee5A1Wa9oefuecM8n8PbuF/8wI3W79
         EzOhmzbjUF9Pj6KhIEbUprKbv2FQdU/VF2DTYHqxScJ3d83yLkwV6xtKZMLAivszSahz
         o0KbIsd8bJUMlaJJsJHvN6g3IUJ7c/0jC6/zetVj+7+UgzHDUKTX0AYtczs67dZ7RTcX
         1RW+pffDkm+Ql6zK1sJ9vtosB/LHbqzxr4nxad2fmA+zn9aTXXSGrRcVmFPzCUqnIC4P
         RNSCFLvcYoZ/jyJpQoJpzBkztKem+7iF+BAM2EjZ3V/rADQx+3crnpX6aIWImbRasxlw
         SdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JwrWs/MiZda2q1ukNpZgEb2jfP428mk45aZ3IWqafsc=;
        b=t3P1or2NXEgufjr49l6W5yvR/M21iOk5fTGkB1Rx6onu9T3evCI+k1G8cjy8QDTAGc
         +/7RYE9nZTzkZFsU9GTdEJKdgBGFL9fCVhK0HLyxqUFEBciEpGiWjG2wZw3rGiPMSTM7
         88eSqQNiboTT/x6ZOWHYEx+9YnEL5NSHm5oQ+L/rJYmQP2cXQ08S+1UcwqmqOk35uOGE
         DglIP0TYyYLicp7gGaZ2lZafpGEA/X/FXLSSgbXkbtpjBQjCxsZOtNikUY40m0hFHj/j
         tgYqghKlmtmyvh2cwbXMCtufZ5YdwO+pgxp7wV7NW+qOVWOtk/kHHXK5WmxIt4XVEioZ
         Uf8Q==
X-Gm-Message-State: AHPjjUg9HQk9nLQ9biqloit3Q1t4F7ZUPu5YiaOxvcdWPCFYL0GlOLW+
        KZMMvh9XkeDb3/E4obwU4e6w/ZqzPgE=
X-Google-Smtp-Source: AOwi7QA3qLd2Kh2EmnBR/QvdPOUktgdjS+TuCZuC2iOzlaMb5SsderbgLQq6xlx68lP4NOdMEUqxiA==
X-Received: by 10.98.61.17 with SMTP id k17mr12419119pfa.48.1506470205647;
        Tue, 26 Sep 2017 16:56:45 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id j2sm18071699pgn.26.2017.09.26.16.56.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 16:56:44 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 0/9] protocol transition
Date:   Tue, 26 Sep 2017 16:56:18 -0700
Message-Id: <20170926235627.79606-1-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.992.g2c7b836f3a-goog
In-Reply-To: <20170913215448.84674-1-bmwill@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 of this series has the following changes:

 * Included Jonathan Tan's patch as [1/9] with a small tweak to not rely on
   hardcoding the side of sha1 into the capability line check.
 * Reworked some of the logic in daemon.c
 * Added the word 'Experimental' to protocol.version to indicate that user's
   shouldn't rely on its semantics to hold until it has been thoroughly tested.

Brandon Williams (8):
  pkt-line: add packet_write function
  protocol: introduce protocol extention mechanisms
  daemon: recognize hidden request arguments
  upload-pack, receive-pack: introduce protocol version 1
  connect: teach client to recognize v1 server response
  connect: tell server that the client understands v1
  http: tell server that the client understands v1
  i5700: add interop test for protocol transition

Jonathan Tan (1):
  connect: in ref advertisement, shallows are last

 Documentation/config.txt               |  17 ++
 Documentation/git.txt                  |   5 +
 Makefile                               |   1 +
 builtin/receive-pack.c                 |  14 ++
 cache.h                                |   9 +
 connect.c                              | 248 ++++++++++++++++++++--------
 daemon.c                               |  68 +++++++-
 http.c                                 |  18 ++
 pkt-line.c                             |   6 +
 pkt-line.h                             |   1 +
 protocol.c                             |  72 ++++++++
 protocol.h                             |  14 ++
 t/interop/i5700-protocol-transition.sh |  68 ++++++++
 t/lib-httpd/apache.conf                |   7 +
 t/t5700-protocol-v1.sh                 | 292 +++++++++++++++++++++++++++++++++
 upload-pack.c                          |  17 +-
 16 files changed, 776 insertions(+), 81 deletions(-)
 create mode 100644 protocol.c
 create mode 100644 protocol.h
 create mode 100755 t/interop/i5700-protocol-transition.sh
 create mode 100755 t/t5700-protocol-v1.sh

-- 
2.14.1.992.g2c7b836f3a-goog

