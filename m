From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 14:01:05 -0500
Message-ID: <20080117190105.GB5547@mit.edu>
References: <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 20:02:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFa0G-0002qq-0m
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 20:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756304AbYAQTBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 14:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752896AbYAQTBt
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 14:01:49 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:33598 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752610AbYAQTBs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 14:01:48 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m0HJ1GUN013029;
	Thu, 17 Jan 2008 14:01:16 -0500 (EST)
Received: from closure.thunk.org (c-76-19-244-124.hsd1.ma.comcast.net [76.19.244.124])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m0HJ1Bl6003256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 17 Jan 2008 14:01:16 -0500 (EST)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JFZzD-0001sV-6u; Thu, 17 Jan 2008 14:01:11 -0500
Content-Disposition: inline
In-Reply-To: <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70904>

On Thu, Jan 17, 2008 at 06:52:57PM +0000, Pedro Melo wrote:
> The answer is that users should not create filenames with non-ascii 
> characters if they want a consistent experience, right?
>
> This is just so that I can write a best practices document to them...

That's the easist thing to do if you want to assure that things will
mostly work across multiple different OS's, with different levels of
sanity.  You might also want to include that it's a bad idea to create
two filenames that are identical on case-insensitive filesystems,
i.e., "makefile" and "Makefile", or "foo.H" and "foo.h" which even
though it works Just Fine on Linux, will likely cause problems on
Windows and MacOS filesystems, and other systems that are insane with
respect to case insensitivity.

							- Ted
