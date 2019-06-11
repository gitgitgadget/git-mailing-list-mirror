Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC4341F462
	for <e@80x24.org>; Tue, 11 Jun 2019 23:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408119AbfFKXbl (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 19:31:41 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:36730 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404692AbfFKXbk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 19:31:40 -0400
Received: by mail-yw1-f74.google.com with SMTP id 75so9397793ywb.3
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 16:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=3Sd57SgamfNEeWT1nql3nZ3ZLlJvVEmQ9GL2IPRq6cU=;
        b=anLzVBQWZxubXyH1/vkkL5+HnFvys1ybZbIh63kg7QiM/L/OBYUagkcSz5HYcqZEkW
         V1hziO1v6NxPNarWixjQhlBQUin1RWaOSvtYQQxO0dpmUwTqaDpXtf7pwh4Le9Ukh8eE
         5ir2ybqeH5hhfc33CWoYxLlg9FJKsaya3iiVUlAn7qS1ewuYXcudHCUGFFDGiHx16OKr
         i/VH9t+92cmrXkQch+Yh+fXy11hRblTxph0379nBSycgj7KQ4yORL4deGoq7Y9ECLPnc
         YLGGHka/0ayyJWSGooI+J7keD2tiJJWxn8E4JmPu9RA59scj9Go8yh52rGEZYGxu1RrK
         E5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=3Sd57SgamfNEeWT1nql3nZ3ZLlJvVEmQ9GL2IPRq6cU=;
        b=RKmUf0uqpzqlk+moAmWtv+ePAGhBgvND8hZsDesvizaHxTjeSk1NwZl8nHv22ZR9UQ
         /SEcBISF20dwuNMC6p/0kMKrMuluhqtB3g8Gte0iuXJzk2zHQb6JrbGlZ5Q61HJ1Ltui
         Wwm4g9Z6x0HNpd+xiagFGYO4y9UqsSlMSRsCy3H0POZu4Lg0pFFdMJ5xyoCr1mJ2sZeR
         b5qDtMo4FiaqwUHvbjHRDCWMlV4l5hullHWbpGq+VTzqQoeq1EtxNgzvtebOVCQzo+wJ
         KXmW9h67siEjt5BA1wP5+8ZaihDY2v3BcZ7NTcYxOrKmIa0421vs0KMZHhuKPM7t0n8m
         QiGg==
X-Gm-Message-State: APjAAAWlt0gEzuucDJUoLEE2313ymlKAN09pSt4kA6aOgo4SKP0IUAkz
        fcGN/D2ALg4kJLcW2cV75R4J+grL7qKCQhspAlunpMuYYlVSMXDN32D2sqcoB+c5QAt3vEyJpfy
        aLnyadvXiuQTH7l3/guzAbpA8cliVj2zYmB/1hq6AFWiXepLuSIYkS8mUAQpcRc8=
X-Google-Smtp-Source: APXvYqzB++e1sKOq4lTuKubBR5YlCYepEJq3zIfBWQVW7R9JFZG8w8HCDITS/7AfIcgPnnBoNkg7eY8tHcLmAg==
X-Received: by 2002:a25:ef10:: with SMTP id g16mr37494621ybd.510.1560295899707;
 Tue, 11 Jun 2019 16:31:39 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:31:34 -0700
Message-Id: <cover.1560295286.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH 0/3] Add a JSON Schema for trace2 events
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a proof of concept series that formalizes the structure of trace2 event
output using JSON-Schema [1].

It provides a validator (written in Go) that verifies the events in a given
trace2 event output file match the schema. I am happy to rewrite this validator
in some other language, provided that the language has a JSON-Schema library
supporting at least draft-04.

In the long term, I think it would be useful to add a regression test that
collects the trace2 output of the entire test suite and runs the validator
against that. On my machine, this takes about 15 minutes of run time to validate
the 1.7M events created by a full test run.

If such a regression test is in place, users of the trace2 event output can be
relatively confident that the output format has not changed so long as the
schema file remains the same and the regression test is passing.

[1]: https://json-schema.org/

Josh Steadmon (3):
  trace2: correct trace2 field name documentation
  trace2: Add a JSON schema for trace2 events
  trace2: add a schema validator for trace2 events

 Documentation/technical/api-trace2.txt        |   2 +-
 t/trace_schema_validator/.gitignore           |   1 +
 t/trace_schema_validator/Makefile             |  10 +
 t/trace_schema_validator/event_schema.json    | 398 ++++++++++++++
 t/trace_schema_validator/strict_schema.json   | 511 ++++++++++++++++++
 .../trace_schema_validator.go                 |  74 +++
 6 files changed, 995 insertions(+), 1 deletion(-)
 create mode 100644 t/trace_schema_validator/.gitignore
 create mode 100644 t/trace_schema_validator/Makefile
 create mode 100644 t/trace_schema_validator/event_schema.json
 create mode 100644 t/trace_schema_validator/strict_schema.json
 create mode 100644 t/trace_schema_validator/trace_schema_validator.go

-- 
2.22.0.410.gd8fdbe21b5-goog

