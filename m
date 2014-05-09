From: William Giokas <1007380@gmail.com>
Subject: [PATCH] svn-fe: Conform to pep8
Date: Thu,  8 May 2014 21:36:50 -0500
Message-ID: <1399603010-2429-1-git-send-email-1007380@gmail.com>
Cc: William Giokas <1007380@gmail.com>, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 04:37:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiagU-0004EU-DO
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 04:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754166AbaEIChG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 22:37:06 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:43247 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbaEIChF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 22:37:05 -0400
Received: by mail-ig0-f171.google.com with SMTP id c1so601305igq.16
        for <git@vger.kernel.org>; Thu, 08 May 2014 19:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=QhlpXkQ1HNxw9g0LgQLZ/kW4Fg1mr5jXeF5Eq2idy+0=;
        b=sBijEHk5kjiTu8oIgahUx6NtTFNc84nmrVibdInc6JOPlXhQMsbbHK86cdwBX8vjh/
         VyShPtMOpkp6K/Rhmwp/t7EJItezGLhLwZzloOFqDNe8bQcyOgGEQaoOomQNU052ECX1
         uJVoVsCUhqDEq9s2Rkwgsj8Yf9Hdwuq0kPH7vbC1/klKWwJSFHNJRwydSUbZ8YsiL2Ao
         v/HHu/yovD00v22h/OoOkHfOK0JQFvwsxFwzS35QU5FsQFM3UmbS9+5+6/T+p0U09y0j
         ZcQaOB5u+aK0900g9SEwuWuCqRxUAph9c10/7rECEouEii4ujlJJig2iRikehKQqzWnJ
         WmcQ==
X-Received: by 10.50.254.36 with SMTP id af4mr3209055igd.24.1399603023604;
        Thu, 08 May 2014 19:37:03 -0700 (PDT)
Received: from localhost (of2-nat1.sat6.rackspace.com. [50.56.228.64])
        by mx.google.com with ESMTPSA id hi8sm3364648igb.8.2014.05.08.19.37.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 19:37:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248507>

Quite a large change, most of this was whitespace changes, though there
were a few places where I removed a comma or added a few characters.
Should pass through pep8 and pass every test.
---
 contrib/svn-fe/svnrdump_sim.py | 93 +++++++++++++++++++++++-------------------
 1 file changed, 52 insertions(+), 41 deletions(-)

diff --git a/contrib/svn-fe/svnrdump_sim.py b/contrib/svn-fe/svnrdump_sim.py
index 4e78a1c..11ac6f6 100755
--- a/contrib/svn-fe/svnrdump_sim.py
+++ b/contrib/svn-fe/svnrdump_sim.py
@@ -5,53 +5,64 @@ of the specified revision range.
 To simulate incremental imports the environment variable SVNRMAX can be set
 to the highest revision that should be available.
 """
-import sys, os
+import sys
+import os
 
 if sys.hexversion < 0x02040000:
-        # The limiter is the ValueError() calls. This may be too conservative
-        sys.stderr.write("svnrdump-sim.py: requires Python 2.4 or later.\n")
-        sys.exit(1)
+    # The limiter is the ValueError() calls. This may be too conservative
+    sys.stderr.write("svnrdump-sim.py: requires Python 2.4 or later.\n")
+    sys.exit(1)
+
 
 def getrevlimit():
-        var = 'SVNRMAX'
-        if var in os.environ:
-                return os.environ[var]
-        return None
+    var = 'SVNRMAX'
+    if var in os.environ:
+        return os.environ[var]
+    return None
+
 
 def writedump(url, lower, upper):
-        if url.startswith('sim://'):
-                filename = url[6:]
-                if filename[-1] == '/': filename = filename[:-1] #remove terminating slash
-        else:
-                raise ValueError('sim:// url required')
-        f = open(filename, 'r');
-        state = 'header'
-        wroterev = False
-        while(True):
-                l = f.readline()
-                if l == '': break
-                if state == 'header' and l.startswith('Revision-number: '):
-                        state = 'prefix'
-                if state == 'prefix' and l == 'Revision-number: %s\n' % lower:
-                        state = 'selection'
-                if not upper == 'HEAD' and state == 'selection' and l == 'Revision-number: %s\n' % upper:
-                        break;
+    if url.startswith('sim://'):
+        filename = url[6:]
+        if filename[-1] == '/':
+            filename = filename[:-1]  # remove terminating slash
+    else:
+        raise ValueError('sim:// url required')
+    f = open(filename, 'r')
+    state = 'header'
+    wroterev = False
+    while(True):
+        l = f.readline()
+        if l == '':
+            break
+        if state == 'header' and l.startswith('Revision-number: '):
+            state = 'prefix'
+        if state == 'prefix' and l == 'Revision-number: %s\n' % lower:
+            state = 'selection'
+        if not upper == 'HEAD' and state == 'selection' and \
+                l == 'Revision-number: %s\n' % upper:
+            break
 
-                if state == 'header' or state == 'selection':
-                        if state == 'selection': wroterev = True
-                        sys.stdout.write(l)
-        return wroterev
+        if state == 'header' or state == 'selection':
+            if state == 'selection':
+                wroterev = True
+            sys.stdout.write(l)
+    return wroterev
 
 if __name__ == "__main__":
-        if not (len(sys.argv) in (3, 4, 5)):
-                print("usage: %s dump URL -rLOWER:UPPER")
-                sys.exit(1)
-        if not sys.argv[1] == 'dump': raise NotImplementedError('only "dump" is suppported.')
-        url = sys.argv[2]
-        r = ('0', 'HEAD')
-        if len(sys.argv) == 4 and sys.argv[3][0:2] == '-r':
-                r = sys.argv[3][2:].lstrip().split(':')
-        if not getrevlimit() is None: r[1] = getrevlimit()
-        if writedump(url, r[0], r[1]): ret = 0
-        else: ret = 1
-        sys.exit(ret)
+    if not (len(sys.argv) in (3, 4, 5)):
+        print("usage: %s dump URL -rLOWER:UPPER")
+        sys.exit(1)
+    if not sys.argv[1] == 'dump':
+        raise NotImplementedError('only "dump" is suppported.')
+    url = sys.argv[2]
+    r = ('0', 'HEAD')
+    if len(sys.argv) == 4 and sys.argv[3][0:2] == '-r':
+        r = sys.argv[3][2:].lstrip().split(':')
+    if not getrevlimit() is None:
+        r[1] = getrevlimit()
+    if writedump(url, r[0], r[1]):
+        ret = 0
+    else:
+        ret = 1
+    sys.exit(ret)
-- 
2.0.0.rc2
