From: Andreas Gruenbacher <agruen-mXXj517/zsQ@public.gmane.org>
Subject: GNU patch close to next stable release
Date: Tue, 17 Apr 2012 18:07:53 +0200
Message-ID: <201204171807.54771.agruen@gnu.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bug-patch-mXXj517/zsQ@public.gmane.org
X-From: bug-patch-bounces+gcgpb-bug-patch=m.gmane.org-mXXj517/zsQ@public.gmane.org Tue Apr 17 18:08:15 2012
Return-path: <bug-patch-bounces+gcgpb-bug-patch=m.gmane.org-mXXj517/zsQ@public.gmane.org>
Envelope-to: gcgpb-bug-patch@m.gmane.org
Received: from lists.gnu.org ([208.118.235.17])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <bug-patch-bounces+gcgpb-bug-patch=m.gmane.org-mXXj517/zsQ@public.gmane.org>)
	id 1SKAwr-00006Q-Gn
	for gcgpb-bug-patch@m.gmane.org; Tue, 17 Apr 2012 18:08:09 +0200
Received: from localhost ([::1]:40097 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bug-patch-bounces+gcgpb-bug-patch=m.gmane.org-mXXj517/zsQ@public.gmane.org>)
	id 1SKAwq-0001Os-Pr
	for gcgpb-bug-patch@m.gmane.org; Tue, 17 Apr 2012 12:08:08 -0400
Received: from eggs.gnu.org ([208.118.235.92]:38573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agruen-mXXj517/zsQ@public.gmane.org>) id 1SKAwl-0001OD-H3
	for bug-patch-mXXj517/zsQ@public.gmane.org; Tue, 17 Apr 2012 12:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agruen-mXXj517/zsQ@public.gmane.org>) id 1SKAwf-00060u-6D
	for bug-patch-mXXj517/zsQ@public.gmane.org; Tue, 17 Apr 2012 12:08:03 -0400
Received: from zimbra.linbit.com ([212.69.161.123]:52542)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agruen-mXXj517/zsQ@public.gmane.org>) id 1SKAwe-0005zz-Sh
	for bug-patch-mXXj517/zsQ@public.gmane.org; Tue, 17 Apr 2012 12:07:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 723741B4354;
	Tue, 17 Apr 2012 18:07:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.linbit.com
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CKprqg9XtP0m; Tue, 17 Apr 2012 18:07:55 +0200 (CEST)
Received: from murkel.localnet (unknown [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTPSA id 5C04A1B4350;
	Tue, 17 Apr 2012 18:07:55 +0200 (CEST)
User-Agent: KMail/1.12.4 (Linux/2.6.36-rc7+; KDE/4.3.5; i686; ; )
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.6 (newer, 3)
X-Received-From: 212.69.161.123
X-BeenThere: bug-patch-mXXj517/zsQ@public.gmane.org
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: "Bug reports, suggestions,
	general discussion for GNU patch." <bug-patch.gnu.org>
List-Unsubscribe: <https://lists.gnu.org/mailman/options/bug-patch>,
	<mailto:bug-patch-request-mXXj517/zsQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/bug-patch>
List-Post: <mailto:bug-patch-mXXj517/zsQ@public.gmane.org>
List-Help: <mailto:bug-patch-request-mXXj517/zsQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/bug-patch>,
	<mailto:bug-patch-request-mXXj517/zsQ@public.gmane.org?subject=subscribe>
Errors-To: bug-patch-bounces+gcgpb-bug-patch=m.gmane.org-mXXj517/zsQ@public.gmane.org
Sender: bug-patch-bounces+gcgpb-bug-patch=m.gmane.org-mXXj517/zsQ@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195768>

I'm glad to announce that finally, support for git-style diffs is working well 
enough, and no more major issues seem to be in our way before the next stable 
release of GNU patch.

Some things have changed significantly recently in order to get the code 
release ready, so now would be a really great time for an extra round of 
testing.

You can find the latest snapshot here:

  ftp://alpha.gnu.org/gnu/patch/

The last stable release dates back to December 2009 with version 2.6.1.  The 
following significant changes have happened since then:

* Support for most features of the "diff --git" format, including renames and
  copies, permission changes, and symlink diffs.  Binary diffs are not
  supported yet; patch will complain and skip them.

* Support for double-quoted filenames in the "diff --git" format: when a
  filename starts with a double quote, it is interpreted as a C string
  literal.  The escape sequences \\, \", \a, \b, \f, \n, \r, \t, \v, and \ooo
  (a three-digit octal number between 0 and 255) are recognized.

* Patch now ignores destination file names that are absolute or that contain
  a component of "..".  This addresses CVE-2010-4651.

* Refuse to apply a normal patch to a symlink.  (Previous versions of patch
  were replacing the symlink with a regular file.)

* When trying to modify a read-only file, warn about the potential problem
  by default.  The --read-only command line option allows to change this
  behavior.

* Files that should be deleted are now deleted once the entire patch file has
  been read.  This fixes a bug with numbered backup files.

* When a timestamp specifies a time zone, honor that instead of assuming the
  local time zone (--set-date) or Universal Coordinated Time (--set-utc).

* Support for nanosecond precision timestamps.

* Many portability and bug fixes.

Please report bugs or suggestions on the <bug-patch-mXXj517/zsQ@public.gmane.org> mailing list, or 
in the project's bug tracker on Savannah:

  http://savannah.gnu.org/projects/patch

Thanks,
Andreas
