From: Paul Martinolich <martinol@nrlssc.navy.mil>
Subject: Re: cloning submodules with children submodules
Date: Fri, 23 Nov 2007 14:35:38 -0600
Message-ID: <383F62AA-096E-4D8E-BCE8-B2B87507C596@nrlssc.navy.mil>
References: <BC1DE15A-9225-41D3-A2D7-21A14DF81048@nrlssc.navy.mil> <20071123194904.GL2261MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Fri Nov 23 21:36:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvfFy-0008V4-F4
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 21:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755061AbXKWUfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 15:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755178AbXKWUfx
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 15:35:53 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34290 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755048AbXKWUfw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 15:35:52 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id lANKZctr030713;
	Fri, 23 Nov 2007 14:35:38 -0600
Received: from garnet.nrlssc.navy.mil ([128.160.22.16]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 23 Nov 2007 14:35:37 -0600
In-Reply-To: <20071123194904.GL2261MdfPADPa@greensroom.kotnet.org>
X-Mailer: Apple Mail (2.915)
X-OriginalArrivalTime: 23 Nov 2007 20:35:37.0712 (UTC) FILETIME=[67DF9700:01C82E10]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15554001
X-TM-AS-Result: : Yes--9.275800-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMTI1My03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMTQ1NS03MDEyOTgtNzAxMjM2LTcwMTk1OC03?=
	=?us-ascii?B?MDIwMjAtNzAyOTAwLTcwMDEwNy0zMDAwMTUtNzA0NDIxLTcwMTU3?=
	=?us-ascii?B?Ni0xMTMyMjgtNzAxNzYyLTcwMDkxOC03MDQzNDEtNzAyMTQzLTcw?=
	=?us-ascii?B?Mzc4OC03MDcxMTktNzAwNzU2LTEyMTQ3MC0xNDgwMzktMTQ4MDUw?=
	=?us-ascii?B?LTIwMDQw?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65924>


On Nov 23, 2007, at 1:49 PM, Sven Verdoolaege wrote:

> You didn't commit the change to mod_B to proj_one.
> Furthermore, you didn't push your changes to mod_B to
> the repo you specified for mod_B in .gitmodules.

Thanks for the help.

It works with the changes below.

Paul

I changed the creation of mod_b under mod_B to:

#  add mod_b to mod_B and push the changes back to mod_B

cd $GITDIR/proj_one/mod_B
git submodule add $GITDIR/modules/mod_b
git commit -m 'add module mod_b under module mod_B for project proj_one'
git push

cd $GITDIR/proj_one
git add mod_B
git commit -m 'reflect module mod_B update for project proj_one'
git status

and when I cloned it to:

#  clone the proj_one project (user user_a)

mkdir -p $GITDIR/user_a
cd $GITDIR/user_a
git clone $GITDIR/proj_one
cd $GITDIR/user_a/proj_one

#  get mod_A and mod_B

git submodule init
git submodule update

#  now get mod_b in mod_B

cd mod_B
git submodule init
git submodule update
