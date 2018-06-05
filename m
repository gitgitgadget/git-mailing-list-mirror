Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44941F403
	for <e@80x24.org>; Tue,  5 Jun 2018 18:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752787AbeFESAm (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 14:00:42 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:50560 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752638AbeFERvz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 13:51:55 -0400
Received: by mail-vk0-f74.google.com with SMTP id i205-v6so1190392vke.17
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 10:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=oSEEevHii1sgOEed3DQ0bU8tCQhYQMXsMCHmkHVgqjo=;
        b=KjaFNvI0PrTTx18XUW5/XI9SKnEN+VTchWFubAYpwnY9TD6idBftdSIJJ9aanIt46q
         EhaRQezivzS7ertG0kTd0J/OyQM01Tfns5g9EatBG7hpQ+MWr7FWvDCfH1flTjLdcNcS
         jXpGEav4IwJsfmWKUliKWiRBCyXT0DlFC77mkz2Ovs+W3UYANR9KqpZfLhxspem3cKNP
         GABa+N1mQ7MvSkgdnKcXOxrNw9vgiol2lgS4tBfz53C1vrPA4IQyqBBUCpxh8a9MgLKW
         9i9jLboVhfO55T0LBfMn1/ce6metoOPRMjn7Pu4LobxPOW4kFkqBso0o+IA01YGEJY8O
         UXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=oSEEevHii1sgOEed3DQ0bU8tCQhYQMXsMCHmkHVgqjo=;
        b=oPGXxd07eVOeIIB4NWvQOPcXwG0hHxOZuYUAtqjlsixyqgUKNaBfZkwVgioeKzE0RN
         qIzhPVApCTAfSwh/mxmh7c/cUULDG2MeG/aCxoIUzrhLj/MODpsXEnVaHkIFJlWTfGNz
         tZFzTAFf9H3ftIknvDsPUH1PGcv8pk8VQx7yvMgUZo/iEKyPK4iCEcSylYY8SJNQHuSX
         5IcTk45zVliSpuEU7wYnX+QDBOzCAiUV9cGVdmPLtvGWIIhpykgfCbgGabuYea1tIPMK
         VmtoDGIoTeFskNE3L1oKXWVzYJN2Nk6/Qa6ZCLY/Thu7ylckoHe0aGLPg8/L7n8N+BeT
         7UDw==
X-Gm-Message-State: APt69E2ls3n72LisJHGdJV+KCpOuXU1OqhNGWwu52y0wJOT7HM6b6iCE
        U8VrQDpMNepw0P40N4rSbD4G10m9Ewuxn8A2LY0M4GOU21s+giKFDP84C0axW7/g/5KxXtfWOlt
        BnRiiciAZCK46MPZnlTh49+MuzD1j6+KrK7Ltio9owYlcOl7R3MG6UWSQgg==
X-Google-Smtp-Source: ADUXVKKOtLYerbJ/EBXtGfQGcpMno+9Y5OIW0PiACUvnFqFPK6Vu+c7IbF2OLrTDpQmWy3JkM8wu2u8GLBI=
MIME-Version: 1.0
X-Received: by 2002:a1f:ae0a:: with SMTP id x10-v6mr6040450vke.92.1528221114803;
 Tue, 05 Jun 2018 10:51:54 -0700 (PDT)
Date:   Tue,  5 Jun 2018 10:51:36 -0700
Message-Id: <20180605175144.4225-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
Subject: [PATCH 0/8] ref-in-want
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds the ref-in-want feature which was originally proposed
by Jonathan Tan
(https://public-inbox.org/git/cover.1485381677.git.jonathantanmy@google.com/).

Back when ref-in-want was first discussed it was decided that we should
first solve the issue of moving to a new wire format and find a way to
limit the ref-advertisement before moving forward with ref-in-want.  Now
that protocol version 2 is a reality, and that refs can be filtered on
the server side, we can revisit ref-in-want.

This version of ref-in-want is a bit more restrictive than what Jonathan
originally proposed (only full ref names are allowed instead of globs
and OIDs), but it is meant to accomplish the same goal (solve the issues
of refs changing during negotiation).

Brandon Williams (8):
  test-pkt-line: add unpack-sideband subcommand
  upload-pack: implement ref-in-want
  upload-pack: test negotiation with changing repository
  fetch: refactor the population of peer ref OIDs
  fetch: refactor fetch_refs into two functions
  fetch: refactor to make function args narrower
  fetch-pack: put shallow info in output parameter
  fetch-pack: implement ref-in-want

 Documentation/config.txt                |   4 +
 Documentation/technical/protocol-v2.txt |  28 ++-
 builtin/clone.c                         |   4 +-
 builtin/fetch.c                         | 126 +++++++-----
 fetch-object.c                          |   2 +-
 fetch-pack.c                            |  52 +++--
 remote.c                                |   1 +
 remote.h                                |   1 +
 t/helper/test-pkt-line.c                |  37 ++++
 t/lib-httpd.sh                          |   1 +
 t/lib-httpd/apache.conf                 |   8 +
 t/lib-httpd/one-time-sed.sh             |  16 ++
 t/t5703-upload-pack-ref-in-want.sh      | 245 ++++++++++++++++++++++++
 transport-helper.c                      |   6 +-
 transport-internal.h                    |   9 +-
 transport.c                             |  34 +++-
 transport.h                             |   3 +-
 upload-pack.c                           |  64 +++++++
 18 files changed, 564 insertions(+), 77 deletions(-)
 create mode 100644 t/lib-httpd/one-time-sed.sh
 create mode 100755 t/t5703-upload-pack-ref-in-want.sh

-- 
2.17.1.1185.g55be947832-goog

