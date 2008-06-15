From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 3/3] The "curl" executable is no longer required
Date: Sun, 15 Jun 2008 13:47:31 +0200
Message-ID: <200806151347.31676.johan@herland.net>
References: <200806120920.31161.johan@herland.net>
 <ee77f5c20806150352n6ccf00e9w8083a17d8c5c2326@mail.gmail.com>
 <m3fxreq60t.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, David Symonds <dsymonds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 13:49:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7qjb-0003ip-GU
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 13:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757282AbYFOLsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 07:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757270AbYFOLsV
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 07:48:21 -0400
Received: from smtp.getmail.no ([84.208.20.33]:49424 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817AbYFOLsV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 07:48:21 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K2I00E0564KG700@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 13:48:20 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I00LDB637KKC0@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 13:47:31 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I006QR637WZ60@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 13:47:31 +0200 (CEST)
In-reply-to: <m3fxreq60t.fsf@localhost.localdomain>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85083>

On Sunday 15 June 2008, Jakub Narebski wrote:
> "David Symonds" <dsymonds@gmail.com> writes:
> > On Sun, Jun 15, 2008 at 8:16 PM, Johan Herland <johan@herland.net> 
wrote:
> > > diff --git a/git.spec.in b/git.spec.in
> > > index 97a26be..d946bb1 100644
> > > --- a/git.spec.in
> > > +++ b/git.spec.in
> > > @@ -12,7 +12,7 @@ BuildRequires:        zlib-devel >= 1.2,
> > > openssl-devel, curl-devel, expat-devel, gettex
> > >  BuildRoot:    
> > > %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
> > >
> > >  Requires:      perl-Git = %{version}-%{release}
> > > -Requires:      zlib >= 1.2, rsync, curl, less, openssh-clients,
> > > expat +Requires:      zlib >= 1.2, rsync, less, openssh-clients,
> > > expat Provides:      git-core = %{version}-%{release}
> > >  Obsoletes:     git-core <= 1.5.4.2
> > >  Obsoletes:     git-p4
> >
> > Shouldn't libcurl still be listed as a requirement? Or is it
> > statically linked?
>
> It is not necessary to enumerate simple library dependencies, as
> rpmbuild _detects_ those dependencies during building binary RPMS.
> Only unusual requirements (on programs (tools) or on specific version
> of library) are needed to be added in Requires header.
>
> This has nothing to do with BuildRequires.  Besides it worked without
> libcurl in Requires, so it should continue to work without it,
> isn't it?

Unfortunately I don't know this format at all. There are now two versions of 
the patch, one without "Requires: curl", and one where it's replaced 
by "Requires: libcurl". Someone with more RPM knowledge will have to 
determine which is right.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
