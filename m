From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] cvsimport: rewritten in Perl
Date: Wed, 29 Jun 2005 11:06:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0506291048140.1667@localhost.localdomain>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 17:01:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dne3E-00081G-2O
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 17:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVF2PHk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 11:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVF2PHk
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 11:07:40 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60453 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261313AbVF2PHY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 11:07:24 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR001.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IIU00EKHPY3RE@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 29 Jun 2005 11:06:03 -0400 (EDT)
In-reply-to: <pan.2005.06.28.19.23.08.307486@smurf.noris.de>
X-X-Sender: nico@localhost.localdomain
To: Matthias Urlichs <smurf@smurf.noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 28 Jun 2005, Matthias Urlichs wrote:

> I just got my machine blocked from a CVS server which didn't like
> to get hammered with connections.
> 
> That was cvs2git's shell script. Which, by the way, is slow as hell.
> 
> Appended: a git-cvsimport script, written in Perl, which directly talks
> to the CVS server. If the repository is local, it runs a "cvs server"
> child. It produces the same git repository as Linus' version. It can do
> incremental imports. And it's 20 times faster (on my system, with a
> local CVS repository).

Tried it on the bkcvs repository from 
ftp.kernel.org/pub/scm/linux/kernel/bkcvs/linux-2.5/
(it can be retrieved with rsync as well)

Your script died after about 30 seconds with:

[...]
New scripts/lxdialog/Makefile: 0 bytes.
New scripts/lxdialog/checklist.c: 0 bytes.
New scripts/lxdialog/colors.h: 0 bytes.
New scripts/lxdialog/dialog.h: 0 bytes.
New scripts/lxdialog/inputbox.c: 0 bytes.
New scripts/lxdialog/lxdialog.c: 0 bytes.
New scripts/lxdialog/menubox.c: 0 bytes.
New scripts/lxdialog/msgbox.c: 0 bytes.
New scripts/lxdialog/textbox.c: 0 bytes.
New scripts/lxdialog/util.c: 0 bytes.
New scripts/lxdialog/yesno.c: 0 bytes.
Can't exec "git-update-cache": Argument list too long at /home/nico/bin/git-cvsimport-script line 402, <CVS> line 8254.
Cannot add files: -1

The original Linus version, although painfully slow, successfully 
converts the whole thing after a couple hours.

Also aren't those "0 bytes" a bit suspicious?


Nicolas
