Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF3D920954
	for <e@80x24.org>; Mon,  4 Dec 2017 23:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751428AbdLDX7H (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 18:59:07 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:41693 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdLDX7G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 18:59:06 -0500
Received: by mail-pf0-f175.google.com with SMTP id j28so9796642pfk.8
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 15:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tU0PgHx4bQphcyoaGFVHJWfdFqd4T44rKtIGp0Ur6oA=;
        b=QjTAWq9o7/vxRHszIUbEt8hXK97Z36HADpwydFoNtPs4dyH2LrElIMOsWiGRndSn65
         3yHLZT3ZvduPf/D3GOEfFFLcz9/KcNKr/VpIGGH/u+J7KT8ucI2toSvWchNBwa3412r9
         NmmNsbDOyq23dOZzR37Cgzp/NlaGMZic5Mt0jdkxTHXHtOKrs5P/uN0fTcBcOmgnvits
         3UDESUtGaOhZel1FFCR2exN92n1XLir9rAbE3Wv8sGyZe7v81zpSshh/01PVO5sEH4pm
         694Y3/bEGnNUAocc3TJtWma6d/DYdF7O+wzWKSCxr8+r2WnF0TlQRhe3B2LCMvlGwVx0
         ezKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tU0PgHx4bQphcyoaGFVHJWfdFqd4T44rKtIGp0Ur6oA=;
        b=Tkmm1YWg1co7JGt5BvJbY+nsSQbViNm3VyLBi8YOKfspxN3CbdmzR/XHcumgR5qRn9
         pCZfCRQUKoi85Qc92ISKWcJaMSifvWYihY7m6AAvNYuzsIfdFPpcmgip05WVLmHQn4Nf
         1RgT4a6kzlT5ert4HPAh0OCh6VgPUKIBKclJ0luNZHWtNnZ8zJIXD+H321Rt5g9AV/7+
         17D+hj6cdu0WxjqJuKBp3NO65/m8+9/lvNddJaYUK02lLaCxd7usY6yk7EtAEyrwCJW7
         3JDEz0zmE4eGw7xRVLRRRJNm750oLzW4oP08Z6RoYE9ew5dguqzih4zR630LKhpBU93y
         96vw==
X-Gm-Message-State: AJaThX6sdTGHClj9Pco33yl5Diqem+66OrwwKTqNZHCGk2Umu9+F/XFT
        pADzEQOZ+sjaSIeGmNhTMN0i2t/gEqk=
X-Google-Smtp-Source: AGs4zMYyug4o/2pY0GtIvfIxoouQygp+K8zZTY2qcfouxBWXKfx8HjMp4OfYhuo7Q1Rp1MXifjFE0g==
X-Received: by 10.101.76.65 with SMTP id l1mr15693923pgr.323.1512431945201;
        Mon, 04 Dec 2017 15:59:05 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id b187sm24939223pfg.109.2017.12.04.15.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 15:59:04 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [WIP 00/15] protocol version 2
Date:   Mon,  4 Dec 2017 15:58:08 -0800
Message-Id: <20171204235823.63299-1-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081-goog
In-Reply-To: <20171020171839.4188-1-bmwill@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A while back I sent out a rough outline for what a protocol version 2 would
look like at
https://public-inbox.org/git/20171020171839.4188-1-bmwill@google.com/.  After
hacking at both the server and client code I've managed to get some patches for
protocol version 2 which implement listing refs and cloning/fetching working.
I still need to get the push side of things working before this would be viable
to accept and apply but I figured this was in a good enough state to start
getting some early feedback on the concept.  I'm hoping that some comments and
other pairs of eyes can help me identify deficiencies earlier rather than
later.

As a whole, fetch works fairly similar to the way it works in v1 except I
removed the support for shallow clients for the time being in order to make it
easier to implement at first.  I haven't decided if it makes more sense to have
the deepening as a separate server command or to keep it in fetch like it is in
v1, just something to think about.

Any comments or criticism is welcome. Thanks!

Brandon Williams (15):
  pkt-line: introduce packet_read_with_status
  pkt-line: introduce struct packet_reader
  pkt-line: add delim packet support
  upload-pack: convert to a builtin
  upload-pack: factor out processing lines
  transport: use get_refs_via_connect to get refs
  connect: convert get_remote_heads to use struct packet_reader
  connect: discover protocol version outside of get_remote_heads
  transport: store protocol version
  protocol: introduce enum protocol_version value protocol_v2
  serve: introduce git-serve
  ls-refs: introduce ls-refs server command
  connect: request remote refs using v2
  upload_pack: introduce fetch server command
  fetch-pack: perform a fetch using v2

 .gitignore             |   1 +
 Makefile               |   6 +-
 builtin.h              |   2 +
 builtin/fetch-pack.c   |  19 ++-
 builtin/receive-pack.c |   3 +
 builtin/send-pack.c    |  18 ++-
 builtin/serve.c        |  25 ++++
 connect.c              | 210 +++++++++++++++++++++---------
 connect.h              |   3 +
 fetch-pack.c           | 237 +++++++++++++++++++++++++++++++++-
 fetch-pack.h           |   4 +-
 git.c                  |   2 +
 ls-refs.c              |  96 ++++++++++++++
 ls-refs.h              |   9 ++
 pkt-line.c             | 133 +++++++++++++++++--
 pkt-line.h             |  31 +++++
 protocol.c             |   2 +
 protocol.h             |   1 +
 remote-curl.c          |  21 ++-
 remote.h               |   7 +-
 serve.c                | 195 ++++++++++++++++++++++++++++
 serve.h                |   6 +
 t/t5701-protocol-v2.sh |  54 ++++++++
 transport.c            |  84 ++++++++----
 upload-pack.c          | 342 +++++++++++++++++++++++++++++++++++++++++++------
 upload-pack.h          |   9 ++
 26 files changed, 1371 insertions(+), 149 deletions(-)
 create mode 100644 builtin/serve.c
 create mode 100644 ls-refs.c
 create mode 100644 ls-refs.h
 create mode 100644 serve.c
 create mode 100644 serve.h
 create mode 100755 t/t5701-protocol-v2.sh
 create mode 100644 upload-pack.h

-- 
2.15.1.424.g9478a66081-goog

