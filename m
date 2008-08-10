From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [QGIT RFC] Unit tests for QGit
Date: Sun, 10 Aug 2008 09:55:57 +0200
Message-ID: <20080810075557.GA3955@efreet.light.src>
References: <20080808211318.GA4396@efreet.light.src> <1621f9fa0808081600i51bcaaedtc22a7a85947ba400@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org
To: Benjamin Sergeant <bsergean@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 09:57:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS5nc-00073t-1N
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 09:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbYHJH4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 03:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752467AbYHJH4I
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 03:56:08 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:42446 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752165AbYHJH4H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 03:56:07 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 639EF572E1;
	Sun, 10 Aug 2008 09:56:04 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id Z8to8i5m5B0W; Sun, 10 Aug 2008 09:56:01 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id A14A0572DB;
	Sun, 10 Aug 2008 09:56:00 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1KS5mQ-0001Jr-0g; Sun, 10 Aug 2008 09:55:58 +0200
Content-Disposition: inline
In-Reply-To: <1621f9fa0808081600i51bcaaedtc22a7a85947ba400@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91807>

On Fri, Aug 08, 2008 at 16:00:57 -0700, Benjamin Sergeant wrote:
> On Fri, Aug 8, 2008 at 2:13 PM, Jan Hudec <bulb@ucw.cz> wrote:
> > I've been thinking about some refactoring of QGit since some time. And to be
> > sure I don't screw up things too hard in the process, I thought about adding
> > a test suite infrastructure first (and add some test cases for each think
> > just before refactoring it).
> >
> > The problem is, that implementing unittests means I need to compile
> > 2 separate binaries -- qgit itself and the test -- using most (but not all)
> > of the same sources. I see two ways to do it, so I'd like to ask which you
> > consider cleaner:
> > [...]
> 
> Maybe you can have a look at QTestLib. But it won't solve your

Sure I did. Unfortunately they don't suggest any good way to handle your
build process with it in their examples. Seems to me they never tried testing
an application with it.

I plan to go down the QTestLib route. Maybe it could be combined with
LDTP[1] for blackbox testing -- they claim to be able to use Qt 4's
accessibility to control an application.

> buildsystem issues. You'll need one .pro per test. (I have one .pro
> per test plus one directory per test). There's probably other ways to
> using it.

Depends on what you call a test. But generally there should be no reason to
have more than one .pro file for all tests. You just need to manually
maintain a list of test classes or create some kind of static instance
self-registration (which I did).

> http://doc.trolltech.com/4.4/qtestlib-manual.html#qtestlib

[1] http://ldtp.freedesktop.org/

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
