From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 16/19] mingw: avoid absolute path in t0008
Date: Mon, 25 Jan 2016 17:48:37 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601251747050.2964@virtualbox>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <7c35a7b9c65d9febb6af1b50907988974bca3fbd.1453650173.git.johannes.schindelin@gmx.de> <xmqq60yibe89.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 17:49:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNkK7-0003sl-4f
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 17:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933410AbcAYQs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 11:48:58 -0500
Received: from mout.gmx.net ([212.227.17.20]:62505 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932488AbcAYQsz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 11:48:55 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lg1QN-1ZmElp3bDP-00pbVZ; Mon, 25 Jan 2016 17:48:38
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq60yibe89.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:59N+5YmJNTiIwbC5D2hM75V2kExAD49GxecpBUQkGnruGv5STxq
 icZnWfsDEI6aKSFLhU4q4UmH5XgD9WGjvRkynVmqBO91fPyXa/d7HE79AjTQE3oGzD/tvoZ
 kei14mnaQGcSzBf+JH4slcC1GVAuoPKCPS8oYRoBiXfZyvX+VHfHzJOunvlRC8yykWSSEFS
 PmbBziZfRs67HK+Zf0CDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Qi1YFiqJBsw=:wa/ZhuuE323jBWMVdoDBRt
 yaijpeV2YkUNH7n4fpcCL8GE5i2AMIUmT2rzQLtiThGECKiIc3nr4RD5BJxQxUG4eUYJj3WQC
 kLjNEKNvqTqRzmAUsDnC7M7bvTxc6TFkKPSFmIvBwPha/psvKApGNHyT8GOgmryiqLl7dCzUY
 4Xf0JIWJO0qmj5Nedzl77qq2ncBVw4oXyujMAY3asA+JrTFXjKtslP9zRj2i0bHQapSqQMp9a
 DxFqIomzAIWJbqHuk+++GPepyPhO9zsQRuMys/ptBRIExWoV1yP4ziPK9Gms54qH6UQqeDQVF
 7pbLdAzvd9FoCueVoPw8Olb+IMP/FfkNNBXw9uoyqZHEk9Ex2xA5zChO2NQrmd8rtVfV+ny4q
 uMWMVLo8Bc4LSY79WXbIEc/h3ZspTUmzHIPk7izxFtp0W+QeLVpHPueCXPHmn6HAlG/w9Tbts
 WEK2eH8/l0sWvNw/MvZNz6larsJrUG31T94Vvqu5eg2X5p3e1yeoYqvWUNbT9V+mFxUqjGYvK
 cG/GNdrbK73Mvu2BFTCTAmCS1n+hZrD60syvWKiVNgljLRYxBdKZeSGVy/RDLCz+mluWWvgjd
 T+GzvTwj0mM9OvbMmZipyoWCftwiBef6UXkTh9j0HJ9mo6Sjvnb1A4o/Z5b0f9W3KtRCwrmNu
 f+Q2anUurvauvwqJc79QlcwRspKOjLBvi3KPo240jKqgu1vhsGQR6lcxwg3aiEnMFQGLsOe37
 LRPlUfuCKirw5QRvS1yN2pVytfq1OoJgtIyKhBakmbvt8ToTQN0OVwF4i3Fi6Y43Z8bp/YCD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284739>

Hi Junio,

On Sun, 24 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > From: Pat Thoyts <patthoyts@users.sourceforge.net>
> >
> > The test separator char is a colon which means any absolute paths on
> > Windows confuse the tests that use global_excludes.
> >
> > Suggested-by: Karsten Blees <karsten.blees@gmail.com>
> > Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/t0008-ignores.sh | 8 +++++++-
> 
> Is the fact that $global_excludes is specified using an absolute
> path significant to the correctness of this test script?

Apparently not. So I followed your suggestion and made this independent
of the OS:

	https://github.com/dscho/git/commit/0b9eb308

> A larger question is if it would make more sense for Git ported to
> Windows environment to use semicolon (that is the element separator
> for %PATH% in the Windows land, right?) instead where POSIXy port
> would use colon as the separator.  A variable that is a list of
> locations (e.g. $PATH) makes little sense when elements can only be
> relative paths in practice.

Oh my... I was not looking for more work ;-)

Seriously again, I do agree with the suggestion to use semicolons on
Windows as path lists' separators instead of colons.

Ciao,
Dscho
