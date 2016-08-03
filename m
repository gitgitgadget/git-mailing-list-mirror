Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28C332022A
	for <e@80x24.org>; Wed,  3 Aug 2016 16:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758002AbcHCQme (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:42:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32942 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757988AbcHCQm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:42:29 -0400
Received: by mail-wm0-f67.google.com with SMTP id o80so37173794wme.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 09:42:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nwoMufyt+rPvAO08+gSf3R7zbewVvS4vEgqqQv0A8SU=;
        b=VkzC4tylGP6zx+Bvx8yCwM1Qehl+VJcol0hjYd7QYYBYBV7KIlZU0SVAa77gz3gRhl
         EjFNnjxhDcmxYlz/UPjRBERrUD5jNr/t8q2s7hgxgZTk8Aulphok6u5Et2JBnJF45Cxa
         rvDY6JiJnB7DZLyIvzIbh92z5h0KJWFhjGdYTBAEf1ruiUiZ2W+6IYOY7y6h2eyK7dpN
         usmO1H4vwuXtbnlWKYqGc9LKrTCtfrc4gbc9rDTrKDTqSnGDahP4SUaSexX1B5iA60Sb
         py0+3cGM1kLENs2B+vAozJkXv1PaS2C7apCTrgQp5JdskVhZ9Aj6bQX+JXYO0jYs6i4o
         MBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nwoMufyt+rPvAO08+gSf3R7zbewVvS4vEgqqQv0A8SU=;
        b=ONONNKC3MPeYKmXZSf3XiwcT19ptyLBQ9jmqtwtTdd9HbNUoV6+h7x6W5gKMv8I8dM
         8HVAj75q81RNnvqsrVI/R97jlR3S8tyLoc9fSzcey46Rpm+zsdurabRrnI8DW4njJ+oE
         +rSckdxaXYqO0Svtv9yUbXz/tsz9Soqwx58y5kC8Qiiq3oTcak4z12z7uqC3ORPe0he5
         NFoisETlOsoiyMK7mtOQrxJtxqqRh92BbKej9vO1gXsIHFqGso0iK99wyGWJER9KPIIi
         1X5/Z23uXFgl93fub+P8Dmw9EelZ8i6Pop9jnBpwIdUBqs3RZvdWjNYtaj6rA3dPFq0Q
         Gcgg==
X-Gm-Message-State: AEkoousQpMUL9XydDTkH/9tYCRKiJfdGXGR6mNNGpq0fn9t/g4YNP5No8ZR3obDiAKnWeQ==
X-Received: by 10.194.115.4 with SMTP id jk4mr68870650wjb.109.1470242547520;
        Wed, 03 Aug 2016 09:42:27 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 3sm8959736wms.1.2016.08.03.09.42.26
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 09:42:26 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v4 00/12] Git filter protocol
Date:	Wed,  3 Aug 2016 18:42:13 +0200
Message-Id: <20160803164225.46355-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160729233801.82844-1-larsxschneider@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

thanks a lot for the very helpful reviews!

Patch 1-10 are preparation. Patch 11 and 12 the real feature.

Diff to v3:
* simplify protocol, remove size information
* run clean_on_exit_handler() only on SIGTERM (Hannes)
* move hex() macro inside set_packet_header(), undef it after use (Jakub)
* rename buf to data in direct_packet_write_data() (Jakub)
* add benchmark summary (Jakub)
* add empty file test case (Jakub)
* rename multi_packet_read() to packet_read_till_flush()
* expect a flush packet even after 0 content
* move packet stream helper functions to pkt-line.c/h (Jakub)
* add GIT_PACKET_TRACE hint to docs
* remove SIGPIPE ignore (Jakub)
* change to goto error handling style (Jakub)
* cleanup test cases with helper functions (Jakub)
* move shutdown implementation to dedicated patch

Thanks,
Lars


Lars Schneider (12):
  pkt-line: extract set_packet_header()
  pkt-line: add direct_packet_write() and direct_packet_write_data()
  pkt-line: add packet_flush_gentle()
  pkt-line: call packet_trace() only if a packet is actually send
  pkt-line: add functions to read/write flush terminated packet streams
  pack-protocol: fix maximum pkt-line size
  run-command: add clean_on_exit_handler
  convert: quote filter names in error messages
  convert: modernize tests
  convert: generate large test files only once
  convert: add filter.<driver>.process option
  convert: add filter.<driver>.process shutdown command option

 Documentation/gitattributes.txt             | 108 +++++-
 Documentation/technical/protocol-common.txt |   6 +-
 convert.c                                   | 324 ++++++++++++++++--
 pkt-line.c                                  | 156 ++++++++-
 pkt-line.h                                  |  13 +
 run-command.c                               |  12 +-
 run-command.h                               |   1 +
 t/t0021-conversion.sh                       | 503 +++++++++++++++++++++++++---
 t/t0021/rot13-filter.pl                     | 155 +++++++++
 9 files changed, 1187 insertions(+), 91 deletions(-)
 create mode 100755 t/t0021/rot13-filter.pl

--
2.9.0

