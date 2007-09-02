From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and make stat use that implementation too.
Date: Sun, 2 Sep 2007 23:38:56 +0200
Message-ID: <20070902213856.GB2756@steel.home>
References: <46DACD93.9000509@trolltech.com> <46DB0478.8050402@trolltech.com> <46DB0F9C.2090306@trolltech.com> <200709022228.00733.robin.rosenberg.lists@dewire.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 23:39:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRxAC-0003oQ-Ri
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 23:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbXIBVjA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 2 Sep 2007 17:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752467AbXIBVi7
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 17:38:59 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:60627 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbXIBVi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 17:38:59 -0400
Received: from tigra.home (Fc92a.f.strato-dslnet.de [195.4.201.42])
	by post.webmailer.de (klopstock mo20) (RZmta 12.3)
	with ESMTP id z0150dj82Js5su ; Sun, 2 Sep 2007 23:38:57 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 09C93277BD;
	Sun,  2 Sep 2007 23:38:57 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id D70DCBEAC; Sun,  2 Sep 2007 23:38:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200709022228.00733.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAFvMw==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57390>

Robin Rosenberg, Sun, Sep 02, 2007 22:27:59 +0200:
> s=F6ndag 02 september 2007 skrev Marius Storm-Olsen:
> > (Also, since Windows doesn't really handle symlinks, it's fine that=
 stat just uses lstat)
>=20
> It does now: See http://msdn2.microsoft.com/en-us/library/aa363866.as=
px
>=20

Except they fscked it up, as usual for microsoft: it 's got a
mandatory argument specifying what the target should be, file or
directory. And they don't tell what happens when the argument is wrong
or the target does not exists. Typical, too.
