From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Don't require working tree for git-rm
Date: Sat, 3 Nov 2007 13:11:50 +0100
Organization: glandium.org
Message-ID: <20071103121150.GB4295@glandium.org>
References: <1194084521-12962-1-git-send-email-mh@glandium.org> <Pine.LNX.4.64.0711031155070.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 03 13:13:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoHsf-000508-C0
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 13:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975AbXKCMND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 08:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbXKCMND
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 08:13:03 -0400
Received: from vawad.err.no ([85.19.200.177]:36336 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752279AbXKCMNB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 08:13:01 -0400
Received: from aputeaux-153-1-33-156.w82-124.abo.wanadoo.fr ([82.124.3.156] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IoHs1-0001mG-0Z; Sat, 03 Nov 2007 13:12:59 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IoHqw-0001DT-Ml; Sat, 03 Nov 2007 13:11:50 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711031155070.4362@racer.site>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63248>

On Sat, Nov 03, 2007 at 11:56:17AM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 3 Nov 2007, Mike Hommey wrote:
> 
> > This allows to do git rm --cached -r directory, instead of
> > git ls-files -z directory | git update-index --remove -z --stdin.
> > This can be particularly useful for git-filter-branch users.
> > 
> > Signed-off-by: Mike Hommey <mh@glandium.org>
> > ---
> >  git.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/git.c b/git.c
> > index 4e10581..01dcb6a 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -345,7 +345,7 @@ static void handle_internal_command(int argc, const char **argv)
> >  		{ "rev-list", cmd_rev_list, RUN_SETUP },
> >  		{ "rev-parse", cmd_rev_parse, RUN_SETUP },
> >  		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
> > -		{ "rm", cmd_rm, RUN_SETUP | NEED_WORK_TREE },
> > +		{ "rm", cmd_rm, RUN_SETUP },
> 
> Just removing this is wrong!
> 
> You have to test for a working tree if "--cached" was _not_ given.  

See the other patch I sent a bit later.

Mike
