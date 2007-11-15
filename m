From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 11/11] Allow ETC_GITCONFIG to be a relative path.
Date: Thu, 15 Nov 2007 22:43:10 +0100
Message-ID: <200711152243.10229.johannes.sixt@telecom.at>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at> <200711151931.29029.johannes.sixt@telecom.at> <E652EC54-9F94-444F-AF94-2FA990355A78@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 22:43:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsmUm-0000Ck-Rn
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 22:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933411AbXKOVnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 16:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933002AbXKOVnO
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 16:43:14 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:40686 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766005AbXKOVnM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 16:43:12 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 0410410BE2D;
	Thu, 15 Nov 2007 22:43:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 9B4D4591B4;
	Thu, 15 Nov 2007 22:43:10 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <E652EC54-9F94-444F-AF94-2FA990355A78@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65162>

On Thursday 15 November 2007 21:10, Steffen Prohaska wrote:
> On Nov 15, 2007, at 7:31 PM, Johannes Sixt wrote:
> > On Thursday 15 November 2007 07:53, Steffen Prohaska wrote:
> >> Now I'm wondering if we could make path relocation a bit more
> >> explicit.  How about doing something like.
> >>
> >> 	system_wide = relocate_path(ETC_GITCONFIG);
> >>
> >> and relocate_path(const char *) would expand a format
> >> string in path.  At this point I see only a single %s
> >> that would be expanded with the install prefix.  If
> >> ETC_GITCONFIG is "%s/etc/gitconfig" relocate path will return
> >> "C:/msysgit/bin/etc/gitconfig" for my above example.  It is
> >> basically a printf with the install prefix path.
> >
> > I don't see the problem that you are trying to solve.
>
> Path relocation would be more explicit:
> 1) Paths that need to be relocated are filtered through
>     relocate_path().  That's easy to understand.
> 2) All the code prefixing the path is in relocate_path().
>     This avoids code duplication.
> 3) Path that should be relocated contain "%s" in the Makefile.
>     This indicates that some string expansion may take place.
>
> (1) and (2) would be useful even if you do not agree with (3).
> The code in PATCH 9/11 and PATCH 11/11 looks very similar.
> If the prefixing code went into a separate function, we'd
> have less code.  Also, relocate_path() could be useful at
> other places.  For example, I'd use it to locate the HTML
> documentation relative to the installation directory.

How is %s/foo different from ../foo? There are only 2 paths that need to be 
relocatable. Your proposal is over-engineering, IMHO.

-- Hannes
