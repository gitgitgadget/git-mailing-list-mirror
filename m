From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] t6040 (branch =?utf-8?Q?trackin?=
	=?utf-8?B?Zyk6IGNoZWNrIOKAnHN0YXR1c+KAnSBpbnN0ZWFkIG9mIOKAnGNvbW1pdA==?=
	=?utf-8?B?4oCd?=
Date: Wed, 11 Aug 2010 02:49:09 -0500
Message-ID: <20100811074909.GC5450@burratino>
References: <20100725005443.GA18370@burratino>
 <20100725010230.GI18420@burratino>
 <201008110911.40133.trast@student.ethz.ch>
 <20100811073028.GA5450@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 11 09:50:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj65M-0005k3-BK
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 09:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863Ab0HKHuj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 03:50:39 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33742 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497Ab0HKHui convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 03:50:38 -0400
Received: by gxk23 with SMTP id 23so4015602gxk.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 00:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=iOcukV4khoaln+7m725yENvDh227q0zJOz0WVWTmq/4=;
        b=vMRa3dC+hI0DI3+YHHefmZacc3Y7ldGMoLYc/PEW3SESKX4SemX0GC2BLxSeSRnr0G
         BYRu+UeNBKe0OonzM0lEfBq0tnPz2Zktd08QDWRsxyXvn0Cshcs53BJUjrxwaLFxd22V
         jLGC3sn85I8lX7D0SAT6Wu0b5X6AuiVCYlCVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=EoZmyDXS5Ij6qODAmhJ5f7cxOaEMbxGbwgoYtJfoXK8STLnURwmO1CqsRcqFSPvWcs
         hss14kG581WDLViT01Y7Zv/eDsUIrz/eE+Jd7lx/NCQQznhRPJ7v5MSy49aJ0M8Vs3bS
         IR/TR3Z7IcjJp89q6vMvLq6YZBNQvMWsgqTn8=
Received: by 10.151.123.3 with SMTP id a3mr20684828ybn.126.1281513037084;
        Wed, 11 Aug 2010 00:50:37 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q31sm7061022ybk.1.2010.08.11.00.50.36
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 00:50:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100811073028.GA5450@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153197>

Among the tests for correct branch tracking output is one that
examines =E2=80=9Cgit commit=E2=80=9D output:

 $ git commit
 # Your branch and 'origin/maint' have diverged,
 # and have 9 and 69 different commit(s) each, respectively.
 [...]
 no changes added to commit (use "git add" and/or "git commit -a")
 $

But we are experimenting with changing that output.  So drop
that test for now and replace it with a test for =E2=80=9Cgit status=E2=
=80=9D
(which was not being checked yet and shares the same output
format and wt-status backend).

Reported-by: Thomas Rast <trast@student.ethz.ch>
Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Oops, wrong patch.  Here=E2=80=99s the one I meant.  Sane?

diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 1785e17..a5b4489 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -68,8 +68,7 @@ test_expect_success 'status' '
 	(
 		cd test &&
 		git checkout b1 >/dev/null &&
-		# reports nothing to commit
-		test_must_fail git commit --dry-run
+		git status
 	) >actual &&
 	grep "have 1 and 1 different" actual
 '
--=20
