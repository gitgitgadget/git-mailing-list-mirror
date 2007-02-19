From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-bundle: move objects and references by archive.
Date: Mon, 19 Feb 2007 16:03:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702191557580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1171838852534-git-send-email-mdl123@verizon.net>
 <Pine.LNX.4.63.0702190126220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <erc8nm$feg$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Mon Feb 19 16:04:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJA3V-0002ct-3P
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 16:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbXBSPDo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 10:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbXBSPDo
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 10:03:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:36706 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932332AbXBSPDn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 10:03:43 -0500
Received: (qmail invoked by alias); 19 Feb 2007 15:03:42 -0000
X-Provags-ID: V01U2FsdGVkX19VNpt2BZNV4qH44k0rBN4DbsLewX7CUZBdCLeQJ1
	QDIg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <erc8nm$feg$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40130>

Hi,

On Mon, 19 Feb 2007, Mark Levedahl wrote:

> "Johannes Schindelin" <Johannes.Schindelin@gmx.de> wrote in message
> news:Pine.LNX.4.63.0702190126220.22628@wbgn013.biozentrum.uni-wuerzburg.de...
> > Hi,
> > 
> > Sorry to be such a PITA, but I really, really think that it is wrong to
> > make a tar dependency here. You said your cygwin has problems with binary
> > files. Could you please try this:
> > 
> > $ echo -ne '\x1a\x1b\x15\x10\0abc' | cat | wc
> > 
> Same result on Cygwin and FC6:
> ~>echo -ne '\x1a\x1b\x15\x10\0abc' | cat | wc
>      0       1       8

Okay, so I really would like to have the bundle file from this experiment:

> To repeat an earlier message, I tried the following:
> 
> cat bundle | (
>      while read <header stuff> do
>        <prcess header stuff>
>      done
>      git-pack-index --stdin
> )

because I cannot see how the aforementioned "cat" can succeed, while 
pack-index --stdin cannot.

> A bundle file *is* an archive.

But the archive in the bundle really is the pack. You don't need any other 
archive there. You don't need to know the name of the prerequisites file, 
for example, if that information is in the header to begin with.

> </unsolicited ignoreable gripe>Has anyone considered how much easier all 
> of git would be if it were written in c + python, rather than c + every 
> variant of shell + core utils + non-core utils known to mankind since 
> the dawn of unix?</unsolicited ignorable gripe>

You realize that Python can be a PITA, a real PITA, when it comes to 
non-Linux systems?

Just look at the fun we had with subprocess. It is included in Python 2.4, 
_works_ with Python 2.3, but _not_ Python with 2.2. If you now say "well, 
just upgrade!" then I SHOUT at you. There is _no_ excuse forcing users to 
upgrade when the failure is on _your_ part.

Ciao,
Dscho
