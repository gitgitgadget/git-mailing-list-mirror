From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2 0/2] improve-wincred-compatibility
Date: Thu, 10 Jan 2013 13:10:02 +0100
Message-ID: <50EEAF9A.6020302@gmail.com>
References: <50E73B80.4070105@gmail.com> <CABPQNSYcOrOZJd0vK=4ESC4qPpcj7RRdhVt3R0dAE-ouhOb5YA@mail.gmail.com> <50EC473A.6060203@gmail.com> <CABPQNSb7MjTKgmeB9TcUV0+-FfjPZ1sgKPsfVDg6+uaw2f_azQ@mail.gmail.com>
Reply-To: blees@dcon.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: kusmabite@gmail.com, msysgit@googlegroups.com, 
 Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: msysgit+bncBCH3XYXLXQDBBG67XKDQKGQEADG7LII@googlegroups.com Thu Jan 10 13:10:21 2013
Return-path: <msysgit+bncBCH3XYXLXQDBBG67XKDQKGQEADG7LII@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f188.google.com ([209.85.217.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBG67XKDQKGQEADG7LII@googlegroups.com>)
	id 1TtGxg-0001O2-2B
	for gcvm-msysgit@m.gmane.org; Thu, 10 Jan 2013 13:10:20 +0100
Received: by mail-lb0-f188.google.com with SMTP id n10sf226746lbo.15
        for <gcvm-msysgit@m.gmane.org>; Thu, 10 Jan 2013 04:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-received:message-id:date:from:reply-to:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=pbQz470p2vThFImxMIUHBGAFfhew8Ek+wMFrAF4Yv2A=;
        b=fNh1oQrumoDYmMgNxA3ahpAI1z4rOGE5ryGe0mM62rT/rFefxouvxLKhyT3Kinhxm7
         KWDkITp+rg6i1UWBJRG3QsmlWXf2j3sfeNs+Y8EjivSlw+GlFlFfxr7h3zHaK72lLPdl
         BcWFG53dyAV92XShcW06E2X40868wMMu7VSlksXqbPz3jIASDEMiU5ThkyinuPfG1YBB
         zpFJ9yCgO0qgwsKvy3Jmpko4mSc5RZgE62bgi7Y8Yn6L7X6PV8LyN+pjy4x1T4S9ixuF
         Tb954GRk7DU4v9fn9kTW1 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-received:message-id:date:from:reply-to:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=pbQz470p2vThFImxMIUHBGAFfhew8Ek+wMFrAF4Yv2A=;
        b=MQW+R2pVGV0CqovLhjRFklsIcWr0umC1M7/4NC5yvu9eKgIgovEhnIXDHueTBvDZkx
         ZuL3OUJ4SKbn4h2Tg5Ijpz1l1D/fFiuaIKQL1v+5AT1syAaq+tjZ32Xg/4GrMd1Qm8Rm
         RcWWfDI55SBBq/mBfP6xcxbotleuOx3sccjYCE+6RBPchp9KuvodgXd57MbtnXs9PmuB
         Nx3BhcridgICD5YmE1HED2Y/K/qKH0X2PwXz/z3QoI9qM+u57TJUh+nnCK1wEx0LyqSN
         1VJI3DsJHHTYILUF1TGe0wU1rm0G 
X-Received: by 10.180.86.165 with SMTP id q5mr1232127wiz.16.1357819804047;
        Thu, 10 Jan 2013 04:10:04 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.181.11.194 with SMTP id ek2ls2830569wid.1.canary; Thu, 10 Jan
 2013 04:10:03 -0800 (PST)
X-Received: by 10.204.128.65 with SMTP id j1mr3308939bks.7.1357819803033;
        Thu, 10 Jan 2013 04:10:03 -0800 (PST)
X-Received: by 10.204.128.65 with SMTP id j1mr3308938bks.7.1357819803009;
        Thu, 10 Jan 2013 04:10:03 -0800 (PST)
Received: from mail-lb0-f176.google.com (mail-lb0-f176.google.com [209.85.217.176])
        by gmr-mx.google.com with ESMTPS id e21si126041bkv.2.2013.01.10.04.10.02
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Jan 2013 04:10:03 -0800 (PST)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 209.85.217.176 as permitted sender) client-ip=209.85.217.176;
Received: by mail-lb0-f176.google.com with SMTP id k6so421274lbo.35
        for <msysgit@googlegroups.com>; Thu, 10 Jan 2013 04:10:02 -0800 (PST)
X-Received: by 10.152.144.164 with SMTP id sn4mr68385412lab.57.1357819802679;
        Thu, 10 Jan 2013 04:10:02 -0800 (PST)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id fe4sm709849lbb.1.2013.01.10.04.10.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Jan 2013 04:10:01 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <CABPQNSb7MjTKgmeB9TcUV0+-FfjPZ1sgKPsfVDg6+uaw2f_azQ@mail.gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 209.85.217.176 as
 permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213138>

Changes since initial version (see attached diff for details):
- split in two patches
- removed unused variables
- improved the dll error message
- changed ?: to if else
- added comments

Also available here:
https://github.com/kblees/git/tree/kb/improve-wincred-compatibility-v2
git pull git://github.com/kblees/git.git kb/improve-wincred-compatibility-v2

Karsten Blees (2):
  wincred: accept CRLF on stdin to simplify console usage
  wincred: improve compatibility with windows versions

 .../credential/wincred/git-credential-wincred.c    | 206 ++++++++-------------
 1 file changed, 75 insertions(+), 131 deletions(-)


> git diff kb/improve-wincred-compatibility..kb/improve-wincred-compatibility-v2
diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index 3464080..dac19ea 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -66,7 +66,7 @@ typedef BOOL (WINAPI *CredEnumerateWT)(LPCWSTR, DWORD, DWORD *,
 typedef VOID (WINAPI *CredFreeT)(PVOID);
 typedef BOOL (WINAPI *CredDeleteWT)(LPCWSTR, DWORD, DWORD);
 
-static HMODULE advapi, credui;
+static HMODULE advapi;
 static CredWriteWT CredWriteW;
 static CredEnumerateWT CredEnumerateW;
 static CredFreeT CredFree;
@@ -77,7 +77,7 @@ static void load_cred_funcs(void)
 	/* load DLLs */
 	advapi = LoadLibrary("advapi32.dll");
 	if (!advapi)
-		die("failed to load DLLs");
+		die("failed to load advapi32.dll");
 
 	/* get function pointers */
 	CredWriteW = (CredWriteWT)GetProcAddress(advapi, "CredWriteW");
@@ -107,14 +107,34 @@ static void write_item(const char *what, LPCWSTR wbuf, int wlen)
 	free(buf);
 }
 
+/*
+ * Match an (optional) expected string and a delimiter in the target string,
+ * consuming the matched text by updating the target pointer.
+ */
 static int match_part(LPCWSTR *ptarget, LPCWSTR want, LPCWSTR delim)
 {
-	LPCWSTR start = *ptarget;
-	LPCWSTR end = *delim ? wcsstr(start, delim) : start + wcslen(start);
-	int len = end ? end - start : wcslen(start);
+	LPCWSTR delim_pos, start = *ptarget;
+	int len;
+
+	/* find start of delimiter (or end-of-string if delim is empty) */
+	if (*delim)
+		delim_pos = wcsstr(start, delim);
+	else
+		delim_pos = start + wcslen(start);
+
+	/*
+	 * match text up to delimiter, or end of string (e.g. the '/' after
+	 * host is optional if not followed by a path)
+	 */
+	if (delim_pos)
+		len = delim_pos - start;
+	else
+		len = wcslen(start);
+
 	/* update ptarget if we either found a delimiter or need a match */
-	if (end || want)
-		*ptarget = end ? end + wcslen(delim) : start + len;
+	if (delim_pos || want)
+		*ptarget = delim_pos ? delim_pos + wcslen(delim) : start + len;
+
 	return !want || (!wcsncmp(want, start, len) && !want[len]);
 }
 
@@ -157,9 +177,6 @@ static void get_credential(void)
 static void store_credential(void)
 {
 	CREDENTIALW cred;
-	BYTE *auth_buf;
-	DWORD auth_buf_size = 0;
-	CREDENTIAL_ATTRIBUTEW attrs[CRED_MAX_ATTRIBUTES];
 
 	if (!wusername || !password)
 		return;

-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en
