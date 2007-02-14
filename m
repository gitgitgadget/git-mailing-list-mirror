From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 15:24:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702141516120.20368@woody.linux-foundation.org>
References: <17875.13564.622087.63653@lisa.zopyra.com>
 <7vhctor78j.fsf@assigned-by-dhcp.cox.net> <17875.17647.74882.218627@lisa.zopyra.com>
 <7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net> <17875.30187.289679.417079@lisa.zopyra.com>
 <17875.30687.661794.512124@lisa.zopyra.com>
 <Pine.LNX.4.64.0702141314440.20368@woody.linux-foundation.org>
 <17875.33204.413186.355557@lisa.zopyra.com> <Pine.LNX.4.64.0702141722410.1757@xanadu.home>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-1291334993-1171495472=:20368"
Cc: Bill Lear <rael@zopyra.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Feb 15 00:25:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHTUu-0004ra-2z
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 00:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbXBNXZI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 18:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbXBNXZH
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 18:25:07 -0500
Received: from smtp.osdl.org ([65.172.181.24]:50639 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbXBNXZG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 18:25:06 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1ENOXhB020134
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Feb 2007 15:24:33 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1ENOWrH012614;
	Wed, 14 Feb 2007 15:24:32 -0800
In-Reply-To: <Pine.LNX.4.64.0702141722410.1757@xanadu.home>
X-Spam-Status: No, hits=-0.406 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39773>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-1291334993-1171495472=:20368
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Wed, 14 Feb 2007, Nicolas Pitre wrote:
> 
> But...... your pack file is read-only, isn't it?

Almost any "edit in place" operation under UNIX is invariably a question 
of "read old file + write new file + mv new old". 

As such, to be read-only for a lot of programs, you actually need to not 
just make the *file* read-only, you need to make the *directory* read-only 
too. 

Or you need to use only tools that explicitly check (a lot of editors will 
do that, for example, because in an RCS world you're supposed to do magic 
things to actually edit a file).

So I'm not at all surprised that "-pi" (where the "i" stands for 
"in-place") will overwrite read-only files.

I'm sure there is some random character that makes perl check, and not do 
it. Probably a sequence of unusual characters that makes it look like a 
swear-word. 

Maybe "perl -pi -%££@$" will do it. And if not, just add random characters 
until it works. "It's the perl way".

	Linus "Yeah, I never really got the 'perl way'" Torvalds
---1463790079-1291334993-1171495472=:20368--
