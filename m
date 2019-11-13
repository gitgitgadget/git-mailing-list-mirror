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
	by dcvr.yhbt.net (Postfix) with ESMTP id 31E511F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 21:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfKMVHm (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 16:07:42 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:35647 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfKMVHl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 16:07:41 -0500
Received: by mail-wr1-f41.google.com with SMTP id s5so4043228wrw.2
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 13:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ulXd4IThug2U96xg6JWSWBuRUK5z8mgnfvbgtowERFM=;
        b=fkWDjhuK9DTKIYVQFHBxLfVGGakEBVgiqrvQUDZSmuHTy1I5kuHTVCcB2++9iQ+slE
         xjkp/8s12brWWhKjljl2l47xkFkagCnYMkhrK6RqYFSfsO1k4W7gujQwiij3vJO1QsNZ
         uFgcKrRHa/l2Lb7L4DmqPI9cPcfrRVNXz7wCfI5ogGu+AzU74mF2RtTMF/fc2qLKqtuF
         7FQvrtwLbVcQTioQMu0IIw8z+oHqSP890aX5WG9s2FDmQcL5MhB4CThCQSLeZ56LeEM4
         QpzXo3C3DrUf/UHJ2mtPKr9Z2iD8ogiTow0wFNDOlFs1q5g7IKt2M1+uiSRnjq/YZ4pA
         OBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ulXd4IThug2U96xg6JWSWBuRUK5z8mgnfvbgtowERFM=;
        b=lfxqV3t9LjYBekrey+9VspeldaybazubL/LwLpj6Mp+Ecybgsm/QiPZTfCQR4vMd+p
         VEFIEGe06TVsxKO7YVpRZJs057DQyQR8Xds7b2oVn10oa6NH1Y43qt1/9HYOuJufkQRb
         +A4jno9AB9Ql089rC+tpKUKCin4ctv1RKdH23okhXtUnAybFPWMiNbXPIC9vO55kZS0a
         rKZYbBFzcjjDxQAfpPKxNtOQexwERDztZmujfoXQvWNqXX4vXkllM+txqggGtrJTlygS
         +lnMQlgD7lgiCChfjqto62wErZLIAPGdNphgC0B7W0eFExIMS5TpZAKR0sNzfYDpU1cq
         lkxg==
X-Gm-Message-State: APjAAAUMKbwnKkTk1MURjYjOFyOZYMcWLD1pJYVD+ogljXLC3cjeO2N6
        h1kFpNEWC2u02eO9mxcHvSX0xyRk
X-Google-Smtp-Source: APXvYqwIQxGrDJEnFBh5Qv8GZ3sTQjYPpniJ4pr22sK/jX42nIqE3E8k8EHn/IIRpu9uYeY5aWhaRg==
X-Received: by 2002:a05:6000:12d1:: with SMTP id l17mr4658264wrx.261.1573679259787;
        Wed, 13 Nov 2019 13:07:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm4369477wrw.6.2019.11.13.13.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 13:07:39 -0800 (PST)
Message-Id: <0bca930ff82623bbef172b4cb6c36ef8e5c46098.1573679258.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.git.1573679258.gitgitgadget@gmail.com>
References: <pull.463.git.1573679258.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Nov 2019 21:07:38 +0000
Subject: [PATCH 1/1] Cast byte strings to unicode strings in python3
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
