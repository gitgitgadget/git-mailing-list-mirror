From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] git-blame: Use the same tests for git-blame as for git-annotate
Date: Sun, 05 Mar 2006 21:56:26 -0500
Message-ID: <440BA4DA.9060101@michonline.com>
References: <20060305111334.GB23448@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0EBAF73837303D87B4580AB9"
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Mar 06 03:57:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG5u3-0007xu-3j
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 03:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWCFC4o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 21:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWCFC4o
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 21:56:44 -0500
Received: from mail.autoweb.net ([198.172.237.26]:34488 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1750775AbWCFC4n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 21:56:43 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FG5tp-0004Yi-DG; Sun, 05 Mar 2006 21:56:42 -0500
Received: from [10.254.251.12] (helo=mythryan.michonline.com)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FG5td-0004xG-7Z; Sun, 05 Mar 2006 21:56:29 -0500
Received: from localhost ([127.0.0.1])
	by mythryan.michonline.com with esmtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FG5tc-0002L9-Rp; Sun, 05 Mar 2006 21:56:28 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060305111334.GB23448@c165.ib.student.liu.se>
X-Enigmail-Version: 0.93.0.0
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17266>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0EBAF73837303D87B4580AB9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Fredrik Kuivinen wrote:

>Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>
>
>
>---
>
> t/annotate-tests.sh |   86 +++++++++++++++++++++++++++++++++++++++++++++++++++
> t/t8001-annotate.sh |   85 +-------------------------------------------------
> t/t8002-blame.sh    |    9 +++++
> 3 files changed, 97 insertions(+), 83 deletions(-)
> create mode 100644 t/annotate-tests.sh
> create mode 100755 t/t8002-blame.sh
>
>06b0e500a5202899dcfd037cf78ee4a982da46b4
>diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
>new file mode 100644
>index 0000000..54a4dfb
>--- /dev/null
>+++ b/t/annotate-tests.sh
>@@ -0,0 +1,86 @@
>+# This file isn't used as a test script directly, instead it is
>+# sourced from t8001-annotate.sh and t8001-blame.sh.
>+
>+test_expect_success \
>+    'prepare reference tree' \
>+    'echo "1A quick brown fox jumps over the" >file &&
>+     echo "lazy dog" >>file &&
>+     git add file
>+     GIT_AUTHOR_NAME="A" git commit -a -m "Initial."'
>+
>+test_expect_success \
>+    'check all lines blamed on A' \
>+    '[ $(git annotate file | awk "{print \$3}" | grep -c "A") == 2 ]'
>  
>
This should be $PROG as well, I suspect.

Also, we need to agree on a syntax for working on non-HEAD revisions.

"git annotate $file $commitish" is what I had been using, but it's
really not something I feel strongly about.


-- 

Ryan Anderson
  sometimes Pug Majere


--------------enig0EBAF73837303D87B4580AB9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFEC6TcfhVDhkBuUKURAixZAJ49sfO7fgKMmf/m8Mfz91hnBM0YdACgn/nw
qP1UITAnTqo/3yzIWemGkC8=
=m5u/
-----END PGP SIGNATURE-----

--------------enig0EBAF73837303D87B4580AB9--
