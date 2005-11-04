From: Petr Baudis <pasky@suse.cz>
Subject: Re: Problem cloning the Linux history tree
Date: Fri, 4 Nov 2005 10:26:26 +0100
Message-ID: <20051104092626.GL1431@pasky.or.cz>
References: <7vmzkl3yl0.fsf@assigned-by-dhcp.cox.net> <20051104092146.E5E35353C33@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Marcel Holtmann <marcel@holtmann.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 10:27:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXxqD-00079m-1u
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 10:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932717AbVKDJ0a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 04:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbVKDJ0a
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 04:26:30 -0500
Received: from w241.dkm.cz ([62.24.88.241]:23216 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932717AbVKDJ0a (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2005 04:26:30 -0500
Received: (qmail 19854 invoked by uid 2001); 4 Nov 2005 10:26:26 +0100
To: Wolfgang Denk <wd@denx.de>
Content-Disposition: inline
In-Reply-To: <20051104092146.E5E35353C33@atlas.denx.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11124>

Dear diary, on Fri, Nov 04, 2005 at 10:21:46AM CET, I got a letter
where Wolfgang Denk <wd@denx.de> told me that...
> In message <7vmzkl3yl0.fsf@assigned-by-dhcp.cox.net> you wrote:
> > 
> > > # cg-clone http://www.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> > > defaulting to local storage area
> > > 09:53:02 URL:http://www.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/HEAD [41/41] -> "refs/heads/.origin-fetching" [1]
> ...
> > That repository is packed but lacks objects/info/packs file.
> > Perhaps you need to ask tglx to run git-update-server-info in
> > the repository.
> 
> I have the same (or a very similar) problem with our Linux repo:
> 
> -> cg-clone http://www.denx.de/git/linux-2.6-denx.git foo
> ...
> defaulting to local storage area
> 09:54:53 URL:http://www.denx.de/git/linux-2.6-denx.git/HEAD [41/41] -> "refs/heads/.origin-fetching" [1]
> Getting alternates list
> Getting pack list
> Getting index for pack eceba3479417b338c2e156b1c6dfd69f3f0eaad1
> Getting index for pack b3c6fbdfa36a326815de6358885c7a570a986b1b
> Getting index for pack 6122f3ffa476a089122c0bffbbb7a7ce31304b56
> Getting index for pack 06949712bb970fc1dd2e13f50accdcd2bf992536
> Getting index for pack 459148e2ea863c15479d69ed4886a6f200c79a49
> Getting pack 459148e2ea863c15479d69ed4886a6f200c79a49
> which contains 010a4c0059a82b834b4d7f65d5cdd4a9717d8ea7
> progress: 3 objects, 0 bytes
> Getting pack 06949712bb970fc1dd2e13f50accdcd2bf992536
> which contains 5014bfa48ac169e0748e1e9651897788feb306dc
> progress: 12210 objects, 0 bytes
> 09:58:42 ERROR 404: Not Found.
> 09:58:42 URL:http://www.denx.de/git/linux-2.6-denx.git/refs/tags/DENX-2005-10-02-18:30 [41/41] -> "refs/tags/DENX-2005-10-02-18:30" [1]
> ...
> 09:58:43 URL:http://www.denx.de/git/linux-2.6-denx.git/refs/tags/v2.6.14-rc5 [41/41] -> "refs/tags/v2.6.14-rc5" [1]
> FINISHED --09:58:43--
> Downloaded: 19,240 bytes in 30 files
> Missing object of tag v2.6.14-rc3... unable to retrieve
> New branch: 010a4c0059a82b834b4d7f65d5cdd4a9717d8ea7
> Cloned to foo/ (origin http://www.denx.de/git/linux-2.6-denx.git available as branch "origin")
> 
> And I did run git-update-server-info, even with --force.

And what exactly is the problem? It seemed to clone ok.

> In the server log I see messages like these:
> 
> [Fri Nov 04 09:54:52 2005] [error] [client 84.150.96.170] File does not exist: /srv/git/linux-2.6-denx.git/objects/01
..snip..
> [Fri Nov 04 09:55:13 2005] [error] [client 84.150.96.170] File does not exist: /srv/git/linux-2.6-denx.git/objects/bc

The fetching code first tries to look into the unpacked object store
(that are those errors) and if that fails, it grabs a pack.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
