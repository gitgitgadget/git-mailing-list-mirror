From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t9100: fix breakage when SHELL_PATH is not /bin/sh
Date: Mon, 8 Feb 2016 20:31:54 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602082027550.2964@virtualbox>
References: <982f6f499c988e1063275e2951c9856d622a83f3.1454872161.git.git@drmicha.warpmail.net> <20160208135013.GA27054@sigill.intra.peff.net> <CAA19uiRSu_6Os3b498obSNec7b2uiYv20SZ=y93CkjsWqhqHzA@mail.gmail.com>
 <20160208163700.GA22929@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 20:32:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSrXt-0003d0-OG
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 20:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576AbcBHTcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 14:32:22 -0500
Received: from mout.gmx.net ([212.227.15.18]:51735 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982AbcBHTcV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 14:32:21 -0500
Received: from virtualbox ([89.204.153.48]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lhwgc-1ZgrbI0s3W-00n7U3; Mon, 08 Feb 2016 20:31:58
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160208163700.GA22929@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Av1YLKaKEJOJX0DUrfGyhfOCKW/xJ6k/YKWS91PfT5M7ONAUHtf
 xMI3tiU6s6BhRWLDfVaqaXiprYGwdRC2cfD8CG2ZKwMyWxk+0afIvhGIsOdubAcrlC6Wip8
 cmGOKiPVB5ahhJShCEnofIGrMsWPpsmCF4Khn9bEGBr/fqxr//eOmb+qEAOB2F4I/qKifFk
 fr5a/57FgwD7qLejdDpLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oA2+a3kAO68=:soedLH8f6P0s/D2i0fXWdU
 GpBB2mXqBZfsxVjWzOMH86W48sxFjizT0zwKdSm3jUxNtZgefV5YpbBdq0bX7Y10vtlCSFenl
 p2K1N/Xy5zuFkf0JrRCsJ05Sc2a2Jb+SAgvqar7bq1IA6yltIYHBqNBBdmXbBEJAwV6e7vh+9
 l4Buq+UR71+lukR3dAGjD3CkY7ymAFeJCH8SyxlBqDmPkDIq5HQms1DdvmDCzKICPYszFuDlA
 /DZoG3VVW468ng0hGsUEnofK1C2WSA7Pui2XyUFor4zhWvDEhFAroYjvF7GyyKLZv/rjZ19XN
 en6bU+RflqXJJBxrIoETwaCeY4vIeTYqaooNn4u4bbzLT9YFQeJlRfSwsBTGnmkGzKxrKbIwX
 jR53qetaSIkbx1MSY/V6+9KRIpT5XoC3iQfTrRH0ecDxeFcLyAwyMSIsp81JZYio94Lp6Ogqj
 Xh+mRQRMWcSxL0m/WRQs33L2jKNglF0jrTfrZbHpzmKMYcHAO1SGuFlZTGVhWf9WTSrX867HM
 MWuYdMCkEfQCYOAy+WNRfZyc0Spz94/Tw03mb8LtCzQZmDcl/nowOwZqs8oa1k5MjRjshLseL
 2zPXqqGUa3mFsO0sMIJatBTGbgb8tXV2kfBil1vj+x93zMYsCSG7rbQ/7pQUL1v1nPD3CdmwG
 uxJSaPYiBK52bSvLfTgktWQBm0BpiVAIvYPGfVqYoJgkfaATnNrgSoaN1JfgNIDEHm8tO5gsN
 rgvLrKwQ/ZIYM/vbQQvXOFgFUDjhEqZLwYBtMwbatJMynMVAct5Sy3UvCBG0WIYA8olQd9/1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285791>

Hi,

On Mon, 8 Feb 2016, Jeff King wrote:

> Assuming your patch works on Windows

If it re-introduces that chmod +x, it won't.

Please note that my *original* patch actually only guarded the chmod +x,
but Junio suggested switching to write_script and since it passed the test
suite here, I though it would be safe.

I still think write_script is the better alternative.

So why not just prefix it with `SHELL_PATH=/bin/sh`?

-- snipsnap --
t a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 56acc1e..6ad8537 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -30,7 +30,7 @@ test_expect_success \
 		echo "deep dir" >dir/a/b/c/d/e/file &&
 		mkdir bar &&
 		echo "zzz" >bar/zzz &&
-		write_script exec.sh </dev/null &&
+		SHELL_PATH=/bin/sh write_script exec.sh </dev/null &&
 		svn_cmd import -m "import for git svn" . "$svnrepo" >/dev/null
 	) &&
 	rm -rf import &&
