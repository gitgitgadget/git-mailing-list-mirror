From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cross-Platform Version Control
Date: Tue, 12 May 2009 22:38:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905122237230.27348@pacific.mpi-cbg.de>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <20090512151403.GS30527@spearce.org> <alpine.DEB.1.00.0905121808480.4447@intel-tinevez-2-302> <D1E08DA2-8D8E-4D45-A50A-F32E3448D6E9@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Esko Luontola <esko.luontola@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 22:38:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3yjv-0008FM-SV
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 22:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbZELUiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 16:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752189AbZELUiG
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 16:38:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:60270 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751923AbZELUiE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 16:38:04 -0400
Received: (qmail invoked by alias); 12 May 2009 20:38:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp036) with SMTP; 12 May 2009 22:38:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+nhQBmkROnuUZGxhnKUlfvjSC+a02e1UF9gasOuX
	ZAWL1OJuaoHF4B
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <D1E08DA2-8D8E-4D45-A50A-F32E3448D6E9@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118952>

Hi,

On Tue, 12 May 2009, Esko Luontola wrote:

> On 12.5.2009, at 19:13, Johannes Schindelin wrote:
> >As to storing all file names in UTF-8, my point about Unicode being not 
> >necessarily appropriate for everyone still stands.
> >
> >UTF-8 _might_ be the de-facto standard for Linux filesystems, but IMHO 
> >we should not take away the freedom for everybody to decide what they 
> >want their file names to be encoded as.
> >
> >However, I see that there might be a need to be able to encode the file 
> >names differently, such as on Windows.  IMHO the best solution would be 
> >a config variable controlling the reencoding of file names.
> 
> Exactly. The system should not force the use of a specific encoding. It 
> should only offer a recommendation, but be also fully compatible if the 
> user uses some other encoding.
> 
> That's why it's best to always store the information about what encoding 
> was used. It shouldn't matter, whether the data is encoded with 
> ISO-8859-1, UTF-8, Shift_JIS, Big5 or some other encoding, as long as it 
> is explicitly said that what the encoding is. Then the reader of the 
> data can best decide, how to show that data on the current platform.
> 
> A config variable for defining, that what encoding should be used when 
> committing the file names, would make sense. Git should also try to 
> autodetect, that what encoding is used in its current environment. In 
> the case of UTF-8, you should also be able to specify which 
> normalization form is used 
> (http://www.unicode.org/unicode/reports/tr15/), or whether it is 
> normalized at all.
> 
> For example, it should be possible to configure Git so, that when a file 
> is checked out on Mac, its file name is converted to the current file 
> system's encoding (UTF-8 NFD, I think), and when the file is committed 
> on Mac, the file name is normalized back to the same UTF-8 form as is 
> used on Linux (UTF-8 NFC).
> 
> It would be nice to have config variables for saying, that all file 
> names in this repository must use UTF-8 NFC, and all commit messages 
> must use UTF-8 NFC (with Unix newlines). Then the Git client would 
> autodetect the current environment's encoding, and convert the text, if 
> necessary, to match the repository's encoding.

That is a nice analysis.  How about implementing it?

Ciao,
Dscho
