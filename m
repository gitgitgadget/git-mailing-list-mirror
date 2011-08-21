From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: git svn --stdlayout 's little quirk.
Date: Sun, 21 Aug 2011 10:38:02 +0100 (BST)
Message-ID: <1313919482.36626.YahooMailClassic@web29501.mail.ird.yahoo.com>
References: <20110820183504.GA32179@dcvr.yhbt.net>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: madduck@madduck.net, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Aug 21 11:38:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qv4U1-0001ON-Or
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 11:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726Ab1HUJiH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Aug 2011 05:38:07 -0400
Received: from nm10-vm0.bullet.mail.ird.yahoo.com ([77.238.189.90]:39753 "HELO
	nm10-vm0.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751282Ab1HUJiE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2011 05:38:04 -0400
Received: from [77.238.189.231] by nm10.bullet.mail.ird.yahoo.com with NNFMP; 21 Aug 2011 09:38:02 -0000
Received: from [212.82.108.247] by tm12.bullet.mail.ird.yahoo.com with NNFMP; 21 Aug 2011 09:38:02 -0000
Received: from [127.0.0.1] by omp1012.mail.ird.yahoo.com with NNFMP; 21 Aug 2011 09:38:02 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 469601.91655.bm@omp1012.mail.ird.yahoo.com
Received: (qmail 50575 invoked by uid 60001); 21 Aug 2011 09:38:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1313919482; bh=YHwxFm1U6Lr5B7kVq8QMaigkwv5z2xVt+qgcHZHp9Fg=; h=X-YMail-OSG:Received:X-RocketYMMF:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=A6duWKe2lu2kU8oXrxsW3mJuQETfMGX81Jp6Oh4roZs6c8b4fjv78J3Dw6JpyNfAp5m2GGtrDWl8YCC0YckYY8p6E/nyt/vpje0K6XJCIYfQEEFwnoPxrACQsf6FzNMicWNE1aiXhZJLipjL1IdSXj64MWpr00tEoySjenwp/Dg=
X-YMail-OSG: .BdkQUUVM1l6AU8Jx2adffDRq.W75gGR_TXPCFQfaoc59D0
 1xUU0jzCVXCmuWyo_80IeoYSnPEtD5qIwxx9lZckCyKjPdB05cy7LeibudY9
 444PGGwS32AxLrQ9x.A_0TLN7sevpYPN1nCrAZGWbCZMpmrqnba.kNnLwkbI
 _ZPPCdwZfRvBocoU.g7J1HtgBpq282719uxjBCG82w4BnkgrZ0xzw.QQQG7p
 JoMhqaGg1aZMxJ.piKPPQK.s3e2jA8Mp4w7eIP3puk6apNhDBQz9LCNu.05c
 o.imtus4UN3XJv5ooT_OEC4w0uFM2PivEwTHBKbQQlS5pUPhWM5hfp_wheqj
 7LMmVGQM8JbkVkeEd3Q4wK6gVR8p.kwRzAYboxUTa6Vlhhd3XddZcgw3x0lR
 UYntdTwWrfe6Hk8L52uJ32MubO06iyNKcix9a_puYtbKiN2VO8W28g3kHDWf
 5G22SPSHNqt.hauRP4p3xk4DBa.1ku6nf.bBV5PIX1KwpUgXYlWfNZBpR
Received: from [81.101.129.153] by web29501.mail.ird.yahoo.com via HTTP; Sun, 21 Aug 2011 10:38:02 BST
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/14.0.4 YahooMailWebService/0.8.113.315625
In-Reply-To: <20110820183504.GA32179@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179799>

--- On Sat, 20/8/11, Eric Wong <normalperson@yhbt.net> wrote:

> > I think I found a small bug in git 1.7.6. Having
> "trunk" at the end of
> > the url in combination of --stdlayout is wrong, but it
> looks like that
> > git-svn tries to cope, but doesn't go try far enough:
> >=20
> > Doing this:
> > ----------------
> > git svn clone --stdlayout http://quick-settings.googlecode.com/svn/=
trunk/
> android-quick-settings
>=20
> --stdlayout expects the "root" path of the code you're
> interested
> in (not necessarily the SVN repository root, but in this
> case they
> could be the same).
>=20
> Try the following instead:
>=20
> git svn clone --stdlayout \
> =A0 http://quick-settings.googlecode.com/svn
> android-quick-settings

I know this is the correct way - what I meant was that, having "trunk" =
at the end is wrong but git-svn appears to try to correct it automatica=
lly, but haven't quite succceeded.

Hin-Tak=20
