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
	by dcvr.yhbt.net (Postfix) with ESMTP id BC34E1F461
	for <e@80x24.org>; Tue,  9 Jul 2019 23:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfGIXFu (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 19:05:50 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:56278 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGIXFu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 19:05:50 -0400
Received: by mail-pf1-f201.google.com with SMTP id i26so120351pfo.22
        for <git@vger.kernel.org>; Tue, 09 Jul 2019 16:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=k76/qtm7lVKpYT6rAPJ0brDd7UskpNRgUyPj12it9Ck=;
        b=SkoLPqJdk56x9aBIqNNAxiPf1GNSbjORItwaY5VCn2YCN/d7DWpQfoWLctYX6L9QuQ
         KqlOaLKyxeytXJxidEby7cg3V5ReTA5v5uTcBt8pFmK0BU1ioDcFeffDz+msmRATbdtG
         4CKI1+MfMTgD0u2dVHROkz9a9kObUwdwudWrzh4TMUWNQxRYRon3vVtYCDx9YnSOT7EL
         agRH08b5Iv179vSAr/HPvzukWMw6iz2CvcikM1iljdhBXnXr6H98pfx0G5CoWCrm+iS/
         HWjpEvbfXRHzxUB83NsIcqY/Wpedig9yxOGsxSTvLGcn5nU1i0PJGcPDugTVWQ7mxD1h
         hAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=k76/qtm7lVKpYT6rAPJ0brDd7UskpNRgUyPj12it9Ck=;
        b=LoNfyhUXQcHVfODJUQgukGCJaqM6E1/7C83rc2SaQLgwCkVKmw/7bsFgP0QCuasgLy
         da1moTTijfcnoys6lV8PxGyhAa4iiMSklWsCjZoYrnLtVduyl7amZQnaZZspzrHhLV/r
         CLD1vO6/pgmxYF+ykPG+BPIm/7Sp1nbERRmW+IPY8acgiBaXfHqB6JDtLrl7YbyXo0DO
         NWXaA7mLaqZx3ilaxjtrHJd50I2hDa6WHIqhDsuhk9rs5AwYj17gq3ldr3R8YzMA/X/L
         Nvs25VmqJV+/D6ql7pbLC8+k64KxEbq5E0+4JdirhYrk83huxKGiurkU7DCuOZq1XWPY
         YHWg==
X-Gm-Message-State: APjAAAU7S7pkZhHESZJnso1C2wFxsqd7LeCMtyWm2pdmYzA5HaUmu2MK
        hvzrObivMH+dSs7DnNfCkQ84he8Vvts6f8FJp2HA0XlYZXE4c2ehCoOMB3JAgGSj9NenKP681+l
        Evlw2RL2Q21o78eKUP0rAv1k3eXm+0DcR1r3LnrBD1GNNQM4Pg9RrOWeKaV+pFTY=
X-Google-Smtp-Source: APXvYqz8JkgZyLiL8XGQWYko6/a3HoTYhLsaO9ThkWeakqxR2RwryNRMN2gPpOnuZONs463hH8WDGz+3qYWIvQ==
X-Received: by 2002:a63:381d:: with SMTP id f29mr13517878pga.101.1562713548786;
 Tue, 09 Jul 2019 16:05:48 -0700 (PDT)
Date:   Tue,  9 Jul 2019 16:05:42 -0700
In-Reply-To: <cover.1560295286.git.steadmon@google.com>
Message-Id: <cover.1562712943.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1560295286.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [RFC PATCH v2 0/3] Add a JSON Schema for trace2 events
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        avarab@gmail.com, peff@peff.net, jnareb@gmail.com
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

It runs the validator as part of the CI suite (it increase the runtime
by about 15 minutes). It tests that the trace output of "make test"
conforms to the schema. Users of the trace2 event output can be
relatively confident that the output format has not changed so long as
the schema file remains the same and the regression test is passing.

I would appreciate any feedback on better ways to integrate the
validator into the CI suite.

I have not added support for standalone schema validators (as requested
in the discussion of V1 of this series) because the few that I tested on
my workstation ran for multiple hours (vs. 15 minutes for the validator
included in this series). If someone can suggest a performant standalone
validator, I will be happy to test that.

[1]: https://json-schema.org/

Changes since V1 of this series:
* dropped the documenation fix, as it can be submitted separately from
  this series
* added JSON-array versions of the schema (currently unused)
* added the validation test to the CI suite

Josh Steadmon (3):
  trace2: Add a JSON schema for trace2 events
  trace2: add a schema validator for trace2 events
  ci: run trace2 schema validation in the CI suite

 ci/run-build-and-tests.sh                     |   5 +
 t/trace_schema_validator/.gitignore           |   1 +
 t/trace_schema_validator/Makefile             |  10 +
 t/trace_schema_validator/README               |  23 +
 t/trace_schema_validator/event_schema.json    | 398 ++++++++++++++
 t/trace_schema_validator/list_schema.json     | 401 ++++++++++++++
 .../strict_list_schema.json                   | 514 ++++++++++++++++++
 t/trace_schema_validator/strict_schema.json   | 511 +++++++++++++++++
 .../trace_schema_validator.go                 |  78 +++
 9 files changed, 1941 insertions(+)
 create mode 100644 t/trace_schema_validator/.gitignore
 create mode 100644 t/trace_schema_validator/Makefile
 create mode 100644 t/trace_schema_validator/README
 create mode 100644 t/trace_schema_validator/event_schema.json
 create mode 100644 t/trace_schema_validator/list_schema.json
 create mode 100644 t/trace_schema_validator/strict_list_schema.json
 create mode 100644 t/trace_schema_validator/strict_schema.json
 create mode 100644 t/trace_schema_validator/trace_schema_validator.go

Range-diff against v1:
1:  e02639b147 ! 1:  a949db776c trace2: Add a JSON schema for trace2 events
    @@ -23,6 +23,35 @@
     
     
    + diff --git a/t/trace_schema_validator/README b/t/trace_schema_validator/README
    + new file mode 100644
    + --- /dev/null
    + +++ b/t/trace_schema_validator/README
    +@@
    ++These JSON schemas[1] can be used to validate trace2 event objects. They
    ++can be used to add regression tests to verify that the event output
    ++format does not change unexpectedly.
    ++
    ++Four versions of the schema are provided:
    ++* event_schema.json is more permissive. It verifies that all expected
    ++  fields are present in a trace event, but it allows traces to have
    ++  unexpected additional fields. This allows the schema to be specified
    ++  more concisely by factoring out the common fields into a reusable
    ++  sub-schema.
    ++* strict_schema.json is more restrictive. It verifies that all expected
    ++  fields are present and no unexpected fields are present in the trace
    ++  event. Due to this additional restriction, the common fields cannot be
    ++  factored out into a re-usable subschema (at least as-of draft-07) [2],
    ++  and must be repeated for each event definition.
    ++* list_schema.json is like event_schema.json above, but validates a JSON
    ++  array of trace events, rather than a single event.
    ++* strict_list_schema.json is like strict_schema.json above, but
    ++  validates a JSON array of trace events, rather than a single event.
    ++
    ++[1]: https://json-schema.org/
    ++[2]: https://json-schema.org/understanding-json-schema/reference/combining.html#allof
    ++
    +
      diff --git a/t/trace_schema_validator/event_schema.json b/t/trace_schema_validator/event_schema.json
      new file mode 100644
      --- /dev/null
    @@ -390,7 +419,7 @@
     +						"nesting": { "type": "integer" },
     +						"category": { "type": "string" },
     +						"key": { "type": "string" },
    -+						"value": true
    ++						"value": { "type": "object" }
     +					},
     +					"required": [
     +						"event", "t_abs", "t_rel", "nesting", "category", "key",
    @@ -425,6 +454,933 @@
     +		{ "$ref": "#/definitions/data_event" },
     +		{ "$ref": "#/definitions/data-json_event" }
     +	]
    ++}
    +
    + diff --git a/t/trace_schema_validator/list_schema.json b/t/trace_schema_validator/list_schema.json
    + new file mode 100644
    + --- /dev/null
    + +++ b/t/trace_schema_validator/list_schema.json
    +@@
    ++{
    ++	"$schema": "http://json-schema.org/draft-07/schema#",
    ++	"$id": "http://git-scm.com/schemas/event_schema.json",
    ++	"title": "trace2 permissive schema",
    ++	"description": "Permissive schema for trace2 event output that does not fail in the presence of unexpected fields.",
    ++
    ++	"definitions": {
    ++		"event_common_fields": {
    ++			"type": "object",
    ++			"properties": {
    ++				"sid": { "type": "string" },
    ++				"thread": { "type": "string" },
    ++				"time": {
    ++					"type": "string",
    ++					"format": "date-time"
    ++				},
    ++				"file": { "type": "string" },
    ++				"line": { "type": "integer" },
    ++				"repo": { "type": "integer" }
    ++			},
    ++			"required": [ "sid", "thread" ]
    ++		},
    ++
    ++		"version_event": {
    ++			"allOf": [
    ++				{ "$ref": "#/definitions/event_common_fields" },
    ++				{
    ++					"properties": {
    ++						"event": { "const": "version" },
    ++						"evt": { "const": "1" },
    ++						"exe": { "type": "string" }
    ++					},
    ++					"required": [ "event", "evt", "exe" ]
    ++				}
    ++			]
    ++		},
    ++
    ++		"start_event": {
    ++			"allOf": [
    ++				{ "$ref": "#/definitions/event_common_fields" },
    ++				{
    ++					"properties": {
    ++						"event": { "const": "start" },
    ++						"t_abs": { "type": "number" },
    ++						"argv": {
    ++							"type": "array",
    ++							"items": { "type": "string" }
    ++						}
    ++					},
    ++					"required": [ "event", "t_abs", "argv" ]
    ++				}
    ++			]
    ++		},
    ++
    ++		"exit_event": {
    ++			"allOf": [
    ++				{ "$ref": "#/definitions/event_common_fields" },
    ++				{
    ++					"properties": {
    ++						"event": { "const": "exit" },
    ++						"t_abs": { "type": "number" },
    ++						"code": { "type": "integer" }
    ++					},
    ++					"required": [ "event", "t_abs", "code" ]
    ++				}
    ++			]
    ++		},
    ++
    ++		"atexit_event": {
    ++			"allOf": [
    ++				{ "$ref": "#/definitions/event_common_fields" },
    ++				{
    ++					"properties": {
    ++						"event": { "const": "atexit" },
    ++						"t_abs": { "type": "number" },
    ++						"code": { "type": "integer" }
    ++					},
    ++					"required": [ "event", "t_abs", "code" ]
    ++				}
    ++			]
    ++		},
    ++
    ++		"signal_event": {
    ++			"allOf": [
    ++				{ "$ref": "#/definitions/event_common_fields" },
    ++				{
    ++					"properties": {
    ++						"event": { "const": "signal" },
    ++						"t_abs": { "type": "number" },
    ++						"signo": { "type": "integer" }
    ++					},
    ++					"required": [ "event", "t_abs", "signo" ]
    ++				}
    ++			]
    ++		},
    ++
    ++		"error_event": {
    ++			"allOf": [
    ++				{ "$ref": "#/definitions/event_common_fields" },
    ++				{
    ++					"properties": {
    ++						"event": { "const": "error" },
    ++						"msg": { "type": "string" },
    ++						"fmt": { "type": "string" }
    ++					},
    ++					"required": [ "event", "msg", "fmt" ]
    ++				}
    ++			]
    ++		},
    ++
    ++		"cmd_path_event": {
    ++			"allOf": [
    ++				{ "$ref": "#/definitions/event_common_fields" },
    ++				{
    ++					"properties": {
    ++						"event": { "const": "cmd_path" },
    ++						"path": { "type": "string" }
    ++					},
    ++					"required": [ "event", "path" ]
    ++				}
    ++			]
    ++		},
    ++
    ++		"cmd_name_event": {
    ++			"allOf": [
    ++				{ "$ref": "#/definitions/event_common_fields" },
    ++				{
    ++					"properties": {
    ++						"event": { "const": "cmd_name" },
    ++						"name": { "type": "string" },
    ++						"hierarchy": { "type": "string" }
    ++					},
    ++					"required": [ "event", "name", "hierarchy" ]
    ++				}
    ++			]
    ++		},
    ++
    ++		"cmd_mode_event": {
    ++			"allOf": [
    ++				{ "$ref": "#/definitions/event_common_fields" },
    ++				{
    ++					"properties": {
    ++						"event": { "const": "cmd_mode" },
    ++						"name": { "type": "string" }
    ++					},
    ++					"required": [ "event", "name" ]
    ++				}
    ++			]
    ++		},
    ++
    ++		"alias_event": {
    ++			"allOf": [
    ++				{ "$ref": "#/definitions/event_common_fields" },
    ++				{
    ++					"properties": {
    ++						"event": { "const": "alias" },
    ++						"alias": { "type": "string" },
    ++						"argv": {
    ++							"type": "array",
    ++							"items": { "type": "string" }
    ++						}
    ++					},
    ++					"required": [ "event", "alias", "argv" ]
    ++				}
    ++			]
    ++		},
    ++
    ++		"child_start_event": {
    ++			"allOf": [
    ++				{ "$ref": "#/definitions/event_common_fields" },
    ++				{
    ++					"properties": {
    ++						"event": { "const": "child_start" },
    ++						"child_id": { "type": "integer" },
    ++						"child_class": { "type": "string" },
    ++						"use_shell": { "type": "boolean" },
    ++						"argv": {
    ++							"type": "array",
    ++							"items": { "type": "string" }
    ++						},
    ++						"hook_name": { "type": "string" },
    ++						"cd": { "type": "string" }
    ++					},
    ++					"required": [
    ++						"event", "child_id", "child_class", "use_shell", "argv"
    ++					]
    ++				}
    ++			]
    ++		},
    ++
    ++		"child_exit_event": {
    ++			"allOf": [
    ++				{ "$ref": "#/definitions/event_common_fields" },
    ++				{
    ++					"properties": {
    ++						"event": { "const": "child_exit" },
    ++						"child_id": { "type": "integer" },
    ++						"pid": { "type": "integer" },
    ++						"code": { "type": "integer" },
    ++						"t_rel": { "type": "number" }
    ++					},
    ++					"required": [ "event", "child_id", "pid", "code", "t_rel" ]
    ++				}
    ++			]
    ++		},
    ++
    ++		"exec_event": {
    ++			"allOf": [
    ++				{ "$ref": "#/definitions/event_common_fields" },
    ++				{
    ++					"properties": {
    ++						"event": { "const": "exec" },
    ++						"exec_id": { "type": "integer" },
    ++						"exe": { "type": "string" },
    ++						"argv": {
    ++							"type": "array",
    ++							"items": { "type": "string" }
    ++						}
    ++					},
    ++					"required": [ "event", "exec_id", "exe", "argv" ]
    ++				}
    ++			]
    ++		},
    ++
    ++		"exec_result_event": {
    ++			"allOf": [
    ++				{ "$ref": "#/definitions/event_common_fields" },
    ++				{
    ++					"properties": {
    ++						"event": { "const": "exec_result" },
    ++						"exec_id": { "type": "integer" },
    ++						"code": { "type": "integer" }
    ++					},
    ++					"required": [ "event", "exec_id", "code" ]
    ++				}
    ++			]
    ++		},
    ++
    ++		"thread_start_event": {
    ++			"allOf": [
    ++				{ "$ref": "#/definitions/event_common_fields" },
    ++				{
    ++					"properties": {
    ++						"event": { "const": "thread_start" },
    ++						"thread": { "type": "string" }
    ++					},
    ++					"required": [ "event", "thread" ]
    ++				}
    ++			]
    ++		},
    ++
    ++		"thread_exit_event": {
    ++			"allOf": [
    ++				{ "$ref": "#/definitions/event_common_fields" },
    ++				{
    ++					"properties": {
    ++						"event": { "const": "thread_exit" },
    ++						"thread": { "type": "string" },
    ++						"t_rel": { "type": "number" }
    ++					},
    ++					"required": [ "event", "thread", "t_rel" ]
    ++				}
    ++			]
    ++		},
    ++
    ++		"def_param_event": {
    ++			"allOf": [
    ++				{ "$ref": "#/definitions/event_common_fields" },
    ++				{
    ++					"properties": {
    ++						"event": { "const": "def_param" },
    ++						"param": { "type": "string" },
    ++						"value": { "type": "string" }
    ++					},
    ++					"required": [ "event", "param", "value" ]
    ++				}
    ++			]
    ++		},
    ++
    ++		"def_repo_event": {
    ++			"allOf": [
    ++				{ "$ref": "#/definitions/event_common_fields" },
    ++				{
    ++					"properties": {
    ++						"event": { "const": "def_repo" },
    ++						"repo": { "type": "integer" },
    ++						"worktree": { "type": "string" }
    ++					},
    ++					"required": [ "event", "repo", "worktree" ]
    ++				}
    ++			]
    ++		},
    ++
    ++		"region_enter_event": {
    ++			"allOf": [
    ++				{ "$ref": "#/definitions/event_common_fields" },
    ++				{
    ++					"properties": {
    ++						"event": { "const": "region_enter" },
    ++						"repo": { "type": "integer" },
    ++						"nesting": { "type": "integer" },
    ++						"category": { "type": "string" },
    ++						"label": { "type": "string" },
    ++						"msg": { "type": "string" }
    ++					},
    ++					"required": [ "event", "nesting" ]
    ++				}
    ++			]
    ++		},
    ++
    ++		"region_leave_event": {
    ++			"allOf": [
    ++				{ "$ref": "#/definitions/event_common_fields" },
    ++				{
    ++					"properties": {
    ++						"event": { "const": "region_leave" },
    ++						"repo": { "type": "integer" },
    ++						"t_rel": { "type": "number" },
    ++						"nesting": { "type": "integer" },
    ++						"category": { "type": "string" },
    ++						"label": { "type": "string" },
    ++						"msg": { "type": "string" }
    ++					},
    ++					"required": [ "event", "t_rel", "nesting" ]
    ++				}
    ++			]
    ++		},
    ++
    ++		"data_event": {
    ++			"allOf": [
    ++				{ "$ref": "#/definitions/event_common_fields" },
    ++				{
    ++					"properties": {
    ++						"event": { "const": "data" },
    ++						"repo": { "type": "integer" },
    ++						"t_abs": { "type": "number" },
    ++						"t_rel": { "type": "number" },
    ++						"nesting": { "type": "integer" },
    ++						"category": { "type": "string" },
    ++						"key": { "type": "string" },
    ++						"value": { "type": "string" }
    ++					},
    ++					"required": [
    ++						"event", "t_abs", "t_rel", "nesting", "category", "key",
    ++						"value"
    ++					]
    ++				}
    ++			]
    ++		},
    ++
    ++		"data-json_event": {
    ++			"allOf": [
    ++				{ "$ref": "#/definitions/event_common_fields" },
    ++				{
    ++					"properties": {
    ++						"event": { "const": "data-json" },
    ++						"repo": { "type": "integer" },
    ++						"t_abs": { "type": "number" },
    ++						"t_rel": { "type": "number" },
    ++						"nesting": { "type": "integer" },
    ++						"category": { "type": "string" },
    ++						"key": { "type": "string" },
    ++						"value": { "type": "object" }
    ++					},
    ++					"required": [
    ++						"event", "t_abs", "t_rel", "nesting", "category", "key",
    ++						"value"
    ++					]
    ++				}
    ++			]
    ++		}
    ++	},
    ++
    ++	"type": "array",
    ++	"items": {
    ++		"oneOf": [
    ++			{ "$ref": "#/definitions/version_event" },
    ++			{ "$ref": "#/definitions/start_event" },
    ++			{ "$ref": "#/definitions/exit_event" },
    ++			{ "$ref": "#/definitions/atexit_event" },
    ++			{ "$ref": "#/definitions/signal_event" },
    ++			{ "$ref": "#/definitions/error_event" },
    ++			{ "$ref": "#/definitions/cmd_path_event" },
    ++			{ "$ref": "#/definitions/cmd_name_event" },
    ++			{ "$ref": "#/definitions/cmd_mode_event" },
    ++			{ "$ref": "#/definitions/alias_event" },
    ++			{ "$ref": "#/definitions/child_start_event" },
    ++			{ "$ref": "#/definitions/child_exit_event" },
    ++			{ "$ref": "#/definitions/exec_event" },
    ++			{ "$ref": "#/definitions/exec_result_event" },
    ++			{ "$ref": "#/definitions/thread_start_event" },
    ++			{ "$ref": "#/definitions/thread_exit_event" },
    ++			{ "$ref": "#/definitions/def_param_event" },
    ++			{ "$ref": "#/definitions/def_repo_event" },
    ++			{ "$ref": "#/definitions/region_enter_event" },
    ++			{ "$ref": "#/definitions/region_leave_event" },
    ++			{ "$ref": "#/definitions/data_event" },
    ++			{ "$ref": "#/definitions/data-json_event" }
    ++		]
    ++	}
    ++}
    +
    + diff --git a/t/trace_schema_validator/strict_list_schema.json b/t/trace_schema_validator/strict_list_schema.json
    + new file mode 100644
    + --- /dev/null
    + +++ b/t/trace_schema_validator/strict_list_schema.json
    +@@
    ++{
    ++	"$schema": "http://json-schema.org/draft-07/schema#",
    ++	"$id": "http://git-scm.com/schemas/event_schema.json",
    ++	"title": "trace2 strict schema",
    ++	"description": "Strict schema for trace2 event output that verifies there are no unexpected fields.",
    ++
    ++	"definitions": {
    ++		"version_event": {
    ++			"type": "object",
    ++			"properties": {
    ++				"sid": { "type": "string" },
    ++				"thread": { "type": "string" },
    ++				"time": {
    ++					"type": "string",
    ++					"format": "date-time"
    ++				},
    ++				"file": { "type": "string" },
    ++				"line": { "type": "integer" },
    ++				"repo": { "type": "integer" },
    ++				"event": { "const": "version" },
    ++				"evt": { "const": "1" },
    ++				"exe": { "type": "string" }
    ++			},
    ++			"required": [ "sid", "thread", "event", "evt", "exe" ],
    ++			"additionalProperties": false
    ++		},
    ++
    ++		"start_event": {
    ++			"type": "object",
    ++			"properties": {
    ++				"sid": { "type": "string" },
    ++				"thread": { "type": "string" },
    ++				"time": {
    ++					"type": "string",
    ++					"format": "date-time"
    ++				},
    ++				"file": { "type": "string" },
    ++				"line": { "type": "integer" },
    ++				"repo": { "type": "integer" },
    ++				"event": { "const": "start" },
    ++				"t_abs": { "type": "number" },
    ++				"argv": {
    ++					"type": "array",
    ++					"items": { "type": "string" }
    ++				}
    ++			},
    ++			"required": [ "sid", "thread", "time", "event", "t_abs", "argv" ],
    ++			"additionalProperties": false
    ++		},
    ++
    ++		"exit_event": {
    ++			"type": "object",
    ++			"properties": {
    ++				"sid": { "type": "string" },
    ++				"thread": { "type": "string" },
    ++				"time": {
    ++					"type": "string",
    ++					"format": "date-time"
    ++				},
    ++				"file": { "type": "string" },
    ++				"line": { "type": "integer" },
    ++				"repo": { "type": "integer" },
    ++				"event": { "const": "exit" },
    ++				"t_abs": { "type": "number" },
    ++				"code": { "type": "integer" }
    ++			},
    ++			"required": [ "sid", "thread", "event", "t_abs", "code" ],
    ++			"additionalProperties": false
    ++		},
    ++
    ++		"atexit_event": {
    ++			"type": "object",
    ++			"properties": {
    ++				"sid": { "type": "string" },
    ++				"thread": { "type": "string" },
    ++				"time": {
    ++					"type": "string",
    ++					"format": "date-time"
    ++				},
    ++				"file": { "type": "string" },
    ++				"line": { "type": "integer" },
    ++				"repo": { "type": "integer" },
    ++				"event": { "const": "atexit" },
    ++				"t_abs": { "type": "number" },
    ++				"code": { "type": "integer" }
    ++			},
    ++			"required": [ "sid", "thread", "time", "event", "t_abs", "code" ],
    ++			"additionalProperties": false
    ++		},
    ++
    ++		"signal_event": {
    ++			"type": "object",
    ++			"properties": {
    ++				"sid": { "type": "string" },
    ++				"thread": { "type": "string" },
    ++				"time": {
    ++					"type": "string",
    ++					"format": "date-time"
    ++				},
    ++				"file": { "type": "string" },
    ++				"line": { "type": "integer" },
    ++				"repo": { "type": "integer" },
    ++				"event": { "const": "signal" },
    ++				"t_abs": { "type": "number" },
    ++				"signo": { "type": "integer" }
    ++			},
    ++			"required": [ "sid", "thread", "event", "t_abs", "signo" ],
    ++			"additionalProperties": false
    ++		},
    ++
    ++		"error_event": {
    ++			"type": "object",
    ++			"properties": {
    ++				"sid": { "type": "string" },
    ++				"thread": { "type": "string" },
    ++				"time": {
    ++					"type": "string",
    ++					"format": "date-time"
    ++				},
    ++				"file": { "type": "string" },
    ++				"line": { "type": "integer" },
    ++				"repo": { "type": "integer" },
    ++				"event": { "const": "error" },
    ++				"msg": { "type": "string" },
    ++				"fmt": { "type": "string" }
    ++			},
    ++			"required": [ "sid", "thread", "event", "msg", "fmt" ],
    ++			"additionalProperties": false
    ++		},
    ++
    ++		"cmd_path_event": {
    ++			"type": "object",
    ++			"properties": {
    ++				"sid": { "type": "string" },
    ++				"thread": { "type": "string" },
    ++				"time": {
    ++					"type": "string",
    ++					"format": "date-time"
    ++				},
    ++				"file": { "type": "string" },
    ++				"line": { "type": "integer" },
    ++				"repo": { "type": "integer" },
    ++				"event": { "const": "cmd_path" },
    ++				"path": { "type": "string" }
    ++			},
    ++			"required": [ "sid", "thread", "event", "path" ],
    ++			"additionalProperties": false
    ++		},
    ++
    ++		"cmd_name_event": {
    ++			"type": "object",
    ++			"properties": {
    ++				"sid": { "type": "string" },
    ++				"thread": { "type": "string" },
    ++				"time": {
    ++					"type": "string",
    ++					"format": "date-time"
    ++				},
    ++				"file": { "type": "string" },
    ++				"line": { "type": "integer" },
    ++				"repo": { "type": "integer" },
    ++				"event": { "const": "cmd_name" },
    ++				"name": { "type": "string" },
    ++				"hierarchy": { "type": "string" }
    ++			},
    ++			"required": [ "sid", "thread", "event", "name", "hierarchy"
    ++			],
    ++			"additionalProperties": false
    ++		},
    ++
    ++		"cmd_mode_event": {
    ++			"type": "object",
    ++			"properties": {
    ++				"sid": { "type": "string" },
    ++				"thread": { "type": "string" },
    ++				"time": {
    ++					"type": "string",
    ++					"format": "date-time"
    ++				},
    ++				"file": { "type": "string" },
    ++				"line": { "type": "integer" },
    ++				"repo": { "type": "integer" },
    ++				"event": { "const": "cmd_mode" },
    ++				"name": { "type": "string" }
    ++			},
    ++			"required": [ "sid", "thread", "event", "name" ],
    ++			"additionalProperties": false
    ++		},
    ++
    ++		"alias_event": {
    ++			"type": "object",
    ++			"properties": {
    ++				"sid": { "type": "string" },
    ++				"thread": { "type": "string" },
    ++				"time": {
    ++					"type": "string",
    ++					"format": "date-time"
    ++				},
    ++				"file": { "type": "string" },
    ++				"line": { "type": "integer" },
    ++				"repo": { "type": "integer" },
    ++				"event": { "const": "alias" },
    ++				"alias": { "type": "string" },
    ++				"argv": {
    ++					"type": "array",
    ++					"items": { "type": "string" }
    ++				}
    ++			},
    ++			"required": [ "sid", "thread", "event", "alias", "argv" ],
    ++			"additionalProperties": false
    ++		},
    ++
    ++		"child_start_event": {
    ++			"type": "object",
    ++			"properties": {
    ++				"sid": { "type": "string" },
    ++				"thread": { "type": "string" },
    ++				"time": {
    ++					"type": "string",
    ++					"format": "date-time"
    ++				},
    ++				"file": { "type": "string" },
    ++				"line": { "type": "integer" },
    ++				"repo": { "type": "integer" },
    ++				"event": { "const": "child_start" },
    ++				"child_id": { "type": "integer" },
    ++				"child_class": { "type": "string" },
    ++				"use_shell": { "type": "boolean" },
    ++				"argv": {
    ++					"type": "array",
    ++					"items": { "type": "string" }
    ++				},
    ++				"hook_name": { "type": "string" },
    ++				"cd": { "type": "string" }
    ++			},
    ++			"required": [
    ++				"sid", "thread", "event", "child_id", "child_class",
    ++				"use_shell", "argv"
    ++			],
    ++			"additionalProperties": false
    ++		},
    ++
    ++		"child_exit_event": {
    ++			"type": "object",
    ++			"properties": {
    ++				"sid": { "type": "string" },
    ++				"thread": { "type": "string" },
    ++				"time": {
    ++					"type": "string",
    ++					"format": "date-time"
    ++				},
    ++				"file": { "type": "string" },
    ++				"line": { "type": "integer" },
    ++				"repo": { "type": "integer" },
    ++				"event": { "const": "child_exit" },
    ++				"child_id": { "type": "integer" },
    ++				"pid": { "type": "integer" },
    ++				"code": { "type": "integer" },
    ++				"t_rel": { "type": "number" }
    ++			},
    ++			"required": [
    ++				"sid", "thread", "event", "child_id", "pid", "code", "t_rel"
    ++			],
    ++			"additionalProperties": false
    ++		},
    ++
    ++		"exec_event": {
    ++			"type": "object",
    ++			"properties": {
    ++				"sid": { "type": "string" },
    ++				"thread": { "type": "string" },
    ++				"time": {
    ++					"type": "string",
    ++					"format": "date-time"
    ++				},
    ++				"file": { "type": "string" },
    ++				"line": { "type": "integer" },
    ++				"repo": { "type": "integer" },
    ++				"event": { "const": "exec" },
    ++				"exec_id": { "type": "integer" },
    ++				"exe": { "type": "string" },
    ++				"argv": {
    ++					"type": "array",
    ++					"items": { "type": "string" }
    ++				}
    ++			},
    ++			"required": [ "sid", "thread", "event", "exec_id", "exe", "argv" ],
    ++			"additionalProperties": false
    ++		},
    ++
    ++		"exec_result_event": {
    ++			"type": "object",
    ++			"properties": {
    ++				"sid": { "type": "string" },
    ++				"thread": { "type": "string" },
    ++				"time": {
    ++					"type": "string",
    ++					"format": "date-time"
    ++				},
    ++				"file": { "type": "string" },
    ++				"line": { "type": "integer" },
    ++				"repo": { "type": "integer" },
    ++				"event": { "const": "exec_result" },
    ++				"exec_id": { "type": "integer" },
    ++				"code": { "type": "integer" }
    ++			},
    ++			"required": [ "sid", "thread", "event", "exec_id", "code" ],
    ++			"additionalProperties": false
    ++		},
    ++
    ++		"thread_start_event": {
    ++			"type": "object",
    ++			"properties": {
    ++				"sid": { "type": "string" },
    ++				"thread": { "type": "string" },
    ++				"time": {
    ++					"type": "string",
    ++					"format": "date-time"
    ++				},
    ++				"file": { "type": "string" },
    ++				"line": { "type": "integer" },
    ++				"repo": { "type": "integer" },
    ++				"event": { "const": "thread_start" }
    ++			},
    ++			"required": [ "sid", "thread", "event" ],
    ++			"additionalProperties": false
    ++		},
    ++
    ++		"thread_exit_event": {
    ++			"type": "object",
    ++			"properties": {
    ++				"sid": { "type": "string" },
    ++				"thread": { "type": "string" },
    ++				"time": {
    ++					"type": "string",
    ++					"format": "date-time"
    ++				},
    ++				"file": { "type": "string" },
    ++				"line": { "type": "integer" },
    ++				"repo": { "type": "integer" },
    ++				"event": { "const": "thread_exit" },
    ++				"t_rel": { "type": "number" }
    ++			},
    ++			"required": [ "sid", "thread", "event", "t_rel" ],
    ++			"additionalProperties": false
    ++		},
    ++
    ++		"def_param_event": {
    ++			"type": "object",
    ++			"properties": {
    ++				"sid": { "type": "string" },
    ++				"thread": { "type": "string" },
    ++				"time": {
    ++					"type": "string",
    ++					"format": "date-time"
    ++				},
    ++				"file": { "type": "string" },
    ++				"line": { "type": "integer" },
    ++				"repo": { "type": "integer" },
    ++				"event": { "const": "def_param" },
    ++				"param": { "type": "string" },
    ++				"value": { "type": "string" }
    ++			},
    ++			"required": [ "sid", "thread", "event", "param", "value" ],
    ++			"additionalProperties": false
    ++		},
    ++
    ++		"def_repo_event": {
    ++			"type": "object",
    ++			"properties": {
    ++				"sid": { "type": "string" },
    ++				"thread": { "type": "string" },
    ++				"time": {
    ++					"type": "string",
    ++					"format": "date-time"
    ++				},
    ++				"file": { "type": "string" },
    ++				"line": { "type": "integer" },
    ++				"repo": { "type": "integer" },
    ++				"event": { "const": "def_repo" },
    ++				"worktree": { "type": "string" }
    ++			},
    ++			"required": [ "sid", "thread", "event", "repo", "worktree" ],
    ++			"additionalProperties": false
    ++		},
    ++
    ++		"region_enter_event": {
    ++			"type": "object",
    ++			"properties": {
    ++				"sid": { "type": "string" },
    ++				"thread": { "type": "string" },
    ++				"time": {
    ++					"type": "string",
    ++					"format": "date-time"
    ++				},
    ++				"file": { "type": "string" },
    ++				"line": { "type": "integer" },
    ++				"repo": { "type": "integer" },
    ++				"event": { "const": "region_enter" },
    ++				"nesting": { "type": "integer" },
    ++				"category": { "type": "string" },
    ++				"label": { "type": "string" },
    ++				"msg": { "type": "string" }
    ++			},
    ++			"required": [ "sid", "thread", "event", "nesting" ],
    ++			"additionalProperties": false
    ++		},
    ++
    ++		"region_leave_event": {
    ++			"type": "object",
    ++			"properties": {
    ++				"sid": { "type": "string" },
    ++				"thread": { "type": "string" },
    ++				"time": {
    ++					"type": "string",
    ++					"format": "date-time"
    ++				},
    ++				"file": { "type": "string" },
    ++				"line": { "type": "integer" },
    ++				"repo": { "type": "integer" },
    ++				"event": { "const": "region_leave" },
    ++				"t_rel": { "type": "number" },
    ++				"nesting": { "type": "integer" },
    ++				"category": { "type": "string" },
    ++				"label": { "type": "string" },
    ++				"msg": { "type": "string" }
    ++			},
    ++			"required": [ "sid", "thread", "event", "t_rel", "nesting" ],
    ++			"additionalProperties": false
    ++		},
    ++
    ++		"data_event": {
    ++			"type": "object",
    ++			"properties": {
    ++				"sid": { "type": "string" },
    ++				"thread": { "type": "string" },
    ++				"time": {
    ++					"type": "string",
    ++					"format": "date-time"
    ++				},
    ++				"file": { "type": "string" },
    ++				"line": { "type": "integer" },
    ++				"repo": { "type": "integer" },
    ++				"event": { "const": "data" },
    ++				"t_abs": { "type": "number" },
    ++				"t_rel": { "type": "number" },
    ++				"nesting": { "type": "integer" },
    ++				"category": { "type": "string" },
    ++				"key": { "type": "string" },
    ++				"value": { "type": "string" }
    ++			},
    ++			"required": [
    ++				"sid", "thread", "event", "t_abs", "t_rel", "nesting",
    ++				"category","key", "value"
    ++			],
    ++			"additionalProperties": false
    ++		},
    ++
    ++		"data-json_event": {
    ++			"type": "object",
    ++			"properties": {
    ++				"sid": { "type": "string" },
    ++				"thread": { "type": "string" },
    ++				"time": {
    ++					"type": "string",
    ++					"format": "date-time"
    ++				},
    ++				"file": { "type": "string" },
    ++				"line": { "type": "integer" },
    ++				"repo": { "type": "integer" },
    ++				"event": { "const": "data-json" },
    ++				"t_abs": { "type": "number" },
    ++				"t_rel": { "type": "number" },
    ++				"nesting": { "type": "integer" },
    ++				"category": { "type": "string" },
    ++				"key": { "type": "string" },
    ++				"value": { "type": "object" }
    ++			},
    ++			"required": [
    ++				"sid", "thread", "event", "t_abs", "t_rel", "nesting",
    ++				"category", "key", "value"
    ++			],
    ++			"additionalProperties": false
    ++		}
    ++	},
    ++
    ++	"type": "array",
    ++	"items": {
    ++		"oneOf": [
    ++			{ "$ref": "#/definitions/version_event" },
    ++			{ "$ref": "#/definitions/start_event" },
    ++			{ "$ref": "#/definitions/exit_event" },
    ++			{ "$ref": "#/definitions/atexit_event" },
    ++			{ "$ref": "#/definitions/signal_event" },
    ++			{ "$ref": "#/definitions/error_event" },
    ++			{ "$ref": "#/definitions/cmd_path_event" },
    ++			{ "$ref": "#/definitions/cmd_name_event" },
    ++			{ "$ref": "#/definitions/cmd_mode_event" },
    ++			{ "$ref": "#/definitions/alias_event" },
    ++			{ "$ref": "#/definitions/child_start_event" },
    ++			{ "$ref": "#/definitions/child_exit_event" },
    ++			{ "$ref": "#/definitions/exec_event" },
    ++			{ "$ref": "#/definitions/exec_result_event" },
    ++			{ "$ref": "#/definitions/thread_start_event" },
    ++			{ "$ref": "#/definitions/thread_exit_event" },
    ++			{ "$ref": "#/definitions/def_param_event" },
    ++			{ "$ref": "#/definitions/def_repo_event" },
    ++			{ "$ref": "#/definitions/region_enter_event" },
    ++			{ "$ref": "#/definitions/region_leave_event" },
    ++			{ "$ref": "#/definitions/data_event" },
    ++			{ "$ref": "#/definitions/data-json_event" }
    ++		]
    ++	}
     +}
     
      diff --git a/t/trace_schema_validator/strict_schema.json b/t/trace_schema_validator/strict_schema.json
    @@ -908,7 +1864,7 @@
     +				"nesting": { "type": "integer" },
     +				"category": { "type": "string" },
     +				"key": { "type": "string" },
    -+				"value": true
    ++				"value": { "type": "object" }
     +			},
     +			"required": [
     +				"sid", "thread", "event", "t_abs", "t_rel", "nesting",
2:  db36c04af9 ! 2:  3fa4e9eef8 trace2: add a schema validator for trace2 events
    @@ -92,6 +92,10 @@
     +
     +	count := 0
     +	for ; scanner.Scan(); count++ {
    ++		if count%10000 == 0 {
    ++			// Travis-CI expects regular output or it will time out.
    ++			log.Print("Validated items: ", count)
    ++		}
     +		event := gojsonschema.NewStringLoader(scanner.Text())
     +		result, err := schema.Validate(event)
     +		if err != nil {
-:  ---------- > 3:  acf3aebcaa ci: run trace2 schema validation in the CI suite
-- 
2.22.0.510.g264f2c817a-goog

