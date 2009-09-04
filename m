From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/8] Make the "traditionally-supported" URLs a special 
 case
Date: Fri, 4 Sep 2009 16:10:44 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909041546030.28290@iabervon.org>
References: <alpine.LNX.2.00.0909032213180.28290@iabervon.org>  <fabb9a1e0909032229k5e6e2ed5mc11e8ff9c16dfcc0@mail.gmail.com>  <alpine.LNX.2.00.0909041114440.28290@iabervon.org> <7vy6ouk4io.fsf@alter.siamese.dyndns.org>  <alpine.DEB.1.00.0909041930450.8306@pacific.mpi-cbg.de>
 <alpine.LNX.2.00.0909041429540.28290@iabervon.org> <fabb9a1e0909041235x74a3b9b4gf65e650ca0d00831@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-2013296706-1252095044=:28290"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 22:10:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjf7V-0001Nc-A4
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 22:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933854AbZIDUKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 16:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933848AbZIDUKn
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 16:10:43 -0400
Received: from iabervon.org ([66.92.72.58]:58705 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933729AbZIDUKn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 16:10:43 -0400
Received: (qmail 21155 invoked by uid 1000); 4 Sep 2009 20:10:44 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Sep 2009 20:10:44 -0000
In-Reply-To: <fabb9a1e0909041235x74a3b9b4gf65e650ca0d00831@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127766>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-2013296706-1252095044=:28290
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 4 Sep 2009, Sverre Rabbelier wrote:

> Heya,
> 
> On Fri, Sep 4, 2009 at 21:05, Daniel Barkalow<barkalow@iabervon.org> wrote:
> > Some foreign vcses, including the only one I ever personally use, do not
> > have URLs, and require a bunch of options and paths to specify a
> > repository. I don't want to have to use:
> >
> >        url = p4://rsh:ssh+-q+-a+-x+-l+p4ssh+-q+-x+perforce+%2Fbin%2Ftrue//projects/foo/bar-1.0/...,//projects/foo/bar-1.1/...
> 
> Btw, doesn't p4 have these config files that you can download that
> contain the configuration? In that case
> 'p4://example.org/p4/main-development.configfile' would be very
> convenient.

The only thing I know of which you might be thinking of is "client 
specifications", which are like git superprojects. They're almost certain 
to only specify one of the multiple locations that you want to have in the 
same repository; the multiple locations are the paths you want to treat 
as branches, and the client picks one branch of each project and places 
it in some non-branch-specific location relative to other projects. (Of 
course, someday I might want to support importing a client specification 
as a git project with submodules, but it's got the same issues as 
svn::externals without revision specifications seems to).

In any case, p4 doesn't have any easy generic way to specify how to 
contact the server, and doesn't have anything client-side.

> Regardless, I do think there should be some way to specify all this
> outside of the url, but to me that's secondary. I think the primary
> usecase is/should be cloning from some url in the form of
> 'hg://example.org/foo', rather than 'http://example.org/some-hg-repo'
> or 'p4://.......', since those are both exceptions (the former being
> an ambiguous url, and the latter being a non-url). Now I do understand
> if you don't want to spend your time on implementing the specialized
> url support since it doesn't scratch your itch, but at least your
> series shouldn't impend supporting that in the near future.

I'm pretty sure that this series makes your primary usecase slightly 
simpler to support, because it no longer is expected to handle the 
ambiguous "http://" class of URLs.

	-Daniel
*This .sig left intentionally blank*
--1547844168-2013296706-1252095044=:28290--
