From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: non-ascii filenames issue
Date: Mon, 6 Apr 2009 08:28:21 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0904060823400.21376@ds9.cixit.se>
References: <20090405093640.GA9803@home> <87ab6v2zor.fsf@iki.fi>  <20090405100127.GA12126@home> <43d8ce650904050351p72590d52l8861b3901f95201a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 09:45:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqjVq-00076l-5Q
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 09:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547AbZDFHn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 03:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754414AbZDFHnZ
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 03:43:25 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:41606 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754354AbZDFHnY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 03:43:24 -0400
X-Greylist: delayed 893 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Apr 2009 03:43:24 EDT
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n367SLot022161
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 6 Apr 2009 09:28:21 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n367SLsv022157;
	Mon, 6 Apr 2009 09:28:21 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <43d8ce650904050351p72590d52l8861b3901f95201a@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Mon, 06 Apr 2009 09:28:21 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115774>

John Tapsell:

> Unfortunately not, because for some absolutely crazy reason, there is no 
> way at all to tell what encoding the string is in.  It never occured to 
> anyone that it might actually be useful to be able to read the filename in 
> an unambiguous way.

It comes from the Unix tradition, unfortunately, that file names are just a 
stream of bytes, instead of a stream of characters mapped to a byte 
sequence. The "stream of bytes" think worked back when everyone used ASCII, 
but as soon as other character encodings were used (i.e back in the 1970s or 
so), that assumption broke.

> The result is this sort of mess. Just wait until you try to checkout that 
> file on a new filesystem with a different encoding.  Or try to checkout 
> that file in Windows.  It's like git decided to step backwards 30 years.

Since most people on Linux nowadays probably are running in a UTF-8-based 
locale, I tried introducing some (very incomplete) patches for the Windows 
port to make this assumption, to allow Windows users to make use of 
non-ASCII file names (Windows uses Unicode strings for file names). Mac OS 
uses (semi-decomposed) UTF-8 strings, so it should also be able to make use 
of this.

Unfortunately, there seems to be quite some resistance towards deciding on 
a platform- and language-independent way of storing file names in Git, but 
rather just going the "Unix" way and making it someone elses problem. I find 
this a bit sad.


-- 
\\// Peter - http://www.softwolves.pp.se/
