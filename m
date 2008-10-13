From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 4/4] Intelligent parsing of ambiguously encoded meta data.
Date: Mon, 13 Oct 2008 19:10:50 +0200
Message-ID: <200810131910.53891.robin.rosenberg.lists@dewire.com>
References: <1223851860-13068-1-git-send-email-robin.rosenberg@dewire.com> <1223851860-13068-5-git-send-email-robin.rosenberg@dewire.com> <20081013022708.GJ4856@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 13 19:13:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpQz2-0006Kq-JE
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 19:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755318AbYJMRMR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Oct 2008 13:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755304AbYJMRMR
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 13:12:17 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:33333 "EHLO
	pne-smtpout2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755208AbYJMRMQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 13:12:16 -0400
Received: from shx250sn1.teliamobile.net (192.71.148.164) by pne-smtpout2-sn2.hy.skanova.net (7.3.129)
        id 4873CA950177222B; Mon, 13 Oct 2008 19:12:14 +0200
Received: from [10.146.176.195] ([10.146.176.195])
	by shx250sn1.teliamobile.net (8.13.1/8.13.1) with ESMTP id m9DHCAe1018916;
	Mon, 13 Oct 2008 19:12:12 +0200
User-Agent: KMail/1.9.10
In-Reply-To: <20081013022708.GJ4856@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98126>

m=C3=A5ndagen den 13 oktober 2008 04.27.08 skrev Shawn O. Pearce:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > We cannot trust meta data to be encoded in any particular way, so w=
e try
> > different encodings. First we try UTF-8, which is the only sane enc=
oding
> > for non-local data, even when used in regions where eight bit legac=
y
> > encodings are common. The chance of mistakenly parsing non-UTF-8 da=
ta
> > as valid UTF-8 is varies from extremely low (western encodings) to =
low
> > for most other encodings. If the data does not look like UTF-8, we =
try the
> > suggested encoding. If that fails we try the user locale and finall=
y, if
> > that fails we try ISO-8859-1, which cannot fail.
>=20
> Hmm.  I'm concerned about the infinite loop you have here.
> If ISO-8859-1 fails we'd be stuck here until the end of time.
> Plus its a bit ugly to read.
>=20
> I wonder if this is any better.  It passes your tests and is 2
> lines shorter.

Yes. Not sure what I was thinking with the loop there... :)

-- robin
