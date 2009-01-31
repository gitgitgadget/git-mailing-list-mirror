From: Geoffrey Thomas <geofft@MIT.EDU>
Subject: Re: [PATCH] utf8: add utf8_strwidth()
Date: Sat, 31 Jan 2009 03:51:48 -0500 (EST)
Message-ID: <alpine.DEB.2.00.0901310348000.3373@vinegar-pot.mit.edu>
References: <1233308489-2656-1-git-send-email-geofft@mit.edu> <20090131071711.GA3710@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 31 09:54:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTBbM-0007rs-FO
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 09:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbZAaIvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 03:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbZAaIvy
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 03:51:54 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:52548 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750856AbZAaIvx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Jan 2009 03:51:53 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n0V8pnRV006004;
	Sat, 31 Jan 2009 03:51:49 -0500 (EST)
Received: from localhost (VINEGAR-POT.MIT.EDU [18.181.0.51])
	(authenticated bits=0)
        (User authenticated as geofft@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n0V8pnV2006026;
	Sat, 31 Jan 2009 03:51:49 -0500 (EST)
In-Reply-To: <20090131071711.GA3710@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107914>

On Sat, 31 Jan 2009, Jeff King wrote:
> I know next to nothing about our encoding functions, but this seems
> suspiciously similar to utf8_width in utf8.c. There is also a
> git_wcwidth, but I don't know how they relate.

git_wcwidth determines the screen columns of a single ucs_char_t. 
utf8_width returns the git_wcwidth of the first character in a string. 
utf8_strwidth (the function added by this patch) is a simple loop around 
utf8_width, because writing the loop every time would be silly.

On that note, there are probably more cases in the code that ought to use 
something like utf8_strwidth. I only noticed this one case because I'm 
working on a project with someone with an accented letter in his last 
name.

-- 
Geoffrey Thomas
geofft@mit.edu
