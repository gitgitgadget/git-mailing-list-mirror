From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH replacement for take 3 4/4] color-words: take an optional
 regular expression describing words
Date: Thu, 15 Jan 2009 02:12:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901150211120.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901142142120.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901142145200.3586@pacific.mpi-cbg.de> <200901150132.14106.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Junio C Hamano <junio@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 15 02:13:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNGnb-0007Kj-Nl
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 02:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbZAOBMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 20:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754046AbZAOBMK
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 20:12:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:53649 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753932AbZAOBMI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 20:12:08 -0500
Received: (qmail invoked by alias); 15 Jan 2009 01:12:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp005) with SMTP; 15 Jan 2009 02:12:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/TPLdg/QjTzJWzF5u/NQH+sxtwfTE1QO2YWtAkrB
	zg/PdfYcs0Gv/a
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901150132.14106.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105751>

Hi,

On Thu, 15 Jan 2009, Thomas Rast wrote:

> Johannes Schindelin wrote:
> > 	This basically contains the fix I sent earlier.
> 
> Unfortunately I found another case where it breaks.  It even comes
> with a fairly neat test case:
> 
>   $ g diff --no-index test_a test_b
>   diff --git 1/test_a 2/test_b
>   index 289cb9d..2d06f37 100644
>   --- 1/test_a
>   +++ 2/test_b
>   @@ -1 +1 @@
>   -(:
>   +(

The diff of the words would look like this:

diff --git a/a1 b/a2
index 8309acb..2d06f37 100644
--- a/a1
+++ b/a2
@@ -2 +1,0 @@
-:


Notice the "+1,0"?  I fully expected this to be "+2,0", but apparently I 
was mistaken...

Can anybody explain to me why this is so?

Ciao,
Dscho
