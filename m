From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2] contrib: add win32 credential-helper
Date: Thu, 19 Apr 2012 20:45:22 +0200
Message-ID: <1334861122-3144-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com,
	peff@peff.net
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxDQusH8BBoEWpdOOg@googlegroups.com Thu Apr 19 20:45:38 2012
Return-path: <msysgit+bncCOPdven-DxDQusH8BBoEWpdOOg@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f186.google.com ([209.85.217.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxDQusH8BBoEWpdOOg@googlegroups.com>)
	id 1SKwMK-0002hQ-IL
	for gcvm-msysgit@m.gmane.org; Thu, 19 Apr 2012 20:45:36 +0200
Received: by lbbgn12 with SMTP id gn12sf2027077lbb.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 19 Apr 2012 11:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=AsOirSTluW0+voq37SEAKI2qIHO3WsE5iXql5Nzqzq0=;
        b=ZMvw+9hgCldK5MuqlmgiyqWoMWk19RbWxHGjOuGBkCYPrXt+Kg5gK/gSBeCbURRSK3
         oSAumhsVy1dem/ad7kWjDve1ppUf+xoSq4FB9WLe/O7kHj7NNZg8/MW7tQc0Gq1zHzbp
         o0xpbwiPvS3CZ8cHqdcQWgURHY8H1lf17u7pk=
Received: by 10.205.136.196 with SMTP id il4mr279671bkc.9.1334861136120;
        Thu, 19 Apr 2012 11:45:36 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.205.128.6 with SMTP id hc6ls2595091bkc.3.gmail; Thu, 19 Apr
 2012 11:45:34 -0700 (PDT)
Received: by 10.204.143.143 with SMTP id v15mr389991bku.8.1334861134529;
        Thu, 19 Apr 2012 11:45:34 -0700 (PDT)
Received: by 10.204.143.143 with SMTP id v15mr389990bku.8.1334861134509;
        Thu, 19 Apr 2012 11:45:34 -0700 (PDT)
Received: from mail-lpp01m010-f52.google.com (mail-lpp01m010-f52.google.com [209.85.215.52])
        by gmr-mx.google.com with ESMTPS id cs9si3635091bkb.3.2012.04.19.11.45.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Apr 2012 11:45:34 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.52 as permitted sender) client-ip=209.85.215.52;
Received: by mail-lpp01m010-f52.google.com with SMTP id i5so10688180lah.39
        for <msysgit@googlegroups.com>; Thu, 19 Apr 2012 11:45:34 -0700 (PDT)
Received: by 10.152.145.169 with SMTP id sv9mr728736lab.12.1334861134229;
        Thu, 19 Apr 2012 11:45:34 -0700 (PDT)
Received: from localhost (cm-84.215.107.111.getinternet.no. [84.215.107.111])
        by mx.google.com with ESMTPS id mm11sm3157945lab.2.2012.04.19.11.45.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Apr 2012 11:45:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.52 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195961>

Since the Windows port of Git expects binary pipes, we need to make
sure the helper-end also sets up binary pipes.

Side-step CRLF-issue in test to make it pass.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

Here's an updated version of my Windows credential-helper.

The most important difference is that it doesn't suck as much as
it used to ;)

Basically, I'm now using the attribute-system to store the meta-data
for the credentials.

This passes the test for me, and seems to work OK.

 contrib/credential/wincred/Makefile                |    8 +
 .../credential/wincred/git-credential-wincred.c    |  352 ++++++++++++++++++++
 t/lib-credential.sh                                |    4 +
 3 files changed, 364 insertions(+), 0 deletions(-)
 create mode 100644 contrib/credential/wincred/Makefile
 create mode 100644 contrib/credential/wincred/git-credential-wincred.c

diff --git a/contrib/credential/wincred/Makefile b/contrib/credential/wincred/Makefile
new file mode 100644
index 0000000..b4f098f
--- /dev/null
+++ b/contrib/credential/wincred/Makefile
@@ -0,0 +1,8 @@
+all: git-credential-wincred.exe
+
+CC = gcc
+RM = rm -f
+CFLAGS = -O2 -Wall
+
+git-credential-wincred.exe : git-credential-wincred.c
+	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@
diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
new file mode 100644
index 0000000..e63575f
--- /dev/null
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -0,0 +1,352 @@
+/*
+ * A git credential helper that interface with Windows' Credential Manager
+ *
+ */
+#include <windows.h>
+#include <stdio.h>
+#include <io.h>
+#include <fcntl.h>
+
+/* common helpers */
+
+static void die(const char *err, ...)
+{
+	char msg[4096];
+	va_list params;
+	va_start(params, err);
+	vsnprintf(msg, sizeof(msg), err, params);
+	fprintf(stderr, "%s\n", msg);
+	va_end(params);
+	exit(1);
+}
+
+static void *xmalloc(size_t size)
+{
+	void *ret = malloc(size);
+	if (!ret && !size)
+		ret = malloc(1);
+	if (!ret)
+		 die("Out of memory");
+	return ret;
+}
+
+static char *xstrdup(const char *str)
+{
+	char *ret = strdup(str);
+	if (!ret)
+		die("Out of memory");
+	return ret;
+}
+
+/* MinGW doesn't have wincred.h, so we need to define stuff */
+
+typedef struct _CREDENTIAL_ATTRIBUTEW {
+	LPWSTR Keyword;
+	DWORD  Flags;
+	DWORD  ValueSize;
+	LPBYTE Value;
+} CREDENTIAL_ATTRIBUTEW, *PCREDENTIAL_ATTRIBUTEW;
+
+typedef struct _CREDENTIALW {
+	DWORD                  Flags;
+	DWORD                  Type;
+	LPWSTR                 TargetName;
+	LPWSTR                 Comment;
+	FILETIME               LastWritten;
+	DWORD                  CredentialBlobSize;
+	LPBYTE                 CredentialBlob;
+	DWORD                  Persist;
+	DWORD                  AttributeCount;
+	PCREDENTIAL_ATTRIBUTEW Attributes;
+	LPWSTR                 TargetAlias;
+	LPWSTR                 UserName;
+} CREDENTIALW, *PCREDENTIALW;
+
+#define CRED_TYPE_GENERIC 1
+#define CRED_PERSIST_LOCAL_MACHINE 2
+#define CRED_MAX_ATTRIBUTES 64
+
+typedef BOOL (WINAPI *CredWriteWT)(PCREDENTIALW, DWORD);
+typedef BOOL (WINAPI *CredUnPackAuthenticationBufferWT)(DWORD, PVOID, DWORD,
+    LPWSTR, DWORD *, LPWSTR, DWORD *, LPWSTR, DWORD *);
+typedef BOOL (WINAPI *CredEnumerateWT)(LPCWSTR, DWORD, DWORD *,
+    PCREDENTIALW **);
+typedef BOOL (WINAPI *CredPackAuthenticationBufferWT)(DWORD, LPWSTR, LPWSTR,
+    PBYTE, DWORD *);
+typedef VOID (WINAPI *CredFreeT)(PVOID);
+typedef BOOL (WINAPI *CredDeleteWT)(LPCWSTR, DWORD, DWORD);
+
+static HMODULE advapi, credui;
+static CredWriteWT CredWriteW;
+static CredUnPackAuthenticationBufferWT CredUnPackAuthenticationBufferW;
+static CredEnumerateWT CredEnumerateW;
+static CredPackAuthenticationBufferWT CredPackAuthenticationBufferW;
+static CredFreeT CredFree;
+static CredDeleteWT CredDeleteW;
+
+static void load_cred_funcs(void)
+{
+	/* load DLLs */
+	advapi = LoadLibrary("advapi32.dll");
+	credui = LoadLibrary("credui.dll");
+	if (!advapi || !credui)
+		die("failed to load DLLs");
+
+	/* get function pointers */
+	CredWriteW = (CredWriteWT)GetProcAddress(advapi, "CredWriteW");
+	CredUnPackAuthenticationBufferW = (CredUnPackAuthenticationBufferWT)
+	    GetProcAddress(credui, "CredUnPackAuthenticationBufferW");
+	CredEnumerateW = (CredEnumerateWT)GetProcAddress(advapi,
+	    "CredEnumerateW");
+	CredPackAuthenticationBufferW = (CredPackAuthenticationBufferWT)
+	    GetProcAddress(credui, "CredPackAuthenticationBufferW");
+	CredFree = (CredFreeT)GetProcAddress(advapi, "CredFree");
+	CredDeleteW = (CredDeleteWT)GetProcAddress(advapi, "CredDeleteW");
+	if (!CredWriteW || !CredUnPackAuthenticationBufferW ||
+	    !CredEnumerateW || !CredPackAuthenticationBufferW || !CredFree ||
+	    !CredDeleteW)
+		die("failed to load functions");
+}
+
+static char target_buf[1024];
+static char *protocol, *host, *path, *username;
+static WCHAR *wusername, *password, *target;
+
+static void write_item(const char *what, WCHAR *wbuf)
+{
+	char *buf;
+	int len = WideCharToMultiByte(CP_UTF8, 0, wbuf, -1, NULL, 0, NULL,
+	    FALSE);
+	buf = xmalloc(len);
+
+	if (!WideCharToMultiByte(CP_UTF8, 0, wbuf, -1, buf, len, NULL, FALSE))
+		die("WideCharToMultiByte failed!");
+
+	printf("%s=", what);
+	fwrite(buf, 1, len - 1, stdout);
+	putchar('\n');
+	free(buf);
+}
+
+static int match_attr(const CREDENTIALW *cred, const WCHAR *keyword,
+    const char *want)
+{
+	int i;
+	if (!want)
+		return 1;
+
+	for (i = 0; i < cred->AttributeCount; ++i)
+		if (!wcscmp(cred->Attributes[i].Keyword, keyword))
+			return !strcmp((const char *)cred->Attributes[i].Value,
+			    want);
+
+	return 0; /* not found */
+}
+
+static int match_cred(const CREDENTIALW *cred)
+{
+	return (!wusername || !wcscmp(wusername, cred->UserName)) &&
+	    match_attr(cred, L"git_protocol", protocol) &&
+	    match_attr(cred, L"git_host", host) &&
+	    match_attr(cred, L"git_path", path);
+}
+
+static void get_credential(void)
+{
+	WCHAR *user_buf, *pass_buf;
+	DWORD user_buf_size = 0, pass_buf_size = 0;
+	CREDENTIALW **creds, *cred = NULL;
+	DWORD num_creds;
+	int i;
+
+	if (!CredEnumerateW(L"git:*", 0, &num_creds, &creds))
+		return;
+
+	/* search for the first credential that matches username */
+	for (i = 0; i < num_creds; ++i)
+		if (match_cred(creds[i])) {
+			cred = creds[i];
+			break;
+		}
+	if (!cred)
+		return;
+
+	CredUnPackAuthenticationBufferW(0, cred->CredentialBlob,
+	    cred->CredentialBlobSize, NULL, &user_buf_size, NULL, NULL,
+	    NULL, &pass_buf_size);
+
+	user_buf = xmalloc(user_buf_size * sizeof(WCHAR));
+	pass_buf = xmalloc(pass_buf_size * sizeof(WCHAR));
+
+	if (!CredUnPackAuthenticationBufferW(0, cred->CredentialBlob,
+	    cred->CredentialBlobSize, user_buf, &user_buf_size, NULL, NULL,
+	    pass_buf, &pass_buf_size))
+		die("CredUnPackAuthenticationBuffer failed");
+
+	CredFree(creds);
+
+	/* zero-terminate (sizes include zero-termination) */
+	user_buf[user_buf_size - 1] = L'\0';
+	pass_buf[pass_buf_size - 1] = L'\0';
+
+	write_item("username", user_buf);
+	write_item("password", pass_buf);
+
+	free(user_buf);
+	free(pass_buf);
+}
+
+static void write_attr(CREDENTIAL_ATTRIBUTEW *attr, const WCHAR *keyword,
+    const char *value)
+{
+	attr->Keyword = (LPWSTR)keyword;
+	attr->Flags = 0;
+	attr->ValueSize = strlen(value) + 1; /* store zero-termination */
+	attr->Value = (LPBYTE)value;
+}
+
+static void store_credential(void)
+{
+	CREDENTIALW cred;
+	BYTE *auth_buf;
+	DWORD auth_buf_size = 0;
+	CREDENTIAL_ATTRIBUTEW attrs[CRED_MAX_ATTRIBUTES];
+
+	if (!wusername || !password)
+		return;
+
+	/* query buffer size */
+	CredPackAuthenticationBufferW(0, wusername, password,
+	    NULL, &auth_buf_size);
+
+	auth_buf = xmalloc(auth_buf_size);
+
+	if (!CredPackAuthenticationBufferW(0, wusername, password,
+	    auth_buf, &auth_buf_size))
+		die("CredPackAuthenticationBuffer failed");
+
+	cred.Flags = 0;
+	cred.Type = CRED_TYPE_GENERIC;
+	cred.TargetName = target;
+	cred.Comment = L"saved by git-credential-wincred";
+	cred.CredentialBlobSize = auth_buf_size;
+	cred.CredentialBlob = auth_buf;
+	cred.Persist = CRED_PERSIST_LOCAL_MACHINE;
+	cred.AttributeCount = 2;
+	cred.Attributes = attrs;
+	cred.TargetAlias = NULL;
+	cred.UserName = wusername;
+
+	write_attr(attrs, L"git_protocol", protocol);
+	write_attr(attrs + 1, L"git_host", host);
+
+	if (path) {
+		write_attr(attrs + 2, L"git_path", path);
+		cred.AttributeCount++;
+	}
+
+	if (!CredWriteW(&cred, 0))
+		die("CredWrite failed");
+}
+
+static void erase_credential(void)
+{
+	CREDENTIALW **creds;
+	DWORD num_creds;
+	int i;
+
+	if (!CredEnumerateW(L"git:*", 0, &num_creds, &creds))
+		return;
+
+	for (i = 0; i < num_creds; ++i) {
+		if (match_cred(creds[i]))
+			CredDeleteW(creds[i]->TargetName, creds[i]->Type, 0);
+	}
+
+	CredFree(creds);
+}
+
+static WCHAR *utf8_to_utf16_dup(const char *str)
+{
+	int wlen = MultiByteToWideChar(CP_UTF8, 0, str, -1, NULL, 0);
+	WCHAR *wstr = xmalloc(sizeof(WCHAR) * wlen);
+	MultiByteToWideChar(CP_UTF8, 0, str, -1, wstr, wlen);
+	return wstr;
+}
+
+static void read_credential(void)
+{
+	char buf[1024];
+
+	while (fgets(buf, sizeof(buf), stdin)) {
+		char *v;
+
+		if (!strcmp(buf, "\n"))
+			break;
+		buf[strlen(buf)-1] = '\0';
+
+		v = strchr(buf, '=');
+		if (!v)
+			die("bad input: %s", buf);
+		*v++ = '\0';
+
+		if (!strcmp(buf, "protocol"))
+			protocol = xstrdup(v);
+		else if (!strcmp(buf, "host"))
+			host = xstrdup(v);
+		else if (!strcmp(buf, "path"))
+			path = xstrdup(v);
+		else if (!strcmp(buf, "username")) {
+			username = xstrdup(v);
+			wusername = utf8_to_utf16_dup(v);
+		} else if (!strcmp(buf, "password"))
+			password = utf8_to_utf16_dup(v);
+		else
+			die("unrecognized input");
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	const char *usage =
+	    "Usage: git credential-wincred <get|store|erase>\n";
+
+	if (!argv[1])
+		die(usage);
+
+	/* git use binary pipes to avoid CRLF-issues */
+	_setmode(_fileno(stdin), _O_BINARY);
+	_setmode(_fileno(stdout), _O_BINARY);
+
+	read_credential();
+
+	load_cred_funcs();
+
+	if (!protocol || !host)
+		return 0;
+
+	/* prepare 'target', the unique key for the credential */
+	strncat(target_buf, "git:", sizeof(target_buf));
+	strncat(target_buf, protocol, sizeof(target_buf));
+	strncat(target_buf, "://", sizeof(target_buf));
+	if (username) {
+		strncat(target_buf, username, sizeof(target_buf));
+		strncat(target_buf, "@", sizeof(target_buf));
+	}
+	strncat(target_buf, host, sizeof(target_buf));
+	if (path) {
+		strncat(target_buf, "/", sizeof(target_buf));
+		strncat(target_buf, path, sizeof(target_buf));
+	}
+
+	target = utf8_to_utf16_dup(target_buf);
+
+	if (!strcmp(argv[1], "get"))
+		get_credential();
+	else if (!strcmp(argv[1], "store"))
+		store_credential();
+	else if (!strcmp(argv[1], "erase"))
+		erase_credential();
+	/* otherwise, ignore unknown action */
+	return 0;
+}
diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index 4a37cd7..d30ae8a 100755
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -8,6 +8,10 @@ check() {
 	read_chunk >expect-stdout &&
 	read_chunk >expect-stderr &&
 	test-credential "$@" <stdin >stdout 2>stderr &&
+	if test_have_prereq MINGW
+	then
+		dos2unix -q stderr
+	fi &&
 	test_cmp expect-stdout stdout &&
 	test_cmp expect-stderr stderr
 }
-- 
1.7.9

-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***

*** Please avoid top-posting. ***

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en
