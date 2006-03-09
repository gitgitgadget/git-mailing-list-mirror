From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-unpack-objects < pack file in repository doesn't work!
Date: Thu, 09 Mar 2006 02:14:20 -0800
Message-ID: <7v4q287wn7.fsf@assigned-by-dhcp.cox.net>
References: <200603070213.02805.blaisorblade@yahoo.it>
	<20060307022926.GB29180@spearce.org>
	<7vlkvn54sv.fsf@assigned-by-dhcp.cox.net>
	<20060307040255.GA29544@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 09 11:14:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHIAB-0006JF-JU
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 11:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWCIKOZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 05:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWCIKOZ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 05:14:25 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:48115 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750702AbWCIKOY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Mar 2006 05:14:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060309101057.YJQI17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Mar 2006 05:10:57 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060307040255.GA29544@spearce.org> (Shawn Pearce's message of
	"Mon, 6 Mar 2006 23:02:55 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17402>

Shawn Pearce <spearce@spearce.org> writes:

> I wanted to explode a pack because I'm starting work on an Eclipse
> plugin for GIT.  I thought I'd try going down the road of letting
> the plugin read the repository directly, and write loose objects
> directly, but leave pack construction to the native C code.  So I
> tried to clone my local GIT repository to a new directory (thus
> had no loose objects at all) and unpack it to get loose objects.
> That didn't go so well.  :-)

Before "git-repack -a" was invented, I used to do this by hand:

	$ mkdir ./++preserve
        $ mv .git/objects/pack/pack-*.pack ./++preserve
        $ for p in ./++preserve/pack-*.pack
          do git-unpack-objects <$p; done
