From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT RFC PATCH] Add a stdio prompt for SSH connection information.
Date: Sun, 22 Jun 2008 19:13:55 -0400
Message-ID: <20080622231355.GH11793@spearce.org>
References: <200806222306.25434.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 01:15:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAYlz-0002Sh-Rd
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 01:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755044AbYFVXOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 19:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755266AbYFVXOA
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 19:14:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58144 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907AbYFVXOA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 19:14:00 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KAYkl-0002HM-VK; Sun, 22 Jun 2008 19:13:48 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7A67120FBAE; Sun, 22 Jun 2008 19:13:55 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200806222306.25434.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85814>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> Starting a command line utility like jgit and getting a graphical prompt is almost
> an insult. The problem here is that Java 5, which we support, does not have a
> portable way of disabling echoing of characters. Java 6 (and anythung newr)
> does. There are several solutions involving non-portable tricks. Should we 
> support an insecure practice of echoing passwords, or as I do here, only support
> it if one is using Java 6. A downside of supporting it at all is that one needs a
> JavaSE 6 compiler to build the thing.

We really shouldn't support insecure entry of the password.  But I'm
also not ready to give up on Java 5 support either.  I wonder if
we shouldn't hide the console reading/writing into a class in our
util package and use reflection to access it, like we do for the
executable flag of java.io.File.
 
> btw, does anyone know if console() yields null when runnings as a Windows
> service? I tentatively assume that it does without explicily setting the headless
> property.

I think that services on Windows have no console, and also can't
talk to the desktop UI, so its both headless and without a console.

> I'm also a little unsure about how to invoke the promptKeyboardInteractive method.

I think you implemented this method correctly.  Its a confusing API,
but it does seem to make sense.
 
-- 
Shawn.
