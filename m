Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD66F2018B
	for <e@80x24.org>; Fri, 29 Jul 2016 23:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbcG2XiJ (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 19:38:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32918 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbcG2XiG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 19:38:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id o80so17700732wme.0
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 16:38:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l9Hzq3cUYTtlGHpO1qifUPBDMuYxUgKkAmMoEiF8rKs=;
        b=Jc/l14v/OF/Aev+q7ERsVkB+u+fpZEk+eKpuhzekpPWO90YmFhIRuPih8XmomLi3nK
         AZ8sDepscN9zjB/ar3qcD3xiL/WWlrmeaOBP2Zw6wFwDQ6kZSgzOYBqKMR9Y75bvnb+Z
         mrLSRifOzPYuuBQJB8yzmHb1nbWTEZ+L81/NTAwODh4TLd+6Pp41yhDuzweG4IUIjICT
         0aZPLjTTXZDzoEgw/Rn8Hcu3g6fYoTgq0UjYhqyymBECT9X18b7PTmFT0JUf50BbuyK6
         D12Wvtx0gGy+RzfausV1auPPmu7Rijrh4C/YaHiO2x7UmzXEtdcdmdFSNhrc9QapvQUM
         GYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l9Hzq3cUYTtlGHpO1qifUPBDMuYxUgKkAmMoEiF8rKs=;
        b=gUcDZKXYXWjCmXGw5GpCxUQcWqIZGz+RCAAqN5fP/PNx7emMgNLh9WPhPvHGiqV0Vk
         22o2f0f/i7If8OYQyLYms2XftVu11b+l7VvsZ3uUC79n+W/NuUrOj9fzePQ1fyrM2pVe
         OLZjse+RGIME1/c6Ii1vuCGI0cVcgUVi/sPN+Oskd5JX86rxH2plqQFbO7Gx3TEw7MtG
         evhbWoAW4DpI5hjlEi4XGaYpLxO+LmDSGyEL+m4KdKFOUY3v2kIVUfKXLN2i0vM8zIb3
         lrElH/4O/zsul3spWfDSHOb1yN7b0B8zVUPpuHABNHML7sDeWi3HhmSfJ9o+uCCyVki+
         yuXA==
X-Gm-Message-State: AEkoouvlVZhw/2lG8It3Ls87YdRjeERImcyWVFIV8EZi+UmmVM9fEFA4C7Eqvsuia+rwQw==
X-Received: by 10.28.111.4 with SMTP id k4mr49052445wmc.94.1469835484425;
        Fri, 29 Jul 2016 16:38:04 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB4145.dip0.t-ipconnect.de. [93.219.65.69])
        by smtp.gmail.com with ESMTPSA id i1sm18663212wjl.9.2016.07.29.16.38.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 16:38:03 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v3 00/10] Git filter protocol
Date:	Sat, 30 Jul 2016 01:37:51 +0200
Message-Id: <20160729233801.82844-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160727000605.49982-1-larsxschneider%40gmail.com/>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

thanks a lot to Jakub, Peff, Torsten, Eric, and Junio for comments
and reviews.

Here is what has changed since v2:

* replace `/dev/urandom` with `test-genrandom` (Torsten, Peff)
* improve commit message "Git filter driver command with spaces" (Jakub)
* use proper types for memory and disk (Peff)
* create packet read buffer with overflow check (Peff)
* change capabilities format: "capabilities clean smudge" (Jakub)
* replace "%zu" (Eric)
* remove &= error handling (Eric, Peff)
* initialize *argv[] with  { cmd, NULL } (Jakub)
* reorder multi_packet_read() parameters to match read(2) (Eric)
* do not continue if fstat fails (Eric)
* filter: add reject response
* add functions to pkt-line.h/c that: (Jakub, Peff)
    - can write a packet without creating a new buffer
    - do not die in case of a failure
* add function to pkt-line.h/c that writes a pkt-line flush and does not die on error
* add filter stream capability
* add filter shutdown capability
* docs: fix LARGE_PACKET_MAX documentaion
    see http://public-inbox.org/git/20160726134257.GB19277%40sigill.intra.peff.net/
* docs: fix s/seperated/separated/ (Jakub)
* docs: "mis-configured one-shot filters would hang" (Jakub)
* docs: filter protocol filename absolute (Jakub)
* docs: state that Git can use more than one packet (Jabub)
* docs: add "\n" to lines (Jakub)
* docs: filter precedence (Jakub)

Cheers,
Lars

PS: If you prefer checkout the code from a Git repo instead then you can find
it here: https://github.com/larsxschneider/git/tree/protocol-filter/v3


Lars Schneider (10):
  pkt-line: extract set_packet_header()
  pkt-line: add direct_packet_write() and direct_packet_write_data()
  pkt-line: add packet_flush_gentle()
  pkt-line: call packet_trace() only if a packet is actually send
  pack-protocol: fix maximum pkt-line size
  run-command: add clean_on_exit_handler
  convert: quote filter names in error messages
  convert: modernize tests
  convert: generate large test files only once
  convert: add filter.<driver>.process option

 Documentation/gitattributes.txt             |  84 ++++-
 Documentation/technical/protocol-common.txt |   6 +-
 convert.c                                   | 412 +++++++++++++++++++++-
 pkt-line.c                                  |  53 ++-
 pkt-line.h                                  |   6 +
 run-command.c                               |  12 +-
 run-command.h                               |   1 +
 t/t0021-conversion.sh                       | 515 +++++++++++++++++++++++++---
 t/t0021/rot13-filter.pl                     | 177 ++++++++++
 9 files changed, 1193 insertions(+), 73 deletions(-)
 create mode 100755 t/t0021/rot13-filter.pl

--
2.9.0

