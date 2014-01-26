From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Added get sendmail from .mailrc
Date: Sun, 26 Jan 2014 09:17:09 +0000
Message-ID: <20140126091709.GA31073@dcvr.yhbt.net>
References: <1390643210-5748-1-git-send-email-brilliantov@inbox.ru>
 <20140125223721.GA2684@dcvr.yhbt.net>
 <20140126073438.GA3858@kirill.netbynet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 26 10:17:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7LqD-0002n4-Ce
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jan 2014 10:17:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbaAZJRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 04:17:15 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:57388 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348AbaAZJRO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jan 2014 04:17:14 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFFA521655;
	Sun, 26 Jan 2014 09:17:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20140126073438.GA3858@kirill.netbynet.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241081>

Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru> wrote:
> On 2014-01-25 22:37:21, Eric Wong wrote:
> > Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru> wrote:
> > > --- a/git-send-email.perl
> > > +++ b/git-send-email.perl
> > > @@ -28,6 +28,7 @@ use File::Temp qw/ tempdir tempfile /;
> > >  use File::Spec::Functions qw(catfile);
> > >  use Error qw(:try);
> > >  use Git;
> > > +use File::HomeDir;
> > 
> > We should probably avoid a new dependency and also remain consistent
> > with the rest of git handles home directories.
> > 
> > Unfortunately, expand_user_path()/git_config_pathname() isn't currently
> > exposed to scripters right now...
> 
> Ok, if new dependency is not allowed I see next ways:

Not saying it's not allowed.  I meant we should probably expose
expand_user_path()/git_config_pathname() C functions to script helpers
(so git-config or git-rev-parse can provide them to sh or perl scripts).
