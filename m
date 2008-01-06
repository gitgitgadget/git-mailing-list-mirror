From: Jon Hancock <redstarling@gmail.com>
Subject: rm and mv commands: should I use them?
Date: Sun, 6 Jan 2008 15:55:22 +0800
Message-ID: <379EDA94-A67B-483A-BC5F-E961DD52AD0C@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=WINDOWS-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 08:56:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBQMy-0006Xy-36
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 08:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbYAFHzm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2008 02:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752469AbYAFHzk
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 02:55:40 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:14550 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602AbYAFHzi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jan 2008 02:55:38 -0500
Received: by wa-out-1112.google.com with SMTP id v27so11683597wah.23
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 23:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        bh=oaeb6QZgz248AEoCO7jetTljRxKGUnZ6avxd9mgypyI=;
        b=uU8C/yBSMKbU33HecAj/Hr3rW2+qUa7rLiJ9EWGKufUvgaoiwlFSqs4QLqKuO3m1TB4It9oDxu1OAl0ZEFsWO2lLuhuX6h8O/svW7LgYTmSkvjfoRcD+afYq0THhZWdz4Zn+iORPUOdSOKujDmC3HajkboT2dzri67OzOvjLqSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        b=nCAiTe8kw8FScrCb9yFnznj0Ebji9dDFxWe4U8gxyoVUZ60TjmroqjCU7Cwj+IjVhVWtRrI6fhNmQ3EXLFoP9DPw/O8H+o3vKwj07MHasa21phmDtf/Sa662oGt0UnKhLyIXmBnP2bzCCO/37SKKzviFpd/rrMt+i8al82a072o=
Received: by 10.114.254.1 with SMTP id b1mr667703wai.140.1199606129505;
        Sat, 05 Jan 2008 23:55:29 -0800 (PST)
Received: from ?192.168.1.20? ( [58.33.231.141])
        by mx.google.com with ESMTPS id l30sm32493875waf.53.2008.01.05.23.55.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2008 23:55:28 -0800 (PST)
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69713>

Hello list,
I'm fairly new to git and coming from svn and have tasted hg and bzr =20
along the decision path.

Here's my newbie issue:

In reading Aristotle Pagaltzis's article http://plasmasturm.org/log/=20
487/  the author stresses that a major difference between git and =20
something like bzr or svn is that git tracks content and not metadata =20
(or at least less metadata); meaning is inferred through content and =20
less through metadata.

The heart of Pagaltzis's argument copied here:
<COPY>
Among the systems I did look into, there are really just two =20
contenders: git and Mercurial. All the other systems track metadata; =20
git and hg just track content and infer the metadata.

By tracking metadata I mean that these systems keep a record of what =20
steps were taken. =93This file had its name changed.=94 =93Those =20
modifications came from that file in that branch.=94 =93This file was =20
copied from that file.=94 Tracking content alone means doing none of =20
that. When you commit, the VCS just records what the tree looks like. =20
It doesn=92t care about how the tree got that way. When you ask it abou=
t =20
two revisions, it looks at the tree beforehand and the tree =20
afterwards, and figures out what happened inbetween. A file is not a =20
unit that defines any sort of boundary in this view. The VCS always =20
looks at entire trees; files have no individual identity separate from =
=20
their trees at all.

As a consequence, whether you used VCS tools to manipulate your =20
working copy or regular command line utilities or applied a patch or =20
whatever is irrelevant. The resulting history is always the same.
</COPY>

So, do I need to use git's mv and rm commands?  Can't I just rename, =20
add, and remove files using any means I like and then just ensure my =20
"index" is staged properly when I do a commit?  Additionally, is there =
=20
a simple procedure with git to say: "I want to version exactly what is =
=20
in my working tree.  If I removed something or added something, just =20
handle it".  This is sort of what "git add ." does, but "git add" =20
doesn't handling things I removed or moved, correct?

thanks, Jon
