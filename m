From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Fri, 18 Jan 2008 02:05:28 +0100
Message-ID: <200801180205.28742.robin.rosenberg.lists@dewire.com>
References: <478E1FED.5010801@web.de> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Pedro Melo <melo@simplicidade.org>, Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 02:06:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFfgD-0003NP-C6
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 02:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759032AbYARBF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 20:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758792AbYARBF1
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 20:05:27 -0500
Received: from [83.140.172.130] ([83.140.172.130]:6820 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1758626AbYARBFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 20:05:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 90D688030D9;
	Fri, 18 Jan 2008 02:05:24 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GUgM8XMmwrlv; Fri, 18 Jan 2008 02:05:24 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id E88C880264C;
	Fri, 18 Jan 2008 02:05:23 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70944>

torsdagen den 17 januari 2008 skrev Linus Torvalds:
> And yes, I also realize that it's not going to be realistic. We're 
> probably *closer* to that than we used to be, but I don't think you can 
> even make Windows think FAT is UTF-8.
It's UTF-16 (when needed). I think it's all in the Linux kernel for you
to see.

> I don't know how NTFS works (I know it is Unicode-aware, and I think it 
> encodes filenames in UCS-2 or possibly UTF-16, but there is an obvious 1:1 
UTF-16 (was UCS-2 until MS did a s/UCS-2/UTF-16/ on the documentation).

> translation to UTF-8, and since we use C strings, I'd assume/hope Windows 
> actually uses that unambiguous translation for any filenames).

It uses the local 8-bit codepage, which is not UTF-8, often some latin-inspired
thingy, but in Asia multi-byte encodings are used. In western Europe it is
Windows-1252, which is almost, but not exactly iso-8859-1. Oh, and then we
have the cmd prompt which has another encoding in 8-bit mode.

I think there is a cygwin patch that converts to and from UTF-8. An application
can choose to use the "A" or "W" interfaces. The W-API's are the real ones and 
the others' are just wrappers that convert to and from UTF-16 before anything
happens (i.e. CreateFileA is slower than CreateFileW and so on). 

-- robin
