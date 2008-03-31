From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: Hand-rolling migration to Git
Date: Mon, 31 Mar 2008 07:23:27 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0803310720520.26808@ds9.cixit.se>
References: <Pine.LNX.4.64.0803251056570.8472@ds9.cixit.se>
 <200803251114.55673.johan@herland.net>
 <alpine.LSU.1.00.0803251137580.10660@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 31 08:24:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgDRO-00067J-Jr
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 08:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbYCaGXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 02:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752448AbYCaGXk
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 02:23:40 -0400
Received: from ds9.cixit.se ([193.15.169.228]:48925 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752285AbYCaGXk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 02:23:40 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m2V6NawE027252
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Mar 2008 08:23:36 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m2V6NRkD027242;
	Mon, 31 Mar 2008 08:23:27 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.LSU.1.00.0803251137580.10660@wbgn129.biozentrum.uni-wuerzburg.de>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Mon, 31 Mar 2008 08:23:36 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78561>

Johannes Schindelin:

>> Take a look at git-fast-import. It should be relatively easy to write a 
>> small script that converts from either (1) or (2) to a stream of 
>> git-fast-import commands.

> Yeah.  To get inspiration how the scripts should look like, read 
> contrib/fast-import/import-tars.perl, or look at 
> http://repo.or.cz/w/fast-export.git

I've played a bit with git-fast-import, but I sort of failed to get
something working for PVCS export (see other thread).

The import-tars.perl script, however, was a very good idea. The
simplest solutions for the multiple-directories source I had was just
to tar it up and feed through import-tars.perl. After importing it into
Git and repacking it with a suitably large --window argument, I had a
Git repository of 64 megabytes, down from the four or so gigabytes of
uncompressed directories. That did include removing some object files,
though (but keeping some .exe's).

-- 
\\// Peter - http://www.softwolves.pp.se/
