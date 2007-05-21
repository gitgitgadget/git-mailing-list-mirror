From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Mon, 21 May 2007 10:54:19 +0200
Message-ID: <20070521085419.GG942MdfPADPa@greensroom.kotnet.org>
References: <11796842882917-git-send-email-skimo@liacs.nl>
 <20070520225252.GO5412@admingilde.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Mon May 21 10:54:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq3ey-0005Ye-D6
	for gcvg-git@gmane.org; Mon, 21 May 2007 10:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755482AbXEUIyZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 04:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755779AbXEUIyZ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 04:54:25 -0400
Received: from smtp17.wxs.nl ([195.121.247.8]:47247 "EHLO smtp17.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755482AbXEUIyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 04:54:25 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp17.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JID00I8BVELBN@smtp17.wxs.nl> for git@vger.kernel.org; Mon,
 21 May 2007 10:54:21 +0200 (CEST)
Received: (qmail 5978 invoked by uid 500); Mon, 21 May 2007 08:54:19 +0000
In-reply-to: <20070520225252.GO5412@admingilde.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47994>

On Mon, May 21, 2007 at 12:52:53AM +0200, Martin Waitz wrote:
> That leads to submodules which store their objects within the
> supermodule .git directory,

My code clones submodules in .git/submodules/<submodule>, so
that could be a good default.

> which would automatically obsolete the
> need to specify explicit submodule URLs.

Absolutely not.  The subproject will likely have a life of its own.
If you export it on the same machine, then why would you have two
different URLs for the same project?
Also, the subproject will typically not even be on the same site,
so you _have_ to be able to specify a submodule URL.
(I noticed that I forgot the "git://" protocol; I'll add that in
the next round.)

> So back to your code: I don't like absolute URLs in the cloneable part
> of the repository.  We should try to stay with relative ones which
> can stay the same everywhere.

The problem with relative paths is that you don't know if the
URL the user gave you points to the working directory or the
git directory of the project, but I guess I can let dump-config
tell you where it found the config file.

skimo
