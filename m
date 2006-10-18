From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use diff3 instead of merge in merge-recursive.
Date: Wed, 18 Oct 2006 12:04:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610181202260.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061018085949.GA26501@cepheus.pub> <eh4sfr$3ej$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-2091614922-1161165862=:14200"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 12:04:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga8Hk-0007pn-NF
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 12:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWJRKE0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 06:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWJRKE0
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 06:04:26 -0400
Received: from mail.gmx.de ([213.165.64.20]:1708 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751042AbWJRKEZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 06:04:25 -0400
Received: (qmail invoked by alias); 18 Oct 2006 10:04:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 18 Oct 2006 12:04:23 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eh4sfr$3ej$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29217>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-2091614922-1161165862=:14200
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 18 Oct 2006, Jakub Narebski wrote:

> Uwe Zeisberger wrote:
> 
> > If no error occurs, merge (from rcs 5.7) is nothing but:
> > 
> >         diff3 -E -am -L label1 -L label2 -L label3 file1 file2 file3 > tmpfile
> >         cat tmpfile > file1
> > 
> > Using diff3 directly saves one fork per conflicting file.
> 
> Doesn't xdiff library git uses have diff3/merge equivalent?
> Couldn't we use that instead (on less dependency, better performance)?

We have only half of libxdiff, lacking the patch functionality. And AFAIUI 
the minimal implementation of diff3 in xdiff just uses a diff of the first 
pair on the third file (or some other order). So, it is not really a 
diff3/merge: it would fail in fairly trivial cases.

Ciao,
Dscho

P.S.: Davide, correct me if I'm wrong.
---1148973799-2091614922-1161165862=:14200--
