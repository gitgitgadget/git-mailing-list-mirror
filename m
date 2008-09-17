From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Getting correct tree layout when importing svn repo into git
Date: Wed, 17 Sep 2008 13:05:10 +0200
Message-ID: <20080917110510.GB13144@atjola.homenet>
References: <cfd18e0f0809161505g4c04bd88vaf4fd7c40f67b243@mail.gmail.com> <48D0BEF1.10008@drmicha.warpmail.net> <cfd18e0f0809170338v168c2991ma3964392e44e0194@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	michael.kerrisk@gmail.com
To: mtk.manpages@gmail.com
X-From: git-owner@vger.kernel.org Wed Sep 17 13:07:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfusB-0002sH-7L
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 13:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbYIQLFP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Sep 2008 07:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362AbYIQLFP
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 07:05:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:43130 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752172AbYIQLFN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 07:05:13 -0400
Received: (qmail invoked by alias); 17 Sep 2008 11:05:11 -0000
Received: from i577B97D3.versanet.de (EHLO atjola.local) [87.123.151.211]
  by mail.gmx.net (mp005) with SMTP; 17 Sep 2008 13:05:11 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+8dChTski8kDcuIW6rdQTwYFWR+D7kaiWb8wa8/Q
	CdNEFshUcH9UGG
Content-Disposition: inline
In-Reply-To: <cfd18e0f0809170338v168c2991ma3964392e44e0194@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96089>

On 2008.09.17 03:38:12 -0700, Michael Kerrisk wrote:
> $ svn list file:///home/mtk/man-pages-rep/tags
> man-pages-2.00
> man-pages-2.01
> man-pages-2.02
> man-pages-2.03
> ...
> $ svn list file:///home/mtk/man-pages-rep/tags/man-pages-2.00
> man-pages
> $ svn list file:///home/mtk/man-pages-rep/tags/man-pages-2.01
> man-pages
> [and so on]
> $ svn list file:///home/mtk/man-pages-rep/branches
> $
> (i.e., no branches, since this has been a linear svn repo.)

That means that you also need to pass the "man-pages" suffix for the
tags and branches.

git svn clone file:///path/to/repo \
	-T trunk/man-pages \
	-b branches/*/man-pages \
	-t tags/*/man-pages

Might require a more recent git-svn version, not sure about that.

Bj=F6rn
