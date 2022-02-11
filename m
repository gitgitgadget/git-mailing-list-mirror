Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3DAC433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353686AbiBKU5j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:57:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353569AbiBKU4u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:50 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA424D5E
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:35 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so7102888wmb.0
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pFuuWuQ7qSz0sYK+T2a6qe7BTST95gUDzAAwqKhF5BQ=;
        b=Ltu8rJX2AcW3sDQd+R5qyXwoQs0GIinn7ERGaBLFKK//mn2qdx6GHgF6K+EyBSQa+X
         Y0VCEqN9z0F6I5hoJyzMXZE3cgruThpPPBhgHTa4K9mo00uj57mqS+CqEPpFntR0SBUy
         RYDA7jRodXE+S/KbGngcYdVnP+QxGtmUA0pzQb8H6NmwvtP0npTElfR3j0B4XMZG/rld
         zLxoJIHg/bnex+w2Pg+y8VEGZRKSZ0JfUh9cCc5Tf1LD6ld9r6fhWPWTANfSyYPt4FYt
         Dt9PeCCyPS9TKh/0IhOub1u2oB3Oz0jFa+5A6w/w0hpmvJ8GtRhChbL37e5s9QM8vRtn
         GXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pFuuWuQ7qSz0sYK+T2a6qe7BTST95gUDzAAwqKhF5BQ=;
        b=TN1c3bftzt3Mj/kJ4pwuS9UGH1iwxJe4kTaZuutVO8Tk6fyZypkVaFyH+K2K/jdP2h
         l9sxPU8b29jrio67tt/mYaT+Qiqd6DSrxMoTu4kuDMicn1KqZGSpBOeEygo2eUKvZest
         R953ksJ50ex9+XkMfrU/NOHGe031y5qpMPTjRdJelSMCHiawg25/eH1iSXNxeN39pEmP
         ck+MWgALAZqSco5ayjTDR4almelmFJA0UZmepdJtWIH+SXV/eVmvIEPS2tUp06lTITjq
         o8Z7OI69I4fAJUzHgZEurbftglq0NVUDr7Ky00vWFiDn6vIIK6WFiwxz47Kk1OQKCR8r
         Vkcw==
X-Gm-Message-State: AOAM531lSW+XxRlK7AWWcsdLu2iXYv2BaTI+TJb+9Leakom+H97YKP8J
        qO3/rQ4vyzzB0OF1EiW+sxPSSWKSsGw=
X-Google-Smtp-Source: ABdhPJxLJ7/bLdhWw1w/KZaxZ7c8ZcQP+CBzdoNtDqSvDKiyl23p9Jp36QdGLi+gVpsT0lzDra9PvQ==
X-Received: by 2002:a05:600c:3516:: with SMTP id h22mr1724586wmq.143.1644612994141;
        Fri, 11 Feb 2022 12:56:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17sm4616828wme.25.2022.02.11.12.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:33 -0800 (PST)
Message-Id: <a3b881315faea153fb6f4839d7077caf6fc8899c.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:56:05 +0000
Subject: [PATCH v5 16/30] compat/fsmonitor/fsm-listen-darwin: add macos header
 files for FSEvent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Include MacOS system declarations to allow us to use FSEvent and
CoreFoundation APIs.  We need GCC and clang versions because of
compiler and header file conflicts.

While it is quite possible to #include Apple's CoreServices.h when
compiling C source code with clang, trying to build it with GCC
currently fails with this error:

In file included
   from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
   ...Library/Frameworks/Security.framework/Headers/AuthSession.h:32,
   from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
   ...Library/Frameworks/Security.framework/Headers/Security.h:42,
   from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
   ...Library/Frameworks/CoreServices.framework/Frameworks/...
   ...OSServices.framework/Headers/CSIdentity.h:43,
   from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
   ...Library/Frameworks/CoreServices.framework/Frameworks/...
   ...OSServices.framework/Headers/OSServices.h:29,
   from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
   ...Library/Frameworks/CoreServices.framework/Frameworks/...
   ...LaunchServices.framework/Headers/IconsCore.h:23,
   from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
   ...Library/Frameworks/CoreServices.framework/Frameworks/...
   ...LaunchServices.framework/Headers/LaunchServices.h:23,
   from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
   ...Library/Frameworks/CoreServices.framework/Headers/CoreServices.h:45,

     /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
     ...Library/Frameworks/Security.framework/Headers/Authorization.h:193:7:
     error: variably modified 'bytes' at file scope
       193 | char bytes[kAuthorizationExternalFormLength];
           |      ^~~~~

The underlying reason is that GCC (rightfully) objects that an `enum`
value such as `kAuthorizationExternalFormLength` is not a constant
(because it is not, the preprocessor has no knowledge of it, only the
actual C compiler does) and can therefore not be used to define the size
of a C array.

This is a known problem and tracked in GCC's bug tracker:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=93082

In the meantime, let's not block things and go the slightly ugly route
of declaring/defining the FSEvents constants, data structures and
functions that we need, so that we can avoid above-mentioned issue.

Let's do this _only_ for GCC, though, so that the CI/PR builds (which
build both with clang and with GCC) can guarantee that we _are_ using
the correct data types.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-listen-darwin.c | 96 ++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index c84e3344ab9..f424253d3eb 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -1,3 +1,99 @@
+#if defined(__GNUC__)
+/*
+ * It is possible to #include CoreFoundation/CoreFoundation.h when compiling
+ * with clang, but not with GCC as of time of writing.
+ *
+ * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=93082 for details.
+ */
+typedef unsigned int FSEventStreamCreateFlags;
+#define kFSEventStreamEventFlagNone               0x00000000
+#define kFSEventStreamEventFlagMustScanSubDirs    0x00000001
+#define kFSEventStreamEventFlagUserDropped        0x00000002
+#define kFSEventStreamEventFlagKernelDropped      0x00000004
+#define kFSEventStreamEventFlagEventIdsWrapped    0x00000008
+#define kFSEventStreamEventFlagHistoryDone        0x00000010
+#define kFSEventStreamEventFlagRootChanged        0x00000020
+#define kFSEventStreamEventFlagMount              0x00000040
+#define kFSEventStreamEventFlagUnmount            0x00000080
+#define kFSEventStreamEventFlagItemCreated        0x00000100
+#define kFSEventStreamEventFlagItemRemoved        0x00000200
+#define kFSEventStreamEventFlagItemInodeMetaMod   0x00000400
+#define kFSEventStreamEventFlagItemRenamed        0x00000800
+#define kFSEventStreamEventFlagItemModified       0x00001000
+#define kFSEventStreamEventFlagItemFinderInfoMod  0x00002000
+#define kFSEventStreamEventFlagItemChangeOwner    0x00004000
+#define kFSEventStreamEventFlagItemXattrMod       0x00008000
+#define kFSEventStreamEventFlagItemIsFile         0x00010000
+#define kFSEventStreamEventFlagItemIsDir          0x00020000
+#define kFSEventStreamEventFlagItemIsSymlink      0x00040000
+#define kFSEventStreamEventFlagOwnEvent           0x00080000
+#define kFSEventStreamEventFlagItemIsHardlink     0x00100000
+#define kFSEventStreamEventFlagItemIsLastHardlink 0x00200000
+#define kFSEventStreamEventFlagItemCloned         0x00400000
+
+typedef struct __FSEventStream *FSEventStreamRef;
+typedef const FSEventStreamRef ConstFSEventStreamRef;
+
+typedef unsigned int CFStringEncoding;
+#define kCFStringEncodingUTF8 0x08000100
+
+typedef const struct __CFString *CFStringRef;
+typedef const struct __CFArray *CFArrayRef;
+typedef const struct __CFRunLoop *CFRunLoopRef;
+
+struct FSEventStreamContext {
+    long long version;
+    void *cb_data, *retain, *release, *copy_description;
+};
+
+typedef struct FSEventStreamContext FSEventStreamContext;
+typedef unsigned int FSEventStreamEventFlags;
+#define kFSEventStreamCreateFlagNoDefer 0x02
+#define kFSEventStreamCreateFlagWatchRoot 0x04
+#define kFSEventStreamCreateFlagFileEvents 0x10
+
+typedef unsigned long long FSEventStreamEventId;
+#define kFSEventStreamEventIdSinceNow 0xFFFFFFFFFFFFFFFFULL
+
+typedef void (*FSEventStreamCallback)(ConstFSEventStreamRef streamRef,
+				      void *context,
+				      __SIZE_TYPE__ num_of_events,
+				      void *event_paths,
+				      const FSEventStreamEventFlags event_flags[],
+				      const FSEventStreamEventId event_ids[]);
+typedef double CFTimeInterval;
+FSEventStreamRef FSEventStreamCreate(void *allocator,
+				     FSEventStreamCallback callback,
+				     FSEventStreamContext *context,
+				     CFArrayRef paths_to_watch,
+				     FSEventStreamEventId since_when,
+				     CFTimeInterval latency,
+				     FSEventStreamCreateFlags flags);
+CFStringRef CFStringCreateWithCString(void *allocator, const char *string,
+				      CFStringEncoding encoding);
+CFArrayRef CFArrayCreate(void *allocator, const void **items, long long count,
+			 void *callbacks);
+void CFRunLoopRun(void);
+void CFRunLoopStop(CFRunLoopRef run_loop);
+CFRunLoopRef CFRunLoopGetCurrent(void);
+extern CFStringRef kCFRunLoopDefaultMode;
+void FSEventStreamScheduleWithRunLoop(FSEventStreamRef stream,
+				      CFRunLoopRef run_loop,
+				      CFStringRef run_loop_mode);
+unsigned char FSEventStreamStart(FSEventStreamRef stream);
+void FSEventStreamStop(FSEventStreamRef stream);
+void FSEventStreamInvalidate(FSEventStreamRef stream);
+void FSEventStreamRelease(FSEventStreamRef stream);
+#else
+/*
+ * Let Apple's headers declare `isalnum()` first, before
+ * Git's headers override it via a constant
+ */
+#include <string.h>
+#include <CoreFoundation/CoreFoundation.h>
+#include <CoreServices/CoreServices.h>
+#endif
+
 #include "cache.h"
 #include "fsmonitor.h"
 #include "fsm-listen.h"
-- 
gitgitgadget

