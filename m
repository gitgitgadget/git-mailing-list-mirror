From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/8] Add a config option for remotes to specify a foreign
  vcs
Date: Tue, 11 Aug 2009 18:20:54 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908111817490.4638@intel-tinevez-2-302>
References: <alpine.LNX.2.00.0908091526060.27553@iabervon.org>  <7v1vnk79lt.fsf@alter.siamese.dyndns.org> <36ca99e90908110831g2ad52a5ar4a755723a6682f77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Brian Gernhardt <benji@silverinsanity.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 18:21:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mau5z-0006Sx-NA
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 18:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbZHKQU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 12:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbZHKQU4
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 12:20:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:40288 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751787AbZHKQU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 12:20:56 -0400
Received: (qmail invoked by alias); 11 Aug 2009 16:20:56 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp026) with SMTP; 11 Aug 2009 18:20:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/S2q4qZ7PS5vq5pZmnLQ9UbE/Hs8SHZhvUaAgNvy
	OltHJDATcmSYu4
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <36ca99e90908110831g2ad52a5ar4a755723a6682f77@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125584>

Hi,

On Tue, 11 Aug 2009, Bert Wesarg wrote:

> On Mon, Aug 10, 2009 at 03:15, Junio C Hamano<gitster@pobox.com> wrote:
> > Daniel Barkalow <barkalow@iabervon.org> writes:
> >
> >> If this is set, the url is not required, and the transport always uses
> >> a helper named "git-remote-<value>".
> >>
> >> It is a separate configuration option in order to allow a sensible
> >> configuration for foreign systems which either have no meaningful urls
> >> for repositories or which require urls that do not specify the system
> >> used by the repository at that location. However, this only affects
> >> how the name of the helper is determined, not anything about the
> >> interaction with the helper, and the contruction is such that, if the
> >> foreign scm does happen to use a co-named url method, a url with that
> >> method may be used directly.
> >
> > Personally, I do not like this.
> >
> > Why isn't it enough to define the canonical remote name git takes as
> > "<name of the helper>:<whatever string the helper understands>"?
> 
> May I ask what will happen to these supported URL notations:
> 
> 
>        o   [user@]host.xz:/path/to/repo.git/
> 
>        o   [user@]host.xz:~user/path/to/repo.git/
> 
>        o   [user@]host.xz:path/to/repo.git
> 
> this will bite you, if you have an ssh host alias named "<your
> favorite helper name>".

That is a valid concern.  I'd suggest to disallow @ and . in the protocol 
name (maybe even everything non-alnum).  For shortcuts that really read 
like "svn", I think it is not too much asked for to require adjusting the 
URL (by prefixing ssh:// and adjusting the path).

If there is really anybody who uses Git via ssh to access a server called 
"svn", we could just as well have a little fun with them, don't you agree?

Ciao,
Dscho
