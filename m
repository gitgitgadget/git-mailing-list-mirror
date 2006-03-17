From: Jon Loeliger <jdl@freescale.com>
Subject: Re: git-reset and clones
Date: Fri, 17 Mar 2006 15:00:03 -0600
Message-ID: <1142629202.17536.242.camel@cashmere.sps.mot.com>
References: <Pine.LNX.4.64.0603161424310.5276@sheen.jakma.org>
	 <7v4q1x95yo.fsf@assigned-by-dhcp.cox.net>
	 <1142623141.17536.225.camel@cashmere.sps.mot.com>
	 <7vslpgztzc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: paul@hibernia.jakma.org, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 17 22:02:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKM57-0000Ui-Ou
	for gcvg-git@gmane.org; Fri, 17 Mar 2006 22:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932768AbWCQVBR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 16:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932770AbWCQVBQ
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 16:01:16 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:13189 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S932766AbWCQVBG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Mar 2006 16:01:06 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id k2HLHk8w011453;
	Fri, 17 Mar 2006 14:17:46 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k2HLAemJ015759;
	Fri, 17 Mar 2006 15:10:40 -0600 (CST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslpgztzc.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17670>

On Fri, 2006-03-17 at 14:39, Junio C Hamano wrote:

> > And the "ours" strategy effectively says, "Favor the B
> > side of things when pulling in the A parts", right?
> 
> Yes, it is stronger than that.  "ours" says: "the tree from our
> head commit B *is* the resulting tree -- whatever we are merging
> into us does not matter".

Aha!  This all makes much more sense now suddenly.

Thank you.


> 
>                   o---o---o---A---N
>                  /               /  
>      ---o---o---o---o---o---B---'
> 
> Because the forked track leading to B was either to fix mistakes
> or clean things up the upstream originally did in the track
> leading to A, the commits on the tracks leading to A and B from
> their fork point are almost guaranteed to have conflicting
> changes, and resolution of that conflict is forced on the
> downstream person.  Worse yet, from this point on, since the
> upstream discarded the track that contains A, the branch
> downstream person has will _never_ converge to upstream branch,
> even though the downstream person did _no_ development of his
> own in the meantime.  This is *B*A*D*.

Wow.  Yeah.  Bad.

> If there is a magic "ours" merge, the downstream person's
> repository records A as the last tip on the tracking branch, and
> git-fetch sees the updated head M is a descendant of it, so it
> simply fast-forwards:

That's beautiful.  I get it.  This has been an
extraordinarily helpful explanation (for me)!

Thank you!

jdl
