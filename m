From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: On pathnames
Date: Fri, 25 Jan 2008 12:25:22 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801251137030.5731@racer.site>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org> <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu>
 <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org> <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org> <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org> <20080123094052.GB6969@glandium.org> <20080123133802.GC7415@mit.edu>
 <alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org> <98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org> <alpine.LFD.1.00.0801230930390.1741@woody.linux-foundation.org> <7vprvr7x8h.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801241722130.22568@xanadu.home>
 <7vy7ae7dcb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-556342719-1201263925=:5731"
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>, Theodore Tso <tytso@MIT.EDU>,
	Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 13:26:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JINdN-0007sz-4V
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 13:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948AbYAYMZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 07:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753794AbYAYMZh
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 07:25:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:41142 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752792AbYAYMZg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 07:25:36 -0500
Received: (qmail invoked by alias); 25 Jan 2008 12:25:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp052) with SMTP; 25 Jan 2008 13:25:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+n3sV2tXSnXoUrR7rLUiRO1udqpteBE+PBiwX+kA
	lf2drpsM5Ppl8f
X-X-Sender: gene099@racer.site
In-Reply-To: <7vy7ae7dcb.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71701>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-556342719-1201263925=:5731
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 24 Jan 2008, Junio C Hamano wrote:

>     $ edit Märchen ;# assume this is a new file
>     $ git add Märchen ;# we were told that IM gives $B (aka NFC)

Please see the discussion on IRC I started with

http://colabti.de/irclogger/irclogger_log/git?date=2008-01-25,Fri&sel=16#l36

(asking for somebody to test the issue if filenames are still mangled when 
the volume was created _case-sensitive_).  The interesting part is this:

http://colabti.de/irclogger/irclogger_log/git?date=2008-01-25,Fri&sel=31#l56

(me asking to git-add the file "Märchen" explicitely),

http://colabti.de/irclogger/irclogger_log/git?date=2008-01-25,Fri&sel=39#l66

(dsymonds saying that no untracked files are shown), and

http://colabti.de/irclogger/irclogger_log/git?date=2008-01-25,Fri&sel=47#l76

(dsymonds showing that the git index contains the mangled filename, _not_ 
what we asked for).  The strange thing is that

http://colabti.de/irclogger/irclogger_log/git?date=2008-01-25,Fri&sel=57#l89

the command line seems not to be mangling the name.

Summary:

it seems that for some strange reason, "git add Märchen" puts the mangled 
filename into the index, even if "echo Märchen" shows the unmangled 
filename.

Ciao,
Dscho

---1463811741-556342719-1201263925=:5731--
