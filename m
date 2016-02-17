From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] remote: use remote_is_configured() for add and
 rename
Date: Wed, 17 Feb 2016 17:20:47 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602171720130.3152@virtualbox>
References: <1455558150-30267-1-git-send-email-t.gummerer@gmail.com> <1455558150-30267-5-git-send-email-t.gummerer@gmail.com> <20160215183334.GH26443@sigill.intra.peff.net> <alpine.DEB.2.20.1602171451030.6516@virtualbox> <20160217142455.GC1831@hank>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 17:21:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW4qp-0000Bb-2h
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 17:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161828AbcBQQVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 11:21:09 -0500
Received: from mout.gmx.net ([212.227.17.21]:54006 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161193AbcBQQVI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 11:21:08 -0500
Received: from virtualbox ([37.24.143.97]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M0tr1-1Zh7ks1Wox-00v81v; Wed, 17 Feb 2016 17:20:49
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160217142455.GC1831@hank>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:+D3U44KBl4eLycPQT4lpLJV1IBkRGR5fEFOQHFa5aP2WJWCENXY
 7n7ujElmFmo2QQjouaV3zAjBpqOgBynQVISRMWcmfa3pIlGC9n/dBld6IR+fhd0smYfP0DY
 fXjt0Tzd6wCvygy1DSRomDFrdJZ2DM3lrMr4cgjBoJBIcdiPslXAdSGojZXV77ILH/N0470
 d9EH08sFRsmJ3Z1AtNAqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5HCUNS4sI5Q=:4qGYzBeNWObirmbwAPQf5V
 gYmi+YCI4tRtOIc0ZOuF/BfrrOsTTDiZvlcu25epdsi3by3Lw2SYAxhCJ743SUI1I8zyCQumQ
 hQDTzQ2j8W1lHS5EwHhWn7WPLnWLCK9Q8u/beEQJZiKMDJ+gI9mK2Uz80dpLK4+TeXO4ovcWz
 rWYjDYCpbiSQO2y5/aEKxSSiBPCwVh3dpqSOOG+fjaP0V8SEtJBtOXMX07e5fBDDp3BZ/3JJK
 Id8EawdvPNxfOoxSdgeOgQo2vl3lh8SiaOLKEEC42tRnqnh1zbwnrlW6yrpJligRoDH7OFCg8
 6z4EhcDyHDWkZ+RHTrOeHmHDshOdkue8r3O4FQFNujsmWyNjcO5FptC2dv9bMI8PkhSaF7WkV
 69lN0Y3caq9f5CjI8hRm7GODHm4kmsdhA6uXQ3Fi711Iy2ZDNrDGvvazO1b6g/i6DiFpPCo9P
 vzW6hQoEv7Ei5A5d07Md6Nux7T2vSRSnujior6QHERpJmBQBVFq3ZfjT4Z3Xmz1X8aKyLQEGt
 IKC8OQMcMlFIpA9wsjLDBn3jXxQMD2/E3MnBZx0x48KSDNFDFZDwdWHyf6dbIy8Ed1OVTZN62
 ichGZclcKWQyLIUO6e6wKr0baOKp1lg+v6tTU8s+HFmnfs0KgKswRFJy+DmzQqjMaQdP/RTZC
 KZmSpJwYvQ0cAfb0Z19AKRwawiptJv/kG1wgucLJZmWAJ190dp2j4FgtNseWB6j0ZQi95Fvrt
 FBiYpRGF7hnawL5w1TVwt8wIa0tKDZ6fS5JxSZt4p16VyXjFZxxt8WQqLdpKNDytLMSW8xDk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286509>

Hi Tomas,

On Wed, 17 Feb 2016, Thomas Gummerer wrote:

> On 02/17, Johannes Schindelin wrote:
> >
> > diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> > index 94079a0..19e8e34 100755
> > --- a/t/t5505-remote.sh
> > +++ b/t/t5505-remote.sh
> > @@ -51,6 +51,11 @@ test_expect_success setup '
> >  	git clone one test
> >  '
> >
> > +test_expect_success 'add remote whose URL agrees with url.<...>.insteadOf' '
> > +	git config url.git@host.com:team/repo.git.insteadOf myremote &&
> 
> Minor nit: I think we should use test_config here.

Good point.

-- snipsnap --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Wed, 17 Feb 2016 14:45:59 +0100
Subject: [PATCH] t5505: 'remote add x y' should work when url.y.insteadOf = x

This is the test missing from fb86e32 (git remote: allow adding
remotes agreeing with url.<...>.insteadOf, 2014-12-23): we should
allow adding a remote with the URL when it agrees with the
url.<...>.insteadOf setting.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5505-remote.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 94079a0..949725e 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -51,6 +51,11 @@ test_expect_success setup '
 	git clone one test
 '
 
+test_expect_success 'add remote whose URL agrees with url.<...>.insteadOf' '
+	test_config url.git@host.com:team/repo.git.insteadOf myremote &&
+	git remote add myremote git@host.com:team/repo.git
+'
+
 test_expect_success C_LOCALE_OUTPUT 'remote information for the origin' '
 	(
 		cd test &&
-- 
2.7.1.windows.2
