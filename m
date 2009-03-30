From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Implementing stat() with FindFirstFile()
Date: Mon, 30 Mar 2009 02:52:47 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0903300245080.6454@intel-tinevez-2-302>
References: <20090321154738.GA27249@jeeves.jpl.local> <200903212055.15026.j6t@kdbg.org> <20090324215416.GB27249@jeeves.jpl.local> <49CB2BA5.1070100@viscovery.net> <20090326213907.GC27249@jeeves.jpl.local> <alpine.DEB.1.00.0903270320020.10279@pacific.mpi-cbg.de>
 <20090329224803.GD27249@jeeves.jpl.local>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1723227639-1238374367=:6454"
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Magnus_B=E4ck?= <baeck@swipnet.se>
X-From: git-owner@vger.kernel.org Mon Mar 30 02:57:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo5oT-00035W-8V
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 02:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840AbZC3Aww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 20:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753631AbZC3Awv
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 20:52:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:46276 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751958AbZC3Awv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 20:52:51 -0400
Received: (qmail invoked by alias); 30 Mar 2009 00:52:48 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 30 Mar 2009 02:52:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18NSQFCP4kNUTXIVSBamiohmL16r1F1HnhkMrMpIQ
	f+UM9T2JbGlKZH
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090329224803.GD27249@jeeves.jpl.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115052>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1723227639-1238374367=:6454
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 30 Mar 2009, Magnus Bäck wrote:

> On Friday, March 27, 2009 at 03:25 CET,
>      Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > Magnus, it is the official policy to reply-to-all on this list.  This
> > has been mentioned in the past quite often, and it will be mentioned
> > in the future, too.
> 
> Sorry, I was not aware. Doesn't seem to have been mentioned in the last
> month or so. Perhaps it could be included in the list introduction
> message? All people obviously won't read it, but some will.
> 
> > You actually forced me to manually look up and re-add Hannes' address.
> > I do not appreciate having to waste my time like that.
> >
> > If that sounds negative, please understand that I am used to the ways
> > of this list, and when I am annoyed by somebody not fitting in, then
> > it is not totally _my_ mistake.
> 
> A plain "please use reply all" would've sufficed.

I do recognize that I was too harsh: I apologize!

> > On Thu, 26 Mar 2009, Magnus Bäck wrote:
> >
> > > I'd be very surprised if ZwQueryDirectoryFile() hasn't always been
> > > around (I just verified ntdll.dll from NT 4.0), so that's not a
> > > worry. Don't know why MSDN reports it as introduced in XP.
> >
> > As the current maintainer of msysGit, I refuse to have something in
> > the installer I ship that relies on not-at-all guaranteed interfaces.
> 
> Although I do appreciate the importance of guaranteed interfaces,
> I am also pragmatic. An incompatible change in ntdll.dll would break
> vast amounts of programs, including cygwin. There is a lot to be said
> about Microsoft and their APIs, but I don't think they have a habit of
> changing ABIs or function semantics for userland libraries that have
> been around for 15 years.

That does not give me the warm and fuzzy feeling I want to have when 
shipping a new Git for Windows.

Had you pointed to some document that states that the function has been in 
all NT-based versions, that would have done the trick.

> > > All right, I'll see if I can find time to take a look at this. I 
> > > just wanted to check that it wasn't a project policy or whatever to 
> > > bypass Win32.
> >
> > You can do whatever you want... This is Open Source.
> >
> > However, I will try to stay with the officially supported functionality,
> > even if that makes msysGit slower -- Windows will never reach the
> > performance levels of Linux anyway.
> 
> Okay, thanks. Just like you I hate wasting time, in my case with patches
> that'll be refused.

Sorry, that was not at all what I meant.

Of course, I wanted to avoid having time wasted: yours and mine.  But if 
you find said document, or another proof that the function was not 
introduced by pure chance in some of NT's service packs, then that's 
perfectly fine with me.

But if it is, say, only in NT when upgrading to Explorer 6 or newer, I do 
not want to take it: I personally know a machine running NT without 
service packs, and with Internet Explorer 5.5, because every attempt at 
upgrading freezes the complete machine 10 seconds into the login screen.  
And no, the machine cannot run with another setup, because there is a 
6-figure microscope plugged in that refuses to be controlled by anything 
else than the proprietary software that just happens to run only on said 
NT4, with said IE5.5.

Again, I am sorry for my harsh reaction, but please understand that I 
_need_ better proof that nobody will be bitten by your change (chances are 
that I'd have to clean it up...).

After all, in the short time since the release of 1.6.2.1, we had over 
4000 downloads already.

Ciao,
Dscho

--8323329-1723227639-1238374367=:6454--
