From: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
Subject: Re: conversion from svn with renames
Date: Fri, 16 Nov 2007 05:16:38 +0200
Message-ID: <D5A64E6F-D80B-4FCD-8184-F53812D4312E@pp.inet.fi>
References: <20070729122301.GA17016@knight.manxome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ricardo SIGNES <rjbs@cpan.org>
X-From: git-owner@vger.kernel.org Fri Nov 16 04:47:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IssAj-0004LK-A3
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 04:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759045AbXKPDq4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Nov 2007 22:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759345AbXKPDq4
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 22:46:56 -0500
Received: from hyat.suomi.net ([82.128.152.22]:59222 "EHLO hyat.suomi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759045AbXKPDqz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Nov 2007 22:46:55 -0500
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Nov 2007 22:46:55 EST
Received: from taku.suomi.net ([82.128.154.66])
 by hyatt.suomi.net (Sun Java System Messaging Server 6.2-3.04 (built Jul 15
 2005)) with ESMTP id <0JRK00AP8X1TJN10@hyatt.suomi.net> for
 git@vger.kernel.org; Fri, 16 Nov 2007 05:15:29 +0200 (EET)
Received: from spam1.suomi.net (spam1.suomi.net [212.50.131.169])
 by mailstore.suomi.net
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JRK00JNIX44IF10@mailstore.suomi.net> for git@vger.kernel.org;
 Fri, 16 Nov 2007 05:16:52 +0200 (EET)
Received: from [192.168.0.140]
 (addr-213-139-166-27.baananet.fi [213.139.166.27])
	by spam1.suomi.net (Postfix) with ESMTP id 6DABD244957; Fri,
 16 Nov 2007 05:16:39 +0200 (EET)
In-reply-to: <20070729122301.GA17016@knight.manxome.org>
X-Mailer: Apple Mail (2.912)
X-DNA-MailScanner-Information: Please contact the ISP for more information
X-DNA-MailScanner: Found to be clean
X-DNA-MailScanner-SpamCheck: not spam, SpamAssassin (not cached, score=-1,
	required 5, autolearn=not spam, BAYES_00 -1.00)
X-DNA-MailScanner-From: v@pp.inet.fi
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65184>

Hi,

I tried importing an SVN project with svn-import, and the project had =20
been renamed once. It seems that git-svn is more mature tool for this, =
=20
even if svn-import seems to be the one to use. If I remember =20
correctly, there was even talk about this very same case in the =20
mailing list archives.

To make a complete conversion from SVN repository to GIT repositories, =
=20
just use --no-metadata option to remove all the metadata git-svn =20
normally appends to the commit messages. There will also be some cruft =
=20
in the .git/config file, I removed those, and have had an working =20
import with renames from SVN.

--
V=E4in=F6

On Jul 29, 2007, at 15:23, Ricardo SIGNES wrote:

>
> I'd like to convert svn.codesimply.com/projects' contents to git.
>
> Right now, the content is like this:
>
> /projects/$PROJECTNAME/{trunk,tags,branches}
>
> git-svnimport does well if I specify projects/$PROJECTNAME/trunk as =20
> the trunk
> directory and that/tags as the tags directory.  (I am not interested =
=20
> in
> bothering with branches.)  The problem is this:
>
> For many of the projects, $PROJECTNAME was once "foo" and is now =20
> "bar."
> git-svnimport only imports the history from the current name.
>
> I tried to import foo, then bar, into one git repostiory, but the =20
> histories
> didn't seem to get connected.  Sam V. suggested git-filter-branch, =20
> but I didn't
> quite see how to make it do what I wanted.
>
> I would greatly appreciate any advice or help on this conversion.
>
> --=20
> rjbs
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
