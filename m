From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Set core.ignorecase globally
Date: Fri, 2 Nov 2012 19:15:16 +0400
Message-ID: <20121102191516.e8b7d448ff76b45990e14b1d@domain007.com>
References: <6DB2AD2A-6531-497E-B87E-0E884C4BCFBE@jetbrains.com>
	<20121102190337.66a08366de41d29e745b0e4c@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>,
	git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Nov 02 16:16:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUIyI-0003Be-8n
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 16:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756574Ab2KBPPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 11:15:33 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:54877 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755554Ab2KBPPd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 11:15:33 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id qA2FFGij027031;
	Fri, 2 Nov 2012 19:15:17 +0400
In-Reply-To: <20121102190337.66a08366de41d29e745b0e4c@domain007.com>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208945>

On Fri, 2 Nov 2012 19:03:37 +0400
Konstantin Khomoutov <flatworm@users.sourceforge.net> wrote:

> > Currently, core.ignorecase is set to true on case insensitive system
> > like Windows or Mac on `git init` and `git clone`, and this setting
> > is local to the created/cloned repository.
> [...]
> > I suggest to set this globally by default when Git is installed,
> > because there is little sense to have this option false on case
> > insensitive systems (it will lead to confusions when renaming a file
> > by changing only the case of letters). 
> 
> Case sensitivity is a property of a file system, not the OS.
> What if I mount a device with ext3 file system via ext2fsd driver in
> on my Windows workstation?  extN have POSIX semantics so it's
> pointless to enforce case insensitivity on them.  The same possibly
> applies to NFS mounts.
> 
> Also note that NTFS (at least by default) is case insensitive but is
> case preserving, observe:
[...]

On the other hand, on NTFS, if I unset core.ignorecase or set it to
false locally, `git mv foo Foo` fails to rename a tracked file "foo"
with the "destination file exists" error.  I would say I would expect it
to work under the conditions I've just described.  Not sure if this
thould be considered a bug in Git for Windows or not -- would be great
to hear opinions of the msysgit port developers.
