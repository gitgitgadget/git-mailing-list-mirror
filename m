From: Petr Baudis <pasky@ucw.cz>
Subject: Re: git pull on ia64 linux tree
Date: Thu, 28 Apr 2005 02:07:29 +0200
Message-ID: <20050428000729.GT22956@pasky.ji.cz>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035B31D9@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.58.0504271525520.18901@ppc970.osdl.org> <20050427225821.GI22956@pasky.ji.cz> <Pine.LNX.4.58.0504271632060.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Luck, Tony" <tony.luck@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 02:02:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQwU6-00062q-Bi
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 02:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVD1AHl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 20:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVD1AHk
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 20:07:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57517 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262113AbVD1AHa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 20:07:30 -0400
Received: (qmail 28883 invoked by uid 2001); 28 Apr 2005 00:07:29 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504271632060.18901@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 28, 2005 at 01:36:19AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> 
> 
> On Thu, 28 Apr 2005, Petr Baudis wrote:
> > 
> > Fixed and pushed out.
> 
> It looks like you only did the fix for the pure "just update to the 
> version at the other end" case. 
> 
> So if you actually end up doing a merge, it still leaves all the old files
> (that the merge may have removed from the tree) around. Or did I miss 
> something?

Hmm, doesn't the three-way read-tree -m take care of that? Then it
should hit

	#
	# deleted in one and unchanged in the other
	#
	"$1.$1" | "$1$1.")
		#echo "Removing $4"
		rm -f -- "$4"; update-cache --remove -- "$4"
		exit 0
		;;

in cg-Xmergefile.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
