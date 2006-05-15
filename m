From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH 1/3] Don't die when there are no branches
Date: Mon, 15 May 2006 11:53:24 +0200
Message-ID: <20060515095324.GA11386@backpacker.hemma.treskal.com>
References: <20060510060040.GA3034@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wartan Hachaturow <wartan.hachaturow@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 11:53:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfZlz-0003Be-Tv
	for gcvg-git@gmane.org; Mon, 15 May 2006 11:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWEOJx2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 15 May 2006 05:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWEOJx2
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 05:53:28 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:23496 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932348AbWEOJx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 05:53:27 -0400
Received: from backpacker.hemma.treskal.com ([83.227.180.148] [83.227.180.148])
          by mxfep02.bredband.com with ESMTP
          id <20060515095325.CHWE29698.mxfep02.bredband.com@backpacker.hemma.treskal.com>;
          Mon, 15 May 2006 11:53:25 +0200
Received: by backpacker.hemma.treskal.com (Postfix, from userid 1000)
	id 373AB26DE; Mon, 15 May 2006 11:53:24 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060510060040.GA3034@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20041>

Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>


---

 stgit/commands/branch.py |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

c32f6b7bfd81bdbdb136ff72a4ad073e162ab97c
diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index c7561a8..2218bbb 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -174,11 +174,14 @@ def func(parser, options, args):
=20
         branches =3D os.listdir(os.path.join(basedir.get(), 'refs', 'h=
eads'))
         branches.sort()
-        max_len =3D max([len(i) for i in branches])
=20
-        print 'Available branches:'
-        for i in branches:
-            __print_branch(i, max_len)
+        if branches:
+            print 'Available branches:'
+            max_len =3D max([len(i) for i in branches])
+            for i in branches:
+                __print_branch(i, max_len)
+        else:
+            print 'No branches'
         return
=20
     elif options.protect:
--=20
1.3.2.g639c


--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
