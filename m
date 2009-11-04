From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 11/13] Allow helpers to request the path to the .git
  directory
Date: Wed, 4 Nov 2009 17:27:24 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911041723010.14365@iabervon.org>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>  <1257364098-1685-12-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0911041621400.14365@iabervon.org> <fabb9a1e0911041406tce0956ai2ad3fe6cfbdc546d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 23:27:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5oKA-0000Of-Ve
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 23:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649AbZKDW1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 17:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755707AbZKDW1U
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 17:27:20 -0500
Received: from iabervon.org ([66.92.72.58]:60630 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755374AbZKDW1U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 17:27:20 -0500
Received: (qmail 4147 invoked by uid 1000); 4 Nov 2009 22:27:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Nov 2009 22:27:24 -0000
In-Reply-To: <fabb9a1e0911041406tce0956ai2ad3fe6cfbdc546d@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132162>

On Wed, 4 Nov 2009, Sverre Rabbelier wrote:

> Heya,
> 
> On Wed, Nov 4, 2009 at 22:35, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > I thought we cd into the repository in the middle of clone somewhere,
> > before running stuff.
> 
> It does, but not soon enough, that is, not before I needed it in my helper.
> 
> > In any case, I think it would be good to have
> > something like that, but I think maybe we should tell it where it can put
> > its status files, rather than telling it where the .git dir is.
> 
> Yes, that would probably be a good idea, .git/info/remote-<vcs>/<alias> perhaps?

Seems reasonable to me, unless we make it .git/info/remote-<vcs>, and tell 
helper authors to deal with having different imports not conflict with 
each other.

> > It would
> > also be nice if this is the absolute path that gfi will base a relative
> > path for the "marks" options on when importing.
> 
> The marks option has been dumped in favor of 'feature import-marks='
> and 'feature export-marks=' which will be in the reroll of
> sr/gfi-options.

Right, but the values of those have to be paths, and I think they should 
be relative paths, relative to the helper's state directory.

	-Daniel
*This .sig left intentionally blank*
