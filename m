Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B805720248
	for <e@80x24.org>; Fri,  8 Mar 2019 21:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfCHVzt (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 16:55:49 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:53630 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfCHVzt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 16:55:49 -0500
Received: by mail-pg1-f201.google.com with SMTP id k198so21696366pgc.20
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 13:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l60cNizw3k+R6216CyLcKW576KmjfOXpd+EXhbatOVg=;
        b=DFfgYn2v2cgz8mfw31cwxrMJ0ZNtlBr7+lp7cPTw7vxbCqRq32LSZ02ZVMqogR2XIO
         LyKrL7Ivq72nOuUddD5ncyH3qUk46wgevmKlolb4RlNQeT8VY3aSBUubyXQSgIkITaN/
         gZYoEbiJ+0ApgjkxpSqdCedIRkckeLYXJ3bGlNPucXVcba30gXG8nNPLN0JdbmVwSg9O
         fI9faoCcjM4aKx+78E6bWN3TIwcQFhMb5C88QfZ0pKmntHS6aY0ayGyw32ARln5/fmiP
         nNZ2/pn41R4D7NaUgwFA/8zZo0WE4AjcujtMTa9K/es22yAWV82gT+KT7MfBDC1BgDzw
         bvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l60cNizw3k+R6216CyLcKW576KmjfOXpd+EXhbatOVg=;
        b=DUwPtztvdN0BxP+Hxvbt7YYqwQxBbX8mZngzU2pjX2dkldGluhInjv0Kvn6opNJjrE
         SogXdLMTPfwGCoPVsFWh8VQxt+69eYwWM6uiReuUPCC/0nkYhOOkYKsKImvy/0w69w0C
         V97BJ5SWqCass96IkA+Gpm2sC/i4tZBI6nwplWpFtmOW5VUpuZ1OJpw9xddFA6hDSJAS
         mb6mnsfVbPA3cf8yO+b8pPeKF7Fz7NIcq2yJK7WdLdOSmN7dCNtscCF3upwhrD10WXow
         myTo4iVnQ/Xs9als8z3FuRw+PX3pYarHnBVXtqfQ3mgBCVqxMbDky5wbZz0PTeTOqtE8
         oAmA==
X-Gm-Message-State: APjAAAWHKqonKp1i+fcyVy0st/FtUFS4TU4MuyVWZ2yIS7ZEajxgOP4i
        ARNyGd3L2jMeNgRxOH/YIu/wgDRF0dDstgrZRk/F
X-Google-Smtp-Source: APXvYqw2w7ERBUNcAbL//4uLGQ2RoQY3Qf7wHHtOfXuYdGPQ23twJnqxujU90vQ5YmlH68gRnMnYr4F4+AlIiipuB38H
X-Received: by 2002:a17:902:8643:: with SMTP id y3mr6328474plt.125.1552082148512;
 Fri, 08 Mar 2019 13:55:48 -0800 (PST)
Date:   Fri,  8 Mar 2019 13:55:17 -0800
In-Reply-To: <cover.1552073690.git.jonathantanmy@google.com>
Message-Id: <5ce56844d3fb740e29d2f3d4be2ade0b2ad5f7fd.1552073690.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550963965.git.jonathantanmy@google.com> <cover.1552073690.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2 5/8] Documentation: add Packfile URIs design doc
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/packfile-uri.txt | 78 ++++++++++++++++++++++++
 Documentation/technical/protocol-v2.txt  | 28 ++++++++-
 2 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/technical/packfile-uri.txt

diff --git a/Documentation/technical/packfile-uri.txt b/Documentation/technical/packfile-uri.txt
new file mode 100644
index 0000000000..6a5a6440d5
--- /dev/null
+++ b/Documentation/technical/packfile-uri.txt
@@ -0,0 +1,78 @@
+Packfile URIs
+=============
+
+This feature allows servers to serve part of their packfile response as URIs.
+This allows server designs that improve scalability in bandwidth and CPU usage
+(for example, by serving some data through a CDN), and (in the future) provides
+some measure of resumability to clients.
+
+This feature is available only in protocol version 2.
+
+Protocol
+--------
+
+The server advertises `packfile-uris`.
+
+If the client then communicates which protocols (HTTPS, etc.) it supports with
+a `packfile-uris` argument, the server MAY send a `packfile-uris` section
+directly before the `packfile` section (right after `wanted-refs` if it is
+sent) containing URIs of any of the given protocols. The URIs point to
+packfiles that use only features that the client has declared that it supports
+(e.g. ofs-delta and thin-pack). See protocol-v2.txt for the documentation of
+this section.
+
+Clients then should understand that the returned packfile could be incomplete,
+and that it needs to download all the given URIs before the fetch or clone is
+complete.
+
+Server design
+-------------
+
+The server can be trivially made compatible with the proposed protocol by
+having it advertise `packfile-uris`, tolerating the client sending
+`packfile-uris`, and never sending any `packfile-uris` section. But we should
+include some sort of non-trivial implementation in the Minimum Viable Product,
+at least so that we can test the client.
+
+This is the implementation: a feature, marked experimental, that allows the
+server to be configured by one or more `uploadpack.blobPackfileUri=<sha1>
+<uri>` entries. Whenever the list of objects to be sent is assembled, a blob
+with the given sha1 can be replaced by the given URI. This allows, for example,
+servers to delegate serving of large blobs to CDNs.
+
+Client design
+-------------
+
+While fetching, the client needs to remember the list of URIs and cannot
+declare that the fetch is complete until all URIs have been downloaded as
+packfiles.
+
+The division of work (initial fetch + additional URIs) introduces convenient
+points for resumption of an interrupted clone - such resumption can be done
+after the Minimum Viable Product (see "Future work").
+
+The client can inhibit this feature (i.e. refrain from sending the
+`packfile-uris` parameter) by passing --no-packfile-uris to `git fetch`.
+
+Future work
+-----------
+
+The protocol design allows some evolution of the server and client without any
+need for protocol changes, so only a small-scoped design is included here to
+form the MVP. For example, the following can be done:
+
+ * On the server, a long-running process that takes in entire requests and
+   outputs a list of URIs and the corresponding inclusion and exclusion sets of
+   objects. This allows, e.g., signed URIs to be used and packfiles for common
+   requests to be cached.
+ * On the client, resumption of clone. If a clone is interrupted, information
+   could be recorded in the repository's config and a "clone-resume" command
+   can resume the clone in progress. (Resumption of subsequent fetches is more
+   difficult because that must deal with the user wanting to use the repository
+   even after the fetch was interrupted.)
+
+There are some possible features that will require a change in protocol:
+
+ * Additional HTTP headers (e.g. authentication)
+ * Byte range support
+ * Different file formats referenced by URIs (e.g. raw object)
diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 36239ec7e9..7b63c26ecd 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -323,13 +323,26 @@ included in the client's request:
 	indicating its sideband (1, 2, or 3), and the server may send "0005\2"
 	(a PKT-LINE of sideband 2 with no payload) as a keepalive packet.
 
+If the 'packfile-uris' feature is advertised, the following argument
+can be included in the client's request as well as the potential
+addition of the 'packfile-uris' section in the server's response as
+explained below.
+
+    packfile-uris <comma-separated list of protocols>
+	Indicates to the server that the client is willing to receive
+	URIs of any of the given protocols in place of objects in the
+	sent packfile. Before performing the connectivity check, the
+	client should download from all given URIs. Currently, the
+	protocols supported are "http" and "https".
+
 The response of `fetch` is broken into a number of sections separated by
 delimiter packets (0001), with each section beginning with its section
 header. Most sections are sent only when the packfile is sent.
 
     output = acknowledgements flush-pkt |
 	     [acknowledgments delim-pkt] [shallow-info delim-pkt]
-	     [wanted-refs delim-pkt] packfile flush-pkt
+	     [wanted-refs delim-pkt] [packfile-uris delim-pkt]
+	     packfile flush-pkt
 
     acknowledgments = PKT-LINE("acknowledgments" LF)
 		      (nak | *ack)
@@ -347,6 +360,9 @@ header. Most sections are sent only when the packfile is sent.
 		  *PKT-LINE(wanted-ref LF)
     wanted-ref = obj-id SP refname
 
+    packfile-uris = PKT-LINE("packfile-uris" LF) *packfile-uri
+    packfile-uri = PKT-LINE(40*(HEXDIGIT) SP *%x20-ff LF)
+
     packfile = PKT-LINE("packfile" LF)
 	       *PKT-LINE(%x01-03 *%x00-ff)
 
@@ -418,6 +434,16 @@ header. Most sections are sent only when the packfile is sent.
 	* The server MUST NOT send any refs which were not requested
 	  using 'want-ref' lines.
 
+    packfile-uris section
+	* This section is only included if the client sent
+	  'packfile-uris' and the server has at least one such URI to
+	  send.
+
+	* Always begins with the section header "packfile-uris".
+
+	* For each URI the server sends, it sends a hash of the pack's
+	  contents (as output by git index-pack) followed by the URI.
+
     packfile section
 	* This section is only included if the client has sent 'want'
 	  lines in its request and either requested that no more
-- 
2.19.0.271.gfe8321ec05.dirty

