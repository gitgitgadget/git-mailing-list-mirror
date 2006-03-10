From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH 1/3] cg-mv doesn't work with bash 3.1.7 due to
	excessive quotes
Date: Fri, 10 Mar 2006 15:48:42 -0500
Message-ID: <1142023722.23830.8.camel@dv>
References: <20060303011154.14619.71590.stgit@dv.roinet.com>
	 <7vbqwo3xo4.fsf@assigned-by-dhcp.cox.net>  <1141395067.30343.14.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 10 21:49:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHoY3-0002lE-NR
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 21:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWCJUtA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 15:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWCJUtA
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 15:49:00 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:11658 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932229AbWCJUs7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 15:48:59 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FHoXe-0000p6-G5
	for git@vger.kernel.org; Fri, 10 Mar 2006 15:48:55 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1FHoXS-0005qp-Px; Fri, 10 Mar 2006 15:48:42 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <1141395067.30343.14.camel@dv>
X-Mailer: Evolution 2.5.92 (2.5.92-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17481>

Hello, Petr!

On Fri, 2006-03-03 at 09:11 -0500, Pavel Roskin wrote:
> On Thu, 2006-03-02 at 21:27 -0800, Junio C Hamano wrote:
> > Pavel Roskin <proski@gnu.org> writes:
> > 
> > > -	ARGS2["${#ARGS2[@]}"]="$_git_relpath${arg%/}"
> > > +	ARGS2[${#ARGS2[@]}]="$_git_relpath${arg%/}"

Any issues with this patch?  FC5 is due in a week.  Expect and outcry
from the new bash 3.1.7 users if the fixed cogito is not available
shortly.

Bash is not as wrong as it may seem.  Left hand side in assignments is
already a special case in earlier versions of bash, just not in the
index:

bash 3.00.16 (FC4)
$ f"oo"=bar
bash: foo=bar: command not found
$ foo["0"]=bar
$

bash 3.1.7 (FC5)
$ f"oo"=bar
bash: foo=bar: command not found
$ foo["0"]=bar
bash: "0": syntax error: operand expected (error token is ""0"")
$

-- 
Regards,
Pavel Roskin
