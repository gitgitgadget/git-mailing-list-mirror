From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [WISH] prepend diffstat in front of the patch
Date: Sat, 15 Apr 2006 11:07:40 +0200
Message-ID: <e5bfff550604150207h6fdb0042x3a9bbfa63269a8c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 11:07:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUgkq-00064K-Vg
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 11:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbWDOJHl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 05:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbWDOJHl
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 05:07:41 -0400
Received: from wproxy.gmail.com ([64.233.184.226]:29940 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751599AbWDOJHl convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 05:07:41 -0400
Received: by wproxy.gmail.com with SMTP id i6so368578wra
        for <git@vger.kernel.org>; Sat, 15 Apr 2006 02:07:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=d1bskhEhHngQ8w4s3JGGSxNswpEo1yxZrgv4DuxzUjSm3Mwd6BgICW8T8mP2eEpPwyoZC1FMulN2qcA/sxjQ44RSIYZ5YejjUfcJp7Bny7FKZYULOJSvZQ4aFg2Lqpq4pLwYEAeEu2qvwS2EO3Y/gCVR4/0Np67K06x874PvKII=
Received: by 10.65.61.14 with SMTP id o14mr1260663qbk;
        Sat, 15 Apr 2006 02:07:40 -0700 (PDT)
Received: by 10.64.131.14 with HTTP; Sat, 15 Apr 2006 02:07:40 -0700 (PDT)
To: Johannes.Schindelin@gmx.de
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18732>

>From today git tree

$ git-diff-tree -r -c -p --stat 84981f9
84981f9ad963f050abf4fe33ac07d36b4ea90c6d
---
 diff.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


$ git-diff-tree -r -c --stat -p 84981f9
84981f9ad963f050abf4fe33ac07d36b4ea90c6d
diff --git a/diff.c b/diff.c
index c120239..f1b672d 100644
--- a/diff.c
+++ b/diff.c
@@ -438,8 +438,8 @@ static void builtin_diffstat(const char
                xdemitcb_t ecb;

                xpp.flags = XDF_NEED_MINIMAL;
-               xecfg.ctxlen = 3;
-               xecfg.flags = XDL_EMIT_FUNCNAMES;
+               xecfg.ctxlen = 0;
+               xecfg.flags = 0;
                ecb.outf = xdiff_outf;
                ecb.priv = diffstat;
                xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);


Perhaps I missed something, but I would like to see --stat and -p as 
_cumulative_ options .

Would be great if git-diff-tree -r -c --stat -p 84981f9 prepends
diffstat in front of the patch as Junio suggested some days ago.

Is it already planned?

Thanks
Marco
