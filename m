Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4ACA20248
	for <e@80x24.org>; Fri, 29 Mar 2019 12:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfC2Mfi (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 08:35:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36778 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbfC2Mfg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 08:35:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so2432568wrd.3
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 05:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5PBiKF8zEpvtgpPoQZBnfSCqx9N/ons4aX+0a2zMnz0=;
        b=AIaz33STGl4J9xXyHC6ZhhNwmMd3/Fnx/mP8xSoLY1Qe1K5sumH/owM29VpWoeb7NO
         Th3P0qDuho9h4zNpoxMyXFWOeg0/NcVAxr+GPj+1vOhQR6goi+PcLTGydYk1XV24bh9t
         XO1K6pWg5qbuJRd5p6B1mZubo6gSeFlk3AfSnJRFwatoZ+HXBjtxdVrFh314oOBl3ikU
         FUCMW7I1ZcrpqVdWsBRTWtEgXvj9lw1GCNH9JL/4u6AgvhN0Llfrp3S3fQsTZxpCTS5z
         20umNmvY9h2WPNsOtj1aed5lgCFGC9ke+lqsF9+cA6OAGnXVLZxiEWe0RuSzjZqMmOLV
         z16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5PBiKF8zEpvtgpPoQZBnfSCqx9N/ons4aX+0a2zMnz0=;
        b=TQyIwt15966eP6DqLHXDe7khr1DVIKISv3dDnfyVYiN76qrKQtXoyQyQr9c2td1IFV
         0nspdcfHOpNXOjYrL30+QThl6WLeu1lF11HRJehxedXZ9NIC0blGjRlf1REFZKpXDrmY
         tSdFq2YlFfeowBrxEbGQ3qtefA8WWvXQysmtWEU8GLEJf4tSxvr/NLZJpnsJKbp6vU5q
         9iT1wlUu8hYLFfpMExF14GTUBJ949KYk/gyddtcwHiQgSGyJ2Em8Xh0Dmy6lz5YWiLDb
         TW4nK8jqB5zqicDhH5wzHv1X6dXdUoqMtiAd02XKrJx+dIeH4/mF/9cFipt0bDfKcXVu
         pr2w==
X-Gm-Message-State: APjAAAWeXeXxGWw5Jgx7J5Z/z5t0DAXvK7U/nXiAHf89QV8QLMqHBT5H
        z9AHwmI4KZGPodMr3e6ROtc=
X-Google-Smtp-Source: APXvYqzTWvipnd9sXmsnwbGImDVzrpCHXtQViQjt6Y3ah0OPxWaFGhJQzrE+a9nR1KWDLzpymAhUgQ==
X-Received: by 2002:adf:8367:: with SMTP id 94mr33024150wrd.46.1553862934256;
        Fri, 29 Mar 2019 05:35:34 -0700 (PDT)
Received: from localhost.localdomain (x4dbd3bb2.dyn.telefonica.de. [77.189.59.178])
        by smtp.gmail.com with ESMTPSA id 61sm7341781wre.50.2019.03.29.05.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Mar 2019 05:35:33 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 3/6] Documentation/technical/protocol-v2.txt: fix formatting
Date:   Fri, 29 Mar 2019 13:35:17 +0100
Message-Id: <20190329123520.27549-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
In-Reply-To: <20190329123520.27549-1-szeder.dev@gmail.com>
References: <20190324215534.9495-1-szeder.dev@gmail.com>
 <20190329123520.27549-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Asciidoctor versions v1.5.7 or later print the following warning while
building the documentation:

      ASCIIDOC technical/protocol-v2.html
  asciidoctor: WARNING: protocol-v2.txt: line 38: unterminated listing block

This highlights an issue (even with older Asciidoctor versions) where
the 'Initial Client Request' header is not rendered as a header but in
monospace.  I'm not sure what exactly causes this issue and why it's
an issue only with this particular header, but all headers in
'protocol-v2.txt' are written like this:

   Initial Client Request
  ------------------------

i.e. the header itself is indented by a space, and the "underline" is
two characters longer than the header.

Dropping that indentation and making the length of the underline match
the length of the header apparently fixes this issue.

While at it, adjust all other headers 'protocol-v2.txt' as well, to
match the style we use everywhere else.

The page rendered with AsciiDoc doesn't have this formatting issue.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/technical/protocol-v2.txt | 52 ++++++++++++-------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index ead85ce35c..03264c7d9a 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -1,5 +1,5 @@
- Git Wire Protocol, Version 2
-==============================
+Git Wire Protocol, Version 2
+============================
 
 This document presents a specification for a version 2 of Git's wire
 protocol.  Protocol v2 will improve upon v1 in the following ways:
@@ -22,8 +22,8 @@ will be commands which a client can request be executed.  Once a command
 has completed, a client can reuse the connection and request that other
 commands be executed.
 
- Packet-Line Framing
----------------------
+Packet-Line Framing
+-------------------
 
 All communication is done using packet-line framing, just as in v1.  See
 `Documentation/technical/pack-protocol.txt` and
@@ -34,8 +34,8 @@ In protocol v2 these special packets will have the following semantics:
   * '0000' Flush Packet (flush-pkt) - indicates the end of a message
   * '0001' Delimiter Packet (delim-pkt) - separates sections of a message
 
- Initial Client Request
-------------------------
+Initial Client Request
+----------------------
 
 In general a client can request to speak protocol v2 by sending
 `version=2` through the respective side-channel for the transport being
@@ -43,22 +43,22 @@ used which inevitably sets `GIT_PROTOCOL`.  More information can be
 found in `pack-protocol.txt` and `http-protocol.txt`.  In all cases the
 response from the server is the capability advertisement.
 
- Git Transport
-~~~~~~~~~~~~~~~
+Git Transport
+~~~~~~~~~~~~~
 
 When using the git:// transport, you can request to use protocol v2 by
 sending "version=2" as an extra parameter:
 
    003egit-upload-pack /project.git\0host=myserver.com\0\0version=2\0
 
- SSH and File Transport
-~~~~~~~~~~~~~~~~~~~~~~~~
+SSH and File Transport
+~~~~~~~~~~~~~~~~~~~~~~
 
 When using either the ssh:// or file:// transport, the GIT_PROTOCOL
 environment variable must be set explicitly to include "version=2".
 
- HTTP Transport
-~~~~~~~~~~~~~~~~
+HTTP Transport
+~~~~~~~~~~~~~~
 
 When using the http:// or https:// transport a client makes a "smart"
 info/refs request as described in `http-protocol.txt` and requests that
@@ -79,8 +79,8 @@ A v2 server would reply:
 Subsequent requests are then made directly to the service
 `$GIT_URL/git-upload-pack`. (This works the same for git-receive-pack).
 
- Capability Advertisement
---------------------------
+Capability Advertisement
+------------------------
 
 A server which decides to communicate (based on a request from a client)
 using protocol version 2, notifies the client by sending a version string
@@ -101,8 +101,8 @@ to be executed by the client.
     key = 1*(ALPHA | DIGIT | "-_")
     value = 1*(ALPHA | DIGIT | " -_.,?\/{}[]()<>!@#$%^&*+=:;")
 
- Command Request
------------------
+Command Request
+---------------
 
 After receiving the capability advertisement, a client can then issue a
 request to select the command it wants with any particular capabilities
@@ -137,8 +137,8 @@ command be executed or can terminate the connection.  A client may
 optionally send an empty request consisting of just a flush-pkt to
 indicate that no more requests will be made.
 
- Capabilities
---------------
+Capabilities
+------------
 
 There are two different types of capabilities: normal capabilities,
 which can be used to to convey information or alter the behavior of a
@@ -153,8 +153,8 @@ management on the server side in order to function correctly.  This
 permits simple round-robin load-balancing on the server side, without
 needing to worry about state management.
 
- agent
-~~~~~~~
+agent
+~~~~~
 
 The server can advertise the `agent` capability with a value `X` (in the
 form `agent=X`) to notify the client that the server is running version
@@ -168,8 +168,8 @@ printable ASCII characters except space (i.e., the byte range 32 < x <
 and debugging purposes, and MUST NOT be used to programmatically assume
 the presence or absence of particular features.
 
- ls-refs
-~~~~~~~~~
+ls-refs
+~~~~~~~
 
 `ls-refs` is the command used to request a reference advertisement in v2.
 Unlike the current reference advertisement, ls-refs takes in arguments
@@ -199,8 +199,8 @@ The output of ls-refs is as follows:
     symref = "symref-target:" symref-target
     peeled = "peeled:" obj-id
 
- fetch
-~~~~~~~
+fetch
+~~~~~
 
 `fetch` is the command used to fetch a packfile in v2.  It can be looked
 at as a modified version of the v1 fetch where the ref-advertisement is
@@ -444,8 +444,8 @@ header.
 		2 - progress messages
 		3 - fatal error message just before stream aborts
 
- server-option
-~~~~~~~~~~~~~~~
+server-option
+~~~~~~~~~~~~~
 
 If advertised, indicates that any number of server specific options can be
 included in a request.  This is done by sending each option as a
-- 
2.21.0.539.g07239c3a71.dirty

