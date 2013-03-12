From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: linux-next: unneeded merge in the security tree
Date: Tue, 12 Mar 2013 17:20:27 -0400
Message-ID: <20130312212027.GE14792@thunk.org>
References: <20130312100950.e45ef0e721492ff0d5fd7c8d@canb.auug.org.au>
 <alpine.LRH.2.02.1303121510270.25612@tundra.namei.org>
 <20130312041641.GE18595@thunk.org>
 <CA+55aFzFLDcN-1GKae6Xqrns59K1xOD_HPzuv2Lv1__fZpqFMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Morris <jmorris@namei.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-next-owner@vger.kernel.org Tue Mar 12 22:21:01 2013
Return-path: <linux-next-owner@vger.kernel.org>
Envelope-to: glkn-linux-next@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-next-owner@vger.kernel.org>)
	id 1UFWd0-0000eB-8p
	for glkn-linux-next@plane.gmane.org; Tue, 12 Mar 2013 22:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671Ab3CLVUe (ORCPT <rfc822;glkn-linux-next@m.gmane.org>);
	Tue, 12 Mar 2013 17:20:34 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:52956 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755682Ab3CLVUe (ORCPT <rfc822;linux-next@vger.kernel.org>);
	Tue, 12 Mar 2013 17:20:34 -0400
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1UFWcW-0001A9-Pj; Tue, 12 Mar 2013 21:20:28 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id A4DDD42C380; Tue, 12 Mar 2013 17:20:27 -0400 (EDT)
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	James Morris <jmorris@namei.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <CA+55aFzFLDcN-1GKae6Xqrns59K1xOD_HPzuv2Lv1__fZpqFMw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-next-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-next.vger.kernel.org>
X-Mailing-List: linux-next@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217995>

What if we added the ability to do something like this:

[remote "origin"]
	url = git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
	fetch = +refs/heads/master:refs/heads/master
	mergeoptions = --ff-only

This would be an analog to branch.<name>.mergeoptions, but it would
apply to the source of the pull request, instead of the destination.

That way, people who do a "git pull" from Linus's tree would get the
protection of --ff-only, while pulls from submaintainer trees would
automatically get a merge commit, which is what we want.

It doesn't handle the case of a submaintainer pulling from a
maintainer in a back-merge scenario, but that should be a pretty rare
case, so maybe that's OK.

      	     	       	   	- Ted
