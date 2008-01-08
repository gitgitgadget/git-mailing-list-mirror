From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 8 Jan 2008 11:56:00 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0801081150010.25629@ds9.cixit.se>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se>
 <200801071947.28586.robin.rosenberg.lists@dewire.com>
 <alpine.LSU.1.00.0801071915470.10101@racer.site>
 <200801072203.23938.robin.rosenberg.lists@dewire.com> <20080107224204.55539c31@jaiman>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 11:56:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCC8O-0002GP-1Y
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 11:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbYAHK4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 05:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbYAHK4I
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 05:56:08 -0500
Received: from ds9.cixit.se ([193.15.169.228]:52467 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674AbYAHK4G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 05:56:06 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m08Au4ZZ019073
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 8 Jan 2008 11:56:04 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m08Au0W0019061;
	Tue, 8 Jan 2008 11:56:04 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20080107224204.55539c31@jaiman>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Tue, 08 Jan 2008 11:56:04 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69861>

Thomas Neumann:

> as a user, I expect a SCM to only modify a file when I have
> explicitly asked it to do so.

As a user, I exepect things to just work. With RCS/CVS/Subversion, it
does, because it differentiates between text files (internally encoding
NLs with "LF", but I couldn't care less what it uses there) and binary
files (which it doesn't change). With git it currently doesn't since it
treats everything as binary files.

Yes, it's the whole text vs. binary file issue. We do live in a world
where different systems store text differently. We have to deal with
it. Preferrably, the computer should deal with it without me having to
do anything about it. After all, that's what computers are good at.

If I occasionally need to do a

 git add -kb binary.txt

to flag a file explicitely, that's a small price to pay for everything
else to work out of the box.


FWIW, I wouldn't care if git internally stored all texts as SCSU/BOCU
(or UTF-32, for that matter, if Git's compression engine is better than
SCSU or BOCU) using PARAGRAPH SEPARATOR to separate lines, just as
long as I could get back the text I checked in. Come to think about it,
locale autoconversion of text files would be a nice way to work between
systems that want different encodings, like how Windows prefers
UTF-16LE, Mac OS X prefers UTF-8 and Linux systems prefers whatever I
have set my locale to (I still use iso-8859-1, so shoot me).

-- 
\\// Peter - http://www.softwolves.pp.se/
