From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: tar commit header names
Date: Thu, 29 Mar 2007 18:07:39 +0200
Message-ID: <460BE44B.8090301@lsrfire.ath.cx>
References: <Pine.LNX.4.64.0703261230420.6485@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Mar 29 18:33:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWxZ3-0001HG-2s
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 18:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933143AbXC2Qd0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 29 Mar 2007 12:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933192AbXC2Qd0
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 12:33:26 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:37276
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933143AbXC2QdZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Mar 2007 12:33:25 -0400
X-Greylist: delayed 1509 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Mar 2007 12:33:25 EDT
Received: from [10.0.1.201] (p508E7959.dip.t-dialin.net [80.142.121.89])
	by neapel230.server4you.de (Postfix) with ESMTP id 809881F009;
	Thu, 29 Mar 2007 18:08:15 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <Pine.LNX.4.64.0703261230420.6485@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43455>

Daniel Barkalow schrieb:
> I'm entirely ignorant of pax header stuff, but would it be possible t=
o=20
> have the pax header specify which project this commit is from (which =
has=20
> to come from a git-archive option, clearly).

Technically, yes.  The commit ID is stored in a comment, more info coul=
d
appended to it.  Adding more stuff there would necessitate an ordering
scheme, though.  I'm not sure this is useful enough.  There already is =
a
nice convention on where to store the project name, description and URL=
:
in a file named 'README'. :)

> Also, could=20
> git-get-tar-commit-id have an option to look for more pax headers bey=
ond=20
> the first? (I'm building tar files by appending multiple archives for=
=20
> different projects from git-archive, and I suddenly find the embedded=
=20
> commit id is helpful, and surprisingly inaccessible in this context.)

This could be done, at the cost of git-get-tar-commit-id having to be
able to really parse tar files in order to seek to the end of the first
and thus to the start of the appended one.  Right now it simply reads
the first few bytes, quickly checks if this looks like a tar file and
prints the commit ID, if one is found.

The right place to add generic archive comment extraction capabilities
(with multi-archive support) would be a general purpose archiver like
GNU tar, no?

Ren=E9
