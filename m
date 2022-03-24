Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85452C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351834AbiCXQwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351838AbiCXQvn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:51:43 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16989AF1EA
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:50:11 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j18so7476913wrd.6
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fAa8hrpVrno1BmdEVVVe0xU+KaqvnFCI1tVOqmc3Cac=;
        b=gzTRkfeYg/6Sjb4OEjLhf8sTMR6wEm7/x5DDUole23jRBgY5RF26U7rxXPmC1Dsomm
         TmLrU/sTYzoIo2tu9qtF50t4OLnd4p5jzQWpP0xC9Pf4+pnZzdogRmiTYczcotiMbZDU
         VLQfK9krvACavQoKnM0NEkM+Sc/aeTEQ9+PnTGkWU5n8eL9DheYgLggNvV6oI8LDdATb
         ZQdyJEpAyaRoI3jfJxZcObWOYO19DBF98TAn/5Vx/zE1AtZrHK9isMgvUPCjOTbKCvYn
         N5PTH6BiObMkZDIYdGJK5EhyTwk2iwBw94D7FOAEEOyM5UtjpsoQgsIv8aXM5YtRjEgf
         v7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fAa8hrpVrno1BmdEVVVe0xU+KaqvnFCI1tVOqmc3Cac=;
        b=zVFKzGSVf1ty2tyf9tyNXoT7ZAguYjUjjrlt0P6FtRnXidXARnwdmpz1E317Ec1upT
         l/xwUdCy1XAyl7WLkSbEeRz6/Fw/w8Qrj3P/vohYekgExLZoo2HKR/A5wulEN+SggZyC
         /hFFEmHTN4eEG+Z2j42eh7+Fl7hilrkyjPP+SI6Oiio/BFnRUGYyqiI0UEdwUxr6+40M
         4orwsNTtn+R9Jy1ibHDn+ckSSzYY0EIuPP1E3F4bgxsBEmob9uC5++YR34RRONjDiMOR
         8Fa8noNYwfUupr9S2e9r4xR4ugZQhHpzenp5FQvJ+uSpl1pIPEmbbnkeQbUJkuWSJL7V
         12sw==
X-Gm-Message-State: AOAM532o4CpYqttWHJTXesYs7SU4mVAvhJ6T/SK4mqSvCmjAqJZVNC5z
        XulF8D72AK9FCKbNIWPuo4E0hdbEYPI=
X-Google-Smtp-Source: ABdhPJwzkmfzT/nxySwjCUfXypHNLcJjnhjiNla2o86HWgVD3faRMLrC6mdIJ3kbPVJ0mkOdQJMBSA==
X-Received: by 2002:adf:eb87:0:b0:1ef:85f5:6ab4 with SMTP id t7-20020adfeb87000000b001ef85f56ab4mr5568870wrn.158.1648140609129;
        Thu, 24 Mar 2022 09:50:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s17-20020adfdb11000000b001f02d5fea43sm3268723wri.98.2022.03.24.09.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:50:08 -0700 (PDT)
Message-Id: <14b775e9d8b1a4672f8175a546eb70e2790c1b23.1648140586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
References: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
        <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:49:32 +0000
Subject: [PATCH v8 16/30] compat/fsmonitor/fsm-listen-darwin: add MacOS header
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
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Include MacOS system declarations to allow us to use FSEvent and
CoreFoundation APIs.  We need different versions of the declarations
for GCC vs. clang because of compiler and header file conflicts.

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/fsmonitor/fsm-darwin-gcc.h    | 92 ++++++++++++++++++++++++++++
 compat/fsmonitor/fsm-listen-darwin.c | 24 ++++++++
 2 files changed, 116 insertions(+)
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
index c84e3344ab9..d2ce942cade 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -1,3 +1,27 @@
+#ifndef __clang__
+#include "fsm-darwin-gcc.h"
+#else
+#include <CoreFoundation/CoreFoundation.h>
+#include <CoreServices/CoreServices.h>
+
+#ifndef AVAILABLE_MAC_OS_X_VERSION_10_13_AND_LATER
+/*
+ * This enum value was added in 10.13 to:
+ *
+ * /Applications/Xcode.app/Contents/Developer/Platforms/ \
+ *    MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/ \
+ *    Library/Frameworks/CoreServices.framework/Frameworks/ \
+ *    FSEvents.framework/Versions/Current/Headers/FSEvents.h
+ *
+ * If we're compiling against an older SDK, this symbol won't be
+ * present.  Silently define it here so that we don't have to ifdef
+ * the logging or masking below.  This should be harmless since older
+ * versions of macOS won't ever emit this FS event anyway.
+ */
+#define kFSEventStreamEventFlagItemCloned         0x00400000
+#endif
+#endif
+
 #include "cache.h"
 #include "fsmonitor.h"
 #include "fsm-listen.h"
-- 
gitgitgadget

