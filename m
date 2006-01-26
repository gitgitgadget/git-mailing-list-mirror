From: Mathieu Chouquet-Stringer <ml2news@free.fr>
Subject: How to create and keep up to date a naked/bare repository?
Date: 26 Jan 2006 12:12:10 +0100
Organization: Uh?
Message-ID: <m37j8n9rat.fsf_-_@localhost.localdomain>
References: <7v1wyvn9pc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Jan 26 12:12:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2539-0007JV-M8
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 12:12:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWAZLMU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 26 Jan 2006 06:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWAZLMU
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 06:12:20 -0500
Received: from AMarseille-252-1-93-193.w86-202.abo.wanadoo.fr ([86.202.148.193]:23021
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S932293AbWAZLMT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 06:12:19 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.5/8.13.5) with ESMTP id k0QBCBHB017852
	for <git@vger.kernel.org>; Thu, 26 Jan 2006 12:12:11 +0100
Received: (from mchouque@localhost)
	by localhost.localdomain (8.13.5/8.13.5/Submit) id k0QBCBMU017849;
	Thu, 26 Jan 2006 12:12:11 +0100
X-Authentication-Warning: localhost.localdomain: mchouque set sender to ml2news@free.fr using -f
To: git@vger.kernel.org
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
In-Reply-To: <7v1wyvn9pc.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15157>

        Hello,

I've got a couple of questions and reading (some of the files in) the
Documentation directory didn't really enlighten me...

Let's say I want to maintain a private (read-only) copy of a git reposi=
tory
(eg git.git or linus-2.6.git). Because this repository is shared
internally (used by a bunch of boxes), I'd like to clone it as a bare
repo, no need to have the files checked out on my local master.

Cloning is done by running the following:
git clone --naked git://www.kernel.org/pub/scm/git/git.git git.git

Now I've got my repository. Because I'll share it with git-daemon, I to=
uch
the git-daemon-export-ok file to export it.

The first problem arises when I try to keep this repo up to date.

If I try a git fetch or pull (more on that later), git complains becaus=
e it
can't find a .git directory (which is correct as in a bare repository t=
he
repository directory is the .git directory).

I can do a: GIT_DIR=3D. git fetch and it works but that's kind of ugly.=
 I
can also link . to .git but it's as disgusting as the previous hack.

Maybe I'm missing something obvious here, is there an option to tell
fetch/pull that it's working with a bare repository?

The second question is I'd think I would have to use git fetch instead =
of
git pull as a pull is fetch + merge and merging wouldn't make much sens=
e as
I didn't check out any files. Does it make any sense?

The third thing (can't reproduce ATM as I just got a fresh new clone) i=
s
that git fetch was just fetching over and over the same objects...

Can anyone tell me what I'm doing wrong?

--=20
Mathieu Chouquet-Stringer
    "Le disparu, si l'on v=E9n=E8re sa m=E9moire, est plus pr=E9sent et
                 plus puissant que le vivant".
           -- Antoine de Saint-Exup=E9ry, Citadelle --
