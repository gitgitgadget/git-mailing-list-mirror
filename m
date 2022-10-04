Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17923C4332F
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 16:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJDQUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 12:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJDQU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 12:20:27 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DADD40E1A
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 09:20:16 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id t4so9227509wmj.5
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 09:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=RpVGLEvH49+bfux2D3e56rX6LL83lZHhbyC5oYqx3WQ=;
        b=P4x5U/ee3pxhKRK7TI7qtavufx76C6bizSjTGC3sc+jAsHxOhnozZ0pprnGAGud0mO
         CSwoY0ECiStMP+ss9Q2FcK3IF0eTkUy0szMZFeVgJ/iid+bqVLHIyifHJOZmXcPz6R+W
         9cgZbn6q8ty7qKEbzj2Cye0msr6wWLs/g7SdKNJzvpQIdVxdCaWh/at0pKv8ov+JDb3E
         6RFG4217QlKfJA7y2KWqUhNXMI1hF08ReeVS+CGw4NmcLmE4xi1ejxq79UqUh7wTgubs
         bY2tGrDbevRU41U8T2wdXFBjTj+W8U47OKb05C79Ne7WRwJWwKBAZrbLuaVwIe060dTB
         Wq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RpVGLEvH49+bfux2D3e56rX6LL83lZHhbyC5oYqx3WQ=;
        b=z4xbbiPhol6MkqgrETTlHOLnD7fnK77FOyfZPUqHoJs3MgfEWL9ofL7XjZhCWHDXly
         D9JG+NMvbAphKAj1z0+coEwJEDYkHr/ejBDFy2DVzjNMfHN+NV6NUqM7lofl2nuJgwDf
         JpkAPYbUtLCcn1V74PRChkF6jV5EUBwyGrnlMfn7YOFJqV6+uh4OPM1h2oerjNChlAjb
         MSnZa2/g1Eh7GYKyv7UH/KyOO4WbixseclYui9GuZ4+/6USgz3L/cbqnDJZ2dU5495MC
         U8k86GB1dJVnMqMQ7sO8H1ERmgv3V/DVSA8/MNzqREomSKHmFcb/3AoRFmHtoxWPAVhA
         WjFQ==
X-Gm-Message-State: ACrzQf0GjSch98CB3Z/qO5BQJBZhihyIm0iXNhl7C0IWpYD5B2Qw72nU
        mD01nqAQ3DyhXswfVfiwXhyZJJJO3Oo=
X-Google-Smtp-Source: AMsMyM7QLbZnIJWL+0LCEoHRu4h1DkI1lj7yrefuWW965LbUE0uGDNwr4OBCdRRO71M8VdTekfZPJA==
X-Received: by 2002:a05:600c:474a:b0:3b4:cb93:7d57 with SMTP id w10-20020a05600c474a00b003b4cb937d57mr397058wmo.41.1664900414323;
        Tue, 04 Oct 2022 09:20:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m10-20020adfe0ca000000b0022e36c1113fsm7155223wri.13.2022.10.04.09.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 09:20:13 -0700 (PDT)
Message-Id: <77a4daf9a4ba8c3b064bfb0cd8a813b822d03b3c.1664900407.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Oct 2022 16:20:05 +0000
Subject: [PATCH 7/9] api-trace2.txt: elminate section describing the public
 trace2 API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Eliminate the mostly obsolete `Public API` sub-section from the
`Trace2 API` section in the documentation.  Strengthen the referral
to `trace2.h`.

Most of the technical information in this sub-section was moved to
`trace2.h` in 6c51cb525d (trace2: move doc to trace2.h, 2019-11-17) to
be adjacent to the function prototypes.  The remaining text wasn't
that useful by itself.

Furthermore, the text would need a bit of overhaul to add routines
that do not immediately generate a message, such as stopwatch timers.
So it seemed simpler to just get rid of it.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/api-trace2.txt | 61 +++-----------------------
 1 file changed, 7 insertions(+), 54 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 4fe2d6992ab..9d43909d068 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -148,20 +148,18 @@ filename collisions).
 
 == Trace2 API
 
-All public Trace2 functions and macros are defined in `trace2.h` and
-`trace2.c`.  All public symbols are prefixed with `trace2_`.
+The Trace2 public API is defined and documented in `trace2.h`; refer to it for
+more information.  All public functions and macros are prefixed
+with `trace2_` and are implemented in `trace2.c`.
 
 There are no public Trace2 data structures.
 
 The Trace2 code also defines a set of private functions and data types
 in the `trace2/` directory.  These symbols are prefixed with `tr2_`
-and should only be used by functions in `trace2.c`.
+and should only be used by functions in `trace2.c` (or other private
+source files in `trace2/`).
 
-== Conventions for Public Functions and Macros
-
-The functions defined by the Trace2 API are declared and documented
-in `trace2.h`.  It defines the API functions and wrapper macros for
-Trace2.
+=== Conventions for Public Functions and Macros
 
 Some functions have a `_fl()` suffix to indicate that they take `file`
 and `line-number` arguments.
@@ -172,52 +170,7 @@ take a `va_list` argument.
 Some functions have a `_printf_fl()` suffix to indicate that they also
 take a `printf()` style format with a variable number of arguments.
 
-There are CPP wrapper macros and `#ifdef`s to hide most of these details.
-See `trace2.h` for more details.  The following discussion will only
-describe the simplified forms.
-
-== Public API
-
-All Trace2 API functions send a message to all of the active
-Trace2 Targets.  This section describes the set of available
-messages.
-
-It helps to divide these functions into groups for discussion
-purposes.
-
-=== Basic Command Messages
-
-These are concerned with the lifetime of the overall git process.
-e.g: `void trace2_initialize_clock()`, `void trace2_initialize()`,
-`int trace2_is_enabled()`, `void trace2_cmd_start(int argc, const char **argv)`.
-
-=== Command Detail Messages
-
-These are concerned with describing the specific Git command
-after the command line, config, and environment are inspected.
-e.g: `void trace2_cmd_name(const char *name)`,
-`void trace2_cmd_mode(const char *mode)`.
-
-=== Child Process Messages
-
-These are concerned with the various spawned child processes,
-including shell scripts, git commands, editors, pagers, and hooks.
-
-e.g: `void trace2_child_start(struct child_process *cmd)`.
-
-=== Git Thread Messages
-
-These messages are concerned with Git thread usage.
-
-e.g: `void trace2_thread_start(const char *name_hint)`.
-
-=== Region and Data Messages
-
-These are concerned with recording performance data
-over regions or spans of code. e.g:
-`void trace2_region_enter(const char *category, const char *label, const struct repository *repo)`.
-
-Refer to trace2.h for details about all trace2 functions.
+CPP wrapper macros are defined to hide most of these details.
 
 == Trace2 Target Formats
 
-- 
gitgitgadget

