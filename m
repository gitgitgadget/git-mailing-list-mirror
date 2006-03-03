From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH 1/3] cg-mv doesn't work with bash 3.1.7 due to excessive quotes
Date: Fri, 3 Mar 2006 17:34:16 +0100
Message-ID: <200603031734.16315.Josef.Weidendorfer@gmx.de>
References: <20060303011154.14619.71590.stgit@dv.roinet.com> <7vbqwo3xo4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Mar 03 17:35:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFDEb-00061l-J9
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 17:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWCCQeY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 11:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWCCQeY
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 11:34:24 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:5058 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S932265AbWCCQeX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Mar 2006 11:34:23 -0500
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id 10489BD;
	Fri,  3 Mar 2006 17:34:18 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.1
In-Reply-To: <7vbqwo3xo4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17157>

On Friday 03 March 2006 06:27, you wrote:
> Pavel Roskin <proski@gnu.org> writes:
> 
> > -	ARGS2["${#ARGS2[@]}"]="$_git_relpath${arg%/}"
> > +	ARGS2[${#ARGS2[@]}]="$_git_relpath${arg%/}"
> 
> Is this an application bug?  It looks like a workaround for a
> bug in the shell...

This line in cg-mv is needed to work around at least two
bugs in git-mv:
* "git-mv a/ b/" not working.
  Fix was to strip all trailing slashes of args (fixed in 1.2.4)
* "cd subdir; git-mv ../file ."
  Fix is to run git-mv from base directory (see separate patch for git-mv)
I think cg-mv should be able to be a direct wrapper for git-mv with
the next maintenance release.

Pasky: do you know of other problems with git-mv?

Josef
