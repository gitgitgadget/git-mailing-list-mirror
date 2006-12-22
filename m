From: Sean <seanlkml@sympatico.ca>
Subject: Re: Separating "add path to index" from "update content in index"
Date: Thu, 21 Dec 2006 22:06:32 -0500
Message-ID: <20061221220632.46444296.seanlkml@sympatico.ca>
References: <89b129c60612191233s5a7f36f2hd409c4b9a2bbbc5c@mail.gmail.com>
	<7v64c7pmlw.fsf@assigned-by-dhcp.cox.net>
	<87wt4m2o99.wl%cworth@cworth.org>
	<7vmz5i6vqb.fsf@assigned-by-dhcp.cox.net>
	<87vek62n1k.wl%cworth@cworth.org>
	<7v1wmu5ecs.fsf@assigned-by-dhcp.cox.net>
	<87tzzp3fgh.wl%cworth@cworth.org>
	<slrneokplo.nsf.Peter.B.Baumann@xp.machine.xx>
	<7vbqlw92fw.fsf@assigned-by-dhcp.cox.net>
	<87d56cirs8.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 04:06:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxakA-0001Fo-EK
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 04:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945923AbWLVDGf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 22:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945924AbWLVDGf
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 22:06:35 -0500
Received: from bayc1-pasmtp13.bayc1.hotmail.com ([65.54.191.173]:42404 "EHLO
	BAYC1-PASMTP13.CEZ.ICE" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1945923AbWLVDGe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 22:06:34 -0500
X-Originating-IP: [65.93.43.74]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.74]) by BAYC1-PASMTP13.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 21 Dec 2006 19:06:42 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GxZnq-0007yW-0W; Thu, 21 Dec 2006 21:06:30 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87d56cirs8.wl%cworth@cworth.org>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 22 Dec 2006 03:06:42.0593 (UTC) FILETIME=[34D28910:01C72576]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35124>

On Thu, 21 Dec 2006 18:32:55 -0800
Carl Worth <cworth@cworth.org> wrote:

> So here I'm arguing against "git add" being a more convenient synonym
> for "git update-index". I still think it would be nice to have a more
> convenient synonym. I've proposed "stage" before but that wasn't well
> accepted. Just shortening "update-index" to "update" would be
> problematic as many other RCSs use "update" as a way of picking up new
> content that has become available on the remote end. So, the best
> suggestion I have at this point is "refresh". So I'd be happy if
> either:
> 
> 	git refresh --add
> or:
> 	git add --refresh
> 
> would provide the behavior that currently is provided by "git add",
> (that is, add a new path to the index and update the content of that
> path in the index from the content of the named file in the working
> tree). But it would be great if "git add" without the --refresh would
> add the path without updating the content.


The end result you're trying to achieve is worthwhile, but it seems the
new git add capabilities have already taken root.  What do you think
about accepting the new behavior of add, but offer a new command, say:

$ git track-file <file>

Which would do exactly as you propose in your email, add the path to
the index with empty content?

Sean
