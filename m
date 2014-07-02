From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] git-merge-file: do not add LF at EOF while applying
 unrelated change
Date: Wed, 2 Jul 2014 16:08:28 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1407021604510.14982@s15462909.onlinehome-server.info>
References: <1403993086-15625-1-git-send-email-max@max630.net> <1403993086-15625-3-git-send-email-max@max630.net> <alpine.DEB.1.00.1406301650430.14982@s15462909.onlinehome-server.info> <20140702044427.GA7325@wheezy.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Wed Jul 02 16:08:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2LDL-0000uc-G1
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 16:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753607AbaGBOIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 10:08:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:50275 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398AbaGBOIm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 10:08:42 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MI8iw-1X40AM4B4A-003r9B;
 Wed, 02 Jul 2014 16:08:29 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20140702044427.GA7325@wheezy.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:qRBK2ozBdzce5F4BYtmnj4I7Ym0giukQfbns07B9iu98N9sk0h3
 8bm8xKer2x9LTysOrj8JGJuLAFybJOOTPdoTtIYOacvPHsWkozj8/oeG/u7ryN9Z/bEmKR9
 pmw7zpwliI+eFziEiZ+cE0Kaq/SgsK3gy+Jn9QzRurRBi1bxzfO3JFc9Rl7coALwlUaGDn7
 vYh1AJBfcXKEs9kiQgzxw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252780>

Hi Max,

On Wed, 2 Jul 2014, Max Kirillov wrote:

> On Mon, Jun 30, 2014 at 04:55:10PM +0200, Johannes Schindelin wrote:
> > I just wish the tests were a little easier to understand...
> 
> What could be improved with them?

Oh, I would name the files more appropriately, for example. That is,
instead of test1.txt I would call it mixed-endings.txt or lf-only.txt or
some such.

And instead of the Latin version of Psalm 23, I would put lines into the
files that describe their own role in the test, i.e.

	unchanged
	ends with a carriage return
	ends with a line feed
	unchanged

or similar.

Please keep in mind that this critique is most likely on my *own* work,
for all I know *I* introduced those files.

> By the way, for "\r\n" eol it did even worse, adding just "\n". And I
> guess it still adds just "\n" for union merge.  Should file merge
> consider the core.eol? I think it should, and for the conflict markers
> also, it looks ugly when whole file has "\r\n" but the conflict markers
> have "\n". But then git-merge-file could not be used outside of
> repository, I guess.

Oh, why not? It could read the configuration if it's inside a working
directory, and just read /etc/gitconfig and $HOME/.gitconfig when
outside...

> In general, I wish file merging (and diffing) were more tolerant of the
> line endings in input. Because in windows environment, when people have
> different core.autocrlf, it becomes quite frustrating to always get
> conflicts and changes.

Amen!

Ciao,
Dscho
