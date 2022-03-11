Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3224C433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 22:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiCKWv0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiCKWvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 17:51:16 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2A51160DF
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:25:16 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qx21so21888529ejb.13
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iW4pWJY0rbH40UwJ9FX+/j5CNTCDjj8eyDl/7ZDB4ME=;
        b=SSPEQFy8AUr3oHl2xk+r+QyIjTQRRnrBa+QLDoXLcIcnk8WNbDbrnxGyYqrNmmmF4p
         rDuhzanJB0NK1QK1U4kd8wNYcPkuPBdVIWRnvd+Ev4O+hcY7EZ/ymsoXIfkH6XkuLji8
         C2CB7EEiPFeVkHErmBzT+27osU9cttvVyNeQsebJcMZRLgW144H5WIBMk6FQPNi578QX
         jJRJtC9WyStXWpIJHACvhzYbqePVj6N79IJUvjqDaaD+ilmI6tEeK8RHFuG0Lu/1sDzZ
         p7ILiVVGyXVy07NrwTOG2N9i2xzWFqzsJdw0J1VrzK5jM3wON89pRkk7j0noCiF1NRGF
         fSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iW4pWJY0rbH40UwJ9FX+/j5CNTCDjj8eyDl/7ZDB4ME=;
        b=g4V8NkfXW+hykzPSVJGikUT4+rFAauSygPI/CdDer2d2BBzYLtbBcjHGk6ITs3aWK6
         uObzCoYvWb4/4ZnHansvICW2Pwu/7BAHJTqNsEy7fqH8HmaRg9HQIi4tmWWwnmzuETCC
         ZKhIhUZVyhBcfGEypT6x/PK5tS4XHKpzIN8av6iHggP7J0IgUZ/3miW/KIGjr+cOpQeG
         3HJNZpcsVv+H6pfHd/H0Egg7rzQXUwwOcT4v1ezU+n2mQeZXn8JC44n00ieKnPt2iSIy
         fb1xuAIBT0UKmmesub/eZjUIKzKqvr9gohXuSwfnTTOOFf79R0MF1bxdugiTPyAdoLEr
         N8Fg==
X-Gm-Message-State: AOAM530TwxZVUp3SmAkLOdAfN1VQzMKkgEQw2rDqeK9q5uGQ+91sobuT
        Em8vgayaD5ySBokp5ISyCEyBgQ7dDkc=
X-Google-Smtp-Source: ABdhPJzaT1LCCEuK2ZWnGXuZQB+H/jwExWktQFX4SBViu5y3C20WFEH1W1Cu9WGZ/ylj+EKknIe3pg==
X-Received: by 2002:adf:a1d5:0:b0:1f0:24f8:4c50 with SMTP id v21-20020adfa1d5000000b001f024f84c50mr8769884wrv.477.1647033306675;
        Fri, 11 Mar 2022 13:15:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1-20020a5d4941000000b001ed89dcacbbsm7463717wrs.23.2022.03.11.13.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:15:06 -0800 (PST)
Message-Id: <2ddb702b330b1bdf7d81e006c5bbe3aee819c8be.1647033303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Mar 2022 21:14:50 +0000
Subject: [PATCH 03/16] compat/fsmonitor/fsm-listen-darwin: split out
 GCC-specific declarations
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

fixup! compat/fsmonitor/fsm-listen-darwin: add MacOS header files \
for FSEvent

Split out GCC-specific MacOS declarations into separate file from
the clang-specific header file includes to reduce visual noise.

Eliminate unnecessary includes when using clang.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-darwin-gcc.h    | 92 ++++++++++++++++++++++++++++
 compat/fsmonitor/fsm-listen-darwin.c | 91 +--------------------------
 2 files changed, 93 insertions(+), 90 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-darwin-gcc.h

diff --git a/compat/fsmonitor/fsm-darwin-gcc.h b/compat/fsmonitor/fsm-darwin-gcc.h
new file mode 100644
index 00000000000..1c75c3d48e7
--- /dev/null
+++ b/compat/fsmonitor/fsm-darwin-gcc.h
@@ -0,0 +1,92 @@
+#ifndef FSM_DARWIN_GCC_H
+#define FSM_DARWIN_GCC_H
+
+#ifndef __clang__
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
+
+#endif /* !clang */
+#endif /* FSM_DARWIN_GCC_H */
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 5c5de1ae702..9a73fb607d5 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -1,95 +1,6 @@
 #ifndef __clang__
-/*
- * It is possible to #include CoreFoundation/CoreFoundation.h when compiling
- * with clang, but not with GCC as of time of writing.
- *
- * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=93082 for details.
- */
-typedef unsigned int FSEventStreamCreateFlags;
-#define kFSEventStreamEventFlagNone               0x00000000
-#define kFSEventStreamEventFlagMustScanSubDirs    0x00000001
-#define kFSEventStreamEventFlagUserDropped        0x00000002
-#define kFSEventStreamEventFlagKernelDropped      0x00000004
-#define kFSEventStreamEventFlagEventIdsWrapped    0x00000008
-#define kFSEventStreamEventFlagHistoryDone        0x00000010
-#define kFSEventStreamEventFlagRootChanged        0x00000020
-#define kFSEventStreamEventFlagMount              0x00000040
-#define kFSEventStreamEventFlagUnmount            0x00000080
-#define kFSEventStreamEventFlagItemCreated        0x00000100
-#define kFSEventStreamEventFlagItemRemoved        0x00000200
-#define kFSEventStreamEventFlagItemInodeMetaMod   0x00000400
-#define kFSEventStreamEventFlagItemRenamed        0x00000800
-#define kFSEventStreamEventFlagItemModified       0x00001000
-#define kFSEventStreamEventFlagItemFinderInfoMod  0x00002000
-#define kFSEventStreamEventFlagItemChangeOwner    0x00004000
-#define kFSEventStreamEventFlagItemXattrMod       0x00008000
-#define kFSEventStreamEventFlagItemIsFile         0x00010000
-#define kFSEventStreamEventFlagItemIsDir          0x00020000
-#define kFSEventStreamEventFlagItemIsSymlink      0x00040000
-#define kFSEventStreamEventFlagOwnEvent           0x00080000
-#define kFSEventStreamEventFlagItemIsHardlink     0x00100000
-#define kFSEventStreamEventFlagItemIsLastHardlink 0x00200000
-#define kFSEventStreamEventFlagItemCloned         0x00400000
-
-typedef struct __FSEventStream *FSEventStreamRef;
-typedef const FSEventStreamRef ConstFSEventStreamRef;
-
-typedef unsigned int CFStringEncoding;
-#define kCFStringEncodingUTF8 0x08000100
-
-typedef const struct __CFString *CFStringRef;
-typedef const struct __CFArray *CFArrayRef;
-typedef const struct __CFRunLoop *CFRunLoopRef;
-
-struct FSEventStreamContext {
-    long long version;
-    void *cb_data, *retain, *release, *copy_description;
-};
-
-typedef struct FSEventStreamContext FSEventStreamContext;
-typedef unsigned int FSEventStreamEventFlags;
-#define kFSEventStreamCreateFlagNoDefer 0x02
-#define kFSEventStreamCreateFlagWatchRoot 0x04
-#define kFSEventStreamCreateFlagFileEvents 0x10
-
-typedef unsigned long long FSEventStreamEventId;
-#define kFSEventStreamEventIdSinceNow 0xFFFFFFFFFFFFFFFFULL
-
-typedef void (*FSEventStreamCallback)(ConstFSEventStreamRef streamRef,
-				      void *context,
-				      __SIZE_TYPE__ num_of_events,
-				      void *event_paths,
-				      const FSEventStreamEventFlags event_flags[],
-				      const FSEventStreamEventId event_ids[]);
-typedef double CFTimeInterval;
-FSEventStreamRef FSEventStreamCreate(void *allocator,
-				     FSEventStreamCallback callback,
-				     FSEventStreamContext *context,
-				     CFArrayRef paths_to_watch,
-				     FSEventStreamEventId since_when,
-				     CFTimeInterval latency,
-				     FSEventStreamCreateFlags flags);
-CFStringRef CFStringCreateWithCString(void *allocator, const char *string,
-				      CFStringEncoding encoding);
-CFArrayRef CFArrayCreate(void *allocator, const void **items, long long count,
-			 void *callbacks);
-void CFRunLoopRun(void);
-void CFRunLoopStop(CFRunLoopRef run_loop);
-CFRunLoopRef CFRunLoopGetCurrent(void);
-extern CFStringRef kCFRunLoopDefaultMode;
-void FSEventStreamScheduleWithRunLoop(FSEventStreamRef stream,
-				      CFRunLoopRef run_loop,
-				      CFStringRef run_loop_mode);
-unsigned char FSEventStreamStart(FSEventStreamRef stream);
-void FSEventStreamStop(FSEventStreamRef stream);
-void FSEventStreamInvalidate(FSEventStreamRef stream);
-void FSEventStreamRelease(FSEventStreamRef stream);
+#include "fsm-darwin-gcc.h"
 #else
-/*
- * Let Apple's headers declare `isalnum()` first, before
- * Git's headers override it via a constant
- */
-#include <string.h>
 #include <CoreFoundation/CoreFoundation.h>
 #include <CoreServices/CoreServices.h>
 #endif
-- 
gitgitgadget

