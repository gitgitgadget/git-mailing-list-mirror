From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: gitk patch display corner-case bug
Date: Sun, 19 Feb 2006 00:36:18 +0100
Message-ID: <20060218233618.GA29025@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 00:36:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAbd1-0004g0-0r
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 00:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWBRXgf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 18 Feb 2006 18:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWBRXgf
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 18:36:35 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:46098 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S932298AbWBRXge (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 18:36:34 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FAbcg-0007ZC-00; Sat, 18 Feb 2006 23:36:18 +0000
To: Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16422>

In a recently updated stgit tree,

  $ git-diff 51cb39db\^ 51cb39db
  diff --git a/templates/covermail.tmpl b/templates/covermail.tmpl
  index 9789c9c..44cd19e 100644
  --- a/templates/covermail.tmpl
  +++ b/templates/covermail.tmpl
  @@ -4,5 +4,5 @@ Date: %(date)s
   %(endofheaders)s
   The following series implements...
  =20
  ---
  +--=20
   Signature

That is, a trailing whitespace was added after the two dashes.
However, gitk displays this as

  index 9789c9c..44cd19e 100644
  @@ -2,7 +2,7 @@ From: %(maintainer)s
   Subject: [PATCH%(version)s%(number)s] Series short description
   Date: %(date)s
   %(endofheaders)s
   The following series implements...
  =20
  +--=20
   Signature

Totally correct except that it omitted the line consisting of only
three dashes.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
