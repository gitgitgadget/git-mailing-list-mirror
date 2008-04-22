From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Tue, 22 Apr 2008 09:52:41 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804220949590.4460@eeepc-johanness>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
 <7vabjm78v2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658432-973574921-1208854362=:4460"
Cc: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 10:53:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoEFV-00015G-05
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 10:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757115AbYDVIwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 04:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757098AbYDVIwS
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 04:52:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:42072 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757097AbYDVIwR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 04:52:17 -0400
Received: (qmail invoked by alias); 22 Apr 2008 08:52:15 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp022) with SMTP; 22 Apr 2008 10:52:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Avf8HaqtAyar3Y/E8w7Ugrt6oWpDUa8Moy8WD13
	IzRIng80QVeVW8
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vabjm78v2.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80082>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--658432-973574921-1208854362=:4460
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 21 Apr 2008, Junio C Hamano wrote:

> Jörg Sommer <joerg@alea.gnuu.de> writes:
> 
> > @@ -244,6 +252,19 @@ peek_next_command () {
> >  	sed -n "1s/ .*$//p" < "$TODO"
> >  }
> >  
> > +mark_to_ref () {
> > +	case "$1" in
> > +	:[!/]*)
> > +		# :/SOMETHING is a reference for the last commit whose
> > +                # message starts with SOMETHING
> > +		echo "$mark_prefix${1#:}"
> > +		;;
> 
> What was the conclusion of the mark-syntax discussion?

Well, I will probably work on something that is not as intrusive and 
syntax-changing this week.

> While I know the bang in ":[!negated]" is POSIX, I wonder if everybody's
> shell we care about groks it.

The common way to do that in the git sources is

	switch "$x" in
	/*)
		# do nothing
		;;
	*)
		<bla>
		;;
	esac

and frankly, I do not see a reason to move away from that practice.  
Especially since consistency in source code is better than inconsistency.

Ciao,
Dscho
--658432-973574921-1208854362=:4460--
