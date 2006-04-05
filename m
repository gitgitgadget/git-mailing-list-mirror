From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] parse_date(): fix parsing 03/10/2006
Date: Tue, 4 Apr 2006 23:40:48 -0700
Message-ID: <20060404234048.0236886e.akpm@osdl.org>
References: <7vodzg4l5n.fsf@assigned-by-dhcp.cox.net>
	<20060404231606.219a4cc5.akpm@osdl.org>
	<7virpo4jxf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 08:42:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR1iB-0003sf-5x
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 08:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWDEGls (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 02:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWDEGls
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 02:41:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53140 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751119AbWDEGls (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Apr 2006 02:41:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k356fitH007585
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 4 Apr 2006 23:41:45 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k356fiUP028042;
	Tue, 4 Apr 2006 23:41:44 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virpo4jxf.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18419>

Junio C Hamano <junkio@cox.net> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> > But there was a second problem.  Once the parsing had misbehaved, Len
> > managed to create a commit which was six months in the future:
> >
> > commit 8313524a0d466f451a62709aaedf988d8257b21c
> > Author: Bob Moore <robert.moore@intel.com>
> > Date:   Tue Oct 3 00:00:00 2006 -0400
> >
> >     ACPI: ACPICA 20060310
> >
> > Will your fix prevent that from happening?  If not, perhaps some basic
> > sanity checking might be appropriate.
> 
> You _might_ get an e-mail to fix kernel problems from yourself
> in the future, in which case you would want to commit with
> future author date, like this ;-).
> 
> People would often deal with dates in the past (way in the past
> when talking about importing foreign SCM history), but probably
> it would never make sense to do dates way into the future.  I'll
> think about it.
> 

Well it doesn't have to be fatal, of course.  Some "do you really want to
do this [y/n]?" prompt, with a command option to override it.  Or simply
print a big warning.

Whatever.
