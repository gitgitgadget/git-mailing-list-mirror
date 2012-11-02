From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Set core.ignorecase globally
Date: Fri, 2 Nov 2012 19:03:37 +0400
Message-ID: <20121102190337.66a08366de41d29e745b0e4c@domain007.com>
References: <6DB2AD2A-6531-497E-B87E-0E884C4BCFBE@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 16:04:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUImu-000539-Mp
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 16:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755465Ab2KBPDn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2012 11:03:43 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:54770 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806Ab2KBPDm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 11:03:42 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id qA2F3bRn026492;
	Fri, 2 Nov 2012 19:03:38 +0400
In-Reply-To: <6DB2AD2A-6531-497E-B87E-0E884C4BCFBE@jetbrains.com>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208944>

On Fri, 2 Nov 2012 18:39:26 +0400
Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com> wrote:

> Currently, core.ignorecase is set to true on case insensitive system
> like Windows or Mac on `git init` and `git clone`, and this setting
> is local to the created/cloned repository.
[...]
> I suggest to set this globally by default when Git is installed,
> because there is little sense to have this option false on case
> insensitive systems (it will lead to confusions when renaming a file
> by changing only the case of letters).=20

Case sensitivity is a property of a file system, not the OS.
What if I mount a device with ext3 file system via ext2fsd driver in on
my Windows workstation?  extN have POSIX semantics so it's pointless to
enforce case insensitivity on them.  The same possibly applies to NFS
mounts.

Also note that NTFS (at least by default) is case insensitive but is
case preserving, observe:

C:\tmp>dir /b
foo

C:\tmp>rename foo Foo

C:\tmp>dir /b
=46oo

C:\tmp>del fOO

C:\tmp>dir /b

C:\tmp>ver

Microsoft Windows XP [=F7=C5=D2=D3=C9=D1 5.1.2600]

I don't really know what to make out of this, but I'd not change the
defaults until the reasons to do this are not really pressing (and
they're not for now).
