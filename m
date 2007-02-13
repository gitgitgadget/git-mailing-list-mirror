From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 19:04:26 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702131901040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com>
 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 13 19:05:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH21r-00085I-Ku
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 19:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbXBMSE3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 13:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbXBMSE2
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 13:04:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:47533 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751401AbXBMSE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 13:04:27 -0500
Received: (qmail invoked by alias); 13 Feb 2007 18:04:26 -0000
X-Provags-ID: V01U2FsdGVkX1/HpuwSEVnHFs+FoawTCTeuORPzfGuG9LEiag47EL
	vmaw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39562>

Hi,

On Tue, 13 Feb 2007, Linus Torvalds wrote:

> On Tue, 13 Feb 2007, Johannes Schindelin wrote:
> > 
> > On Tue, 13 Feb 2007, Alexander Litvinov wrote:
> > 
> > > The only trouble is the rebase, it does not like \r\n ending and 
> > > othen produce unexpected merge conflict. But I don't use rebse to 
> > > othen to realy investigate and try to solve the problem.
> > 
> > Well, if everybody thinks like you, maybe we do not have to change 
> > anything for Windows after all?
> 
> No no no.
> 
> It's going to be _horrible_ if people start interesting projects in 
> Windows, and there are files in a git repository that are encoded with 
> CRLF.
> 
> I'd much rather just get this right, and that means "no hooks".

No hooks means something like cvsnt does, and that means no .gitattributes 
either. (BTW I really hate .gitattributes, as it does not at all say what 
this is about; it's about file _conversions_, not attributes).

CVSNT analyzes the files, and guesses if they are text, and only then 
activates the text mode.

I am strongly opposed to including something like that. (It was already 
proposed, and your "no hooks" suggests the same.)

However, I am slightly positive about the .gitfiletypes approach, _iff_ we 
think about more than just text/binary from the start. If we do it right, 
it will buy us more.

Ciao,
Dscho
