From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH] Permit a wider range of repository names in jgit daemon requests
Date: Mon, 9 Feb 2009 08:47:40 +0100
Message-ID: <200902090847.40905.robin.rosenberg@dewire.com>
References: <1234151883-30479-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 09 09:59:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWRyq-0001Ii-CW
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 09:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbZBII5g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Feb 2009 03:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbZBII5e
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 03:57:34 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:57280 "EHLO
	pne-smtpout1-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751377AbZBII5e convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 Feb 2009 03:57:34 -0500
X-Greylist: delayed 4181 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Feb 2009 03:57:34 EST
Received: from sleipner.localnet (90.234.23.249) by pne-smtpout1-sn1.fre.skanova.net (7.3.129)
        id 47A9795005FB67AB; Mon, 9 Feb 2009 08:47:50 +0100
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <1234151883-30479-1-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109050>

m=E5ndag 09 februari 2009 04:58:03 skrev du:
> The earlier restriction was too narrow for some applications, for
> example repositories named "jgit.dev" and "jgit.test" are perfectly
> valid Git repositories and should still be able to be served by
> the daemon.
>=20
> By blocking out only uses of ".." as a path component and Windows
> UNC paths (by blocking "\") we can reasonably prevent the client
> from escaping the base dirctories configured in the daemon.

Didn't I tell you // is also UNC-prefix? Windows treats / =3D=3D \ at t=
he API
level. Also why test for contains one "\"? And why in the middle? The
UNC prefix can only occur at the beginning of a path. You can use
=46ile.isAbsolute to see if a name represents an absolute path. It is
platform-depdendent, so new File("//foo/bar").isAbsolute() yield
different results on Windows and unix platforms.

-- robin
