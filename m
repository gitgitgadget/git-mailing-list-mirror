Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15CD520D11
	for <e@80x24.org>; Tue, 20 Jun 2017 07:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbdFTH43 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:29 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34423 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752130AbdFTH41 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:27 -0400
Received: by mail-wr0-f194.google.com with SMTP id y25so14133016wrd.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6qFoUhq/8WU8tLhnjZ3k3z21QyGKplggE5Y5QdI3iLc=;
        b=TBu0wYGtrDIKnZXZcEIO29jiUjTcUur1lpgsnFLv0Ast15b58W6yY1lJu7hAwMi6IH
         E/aZk9aPnKk2kXT90Mse+rsDuWROZAIp3zdsLozoYSruqKdIoY41CkR+0fh4/NVKAqj/
         EboMfMA71mr71tRoGtsZ9YIQgbnueomlo/xU3Y7pXqdoV2Gi/tYN1a7hdaPK2lF10xIm
         L4I4XoTF9E4Xj5+418Luf5xWSliQwGbqgsbFKGEonez4LgGIyi7DDfADzn8SUQNsbnP4
         fORHP8kp2qfLxOlVQq+35ly6y7F7kMc/GP1YhSE5btDxinQboaLiiyOmh94KfRFkJVuH
         DEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6qFoUhq/8WU8tLhnjZ3k3z21QyGKplggE5Y5QdI3iLc=;
        b=oBbHKaiWRdX8VuBDeycBARQCEApl/+yzjIkxpKPDG6wxUo3EUgtvNwSUWTa6kQDbtN
         uUvm5Oe+BYSr0ihlBZEOUaZuHTT8h9MaPADZS2e9aDcbyAtn/HYrnp7+AZsJr3oE4jsB
         ppjNPK+oqtT8nxnncnhRTFbOpSEPrg+utS6dtaL1TGWxgio++PEa5NSBCsPfa4DaW0Kj
         Uimt4MSsH1C/KChRZy8XOixos5BhYHiOUsOKu42vc+gKyopsEagVa01+TM6XG480RT36
         NkftIxNHSqcl5qBynasBBtZVfYCqfe1HKhJLrI4BZk/8XfTxRlbHFS53s5+O6wJYsKut
         DmuA==
X-Gm-Message-State: AKS2vOxvhAQwWdLSSKxq/AOBj7zCLi+HHDx+pAUnIroaFI2OHLX9y20m
        GhGs+WY5xbiE4C+M
X-Received: by 10.223.182.136 with SMTP id j8mr11580753wre.122.1497945384687;
        Tue, 20 Jun 2017 00:56:24 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:24 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ben Peart <benpeart@microsoft.com>
Subject: [RFC/PATCH v4 27/49] Documentation: add read-object-protocol.txt
Date:   Tue, 20 Jun 2017 09:55:01 +0200
Message-Id: <20170620075523.26961-28-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Signed-off-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/technical/read-object-protocol.txt | 102 +++++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 Documentation/technical/read-object-protocol.txt

diff --git a/Documentation/technical/read-object-protocol.txt b/Documentation/technical/read-object-protocol.txt
new file mode 100644
index 0000000000..a893b46e7c
--- /dev/null
+++ b/Documentation/technical/read-object-protocol.txt
@@ -0,0 +1,102 @@
+Read Object Process
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The read-object process enables Git to read all missing blobs with a
+single process invocation for the entire life of a single Git command.
+This is achieved by using a packet format (pkt-line, see technical/
+protocol-common.txt) based protocol over standard input and standard
+output as follows. All packets, except for the "*CONTENT" packets and
+the "0000" flush packet, are considered text and therefore are
+terminated by a LF.
+
+Git starts the process when it encounters the first missing object that
+needs to be retrieved. After the process is started, Git sends a welcome
+message ("git-read-object-client"), a list of supported protocol version
+numbers, and a flush packet. Git expects to read a welcome response
+message ("git-read-object-server"), exactly one protocol version number
+from the previously sent list, and a flush packet. All further
+communication will be based on the selected version.
+
+The remaining protocol description below documents "version=1". Please
+note that "version=42" in the example below does not exist and is only
+there to illustrate how the protocol would look with more than one
+version.
+
+After the version negotiation Git sends a list of all capabilities that
+it supports and a flush packet. Git expects to read a list of desired
+capabilities, which must be a subset of the supported capabilities list,
+and a flush packet as response:
+------------------------
+packet: git> git-read-object-client
+packet: git> version=1
+packet: git> version=42
+packet: git> 0000
+packet: git< git-read-object-server
+packet: git< version=1
+packet: git< 0000
+packet: git> capability=get
+packet: git> capability=have
+packet: git> capability=put
+packet: git> capability=not-yet-invented
+packet: git> 0000
+packet: git< capability=get
+packet: git< 0000
+------------------------
+The only supported capability in version 1 is "get".
+
+Afterwards Git sends a list of "key=value" pairs terminated with a flush
+packet. The list will contain at least the command (based on the
+supported capabilities) and the sha1 of the object to retrieve. Please
+note, that the process must not send any response before it received the
+final flush packet.
+
+When the process receives the "get" command, it should make the requested
+object available in the git object store and then return success. Git will
+then check the object store again and this time find it and proceed.
+------------------------
+packet: git> command=get
+packet: git> sha1=0a214a649e1b3d5011e14a3dc227753f2bd2be05
+packet: git> 0000
+------------------------
+
+The process is expected to respond with a list of "key=value" pairs
+terminated with a flush packet. If the process does not experience
+problems then the list must contain a "success" status.
+------------------------
+packet: git< status=success
+packet: git< 0000
+------------------------
+
+In case the process cannot or does not want to process the content, it
+is expected to respond with an "error" status.
+------------------------
+packet: git< status=error
+packet: git< 0000
+------------------------
+
+In case the process cannot or does not want to process the content as
+well as any future content for the lifetime of the Git process, then it
+is expected to respond with an "abort" status at any point in the
+protocol.
+------------------------
+packet: git< status=abort
+packet: git< 0000
+------------------------
+
+Git neither stops nor restarts the process in case the "error"/"abort"
+status is set.
+
+If the process dies during the communication or does not adhere to the
+protocol then Git will stop the process and restart it with the next
+object that needs to be processed.
+
+After the read-object process has processed an object it is expected to
+wait for the next "key=value" list containing a command. Git will close
+the command pipe on exit. The process is expected to detect EOF and exit
+gracefully on its own. Git will wait until the process has stopped.
+
+A long running read-object process demo implementation can be found in
+`contrib/long-running-read-object/example.pl` located in the Git core
+repository. If you develop your own long running process then the
+`GIT_TRACE_PACKET` environment variables can be very helpful for
+debugging (see linkgit:git[1]).
-- 
2.13.1.565.gbfcd7a9048

