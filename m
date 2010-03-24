From: hachi <hachi@kuiki.net>
Subject: asciidoc problem, and a possible fix
Date: Wed, 24 Mar 2010 16:34:53 -0700
Message-ID: <4ABB29E2-6DB1-4712-A3E8-CD524983FB0B@kuiki.net>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: multipart/mixed; boundary=Apple-Mail-15--891282455
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 25 00:35:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nua6J-0003Hd-Dc
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 00:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217Ab0CXXe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 19:34:57 -0400
Received: from sachiko.kuiki.net ([80.68.89.100]:59768 "EHLO sachiko.kuiki.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888Ab0CXXe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 19:34:56 -0400
Received: from lan-235-sf2-it-gw1.sixapart.net (unknown [204.9.180.30])
	by sachiko.kuiki.net (Postfix) with ESMTP id 864E2C049
	for <git@vger.kernel.org>; Wed, 24 Mar 2010 23:34:55 +0000 (UTC)
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143137>


--Apple-Mail-15--891282455
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hello folks,

I had an issue building git on some centos 5 machines today, and in =
trying to interpret the error message I formed the attached patch.

The errors were:
xmlto: input does not validate (status 1)
=
/home/hachi/rpm/BUILD/git-1.7.0.3/Documentation/git-filter-branch.xml:463:=
 parser error : PCDATA invalid Char value 7
Clone it with <literal>git clone +++0+++</literal>.  The clone
                                    ^
=
/home/hachi/rpm/BUILD/git-1.7.0.3/Documentation/git-filter-branch.xml:463:=
 parser error : PCDATA invalid Char value 7
Clone it with <literal>git clone +++0+++</literal>.  The clone


I will happily admit that I don't know asciidoc, or the use of asciidoc =
in git.... but the +++ marker surrounding the url seems to not be used =
anywhere else in the documents directory, and I seem to be getting the =
appropriate output because of the `` surrounding the command.

I'm not subscribed to the list, but I'll try to watch for replies. Would =
anyone like to either tell me I did this wrong, or apply my fix?

Thanks much,

hachi


--Apple-Mail-15--891282455
Content-Disposition: attachment;
	filename=asciidoc-problem.patch
Content-Type: application/octet-stream;
	name="asciidoc-problem.patch"
Content-Transfer-Encoding: 7bit

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 020028c..4f71c17 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -386,7 +386,7 @@ objects until you tell it to.  First make sure that:
 Then there are two ways to get a smaller repository.  A safer way is
 to clone, that keeps your original intact.
 
-* Clone it with `git clone +++file:///path/to/repo+++`.  The clone
+* Clone it with `git clone file:///path/to/repo`.  The clone
   will not have the removed objects.  See linkgit:git-clone[1].  (Note
   that cloning with a plain path just hardlinks everything!)
 

--Apple-Mail-15--891282455--
