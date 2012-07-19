From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] git-svn: don't create master if another head exists
Date: Thu, 19 Jul 2012 08:19:35 +0000
Message-ID: <20120719081935.GA15414@dcvr.yhbt.net>
References: <7vfw9hafz8.fsf@alter.siamese.dyndns.org>
 <20120626223215.GB8336@beczulka>
 <20120709220321.GE30213@beczulka>
 <7v8vesk12v.fsf@alter.siamese.dyndns.org>
 <20120711012617.GA18369@dcvr.yhbt.net>
 <20120711214019.GF30213@beczulka>
 <7vmx35dhzo.fsf@alter.siamese.dyndns.org>
 <20120718074908.GA23460@beczulka>
 <20120718112722.GA22042@dcvr.yhbt.net>
 <20120718124723.GA17379@beczulka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marcin Owsiany <marcin@owsiany.pl>
X-From: git-owner@vger.kernel.org Thu Jul 19 10:19:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Srlxl-0003VY-Ex
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 10:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871Ab2GSITi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 04:19:38 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39719 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866Ab2GSITg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 04:19:36 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B2E71F451;
	Thu, 19 Jul 2012 08:19:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20120718124723.GA17379@beczulka>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201728>

Marcin Owsiany <marcin@owsiany.pl> wrote:
> On Wed, Jul 18, 2012 at 11:27:22AM +0000, Eric Wong wrote:
> > Marcin Owsiany <marcin@owsiany.pl> wrote:
> > > Turns out that command_noisy()
> > >  - has a meaningless return value
> > >  - throws an exception on command failure
> > > so the "||" bit does not work.
> > > Also, for some reason command_noisy does not check for the command being
> > > killed by a signal, so I'd prefer to leave the verify_ref there.
> > 
> > Ugh, I always forget the Git.pm API, too.  Perhaps command_noisy should
> > be made to respect signals in exit codes (the rest of git-svn is
> > compromised by this behavior in command_noisy, too, it turns out... :x)
> > 
> > I'm not sure what else would break if command_noisy were changed,
> > git-svn appears to be the only user in git.git.
> 
> Other "command" flavours should probably also be changed to match?

Probably, I'm not sure if it'd break existing uses.  Anyways, that's a
separate issue we can deal with another day.

I've added my Signed-off-by: to your latest patch and pushed
to "master" of git://bogomips.org/git-svn.git
(commit e3bd4ddaa9a60fa4e70efdb143b434b440d6cec4)

Marcin Owsiany (1):
      git-svn: don't create master if another head exists
