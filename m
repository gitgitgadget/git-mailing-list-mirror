From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: [PATCH] Explain how svn-fe parses filenames in SVN dumps
Date: Sat, 14 Apr 2012 18:37:09 +0100
Message-ID: <4F89B5C5.3030606@pileofstuff.org>
References: <4F89ADCD.6000109@pileofstuff.org> <20120414171431.GA4161@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 19:37:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ6v5-0006Ok-1V
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 19:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000Ab2DNRhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 13:37:14 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:64324 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751144Ab2DNRhN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Apr 2012 13:37:13 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120414173711.XQZA23305.mtaout02-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Sat, 14 Apr 2012 18:37:11 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120414173711.WKOL13318.aamtaout03-winn.ispmail.ntl.com@[192.168.0.2]>;
          Sat, 14 Apr 2012 18:37:11 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <20120414171431.GA4161@burratino>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=yXtjXN6ItgYA:10 a=hBuI5vrYS2AA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=COaubJS4YYzMFEfA6J0A:9 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195497>

On 14/04/12 18:14, Jonathan Nieder wrote:
> this description and the location of this description seem quite
> misleading.  Isn't what the reader needs to know something like the
> following?
> 
> 	BUGS
> 	----
> 	Due to limitations in the Subversion dumpfile format, svn-fe
> 	does not support filenames with newlines.  Since version 1.2.0,
> 	"svn add" forbids adding such filenames but some historical
> 	repositories contain them.  An import can appear to succeed and
> 	produce incorrect results when such pathological filenames are
> 	present.
> 
> Thanks,
> Jonathan
> 

I went back and forth a bit while writing the text.  Newlines are only
one special case, albeit an important one that I hadn't expressed
clearly enough.  For example, the handling of NUL characters is worse
than newlines (a quick test suggests svn-fe terminates parsing
altogether if it sees one), but SVN has never allowed the creation of
files with NULs so arguably it's even less important.

I'm warming again to the idea of explicitly mentioning that newlines
cause breakage, but it feels like the wider story is worth telling too.
 If this were a man page I'd consider adding a section or something, but
I'm not sure what level of verbosity you're looking for in this file.

	- Andrew
