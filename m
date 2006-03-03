From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH 1/3] cg-mv doesn't work with bash 3.1.7 due to
	excessive quotes
Date: Fri, 03 Mar 2006 09:11:07 -0500
Message-ID: <1141395067.30343.14.camel@dv>
References: <20060303011154.14619.71590.stgit@dv.roinet.com>
	 <7vbqwo3xo4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 03 15:11:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFB0C-0001NA-Hb
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 15:11:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWCCOLZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 09:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWCCOLZ
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 09:11:25 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:31915 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751091AbWCCOLZ
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Mar 2006 09:11:25 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FFB03-0000QA-HW
	for git@vger.kernel.org; Fri, 03 Mar 2006 09:11:21 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1FFAzs-0007xp-4R; Fri, 03 Mar 2006 09:11:08 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqwo3xo4.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.5.92 (2.5.92-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17152>

On Thu, 2006-03-02 at 21:27 -0800, Junio C Hamano wrote:
> Pavel Roskin <proski@gnu.org> writes:
> 
> > -	ARGS2["${#ARGS2[@]}"]="$_git_relpath${arg%/}"
> > +	ARGS2[${#ARGS2[@]}]="$_git_relpath${arg%/}"
> 
> Is this an application bug?  It looks like a workaround for a
> bug in the shell...

Indeed, bash 3.00.16 (FC4) is fine with the original cg-mv.  On the
other hand, bash 3.1.7 (FC development) doesn't even like this:

$ arg["0"]=0
bash: "0": syntax error: operand expected (error token is ""0"")

I don't see any relevant information in the NEWS file, so even if it's
no a bug, it's an undocumented feature :-)

Anyway, the quotes are excessive, bash is (sort of) correct to complain
about it, and I don't see any other instances of quoting array arguments
in cogito.

The quotes in question have always existed in cg-mv, they were not added
to work around anything.

-- 
Regards,
Pavel Roskin
