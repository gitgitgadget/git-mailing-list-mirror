Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2317211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 22:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfAKWSh (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 17:18:37 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:37576 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfAKWSh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 17:18:37 -0500
Received: by mail-qk1-f202.google.com with SMTP id s70so10759219qks.4
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 14:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PFZEHB+muEO+8mxCmTEv0Yi9B4qadPlwBrd5jAe+qxs=;
        b=QQtsE5895VgGZy1HI+xotR/Bi6KdmmSskh5BpT0N5VAGpDs9cGG6hkj/B9PO2I9YaW
         vTKmBxfXw5ApinmVNHL2E7pAINAuSGy9hIvNuZxcuaP30iWlNB6jpKqtmWeRPg6girqb
         cYfWimW5DVL2LBJnvIlFpIT7F4/fxarFSJ7XmUNxO0SyjzkVb2W39EC2oCzqAw3RnM7r
         RyfIDpKgV4BJcchbwkEQt98UOhSviUwOwUhPkbGIlHOj0qChFMaSMq6ksH2lX0cuz7Ax
         sZzpdUvtiUwQezPSlbGLu5nak9jsKXsH9h+fyIbgcsyvma4uHfDFVT2fR2mzEkl5thQG
         bRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PFZEHB+muEO+8mxCmTEv0Yi9B4qadPlwBrd5jAe+qxs=;
        b=X+KCzHSHr/66h1q+uWIeeRY1t2FSh7ka8XXcrcmYHAM0LAsp5lC2ogWG3JsvsFfB+W
         pr3n83i2MKmLePMGShJ0kCi9BBPcAMZ0cJuNw7gkYOVpKfVOCd+6+NkldDBX0jS+AWVl
         Qv5s3B+SkVopDcRbQD5TT7353qDzamXFdTFWp+vsK2U65UJ1ZczgfnSWbaA4RHZaF3MG
         2KyYJ2+8of1szKa6pbGSJ830j/sjb2JF8ggXxOgmkheHOD3MkEsfzrD+SokwnOq5gdFt
         rdUQfyHyxaGSQcNpReP0oj9wsbuZA8IrhwmAeEBt7IkfjZjpmHYWPMavWtjibcOwCzwq
         ioeg==
X-Gm-Message-State: AJcUukemVKN2Zr7cuo+HEGIe/bwNaqjc4S7OQkvGd3QaWAVF6A8sYB5U
        UzGly0NW896vz1euUqtrDotnKo7jPaojP4y5WEu5f+s8prthdP5+gbcPzdH459bSjOupc6xiwid
        Ht1yE8xOZEMdU80aYLGNEVgZcSreZ1pyq31rU4/sl96gpWaonBR7yLav8GrnybC10XoaWJKsv/e
        Xh
X-Google-Smtp-Source: ALg8bN47ghciDQj0ctespL/Yzw4y4Jf3tRYc4QtTHjy5wBmnxvIpGMJw8Er5CeiTGKTT4b4HturIbZrG0es+Z+EZPExB
X-Received: by 2002:a37:11c1:: with SMTP id 62mr1519310qkr.54.1547245116363;
 Fri, 11 Jan 2019 14:18:36 -0800 (PST)
Date:   Fri, 11 Jan 2019 14:18:13 -0800
Message-Id: <cover.1547244620.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 0/4] Sideband the whole fetch v2 response
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is on ms/packet-err-check.

This is a follow-up of my earlier work to allow partial CDN offloading
of fetch v2 response packfiles, which had the issue of having to buffer
(or suspend) progress and keepalive messages because we didn't have
sideband until the packfile section started (as I wrote here [1]). These
patches expand the sideband to the whole response, eliminating that
problem.

There are 8 patches total. I'm most interested in review of the first 4
patches for inclusion into Git - I think it would be useful for servers
to be allowed to send progress messages and other notices whenever they
need to, especially if other sections are added to the response (like in
the case of CDN offloading).

The other 4 patches are from my CDN offloading work, included here to
show how this sideband-all feature could be used. But take note that
they are all WIP and that I still haven't incorporated some of the
design considerations from the earlier review [2].

[1] https://public-inbox.org/git/20181206232538.141378-1-jonathantanmy@google.com/
[2] https://public-inbox.org/git/cover.1543879256.git.jonathantanmy@google.com/

Jonathan Tan (8):
  pkt-line: introduce struct packet_writer
  sideband: reverse its dependency on pkt-line
  {fetch,upload}-pack: sideband v2 fetch response
  tests: define GIT_TEST_SIDEBAND_ALL
  Documentation: order protocol v2 sections
  Documentation: add Packfile URIs design doc
  upload-pack: refactor reading of pack-objects out
  upload-pack: send part of packfile response as uri

 Documentation/technical/packfile-uri.txt |  83 ++++++++
 Documentation/technical/protocol-v2.txt  |  32 ++-
 builtin/pack-objects.c                   |  48 +++++
 fetch-pack.c                             |  22 +-
 pkt-line.c                               | 114 ++++++++--
 pkt-line.h                               |  34 +++
 sideband.c                               | 161 +++++++-------
 sideband.h                               |  15 +-
 t/README                                 |   5 +
 t/lib-httpd/apache.conf                  |   1 +
 t/t5537-fetch-shallow.sh                 |   3 +-
 t/t5701-git-serve.sh                     |   2 +-
 t/t5702-protocol-v2.sh                   |  31 ++-
 upload-pack.c                            | 259 +++++++++++++++--------
 14 files changed, 607 insertions(+), 203 deletions(-)
 create mode 100644 Documentation/technical/packfile-uri.txt

-- 
2.19.0.271.gfe8321ec05.dirty

