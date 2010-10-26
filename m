From: Bron Gondwana <brong@fastmail.fm>
Subject: Re: Why /var/cache/git?
Date: Tue, 26 Oct 2010 12:22:24 +1100
Organization: brong.net
Message-ID: <20101026012224.GA3360@brong.net>
References: <20101025103006.GA18782@brong.net>
 <4CC5A13F.2090702@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bron Gondwana <brong@fastmail.fm>, git@vger.kernel.org,
	pape@smarden.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Tue Oct 26 03:22:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAYFG-0005UN-MQ
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 03:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862Ab0JZBW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 21:22:28 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55903 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753733Ab0JZBW2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Oct 2010 21:22:28 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CC6F2576;
	Mon, 25 Oct 2010 21:22:27 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 25 Oct 2010 21:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=smtpout; bh=CZgknt6k8ccD2Hh0gUZNAhqd8Dk=; b=kZ11xZwdJ1uJEi/mMHX85gXpNwujvU3rEngtZMm755ZV2Ijzv37E0iC/83Mo3c+EGYfQXEzdyv0HGG5hkda+ZYfNBrd/FNa8z+bZhqIheKyHoX6JgUMmS8M5wKz9T6B3BhgYB/ttvIT8Va1kv8E7RSIeh/6fMSylzVKObPi9ghU=
X-Sasl-enc: qOzRnMuqlj9me8OUC+gwUAD1YtZ0PdAa7yHhrlE9TQ9s 1288056147
Received: from launde (unknown [202.138.5.42])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 65B715E3929;
	Mon, 25 Oct 2010 21:22:27 -0400 (EDT)
Received: by launde (Postfix, from userid 1000)
	id 591FA403C5; Tue, 26 Oct 2010 12:22:24 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <4CC5A13F.2090702@eaglescrag.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159974>

On Mon, Oct 25, 2010 at 08:24:47AM -0700, J.H. wrote:
> On 10/25/2010 03:30 AM, Bron Gondwana wrote:
> > (resent - correct address for git list!)
> > 
> > (Gerrit: you're CC'd as the attribution in README.Debian
> >  which in the one place I can see /var/cache/git mentioned
> >  in the docs - without a justification for why it was
> >  chosen...)
> 
> Couple of quick points:
> 
> $ grep -Ri "/var/git\|\/var\/git" *
> Documentation/git-cvsserver.txt:     export
> CVSROOT=:ext:user@server:/var/git/project.git
> 
> gitweb/README:    RewriteRule ^/var(/|/gitweb.cgi)?$	
> /cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/var/git/,L,PT]
> 
> gitweb/README:Second, repositories found in /pub/scm/ and /var/git/ will
> be accesible
> 
> Are the only 3 instances where this is mentioned.  Looking at those
> quick it was probably chosen based on the fact that it's a location that
> likely exists on most machines.  Or just for explanatory reasons like
> /example/dir/project.git could be used.

I have no problem with /var/git - it's /var/cache/git that worries
me, since the FHS quite clearly says that blowing away /var/cache/*
is not a problem.  It makes sense to back up /var/lib/ on any machine,
since that's somewhere that contains application data.  We already
back up a few things from /var/lib (like /var/lib/svn for example,
at least until we finish this switchover!)
 
Bron.
