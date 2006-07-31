From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: fill in gitweb configuration by Makefile
Date: Mon, 31 Jul 2006 01:14:28 -0700 (PDT)
Message-ID: <20060731081428.17416.qmail@web31807.mail.mud.yahoo.com>
References: <7vzmeqa7tx.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 10:14:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7Sv2-00055H-33
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 10:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWGaIO3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 04:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWGaIO3
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 04:14:29 -0400
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:50327 "HELO
	web31807.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964829AbWGaIO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 04:14:28 -0400
Received: (qmail 17418 invoked by uid 60001); 31 Jul 2006 08:14:28 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=iHOGSv4VRo8JRpm8/b/DrLLYxyjjNPx6NXBwEyx3gNTSL5h3cMjlOjTMfvWo+rAVPpfuHnIsVMtQy1pzyHVemmkciOZ+VU7uffq2r5gctOIyaC7hs4QGAANuy2UkGugWcS+s/FpEhPxFLMj1LmEWbxrtQZe6mB0SOse9UqD8O54=  ;
Received: from [71.80.231.253] by web31807.mail.mud.yahoo.com via HTTP; Mon, 31 Jul 2006 01:14:28 PDT
To: Junio C Hamano <junkio@cox.net>, Martin Waitz <tali@admingilde.org>
In-Reply-To: <7vzmeqa7tx.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24501>

--- Junio C Hamano <junkio@cox.net> wrote:
> Martin Waitz <tali@admingilde.org> writes:
> 
> > diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.pl
> > similarity index 100%
> > rename from gitweb/gitweb.cgi
> > rename to gitweb/gitweb.pl
> > index 243a2921f849568260e848201d238b3b9fe7e1f2..8e05c335f801d4c52a9b348fa56fccfae36ce621
> 100755
> > --- a/gitweb/gitweb.cgi
> > +++ b/gitweb/gitweb.pl
> > @@ -24,14 +24,14 @@ our $rss_link = "";
> >  
> >  # core git executable to use
> >  # this can just be "git" if your webserver has a sensible PATH
> > -our $GIT = "/usr/bin/git";
> > +our $GIT = "@@GIT_BINDIR@@/git";
> >  
> >  # absolute fs-path which will be prepended to the project path
> >  #our $projectroot = "/pub/scm";
> > -our $projectroot = "/home/kay/public_html/pub/scm";
> > +our $projectroot = "@@GITWEB_PROJECTROOT@@";
> >  
> >  # version of the core git binary
> > -our $git_version = qx($GIT --version) =~ m/git version (.*)$/ ? $1 : "unknown";
> > +our $git_version = "@@GIT_VERSION@@";
> 
> I think the other parts are sensible but I am not sure if we
> want to report the version of git distribution (your patch), or
> the version of git binary the cgi script happens to use (the
> current implementation).

I'd rather see git distribution (Martin's patch) since, after all,
gitweb became part of git not so long ago.  And as thus, its own
numbers don't matter much, but the git distribution.

In fact, I was thinking of submitting a patch to the same effect
myself.

    Luben
