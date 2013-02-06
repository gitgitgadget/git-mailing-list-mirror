From: Ted Zlatanov <tzz@lifelogs.com>
Subject: [PATCH v2] Update CodingGuidelines for Perl 5
Date: Wed, 06 Feb 2013 14:49:01 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <877gmlgr4i.fsf_-_@lifelogs.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v7gmumzo6.fsf@alter.siamese.dyndns.org>
	<87pq0l5qbc.fsf@lifelogs.com>
	<20130131193844.GA14460@sigill.intra.peff.net>
	<87k3qrx712.fsf@lifelogs.com>
	<20130203194148.GA26318@sigill.intra.peff.net>
	<87sj5cvxnf.fsf_-_@lifelogs.com>
	<7vk3qo2dsc.fsf@alter.siamese.dyndns.org>
	<87k3qoudxp.fsf@lifelogs.com>
	<7vvca7291z.fsf@alter.siamese.dyndns.org>
	<87lib3uats.fsf@lifelogs.com>
	<7v7gmn1xqi.fsf@alter.siamese.dyndns.org>
	<871ucto4vj.fsf_-_@lifelogs.com>
	<7vvca5mmmt.fsf@alter.siamese.dyndns.org>
	<87vca5gvx6.fsf@lifelogs.com>
	<CANgJU+VbkQ+xa+_sSAu-3pMe+6gycHi9J4VR18M5YJt=pa9QUw@mail.gmail.com>
	<87ip65guj8.fsf@lifelogs.com>
	<CANgJU+X=Bb=ncqOxsd1hZDWsnFkt-bJw=Zbtuz8_KC0gO-dLaQ@mail.gmail.com>
	<87bobxgtmw.fsf@lifelogs.com>
	<7vwqulb5el.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: demerphq <demerphq@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 20:49:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3Azo-0006eA-52
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 20:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758075Ab3BFTtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 14:49:06 -0500
Received: from z.lifelogs.com ([173.255.230.239]:60803 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755031Ab3BFTtD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 14:49:03 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 3E601DE0E3;
	Wed,  6 Feb 2013 19:49:02 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <7vwqulb5el.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 06 Feb 2013 11:37:06 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215628>

Update the coding guidelines for Perl 5.

Signed-off-by: Ted Zlatanov <tzz@lifelogs.com>
---
Changes since PATCHv1:
- removed brace guidelines
- add "don't try to be clever" at beginning

 Documentation/CodingGuidelines |   42 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 1d7de5f..166c141 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -18,6 +18,8 @@ code.  For Git in general, three rough rules are:
    judgement call, the decision based more on real world
    constraints people face than what the paper standard says.
 
+For any programming language below, make your code readable and sensible, and
+don't try to be clever.
 
 As for more concrete guidelines, just imitate the existing code
 (this is a good guideline, no matter which project you are
@@ -179,6 +181,46 @@ For C programs:
  - Use Git's gettext wrappers to make the user interface
    translatable. See "Marking strings for translation" in po/README.
 
+For Perl 5 programs:
+
+ - Most of the C guidelines above apply.
+
+ - We try to support Perl 5.8 and later ("use Perl 5.008").
+
+ - use strict and use warnings are strongly preferred.
+
+ - Don't abuse statement modifiers--they are discouraged.  But in general:
+
+	... do something ...
+	do_this() unless (condition);
+        ... do something else ...
+
+   should be used instead of
+
+	... do something ...
+	unless (condition) {
+		do_this();
+	}
+        ... do something else ...
+
+   *only* when when the condition is so rare that do_this() will be called
+   almost always.
+
+ - We try to avoid assignments inside if().
+
+ - Learn and use Git.pm if you need that functionality.
+
+ - For Emacs, it's useful to put the following in
+   GIT_CHECKOUT/.dir-locals.el, assuming you use cperl-mode:
+
+    ;; note the first part is useful for C editing, too
+    ((nil . ((indent-tabs-mode . t)
+                  (tab-width . 8)
+                  (fill-column . 80)))
+     (cperl-mode . ((cperl-indent-level . 8)
+                    (cperl-extra-newline-before-brace . nil)
+                    (cperl-merge-trailing-else . t))))
+
 Writing Documentation:
 
  Every user-visible change should be reflected in the documentation.
-- 
1.7.9.rc2
