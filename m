From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 00:24:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702130020450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45CFA30C.6030202@verizon.net> <20070212042425.GB18010@thunk.org>
 <Pine.LNX.4.64.0702120839490.8424@woody.linux-foundation.org>
 <7vps8f6l81.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 00:25:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGkXd-0006ah-9W
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 00:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030486AbXBLXY6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 18:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030487AbXBLXY6
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 18:24:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:39329 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030486AbXBLXY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 18:24:57 -0500
Received: (qmail invoked by alias); 12 Feb 2007 23:24:56 -0000
X-Provags-ID: V01U2FsdGVkX1+Dixtwx92DN9JTVzRAdQNloQb2xtMUjALM4LOCD0
	zi6Q==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vps8f6l81.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39454>

Hi,

On Mon, 12 Feb 2007, Junio C Hamano wrote:

> I agree that we can assume editors can grok files with LF end-of-line 
> just fine and we would not need to do the reverse conversion on checkout 
> paths (e.g. "read-tree -u", "checkout-index").

In that case, a simple pre-commit hook would suffice.

No, the problem mentioned by Mark was a very real one: you _cannot_ rely 
on Windows' editors not to fsck up with line endings. The worst case is if 
the file contains _some_ CRLF and _some _LF_. Almost always I had the 
problem that it now converted _all_ LFs to CRLFs. Even those which already 
were converted.

So, if we are to support text mode, it is not one-way. If we do one-way, 
we really do _not_ support text mode, but pre-commit conversion to LF 
style text. And in this case, core git does not need _any_ change.

Ciao,
Dscho
