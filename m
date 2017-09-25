Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C03BB202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 16:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965196AbdIYQGg (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 12:06:36 -0400
Received: from mout.gmx.net ([212.227.17.20]:59711 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935462AbdIYQGe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 12:06:34 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMpYB-1e06PO1Pqh-008bUw; Mon, 25
 Sep 2017 18:06:25 +0200
Date:   Mon, 25 Sep 2017 18:06:24 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 1/1] Win32: simplify loading of DLL functions
In-Reply-To: <cover.1506355545.git.johannes.schindelin@gmx.de>
Message-ID: <177d34742e603aabb57046a0d5f9a5c6e40696ca.1506355545.git.johannes.schindelin@gmx.de>
References: <f5a3add27206df3e7f39efeac8a3c3b47f2b79f2.1505834586.git.johannes.schindelin@gmx.de> <cover.1506355545.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:EHsERf6fXVUlK3MrNA9QO+YGAC2M/vEZgnCd9PVxc8mhOd2RVWT
 HLdSbxx183ZqzACO2RYKCA4gFo8flXFCc64l1CSUvO/XVNgO9XsysOk15QcQZUoZFPVCM60
 Q26QD7sgnu4kZhEBs8Uhw3tigvw2V04D4/cZJ24aaTVw4fy7vZLKpnZOKaEMFyuDX9YX/xS
 vqo7E1ZJk7dW/vIn4Qdzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D5JVsg34jhk=:gxykIsLuCNODVe/wjnOYMd
 AEbHNQtmg2QHjl9Qe+DfhL7g5Bf3PtiGv6vOE7Xseu9AGx+M8v58NVSyA0hBudF5F1kHFJuxS
 jjL0EYTItIBzDTMtfveYROye1Y/ExHfbF4dMdmgVVd/htlfFGgRjoSHR9/odSB9/bjSu5d8mC
 J4u0PRbxS9V3j+O+gXg2RtvH6XEqK9WwGMrMUkZPjIaiKFax7b3kZTbqV6tRiihbJ9Q+Dgi9D
 /JzNCmehV2q3WkWFBP8qRcvVyqG57tspM6ZOr7Dda3WLsqBrpW7j+/ELVcQ90G69XR2lrGBu3
 6PlWizt1IWLRMMPHJ/SJ2d+vLb7pSVKKmJBop+MpKpix4vh4Kl6uaQvbt0cIlZmHQin9JDq9x
 sR8knlUwVlHt1JbCjwoKFApieeB3GblyzOsobd+ZkPfDdwiC6pVVjmaasw6vPjX4pBytkDoyW
 41xm+kkqosIJOCnZnjNxFkG46e3Jj+D4+JRtDHc0jFLy4am4cjJudn+oiYwz2MWGuXl9B5PR2
 HsIguFQWIZs0PtxjbLjbF7ryPgbUtoT25Pd9a++MMQxpBlFVRWBkfEm6feQ48FbqMo6DQzV1m
 9Co8CD/AJ3cdKhCX+7vwSebPmPyEGnKBU+LLmN6nNAhs+VknHklhb6M2p4CAjNGqw+FW+kYA3
 Z+KHiUtL9Xt0uKZpEhNFLR/CpGsY9MZ5VgjmqyhcublmDnaYgHxXr8/OaGIhwX2ydPK/hRt8T
 AuN6b5LqHEEn7ldVBPoyUoMRs+mM9YTtGiWG2PIZfS9yZUaTn787skYh+mKms99Ulv5UHl8YI
 SG8Wm8XxRQFdaGjOVOyVGK/iIy3u+KDdZxpAkERiXut0eBeY08=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dynamic loading of DLL functions is duplicated in several places in Git
for Windows' source code.

This patch adds a pair of macros to simplify the process: the
DECLARE_PROC_ADDR(<dll>, <return-type>, <function-name>,
...<function-parameter-types>...) macro to be used at the beginning of a
code block, and the INIT_PROC_ADDR(<function-name>) macro to call before
using the declared function. The return value of the INIT_PROC_ADDR()
call has to be checked; If it is NULL, the function was not found in the
specified DLL.

Example:

        DECLARE_PROC_ADDR(kernel32.dll, BOOL, CreateHardLinkW,
                          LPCWSTR, LPCWSTR, LPSECURITY_ATTRIBUTES);

        if (!INIT_PROC_ADDR(CreateHardLinkW))
                return error("Could not find CreateHardLinkW() function";

	if (!CreateHardLinkW(source, target, NULL))
		return error("could not create hardlink from %S to %S",
			     source, target);
	return 0;

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/win32/lazyload.h | 57 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 compat/win32/lazyload.h

diff --git a/compat/win32/lazyload.h b/compat/win32/lazyload.h
new file mode 100644
index 00000000000..9e631c8593f
--- /dev/null
+++ b/compat/win32/lazyload.h
@@ -0,0 +1,57 @@
+#ifndef LAZYLOAD_H
+#define LAZYLOAD_H
+
+/*
+ * A pair of macros to simplify loading of DLL functions. Example:
+ *
+ *   DECLARE_PROC_ADDR(kernel32.dll, BOOL, CreateHardLinkW,
+ *                     LPCWSTR, LPCWSTR, LPSECURITY_ATTRIBUTES);
+ *
+ *   if (!INIT_PROC_ADDR(CreateHardLinkW))
+ *           return error("Could not find CreateHardLinkW() function";
+ *
+ *   if (!CreateHardLinkW(source, target, NULL))
+ *           return error("could not create hardlink from %S to %S",
+ *                        source, target);
+ */
+
+struct proc_addr {
+	const char *const dll;
+	const char *const function;
+	FARPROC pfunction;
+	unsigned initialized : 1;
+};
+
+/* Declares a function to be loaded dynamically from a DLL. */
+#define DECLARE_PROC_ADDR(dll, rettype, function, ...) \
+	static struct proc_addr proc_addr_##function = \
+	{ #dll, #function, NULL, 0 }; \
+	static rettype (WINAPI *function)(__VA_ARGS__)
+
+/*
+ * Loads a function from a DLL (once-only).
+ * Returns non-NULL function pointer on success.
+ * Returns NULL + errno == ENOSYS on failure.
+ * This function is not thread-safe.
+ */
+#define INIT_PROC_ADDR(function) \
+	(function = get_proc_addr(&proc_addr_##function))
+
+static inline void *get_proc_addr(struct proc_addr *proc)
+{
+	/* only do this once */
+	if (!proc->initialized) {
+		HANDLE hnd;
+		proc->initialized = 1;
+		hnd = LoadLibraryExA(proc->dll, NULL,
+				     LOAD_LIBRARY_SEARCH_SYSTEM32);
+		if (hnd)
+			proc->pfunction = GetProcAddress(hnd, proc->function);
+	}
+	/* set ENOSYS if DLL or function was not found */
+	if (!proc->pfunction)
+		errno = ENOSYS;
+	return proc->pfunction;
+}
+
+#endif
-- 
2.14.1.windows.1.1024.gf2dea585d74.dirty
