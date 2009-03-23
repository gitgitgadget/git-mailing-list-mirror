From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Summer of Code - Cached Packs/Object Lists
Date: Sun, 22 Mar 2009 18:59:36 -0700
Message-ID: <20090323015936.GM23521@spearce.org>
References: <fsmi80et2dp57f5bdxUYAxe124vaj_firegpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: thisnukes4u@gmail.com
X-From: git-owner@vger.kernel.org Mon Mar 23 03:01:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlZTT-0006hw-Gd
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 03:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756939AbZCWB7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 21:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756734AbZCWB7j
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 21:59:39 -0400
Received: from george.spearce.org ([209.20.77.23]:38388 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757301AbZCWB7i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 21:59:38 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BD09A38211; Mon, 23 Mar 2009 01:59:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <fsmi80et2dp57f5bdxUYAxe124vaj_firegpg@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114226>

Please line wrap your email at something useful to others when
quoting, like 70-72 characters per line.

thisnukes4u@gmail.com wrote:
> I am particularly interested in the packfile caching project
> mentioned on the wiki, but I have a couple of questions:
>
> 1.  Would it be possible to implement both the packfile and
> object list caching mechanisms, or might would one interfere with
> the other in some way?

You could do both.  But I think most people on the list will argue
that doing both is overkill and only one is necessary, and further,
that only the one that offers the "biggest bank for the buck"
should be implemented.

Whole pack file caching has been discussed on list a few times as a
nice feature to have, but it raises some issues of cache management,
not to mention the issue I posed about it being relatively useless
on frequently changing repositories.

> 2.  With just a quick perusal of the daemon source, I noticed
> that it shells out to the upload-pack command. Where would it be
> appropriate to implement such a caching mechanism, in the daemon
> proper, the upload-pack code, or would both need to be updated?

The daemon doesn't get enough data from the client in order to
perform any sort of caching.

So the caching has to happen in upload-pack, and/or pack-objects.
(upload-pack forks out to pack-objects to create the pack file to
send to the client)

-- 
Shawn.
