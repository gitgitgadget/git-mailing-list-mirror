From: Philip Oakley <philipoakley@iee.org>
Subject: [RFC 1/4] Fix i18n -o option in msvc engine.pl
Date: Thu, 20 Nov 2014 23:37:59 +0000
Message-ID: <1416526682-6024-2-git-send-email-philipoakley@iee.org>
References: <1416526682-6024-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Wookey <michaelwookey@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Msysgit <msysgit@googlegroups.com>
To: GitList <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBRXWXGRQKGQERQXTYHQ@googlegroups.com Fri Nov 21 00:37:46 2014
Return-path: <msysgit+bncBDSOTWHYX4PBBRXWXGRQKGQERQXTYHQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f63.google.com ([74.125.82.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBRXWXGRQKGQERQXTYHQ@googlegroups.com>)
	id 1XrbIF-0002Ws-CM
	for gcvm-msysgit@m.gmane.org; Fri, 21 Nov 2014 00:37:43 +0100
Received: by mail-wg0-f63.google.com with SMTP id b13sf327058wgh.18
        for <gcvm-msysgit@m.gmane.org>; Thu, 20 Nov 2014 15:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe;
        bh=IMQrvIO/DZO+oA3SiC8aBhAmUe1OvXZf+rQ173XWMgU=;
        b=ETyK0HbN+TPP3ZnAnxFJDiuh5i4MBC14orTVq149hwjIqI3QlDmkUwLeREs8ke0WWK
         bFicAEps4/cai4OgRyDxE/O3SbjlEpW2RXO1pROxbgRmhh0VY1regdrpBYWe++fWosnr
         ct5JmgYoAnOOPfwQpexChbXgg3+8SKv7MLli5rpM4FeF4lCZD0iWIFzJaPf4W/B5oIsi
         R/h0iuQMlumE9lIqi5a0JnlKKqSX4uaoO39+HMR2JhHJk6IUCzXRgh16tWVC0LL86Ayj
         s0M32Z844SisusyYawFuNg0/0q8RkM726LVWEBi4x1LSwLlS2Exy+9kLiEWFx7uC3iCA
         sn+g==
X-Received: by 10.180.14.33 with SMTP id m1mr103536wic.20.1416526663204;
        Thu, 20 Nov 2014 15:37:43 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.90.146 with SMTP id bw18ls76481wib.23.canary; Thu, 20 Nov
 2014 15:37:42 -0800 (PST)
X-Received: by 10.181.12.37 with SMTP id en5mr9855198wid.6.1416526662465;
        Thu, 20 Nov 2014 15:37:42 -0800 (PST)
Received: from out1.ip06ir2.opaltelecom.net (out1.ip06ir2.opaltelecom.net. [62.24.128.242])
        by gmr-mx.google.com with ESMTP id jv2si90840wid.1.2014.11.20.15.37.42
        for <msysgit@googlegroups.com>;
        Thu, 20 Nov 2014 15:37:42 -0800 (PST)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.242 as permitted sender) client-ip=62.24.128.242;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmoOAPx5blROl3PwPGdsb2JhbABagw5VWYI2hFPET4dLBAICgQYXAQEBAQEBBQEBAQE4O4QDAQVWIxAISTkKFAYTiEXUfAELIJEIB4RLBZc1iRyZBj0wgksBAQE
X-IPAS-Result: AmoOAPx5blROl3PwPGdsb2JhbABagw5VWYI2hFPET4dLBAICgQYXAQEBAQEBBQEBAQE4O4QDAQVWIxAISTkKFAYTiEXUfAELIJEIB4RLBZc1iRyZBj0wgksBAQE
X-IronPort-AV: E=Sophos;i="5.07,426,1413241200"; 
   d="scan'208";a="651403018"
Received: from host-78-151-115-240.as13285.net (HELO localhost) ([78.151.115.240])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 20 Nov 2014 23:37:42 +0000
X-Mailer: git-send-email 1.9.4.msysgit.0
In-Reply-To: <1416526682-6024-1-git-send-email-philipoakley@iee.org>
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.242 as permitted sender) smtp.mail=philipoakley@iee.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>

    The i18n 5e9637c6 introduced an extra '-o' option
    into the make file, which broke engine.pl code for
    extracting the git.sln for msvc gui-IDE.
    add tests for 'msgfmt' and its precursor 'mkdir'
    (in same vein as 74cf9bdda6).

    Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 contrib/buildsystems/engine.pl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 23da787..9144ea7 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -140,6 +140,18 @@ sub parseMakeOutput
             next;
         }
 
+        if ($text =~ /^mkdir /) {
+            # options to the Portable Object translations in the line
+            # mkdir -p po/... && msgfmt ... (eg -o) may be mistaken for linker options
+            next;
+        }
+
+        if ($text =~ /^msgfmt /) {
+            # options to the Portable Object translations in the line
+            # mkdir -p po/... && msgfmt ... (eg -o) may be mistaken for linker options
+            next;
+        }
+
         if($text =~ / -c /) {
             # compilation
             handleCompileLine($text, $line);
-- 
1.9.4.msysgit.0

-- 
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

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
