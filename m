From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Sat, 19 Jan 2008 23:26:23 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801192311190.2957@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <2E6F57FC-3E78-4DD2-9B5B-CF75975D6A60@sb.org> <20080119084814.GH14871@dpotapov.dyndns.org>
 <alpine.LFD.1.00.0801191026500.2957@woody.linux-foundation.org> <B4FDA32F-16C9-497A-AAD8-27A8D510C4CB@wincent.com> <alpine.LFD.1.00.0801191659350.2957@woody.linux-foundation.org> <20080120052735.GA18581@glandium.org> <alpine.LFD.1.00.0801192130180.2957@woody.linux-foundation.org>
 <20080120070018.GA11015@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wincent Colaiuta <win@wincent.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Kevin Ballard <kevin@sb.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Jan 20 08:27:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGUag-0008Ti-UZ
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 08:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812AbYATH1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 02:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753917AbYATH1K
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 02:27:10 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59733 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752837AbYATH1I (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jan 2008 02:27:08 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0K7QOqk024903
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 Jan 2008 23:26:25 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0K7QN8n008545;
	Sat, 19 Jan 2008 23:26:24 -0800
In-Reply-To: <20080120070018.GA11015@glandium.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71162>



On Sun, 20 Jan 2008, Mike Hommey wrote:
> 
> That said, the locale doesn't necessarily express the language in which
> the document is written.

.. and quite commonly, there are multiple languages per document.

The good news is that sorting is almost never relevant or done over 
general documents. You sort almost only well-behaved data, and quite often 
the exact order is less than important: and when it is, you have very 
specific rules (which probably seldom have anything what-so-ever to do 
with general unicode ;).

> It's easy enough to read documents that are not
> written in your native language on the net. That's already what we are both
> doing right now. Fortunately, HTTP and HTML have ways to indicate the
> language in which a document is written in, but that leaves out plain
> mail, for instance. 

Well, Unicode already handles the "reading" part, just not the sorting.

> That said, the "decomposed" version of UTF-8 has nice side effects on
> OSX, with UTF-8 encoded RockRidge ISO-9660 volumes (with or without
> Joliet ; OSX will use RockRidge by default when it's there), for instance.

I think Unicode in general (and UTF-8 in particular) is a great thing. I 
do not argue against Unicode at all.  It's what I use myself.

The thing I argue against is that they force normalization (and then, as a 
secondary complaint, their insane choice of target format).

Linux is generally UTF-8 too, and does all of this much better. No forced 
normalization, and it uses UTF-8 everywhere as the encoding model. Joliet 
and RR works beautifully.

(I don't think RR is NFD, btw. It's the standard microsoft UTF-16 without 
normalization, afaik. I think you can happily generate a Rock Ridge disk 
that has two _different_ filenames that OS X cannot tell apart, but that 
both Linux and Windows can see peoperly)

		Linus
