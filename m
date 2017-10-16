Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 741BB20437
	for <e@80x24.org>; Mon, 16 Oct 2017 17:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754506AbdJPR4f (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 13:56:35 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:50166 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754490AbdJPR4d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 13:56:33 -0400
Received: by mail-io0-f170.google.com with SMTP id n137so17048514iod.6
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 10:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9AeAoQUW5tu8UU04QDUbGSdtSk7r6okELAsi3AhpYNg=;
        b=dXiISSnPGuzBjw092WimZ3V7vZdks6vpJno9Q5i8ph9ugwkQUvUO7MSaPlgWIWxAcD
         SO9wBY0PVWavDT4xKwk5ZNHheg7nOaZLY/2VxPZ0WHzbN0o8pG8Qdht2QdF81bBZ56+s
         N0j4qPn+DkUVbIb/Pp1OtB9GKWuHM+iLwMBxcounUnkA+qBiIAdmLY07BUrB5cBHpxQc
         JquXRDaSWP7fhNvSANEGP8iD4If07CreCoHclHjfBafqSHerMFUlESxHOaDRD3y/pJv0
         b7vI4w3aIOVgHGVTu2PKCyjD3p0jARsGAHv9k5nicwzp2lo6d5dd167V1Nj9KfCorhQn
         WV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9AeAoQUW5tu8UU04QDUbGSdtSk7r6okELAsi3AhpYNg=;
        b=FxksfThrLjbytmNuZAFk7ERYhxnLz7EtVLS+XgUikgq0IG9ID3QJDcAIa2LW48zGeP
         xsPycdeaMu6iYbIaO2D681z/L+3Q9rLzkyGTdaZE3toTbLM/eMS1auZmGbLT9rG8Jx1W
         eBK8EPArLUaH/y3B9pzz0RdUyfxxezZOPTHbZ/k4J/1q6ZxJfL4RkwZZVa3jMCYa3lFX
         PzVC82/eMqXD88KWbq+4Z72comvWRKA1fM4CPUROfOVxxDcIVxOX9AeRlDK3KKCbj/Yp
         6tDmYnJkdHjhMahOtw2UJmlU2He56C3CkOKcdpbhD0GzP9YpSUCgBMA/b0RiUctyTr+b
         zZxA==
X-Gm-Message-State: AMCzsaVmt3y9l6g2w8ET2OECDwfOHO3+o6LBl5kngadGeCRyYS7hH/Ul
        vpUpveaibJ9A59w+ouWEEFT2ah+s+rQ=
X-Google-Smtp-Source: ABhQp+QTDz/tg5e/deNyELk1vTaK0MDweZ5f+hhbwc80czzTykUNBlQoDi43F+FRq65+p2m+faZbqg==
X-Received: by 10.107.24.129 with SMTP id 123mr4586834ioy.115.1508176591874;
        Mon, 16 Oct 2017 10:56:31 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s74sm3813071ita.21.2017.10.16.10.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Oct 2017 10:56:30 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     martin.agren@gmail.com, simon@ruderich.org, bturner@atlassian.com,
        git@jeffhostetler.com, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com, peff@peff.net, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 11/11] Documentation: document Extra Parameters
Date:   Mon, 16 Oct 2017 10:55:32 -0700
Message-Id: <20171016175532.73459-12-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc-goog
In-Reply-To: <20171016175532.73459-1-bmwill@google.com>
References: <20171003201507.3589-1-bmwill@google.com>
 <20171016175532.73459-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Document the server support for Extra Parameters, additional information
that the client can send in its first message to the server during a
Git client-server interaction.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/technical/http-protocol.txt |  8 ++++++
 Documentation/technical/pack-protocol.txt | 43 ++++++++++++++++++++++++++-----
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index 1c561bdd9..a0e45f288 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -219,6 +219,10 @@ smart server reply:
    S: 003c2cb58b79488a98d2721cea644875a8dd0026b115 refs/tags/v1.0\n
    S: 003fa3c2e2402b99163d1d59756e5f207ae21cccba4c refs/tags/v1.0^{}\n
 
+The client may send Extra Parameters (see
+Documentation/technical/pack-protocol.txt) as a colon-separated string
+in the Git-Protocol HTTP header.
+
 Dumb Server Response
 ^^^^^^^^^^^^^^^^^^^^
 Dumb servers MUST respond with the dumb server reply format.
@@ -269,7 +273,11 @@ the C locale ordering.  The stream SHOULD include the default ref
 named `HEAD` as the first ref.  The stream MUST include capability
 declarations behind a NUL on the first ref.
 
+The returned response contains "version 1" if "version=1" was sent as an
+Extra Parameter.
+
   smart_reply     =  PKT-LINE("# service=$servicename" LF)
+		     *1("version 1")
 		     ref_list
 		     "0000"
   ref_list        =  empty_list / non_empty_list
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index ed1eae8b8..cd31edc91 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -39,6 +39,19 @@ communicates with that invoked process over the SSH connection.
 The file:// transport runs the 'upload-pack' or 'receive-pack'
 process locally and communicates with it over a pipe.
 
+Extra Parameters
+----------------
+
+The protocol provides a mechanism in which clients can send additional
+information in its first message to the server. These are called "Extra
+Parameters", and are supported by the Git, SSH, and HTTP protocols.
+
+Each Extra Parameter takes the form of `<key>=<value>` or `<key>`.
+
+Servers that receive any such Extra Parameters MUST ignore all
+unrecognized keys. Currently, the only Extra Parameter recognized is
+"version=1".
+
 Git Transport
 -------------
 
@@ -46,18 +59,25 @@ The Git transport starts off by sending the command and repository
 on the wire using the pkt-line format, followed by a NUL byte and a
 hostname parameter, terminated by a NUL byte.
 
-   0032git-upload-pack /project.git\0host=myserver.com\0
+   0033git-upload-pack /project.git\0host=myserver.com\0
+
+The transport may send Extra Parameters by adding an additional NUL
+byte, and then adding one or more NUL-terminated strings:
+
+   003egit-upload-pack /project.git\0host=myserver.com\0\0version=1\0
 
 --
-   git-proto-request = request-command SP pathname NUL [ host-parameter NUL ]
+   git-proto-request = request-command SP pathname NUL
+		       [ host-parameter NUL ] [ NUL extra-parameters ]
    request-command   = "git-upload-pack" / "git-receive-pack" /
 		       "git-upload-archive"   ; case sensitive
    pathname          = *( %x01-ff ) ; exclude NUL
    host-parameter    = "host=" hostname [ ":" port ]
+   extra-parameters  = 1*extra-parameter
+   extra-parameter   = 1*( %x01-ff ) NUL
 --
 
-Only host-parameter is allowed in the git-proto-request. Clients
-MUST NOT attempt to send additional parameters. It is used for the
+host-parameter is used for the
 git-daemon name based virtual hosting.  See --interpolated-path
 option to git daemon, with the %H/%CH format characters.
 
@@ -117,6 +137,12 @@ we execute it without the leading '/'.
 		     v
    ssh user@example.com "git-upload-pack '~alice/project.git'"
 
+Depending on the value of the `protocol.version` configuration variable,
+Git may attempt to send Extra Parameters as a colon-separated string in
+the GIT_PROTOCOL environment variable. This is done only if
+the `ssh.variant` configuration variable indicates that the ssh command
+supports passing environment variables as an argument.
+
 A few things to remember here:
 
 - The "command name" is spelled with dash (e.g. git-upload-pack), but
@@ -137,11 +163,13 @@ Reference Discovery
 -------------------
 
 When the client initially connects the server will immediately respond
-with a listing of each reference it has (all branches and tags) along
+with a version number (if "version=1" is sent as an Extra Parameter),
+and a listing of each reference it has (all branches and tags) along
 with the object name that each reference currently points to.
 
-   $ echo -e -n "0039git-upload-pack /schacon/gitbook.git\0host=example.com\0" |
+   $ echo -e -n "0044git-upload-pack /schacon/gitbook.git\0host=example.com\0\0version=1\0" |
       nc -v example.com 9418
+   000aversion 1
    00887217a7c7e582c46cec22a130adf4b9d7d950fba0 HEAD\0multi_ack thin-pack
 		side-band side-band-64k ofs-delta shallow no-progress include-tag
    00441d3fcd5ced445d1abc402225c0b8a1299641f497 refs/heads/integration
@@ -165,7 +193,8 @@ immediately after the ref itself, if presented. A conforming server
 MUST peel the ref if it's an annotated tag.
 
 ----
-  advertised-refs  =  (no-refs / list-of-refs)
+  advertised-refs  =  *1("version 1")
+		      (no-refs / list-of-refs)
 		      *shallow
 		      flush-pkt
 
-- 
2.15.0.rc0.271.g36b669edcc-goog

