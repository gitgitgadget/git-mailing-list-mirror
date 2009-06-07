From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 3/3] Add a ref log reader class
Date: Mon, 8 Jun 2009 00:45:26 +0200
Message-ID: <200906080045.26927.robin.rosenberg.lists@dewire.com>
References: <1244405951-21808-1-git-send-email-robin.rosenberg@dewire.com> <1244405951-21808-4-git-send-email-robin.rosenberg@dewire.com> <20090607222154.GD16497@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 08 00:45:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDR7i-00053O-Fv
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 00:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755088AbZFGWpd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Jun 2009 18:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756477AbZFGWpd
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 18:45:33 -0400
Received: from mail.dewire.com ([83.140.172.130]:20470 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756475AbZFGWpb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jun 2009 18:45:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 08C9C146D03B;
	Mon,  8 Jun 2009 00:45:29 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TFpC8QLRFrrx; Mon,  8 Jun 2009 00:45:28 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 6DC2D146D027;
	Mon,  8 Jun 2009 00:45:28 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <20090607222154.GD16497@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121019>

m=E5ndag 08 juni 2009 00:21:54 skrev "Shawn O. Pearce" <spearce@spearce=
=2Eorg>:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
=2E..
> > +			int p1 =3D RawParseUtils.next(raw, p0 + 1, ':');
> > +			if (p1 =3D=3D -1)
> > +				throw new IllegalArgumentException(
> > +						"Raw log message does not parse as log entry");
>=20
> Technically, missing a ':' is legal.  Everything after the '\t'
> is the comment.  It may be splittable into an action/comment,
> it might not be.

Do you think I should just skip parsing out action? I don't really need=
 it. I can
go with everything after tab as one string for my purposes, i.e. readin=
g reflogs
in JUnit tests.

As for optimized reading, I'd rather spend my time on something else. R=
eading
reflogs won't likely be a real problem and I think the interface will b=
e stable
even if it needs to be optimized.

The other stuff I'll fix.

-- robin
