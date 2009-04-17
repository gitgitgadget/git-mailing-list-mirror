From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Allow git-shell to be used as a ssh forced-command
Date: Sat, 18 Apr 2009 00:36:49 +0200
Message-ID: <20090417223649.GA1881@glandium.org>
References: <1239916256-10878-1-git-send-email-mh@glandium.org> <37fcd2780904170924t61168a49uf1800098cdb1d730@mail.gmail.com> <20090417194919.GA7611@glandium.org> <37fcd2780904171400uf9d1f36g4d24e02aebf6ac3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 00:38:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Luwhi-0005Ur-0w
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 00:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbZDQWhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 18:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbZDQWhB
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 18:37:01 -0400
Received: from vuizook.err.no ([85.19.221.46]:42121 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083AbZDQWhA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 18:37:00 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1Luwfy-00012W-Mb; Sat, 18 Apr 2009 00:36:53 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1Luwfx-0000Ut-8j; Sat, 18 Apr 2009 00:36:49 +0200
Content-Disposition: inline
In-Reply-To: <37fcd2780904171400uf9d1f36g4d24e02aebf6ac3f@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116800>

On Sat, Apr 18, 2009 at 01:00:35AM +0400, Dmitry Potapov wrote:
> On Fri, Apr 17, 2009 at 09:49:19PM +0200, Mike Hommey wrote:
> > On Fri, Apr 17, 2009 at 08:24:35PM +0400, Dmitry Potapov wrote:
> > > On Thu, Apr 16, 2009 at 11:10:56PM +0200, Mike Hommey wrote:
> > > > When using a forced-command, OpenSSH sets the SSH_ORIGINAL_COMMAND
> > > > variable to what would otherwise be passed to $SHELL -c. When this
> > > > variable is set, we use it instead of the contents of argv.
> > >_
> > > It would be nice to provide some justification where it can be used.
> > > IOW, why do you want to have the force command where essentially
> > > you execute the original command as it were no force-command?
> >_
> > You're not executing any command, but only what git-shell allows.
> > This allows git-shell to be set as a forced-command for a specific
> > ssh key, for example.
> 
> Would it better to set git-shell as the login shell for this account?
> IMHO, that provides better security than using a forced-command, and
> that is how git-shell is intended to use. So, I am not sure what are
> benefits of using a forced-command when it just executes the original
> command using git-shell.

You may want to provide other kind of accesses for the same account.
Also, an unpriviledged user would be able to, without root access, setup
write access to his private git repositories via forced-commands for
given ssh keys.

> Besides, you made SSH_ORIGINAL_COMMAND to take precedent over explicitly
> specified parameters given to git-shell. Maybe it should be the other
> way around?

If SSH_ORIGINAL_COMMAND is set, which means forced-commands are in use,
I don't see why other parameters should be more important.

Mike
