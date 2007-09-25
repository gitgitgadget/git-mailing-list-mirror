From: "lode leroy" <lode_leroy@hotmail.com>
Subject: Q: howto rebase
Date: Tue, 25 Sep 2007 16:46:59 +0200
Message-ID: <BAY105-F33DC84FACB8B66BFEB9EC8FFB70@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 25 16:47:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaBgz-0003XZ-Cj
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 16:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbXIYOrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 10:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbXIYOrI
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 10:47:08 -0400
Received: from bay0-omc3-s3.bay0.hotmail.com ([65.54.246.203]:18725 "EHLO
	bay0-omc3-s3.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751835AbXIYOrH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Sep 2007 10:47:07 -0400
Received: from hotmail.com ([65.54.224.43]) by bay0-omc3-s3.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Sep 2007 07:47:04 -0700
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Tue, 25 Sep 2007 07:47:04 -0700
Received: from 65.54.224.200 by by105fd.bay105.hotmail.msn.com with HTTP;
	Tue, 25 Sep 2007 14:46:59 GMT
X-Originating-IP: [213.246.200.66]
X-Originating-Email: [lode_leroy@hotmail.com]
X-Sender: lode_leroy@hotmail.com
X-OriginalArrivalTime: 25 Sep 2007 14:47:04.0540 (UTC) FILETIME=[F04789C0:01C7FF82]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59129>

I'm trying to understand how rebase works, but I need some help to get it.
Suppose I do the following workflow... (see below)

In "version B" I introduce the "fix c", but in "version D" I realize it 
should have
been in some other place. (commit D moves the fix to its proper place).
A-B-C-D-E

Now I want to 'rewrite history'.
I would like to move commit D after B
A-B-D'-C'-E

and then fold the commits B and D' into a single commit.
A-B'-C'-E

I somehow managed to get this done using "rebase -i"
by exchanging the 2 appropriate lines, and then deleting the second one,
but I'd like to understand how to do this from the command line...

Could anyone enlighten me? I've read git-rebase(1) several times,
but don't seem to get it right...


cat > file <<EOF
a
b
d
e
g
h
EOF
git add file
git commit -m 'A' -a
cat > file <<EOF
a
b
d
e
g
c
h
EOF
git commit -m 'B' -a
cat > file <<EOF
a
b
d
e
f
g
c
h
EOF
git commit -m 'C' -a
cat > file <<EOF
a
b
c
d
e
f
g
h
EOF
git commit -m 'D' -a
cat > file <<EOF
a
b
c
d
e
f
g
h
i
EOF
git commit -m 'E' -a

_________________________________________________________________
A lot of passions?  Collect all your personal info on one central location , 
for free! http://get.live.com/live/features
