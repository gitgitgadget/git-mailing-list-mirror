From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Sat, 14 Oct 2006 21:44:52 -0400
Message-ID: <BAYC1-PASMTP01D7FF6651E6563344419BAE080@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<egrgqe$1i9$1@sea.gmane.org>
	<9e4733910610141606g749d268eudd85791620e1363a@mail.gmail.com>
	<BAYC1-PASMTP08F9B6EA71E7C83DD93E8DAE080@CEZ.ICE>
	<9e4733910610141734h581afdc9r4d330d6a5a5bd1aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 15 03:45:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYv3u-0006ib-TA
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 03:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbWJOBoz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 21:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752324AbWJOBoz
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 21:44:55 -0400
Received: from bayc1-pasmtp01.bayc1.hotmail.com ([65.54.191.161]:18079 "EHLO
	bayc1-pasmtp01.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932320AbWJOBoy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Oct 2006 21:44:54 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by bayc1-pasmtp01.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 14 Oct 2006 18:44:54 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GYu7Z-00023E-1E; Sat, 14 Oct 2006 20:44:53 -0400
To: "Jon Smirl" <jonsmirl@gmail.com>
Message-Id: <20061014214452.8c2d2a5c.seanlkml@sympatico.ca>
In-Reply-To: <9e4733910610141734h581afdc9r4d330d6a5a5bd1aa@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 15 Oct 2006 01:44:54.0441 (UTC) FILETIME=[833EF990:01C6EFFB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 14 Oct 2006 20:34:22 -0400
"Jon Smirl" <jonsmirl@gmail.com> wrote:

> That is possible but I wish git had tools supporting this. What do you
> do about core developers that want the full repo syncing to other
> developers that only have a partial copy?

I don't think that will be an issue at all.

As an example, take the current Linux kernel repo maintained by Linus,
and one of the repos containing old historic kernel data imported into
Git.  Graft in the old historic data into your clone of Linus' repo,
and you're done. Anyone can pull from you even if they don't have the
historic data themselves.

With a little work you could do the same thing with the Mozilla data.
After you decide where to make the split, you'd have to rewrite the
commit history for the "current" repository, so that it terminates
at an initial commit rather than having a direct connection to the
historic data.  After that, the repos could be used just as described
above, separately or graphed together.

As far as I know though, there is still no way to use the git protocol
for the initial pull of such a combined repository.  You have to pull
both repos separately and graft them together locally.  This sounds
harder than it is though and can be scripted easily.

Sean
