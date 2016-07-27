Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4C65203EF
	for <e@80x24.org>; Wed, 27 Jul 2016 00:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757648AbcG0AGL (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 20:06:11 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34819 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045AbcG0AGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 20:06:09 -0400
Received: by mail-wm0-f41.google.com with SMTP id f65so192644597wmi.0
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 17:06:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QxfrgGSH5udJ5Mr345Q0kYxxpuZzVQdH7vqJ+TVNHXE=;
        b=Eq/RNn/ia0uJQNc3SCOVnmTIkFjbMQBRx0gsAFuGdbrl0irw0nMokNPC6sk109c8Zv
         nPsXQK92dF4JzUeFE2g3CMfh0wWX5ArbWAsXSDnfALOo+/yOP03TQ+AurPFgkomH6JY3
         Udxv2dhgnGYHacT9mEZNu2TnKf74hsCFgLiNFR10qrbSNtQoVNejMCigZSy5RMSpDGPy
         auAdazxbpxLq0K98ZTGJ819QYPiH2fmq7FfWKvAHH5OWZZSFMTm3NENkmG0GymQ983kV
         JjkiVrLtdXksWGnFIXkihuVtB+wQnzjGD1Eyn195suOsxM5Rf47bdX8xtUawvbYo719x
         7LSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QxfrgGSH5udJ5Mr345Q0kYxxpuZzVQdH7vqJ+TVNHXE=;
        b=c4jDh2Z5EVmgyGexZw5KE9Hz2IcgfqKzAxsxtI03x28fCR3o5fAaZfWaGNQkYABvFk
         Omthi+TbLo8p1NwOykjYEPY5HThXUpl3fykQZY++ozicFCS61l8zVpErIpyHt6wxPRs9
         7glOshre/Df/VKxzdYfOFXgPrNGqJgNmmozCPtMpUQLTc9egDkkwLh9M+WZQ9DFSuu5G
         7Ad5XEOx5z2yE/cy49/WC7gIb80jOYNACcsGsm77JUMHxOr+RYY3l7G53lPQxPXLFB8B
         xsQ1gNkDaB6DSvM33X+05GZYXc5Bb2tWq2BOXatH50rrvRTjiT9mxggvmUx54uAn6Qji
         5Uiw==
X-Gm-Message-State: ALyK8tJiCPCqDXz53gawC75Yr7SCW/armpGC2U4G2FwHAgRgFWASRT8hVRZ3HUuZkLnsLA==
X-Received: by 10.28.226.85 with SMTP id z82mr51613198wmg.101.1469577968095;
        Tue, 26 Jul 2016 17:06:08 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB772A.dip0.t-ipconnect.de. [93.219.119.42])
        by smtp.gmail.com with ESMTPSA id q137sm35330015wmd.19.2016.07.26.17.06.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jul 2016 17:06:07 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, remi.galan-alfonso@ensimag.grenoble-inp.fr,
	pclouds@gmail.com, e@80x24.org, ramsay@ramsayjones.plus.com,
	peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v2 0/5] Git filter protocol
Date:	Wed, 27 Jul 2016 02:06:00 +0200
Message-Id: <20160727000605.49982-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160722154900.19477-1-larsxschneider@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

thanks a lot for the extensive reviews. I tried to address all mentioned
concerns and summarized them below. The most prominent changes since v1 are
the following:
* pipe communication uses a packet format (pkt-line) based protocol
* a long running filter application is defined with "filter.<driver>.process"
* Git offers a number of filter capabilties that a filter can request
  (right now only "smudge" and "clean" - in the future maybe "cleanFromFile",
  "smudgeToFile", and/or "stream")

Cheers,
Lars


## Torsten:
* add "\n" line terminator after version in init sequence
* prepare big file for EXPENSIVE tests once
* set "#!/usr/bin/perl" as shebang for rot13.pl to mimic other Perl test scripts
* add test_have_prereq PERL to t0021

## Ramsay:
* use write_in_full(process->in, nbuf.buf, nbuf.len) to avoid unneccsary strlen call
* use read_in_full to read data that exceeds MAX_IO_SIZE properly
* fix test case to check for large file filtering

## Jakub:
* use standard input/standard output instead of stdin/stdout
* replace global variable "cmd_process_map" with a function parameter where possible
* avoid "strbuf_reset" after STRBUF_INIT
* align test_config_global
* rename rot13.pl to rot13-filter.pl
* make Perl style consistent
* describe hard coded filenames in test filter header
* improve docs
* add filter capabilities field (enables cleanToFile, smudgeFromFile, and/or stream later)
* explain that content size in bytes is encoded in ASCII
* consistent line ending for die call in Perl (without "\n")
* make rot13 test filter die in case of failure (instead of returning "fail")

## Eric:
* flush explicitly in Perl test filter
* do not initialize variables to NULL if they are set unconditionally
* fix no-op stop_protocol_filter
* use off_t instead of size_t
* improve test filter int parsing ($filelen =~ /\A\d+\z/ or die "bad filelen: $filelen")

## Peff:
* use pkt-line protocol
* do not use Perl autodie

## Remi:
* remove spaces after '<'



Lars Schneider (5):
  convert: quote filter names in error messages
  convert: modernize tests
  pkt-line: extract and use `set_packet_header` function
  convert: generate large test files only once
  convert: add filter.<driver>.process option

 Documentation/gitattributes.txt |  54 +++++++-
 convert.c                       | 281 +++++++++++++++++++++++++++++++++++++---
 pkt-line.c                      |  15 ++-
 pkt-line.h                      |   1 +
 t/t0021-conversion.sh           | 272 ++++++++++++++++++++++++++++++++------
 t/t0021/rot13-filter.pl         | 146 +++++++++++++++++++++
 6 files changed, 704 insertions(+), 65 deletions(-)
 create mode 100755 t/t0021/rot13-filter.pl

--
2.9.0

