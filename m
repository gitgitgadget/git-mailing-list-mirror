Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 401EF2093C
	for <e@80x24.org>; Fri,  9 Dec 2016 01:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753724AbcLIBrN (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 20:47:13 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35606 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752760AbcLIBrM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 20:47:12 -0500
Received: by mail-wm0-f43.google.com with SMTP id a197so5350139wmd.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 17:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:message-id:date:user-agent:mime-version;
        bh=BA5jhfzkGZVU+zv95mZgE1vmO0jdH+iHovbdTLR900k=;
        b=CSM7aCSe1UwmTTps+pdFfrx1uim2bCmojkX0ke1dkSeopdTpTM8Nyn5XQm0PFj/qep
         6dwmHs1pzxsTtcrdZx/rcgTRZgufq93YHYYS2K+Q86V0RwLgfO34QP+44bBkmeHxreLd
         62MwcACkxfXolo4C0KTMms5xoNnDzRC3jKhXCDt1Rgf0/9xNf/+zipaD9E+z5u4vNrRa
         nEn3IxFuYLWAE8z+NBnk0M7B2noJe4LI6NotbblWN2RKVHXvJ4Lax+GC3OZ3bmJ9Go0J
         fq1c04GDnrvU6scwnNNBaJhKFq0VudW2oi6Voc/BiHHlf2ZMKrCHIDayRAD+Bzei05JV
         2kPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version;
        bh=BA5jhfzkGZVU+zv95mZgE1vmO0jdH+iHovbdTLR900k=;
        b=FI1hRojgf9B+hScEUAcB/2gqQEjthA578ngv07pPlZ8iK3MlmGgHNDBZ8nW1dRnLXW
         X0dyClgU0woW837maTjtQsNv/QGGZAJk/nlZXVrwQvgeQKp3GJTDF5yzUVaqH31HY3q/
         /RX28M7ZE3uWTuaVRESXg+N8dD6f+4UXdKx4BCgygJlaDacRO/JE3tQOckIKV7RM0jIq
         yaJFVn2Gbdl3szrSCld8d3/NQdTytU7MmxOPB/+DimeboAU2nE1DmMRcAzg3/wI4/zvb
         0ak7z7Elftrm8xG6Be/gdDqwuQSTHL722jI0MAXHK1RQ0gKllJkk4jrhHMcfPGhDtC4l
         1iCg==
X-Gm-Message-State: AKaTC01flSApVGdQz2CMYk0JE2qfxA6Ob5dm1fcIOghbOCDYW0R1+ShX+QzjUszrYeKLtA==
X-Received: by 10.25.209.73 with SMTP id i70mr19803194lfg.24.1481248030107;
        Thu, 08 Dec 2016 17:47:10 -0800 (PST)
Received: from [192.168.1.102] ([46.151.157.21])
        by smtp.gmail.com with ESMTPSA id l137sm410664lfb.7.2016.12.08.17.47.09
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Dec 2016 17:47:09 -0800 (PST)
From:   unixway.drive@gmail.com
X-Google-Original-From: unixway.drive+git@gmail.com
Subject: [BUG] regarding `git add -p` and files containing wildcard characters
To:     git@vger.kernel.org
Message-ID: <c9876671-6252-5dfa-18df-a6719dc6834c@gmail.com>
Date:   Fri, 9 Dec 2016 04:46:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------A2C68850DC80F8EB203F238D"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------A2C68850DC80F8EB203F238D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

`git add -p` behaves incorrectly if modified file contains any wildcard 
character. Consider 'random.diff' (attached). For this, interactive 
'add' would first ask to add hunk with two diff headers (or with some 
"random" header at the end):

     $ git add -p
     diff --git a/Random * b/Random *
     index 01e79c3..01f03ff 100644
     --- a/Random *
     +++ b/Random *
     @@ -1,3 +1,5 @@
      1
     +  a
      2
     +  b
      3
     diff --git a/Random Crap b/Random Crap
     index 01e79c3..b4373d5 100644
     --- a/Random Crap
     +++ b/Random Crap
     Stage this hunk [y,n,q,a,d,/,j,J,g,s,e,?]? y

Then it will ask for some irrelevant hunk:

     @@ -1,3 +1,5 @@
      1
     +  whoa
      2
     +  dude
      3
     Stage this hunk [y,n,q,a,d,/,K,g,s,e,?]? y

…and, if confirmed, apply it to the wildcard-named file instead of what 
was confirmed for staging before:

     $ git diff --cached
     diff --git a/Random * b/Random *
     index 01e79c3..283ac91 100644
     --- a/Random *
     +++ b/Random *
     @@ -1,3 +1,5 @@
      1
     +  whoa
      2
     +  dude
      3

Then one can just repeat this over and over again (unless safely named 
files are resolved first):

     $ git add -p
     diff --git a/Random * b/Random *
     index 283ac91..04c92f1 100644
     --- a/Random *	
     +++ b/Random *	
     @@ -1,5 +1,5 @@
      1
     -  whoa
     +  a
      2
     -  dude
     +  b
      3
     diff --git a/Random Crap b/Random Crap
     index 01e79c3..283ac91 100644
     --- a/Random Crap	
     +++ b/Random Crap	
     Stage this hunk [y,n,q,a,d,/,j,J,g,s,e,?]?

The problem is that `git-diff-files` does some globbing on the 'path' 
arguments on its own and has no option to disable that (and 
`git-add--interactive`'s `run_cmd_pipe` already handles all other sorts 
of unsafe characters like spaces and backticks well).

     $ strace -f -e trace=execve git add -p
     …
     [pid  1713] execve("/usr/lib/git-core/git",
         ["git", "diff-files", "-p", "--", "Random *"],
     [/* 36 vars */]) = 0
     …
     $ git diff-files -- 'Random *'
     :100644 100644 … … M	Random *
     :100644 100644 … … M	Random Crap

For all the eager people (although I doubt if anybody else is lazy 
enough to not bother with file names like these), this could be easily 
worked around like this:

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index ee3d812..358d877 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -2,3 +2,3 @@

-use 5.008;
+use 5.014;
  use strict;
@@ -761,3 +761,5 @@ sub parse_diff {
         }
-       my @diff = run_cmd_pipe("git", @diff_cmd, "--", $path);
+       my @diff = run_cmd_pipe("git", @diff_cmd, "--", (
+               $path =~ s#[\[*?]#\\$&#gr
+       ));
         my @colored = ();

(Although a `git-diff-files` option is clearly a better solution that 
would cover tools other than `git-add--interactive` as well.)

--------------A2C68850DC80F8EB203F238D
Content-Type: text/x-patch;
 name="random.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="random.diff"

diff --git a/Random * b/Random *
index 01e79c3..04c92f1 100644
--- a/Random *	
+++ b/Random *	
@@ -1,3 +1,5 @@
 1
+  a
 2
+  b
 3
diff --git a/Random Crap b/Random Crap
index 01e79c3..283ac91 100644
--- a/Random Crap	
+++ b/Random Crap	
@@ -1,3 +1,5 @@
 1
+  whoa
 2
+  dude
 3

--------------A2C68850DC80F8EB203F238D--
