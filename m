From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: =?iso-8859-1?Q?gitweb=2Ftest=2FM=E4rch?=
	=?iso-8859-1?Q?en?= has an identity crisis
Date: Mon, 9 Apr 2007 15:18:20 -0400
Message-ID: <20070409191820.GA5436@spearce.org>
References: <FBFBF002-4887-4216-9CF0-42407E93045C@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 01:58:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HazNm-0004KA-Af
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 21:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbXDITS1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 9 Apr 2007 15:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbXDITS1
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 15:18:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42805 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965104AbXDITS0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Apr 2007 15:18:26 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HazNW-0007Y6-Py; Mon, 09 Apr 2007 15:18:14 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8780A20FBAE; Mon,  9 Apr 2007 15:18:20 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <FBFBF002-4887-4216-9CF0-42407E93045C@adacore.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44087>

Geert Bosch <bosch@adacore.com> wrote:
> # On branch master
> # Changed but not updated:
> #   (use "git add/rm <file>..." to update what will be committed)
> #
> #       deleted:    gitweb/test/M=E4rchen
>=20
> Aaaarghh!! There seems something inconsistent in the encoding
> of the =E4 letter that confuses git on my Mac OS X system.
> My environment has LANG=3Den_US.UTF-8 set, in case that matters.

This has been discussed on the list in the past.  Mac OS X does a bad
thing here; it is normalizating the UTF-8 encoding in a different
way than Git supplied the encoding.  This is apparently done to
support its other bad feature, case insensitive filesystems.  ;-)

Basically what Git gave Mac OS X during an open() syscall is not
what it gets back during a readdir() because the filesystem changed
the byte sequence on us.  Yea, not cute.

I think I stuck the byte sequence Mac OS X is supplying into my
=2Egit/info/exclude and the problem went away...

--=20
Shawn.
