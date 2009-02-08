From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] Minor : Make ObjectId, RemoteConfig Serializable
Date: Sun, 8 Feb 2009 11:47:45 -0800
Message-ID: <20090208194745.GA30949@spearce.org>
References: <320075ff0902060702n7573aaecu9054626ee9a6991@mail.gmail.com> <320075ff0902080526g2bee8188g395397b06a0c80ee@mail.gmail.com> <20090208191024.GA30557@spearce.org> <200902082045.22703.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nigel Magnay <nigel.magnay@gmail.com>, Git ML <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 20:49:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWFeT-0002Y0-Hb
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 20:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbZBHTrr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2009 14:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753245AbZBHTrq
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 14:47:46 -0500
Received: from george.spearce.org ([209.20.77.23]:40463 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122AbZBHTrp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 14:47:45 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 507BA38210; Sun,  8 Feb 2009 19:47:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200902082045.22703.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109005>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> s=F6ndag 08 februari 2009 20:10:24 skrev Shawn O. Pearce:
> > In the case of any of the types you are discussing there is an easy
> > canonical form for them to be written on the wire, or to read back:
> >=20
> >   ObjectId     - the 20 byte SHA-1
> >   RefSpec      - the string form as it appears in the config file
> >   URIish       - the string form as it appears in the config file
>
> with our without the password?

With.

We're serializing the object, we should store as much of the data
as we have.  Clients throwing this over the wire should either be
careful with their connection (e.g. use SSL) or be careful with
the data they are throwing (e.g. don't use URIish that has password).
=20
--=20
Shawn.
