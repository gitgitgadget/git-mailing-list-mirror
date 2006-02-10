From: Sam Vilain <sam@vilain.net>
Subject: Re: Tracking and committing back to Subversion?
Date: Sat, 11 Feb 2006 00:16:11 +1300
Message-ID: <1139570171.12123.29.camel@localhost.localdomain>
References: <1138834301.21899.40.camel@wilber.wgtn.cat-it.co.nz>
	 <200602091650.55370.linuxfood@linuxfood.net> <43EC162E.9090905@vilain.net>
	 <200602092301.21098.linuxfood@linuxfood.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 12:16:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7WGP-0007Mw-Ai
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 12:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWBJLQa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 06:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWBJLQa
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 06:16:30 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:29086 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1751206AbWBJLQ3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2006 06:16:29 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 01A6943E2; Sat, 11 Feb 2006 00:16:25 +1300 (NZDT)
Received: from localhost.localdomain (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 36C6D8BB;
	Sat, 11 Feb 2006 00:16:19 +1300 (NZDT)
To: Brian Smith <linuxfood@linuxfood.net>
In-Reply-To: <200602092301.21098.linuxfood@linuxfood.net>
X-Mailer: Evolution 2.4.1 
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15871>

On Thu, 2006-02-09 at 23:01 -0800, Brian Smith wrote:
> > > While that is an admirable goal, unless you can point me to something
> > > that will allow you to actually commit back to SVN without a working
> > > copy,
> > Such as SVK
> >    http://svk.elixus.org/
> >    (svn url: http://svn.openfoundry.org/svk/)
> Well, after reading through a number of pages I discovered something:
> "The repository created is actually a Subversion repository. In other words, 
> you could use any subversion commands with that repository." [*1*]
> So, while it is a technicality, there is an SVN Repo, which is what
> I'm trying to avoid[...

Yes, currently there is - but let me show you what's under the hood
briefly... as you notice later;

> (Incidentally, the allure of the SVN perl bindings had me for awhile, but 
> after trying to decipher the horrid PODs for it decided that Bash was just 
> easier. )

Yes, there are SWIG bindings for various languages.  In debian/ubuntu the
Perl bindings will be built to the package libsvn-core-perl.

Take a look at this module:

  http://search.cpan.org/dist/SVN-Simple/lib/SVN/Simple/Edit.pm

That uses the above module and allows you to construct a Subversion
commit and try to apply it.

The documentation's a bit weak, but AFAIK the basic functionality is
there and a lot better an abstraction than the raw bindings themselves.

SVN::Mirror:

  http://search.cpan.org/dist/SVN-Mirror/lib/SVN/Mirror.pm

can go the other way.

> (the point being to have a git repo after all, for
> the purpose of using git commands), perhaps it would be worth looking
> into to see if I could somehow utilize the svk svn repo (since there
> are space savings) for the SVN working copy. [*2*]

That's right - in principle, SVK could be plumbed to have a git
repository in its ~/.svk/local - then you could have one git repo, and a
head for each mirrored project.

But don't concern yourself with my plans - it seems our tastes in
porcelain differ ;)

Sam.
