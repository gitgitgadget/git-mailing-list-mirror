Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACDEB1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 21:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfKMVOb (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 16:14:31 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:47034 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfKMVO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 16:14:29 -0500
Received: by mail-wr1-f52.google.com with SMTP id b3so4012674wrs.13
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 13:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ulXd4IThug2U96xg6JWSWBuRUK5z8mgnfvbgtowERFM=;
        b=Hz7umNncFbb+BlVJogWprpqrn4gNWhzfw5LqfQHN5f+4bxktANzpnRJLDzvHj5HtK4
         cq0ATfBX9eHemxweTonufctoK2L14OdVEWJJYxeaJCKN2W0YVl5Mz7eOODlqxHg46y8b
         3LsLiw83hTpTXardWGOhKV5JQSnKalUAV19jqxOL6+GmKmwkYeaPosDbqvxFWwM05/FF
         pvpGXnIsM6XBmKCnDkuufVzbMuJusztKSnDDHqUEolVYYzmP05QljDcveCaC7mDKnZjQ
         iC1U+cWillD0fpgXEp1U9wK5/9w6qMIQUddIh+y1BNX8uYGTCan1/nrFjuv4jOFYU8qX
         XfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ulXd4IThug2U96xg6JWSWBuRUK5z8mgnfvbgtowERFM=;
        b=VB+Q9gu5sl7ZPkjHngzjou1/0CuevOVu58uzzJsCAQVSc2bXrVzNWtxwm+MYOI1bUh
         K728Lr1yI+L9ztrN+EBi1TG2a17zDQUeBS6QMbaamFpPDd9qDo7oqDprYZawF0voPE4J
         9gqPw4gOXK6YB1KwA/IMQjyQCxCeLR0+3qJkclMBD+lwunho9pD6vbCmPyvSa1OKOhpV
         jPBwTMXrqtVJkT/c30EPMlMAhx4DtabSxinkGG4YgvhiCkzHyi15CMO/j2VPi3yrtHWU
         ga/nummM6wvpe2p9jG4DvToLHZLIigOIkmwsqfRf9oxZtShrDhR+4GWSK3mHPa5CUamN
         KFRQ==
X-Gm-Message-State: APjAAAXwAEa+hSz/LXOzvg23AeFNZPKZs6TvBV9hP15zjLFZlO7gx43T
        7XS9+2nxG/HAB52ULHsyuBmqLBHM
X-Google-Smtp-Source: APXvYqzHu2NhXvezCjOJgZXTnyDmBsMAaQHrtLUQWXRYRf9WbdaD48/XHzzyDkB19ovBhAmzMWYLtA==
X-Received: by 2002:a5d:6789:: with SMTP id v9mr4731368wru.344.1573679667272;
        Wed, 13 Nov 2019 13:14:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q17sm3547620wmj.12.2019.11.13.13.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 13:14:26 -0800 (PST)
Message-Id: <0bca930ff82623bbef172b4cb6c36ef8e5c46098.1573679665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.465.git.1573679665.gitgitgadget@gmail.com>
References: <pull.465.git.1573679665.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Nov 2019 21:14:24 +0000
Subject: [PATCH 1/2] Cast byte strings to unicode strings in python3
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Keene <bkeene@partswatch.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <bkeene@partswatch.com>

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 60c73b6a37..6e8b3a26cd 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -36,12 +36,22 @@
     unicode = str
     bytes = bytes
     basestring = (str,bytes)
+    isunicode = True
+    def ustring(text):
+        """Returns the byte string as a unicode string"""
+        if text == '' or text == b'':
+            return ''
+        return unicode(text, "utf-8")
 else:
     # 'unicode' exists, must be Python 2
     str = str
     unicode = unicode
     bytes = str
     basestring = basestring
+    isunicode = False
+    def ustring(text):
+        """Returns the byte string unchanged"""
+        return text
 
 try:
     from subprocess import CalledProcessError
@@ -196,6 +206,8 @@ def read_pipe_full(c):
     expand = isinstance(c,basestring)
     p = subprocess.Popen(c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=expand)
     (out, err) = p.communicate()
+    out = ustring(out)
+    err = ustring(err)
     return (p.returncode, out, err)
 
 def read_pipe(c, ignore_error=False):
@@ -263,6 +275,7 @@ def p4_has_move_command():
     cmd = p4_build_cmd(["move", "-k", "@from", "@to"])
     p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
     (out, err) = p.communicate()
+    err = ustring(err)
     # return code will be 1 in either case
     if err.find("Invalid option") >= 0:
         return False
@@ -646,10 +659,18 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
             if skip_info:
                 if 'code' in entry and entry['code'] == 'info':
                     continue
+                if b'code' in entry and entry[b'code'] == b'info':
+                    continue
             if cb is not None:
                 cb(entry)
             else:
-                result.append(entry)
+                if isunicode:
+                    out = {}
+                    for key, value in entry.items():
+                        out[ustring(key)] = ustring(value)
+                    result.append(out)
+                else:
+                    result.append(entry)
     except EOFError:
         pass
     exitCode = p4.wait()
@@ -792,7 +813,7 @@ def gitConfig(key, typeSpecifier=None):
         cmd += [ key ]
         s = read_pipe(cmd, ignore_error=True)
         _gitConfig[key] = s.strip()
-    return _gitConfig[key]
+    return ustring(_gitConfig[key])
 
 def gitConfigBool(key):
     """Return a bool, using git config --bool.  It is True only if the
@@ -860,6 +881,7 @@ def branch_exists(branch):
     cmd = [ "git", "rev-parse", "--symbolic", "--verify", branch ]
     p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
     out, _ = p.communicate()
+    out = ustring(out)
     if p.returncode:
         return False
     # expect exactly one line of output: the branch name
-- 
gitgitgadget

