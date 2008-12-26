From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: getting started, happy with cmd line on windows [Scanned]
Date: Fri, 26 Dec 2008 17:39:21 +0100
Message-ID: <495508B9.7070103@lsrfire.ath.cx>
References: <BB5F02FD3789B54E8964D38D6775E718242D07@ALTMORE-SVR.altmore.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Conor Rafferty <conor.rafferty@altmore.co.uk>
X-From: git-owner@vger.kernel.org Fri Dec 26 17:40:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGFk6-0002W6-EX
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 17:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbYLZQja convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Dec 2008 11:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752551AbYLZQja
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 11:39:30 -0500
Received: from india601.server4you.de ([85.25.151.105]:47538 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbYLZQja (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 11:39:30 -0500
Received: from [10.0.1.101] (p57B7F73B.dip.t-dialin.net [87.183.247.59])
	by india601.server4you.de (Postfix) with ESMTPSA id 955EA2F8003;
	Fri, 26 Dec 2008 17:39:28 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <BB5F02FD3789B54E8964D38D6775E718242D07@ALTMORE-SVR.altmore.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103945>

Conor Rafferty schrieb:
> I then deleted all files from the working directory, so I can pull ou=
t
> ONLY the ones in version A.
> I tried both fetch and checkout - but nothing was copied into working
> dir How do I do this ?

git treats deleted files just like edited files: as having been changed
in preparation for the next commit.  You can get back all of the tracke=
d
files using this command:

	$ git reset --hard

It undoes _all_ changes: tracked edited files will be reverted to their
in-repository state, deleted files created again.  You can also check
out individual files like this:

	$ git checkout ABC.txt

If you just want to get rid of untracked files, you'd use the command
"git clean".

In general, if you switch your work tree from one revision to another
(git checkout), git tries to minimize the I/O needed.  Files that are
the same in both aren't touched.

Ren=E9
