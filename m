From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Mon, 1 Jan 2007 19:10:44 -0500
Message-ID: <20070102001044.GB32148@fieldses.org>
References: <20070101214023.GB23857@fieldses.org> <182318.86313.qm@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 02 01:10:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1XEw-0007GW-1j
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 01:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbXABAKr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 19:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbXABAKr
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 19:10:47 -0500
Received: from mail.fieldses.org ([66.93.2.214]:43057 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932636AbXABAKq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 19:10:46 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H1XEq-0000a0-Cz; Mon, 01 Jan 2007 19:10:44 -0500
To: Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <182318.86313.qm@web31812.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35754>

On Mon, Jan 01, 2007 at 04:01:15PM -0800, Luben Tuikov wrote:
> --- "J. Bruce Fields" <bfields@fieldses.org> wrote:
> > -The common `Pull: master:origin` mapping of a remote `master`
> > -branch to a local `origin` branch, which is then merged to a
> > -local development branch, again typically named `master`, is made
> > -when you run `git clone` for you to follow this pattern.
> 
> So is this no longer the case?

Right; that mapping is no longer what git clone sets up for you.

> Can someone please bring me up to date?
> 
> What is going on?

The simplest way to understand the current behavior is probably to
install the latest git, read the git-clone man page, clone a new
repository, and take a look at it.

Remote branches are stored in separate namespaces under
.git/refs/remotes/, so that they don't muck up your view of your local
branches, and so git can enforce different policies for them (such as
forbidding committing to them).

--b.
