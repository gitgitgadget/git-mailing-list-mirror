From: Wolfgang Denk <wd@denx.de>
Subject: Re: Problem cloning the Linux history tree
Date: Fri, 04 Nov 2005 10:21:46 +0100
Message-ID: <20051104092146.E5E35353C33@atlas.denx.de>
References: <7vmzkl3yl0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Marcel Holtmann <marcel@holtmann.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 10:23:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXxm0-0005fL-PA
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 10:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719AbVKDJVz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 04:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbVKDJVy
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 04:21:54 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:22708 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S932719AbVKDJVx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 04:21:53 -0500
Received: from mail.m-online.net (svr20.m-online.net [192.168.3.148])
	by mail-out.m-online.net (Postfix) with ESMTP id 4EB5A700C1;
	Fri,  4 Nov 2005 10:20:26 +0100 (CET)
X-Auth-Info: uL/qcze6xbbaT5aAckXio30WElhOgqNcmILw+T3nedI=
X-Auth-Info: uL/qcze6xbbaT5aAckXio30WElhOgqNcmILw+T3nedI=
X-Auth-Info: uL/qcze6xbbaT5aAckXio30WElhOgqNcmILw+T3nedI=
Received: from mail.denx.de (p549660AA.dip.t-dialin.net [84.150.96.170])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 6B7B01271F0;
	Fri,  4 Nov 2005 10:21:47 +0100 (CET)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by mail.denx.de (Postfix) with ESMTP id 01F3A6D00AC;
	Fri,  4 Nov 2005 10:21:47 +0100 (MET)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id E5E35353C33;
	Fri,  4 Nov 2005 10:21:46 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
In-reply-to: Your message of "Thu, 03 Nov 2005 19:02:03 PST."
             <7vmzkl3yl0.fsf@assigned-by-dhcp.cox.net> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11123>

In message <7vmzkl3yl0.fsf@assigned-by-dhcp.cox.net> you wrote:
> 
> > # cg-clone http://www.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> > defaulting to local storage area
> > 09:53:02 URL:http://www.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/HEAD [41/41] -> "refs/heads/.origin-fetching" [1]
...
> That repository is packed but lacks objects/info/packs file.
> Perhaps you need to ask tglx to run git-update-server-info in
> the repository.

I have the same (or a very similar) problem with our Linux repo:

-> cg-clone http://www.denx.de/git/linux-2.6-denx.git foo
...
defaulting to local storage area
09:54:53 URL:http://www.denx.de/git/linux-2.6-denx.git/HEAD [41/41] -> "refs/heads/.origin-fetching" [1]
Getting alternates list
Getting pack list
Getting index for pack eceba3479417b338c2e156b1c6dfd69f3f0eaad1
Getting index for pack b3c6fbdfa36a326815de6358885c7a570a986b1b
Getting index for pack 6122f3ffa476a089122c0bffbbb7a7ce31304b56
Getting index for pack 06949712bb970fc1dd2e13f50accdcd2bf992536
Getting index for pack 459148e2ea863c15479d69ed4886a6f200c79a49
Getting pack 459148e2ea863c15479d69ed4886a6f200c79a49
which contains 010a4c0059a82b834b4d7f65d5cdd4a9717d8ea7
progress: 3 objects, 0 bytes
Getting pack 06949712bb970fc1dd2e13f50accdcd2bf992536
which contains 5014bfa48ac169e0748e1e9651897788feb306dc
progress: 12210 objects, 0 bytes
09:58:42 ERROR 404: Not Found.
09:58:42 URL:http://www.denx.de/git/linux-2.6-denx.git/refs/tags/DENX-2005-10-02-18:30 [41/41] -> "refs/tags/DENX-2005-10-02-18:30" [1]
...
09:58:43 URL:http://www.denx.de/git/linux-2.6-denx.git/refs/tags/v2.6.14-rc5 [41/41] -> "refs/tags/v2.6.14-rc5" [1]
FINISHED --09:58:43--
Downloaded: 19,240 bytes in 30 files
Missing object of tag v2.6.14-rc3... unable to retrieve
New branch: 010a4c0059a82b834b4d7f65d5cdd4a9717d8ea7
Cloned to foo/ (origin http://www.denx.de/git/linux-2.6-denx.git available as branch "origin")

And I did run git-update-server-info, even with --force.


In the server log I see messages like these:

[Fri Nov 04 09:54:52 2005] [error] [client 84.150.96.170] File does not exist: /srv/git/linux-2.6-denx.git/objects/01
[Fri Nov 04 09:54:52 2005] [error] [client 84.150.96.170] File does not exist: /srv/git/linux-2.6-denx.git/objects/info/http-alternates
[Fri Nov 04 09:54:53 2005] [error] [client 84.150.96.170] File does not exist: /srv/git/linux-2.6-denx.git/objects/info/alternates
[Fri Nov 04 09:55:12 2005] [error] [client 84.150.96.170] File does not exist: /srv/git/linux-2.6-denx.git/objects/5b
[Fri Nov 04 09:55:12 2005] [error] [client 84.150.96.170] File does not exist: /srv/git/linux-2.6-denx.git/objects/ca
[Fri Nov 04 09:55:12 2005] [error] [client 84.150.96.170] File does not exist: /srv/git/linux-2.6-denx.git/objects/50
[Fri Nov 04 09:55:12 2005] [error] [client 84.150.96.170] File does not exist: /srv/git/linux-2.6-denx.git/objects/98
[Fri Nov 04 09:55:12 2005] [error] [client 84.150.96.170] File does not exist: /srv/git/linux-2.6-denx.git/objects/79
[Fri Nov 04 09:55:12 2005] [error] [client 84.150.96.170] File does not exist: /srv/git/linux-2.6-denx.git/objects/4e
[Fri Nov 04 09:55:12 2005] [error] [client 84.150.96.170] File does not exist: /srv/git/linux-2.6-denx.git/objects/79
[Fri Nov 04 09:55:12 2005] [error] [client 84.150.96.170] File does not exist: /srv/git/linux-2.6-denx.git/objects/c1
[Fri Nov 04 09:55:12 2005] [error] [client 84.150.96.170] File does not exist: /srv/git/linux-2.6-denx.git/objects/f9
[Fri Nov 04 09:55:12 2005] [error] [client 84.150.96.170] File does not exist: /srv/git/linux-2.6-denx.git/objects/e5
[Fri Nov 04 09:55:13 2005] [error] [client 84.150.96.170] File does not exist: /srv/git/linux-2.6-denx.git/objects/e1
[Fri Nov 04 09:55:13 2005] [error] [client 84.150.96.170] File does not exist: /srv/git/linux-2.6-denx.git/objects/67
[Fri Nov 04 09:55:13 2005] [error] [client 84.150.96.170] File does not exist: /srv/git/linux-2.6-denx.git/objects/0c
[Fri Nov 04 09:55:13 2005] [error] [client 84.150.96.170] File does not exist: /srv/git/linux-2.6-denx.git/objects/b6
[Fri Nov 04 09:55:13 2005] [error] [client 84.150.96.170] File does not exist: /srv/git/linux-2.6-denx.git/objects/bc

These directories really don't exist:

$ cd /srv/git/linux-2.6-denx.git/objects
. ls -l
total 8
drwxrwxr-x  2 wd wd 4096 Nov  4 09:52 info
drwxrwxr-x  2 wd wd 4096 Nov  3 15:15 pack

The question is : why are they requested?

> Cloning over git native transport should work, though:
> 
>     $ git clone git://git.kernel.org/pub/scm/lin.../history.git history

This does not work for me,  either.  It  runs  a  long  time  without
obvious problems, but finally fails with:

-> git clone http://www.denx.de/git/linux-2.6-denx.git bar
...
walk c264852726dde251a0c09ec22f61a9be8b0db68b
walk 69903d6500c73af8329a5fba7153b0d50748981c
walk b59a9504cb93db7fae31e60760725d48652a1fc3
error: Could not interpret tags/DENX-2005-10-02-18:30 as something to pull



I have to admit that I have absolutely no clue (1)  what  might  have
caused this situation nor (2) how to fix it :-(

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
 The software required `Windows 95 or better', so I installed Linux.
