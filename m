From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH v2 07/24] Added findWorkTree method to Repository class.
Date: Fri, 23 May 2008 23:28:33 +0200
Message-ID: <200805232328.33666.robin.rosenberg.lists@dewire.com>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de> <20080513002409.GC29038@spearce.org> <4837090F.4000307@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Florian =?iso-8859-1?q?K=F6berle?= <FloriansKarten@web.de>
X-From: git-owner@vger.kernel.org Fri May 23 23:32:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzerA-0000tG-UI
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 23:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756420AbYEWVa1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 May 2008 17:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755603AbYEWVa1
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 17:30:27 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13238 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753264AbYEWVa0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 May 2008 17:30:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 606231434D93;
	Fri, 23 May 2008 23:30:24 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SPeg26GNd2hL; Fri, 23 May 2008 23:30:23 +0200 (CEST)
Received: from [10.9.0.13] (unknown [10.9.0.13])
	by dewire.com (Postfix) with ESMTP id CBF271434D8F;
	Fri, 23 May 2008 23:30:23 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <4837090F.4000307@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82760>

fredagen den 23 maj 2008 20.12.31 skrev Florian K=F6berle:
> >> +	 *=20
> >> +	 * @param directory
> >> +	 *            the path which should be checked.
> >> +	 * @return true if the path is a valid git repository.
> >> +	 */
> >> +	private static boolean isRepository(File directory) {
> >> +		if (!directory.isDirectory()) {
> >> +			return false;
> >> +		}
> >=20
> > We usually omit { and } on simple conditions like this.  Its a codi=
ng
> > pattern we stole from C Git, which stole it from the Linux kernel.
>=20
> I used this style once too, but was convinced that it dangerous to do=
 so.
As Shawn said, usually. Sometimes we slip too.  But it is unnecessary a=
nd
anything unnecessary usually makes code harder to read. It is not a big
deal to me.=20

> The following looks correct at the first look, but it's not:
>=20
> 	if (a)
> 		if (b)
> 			something;
> 	else
> 		something;
>=20
> this can't happen if you use { and }:
> 	if (a) {
> 		if (b) {
> 			something0();
> 		}
> 	} else {
> 		something1();
> 	}

This isn't the same case, because here we have nested statements, I do =
think braces should be used here. Java shouldn't even allow "ambigous" =
syntax like this (first case).

> Also it is better extenable:
>=20
> if (a) {
> 	something0();
> }
>=20
> if (a) {
> 	something0():
> +	something1();
> }

Which is why I think is not that big a deal.  The main reason I may lea=
ve braces on a non-nested simple statement is becuase I had a debug sta=
tement or something like that there, and I might well want to have one =
again temporarily. Toggling braces on and off (even with eclipse where =
it requires two-four keypresses) are annoying.

-- robin
