From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: git svn clone cannot go beyond a specific rev on codeplex
Date: Thu, 12 May 2016 21:38:05 +0000 (UTC)
Message-ID: <1755662347.2265534.1463089085574.JavaMail.yahoo@mail.yahoo.com>
References: <1755662347.2265534.1463089085574.JavaMail.yahoo.ref@mail.yahoo.com>
Reply-To: Hin-Tak Leung <htl10@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: <normalperson@yhbt.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 12 23:44:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0yPE-0003S2-K0
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 23:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbcELVoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 17:44:24 -0400
Received: from nm2-vm3.bullet.mail.ir2.yahoo.com ([212.82.96.83]:56691 "EHLO
	nm2-vm3.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750929AbcELVoX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2016 17:44:23 -0400
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 May 2016 17:44:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1463089086; bh=qVc4Bza8R7VqLBwqA+cW1qEa8FIFyzMQ0wH1Mvj28JM=; h=Date:From:Reply-To:To:Cc:Subject:References:From:Subject; b=Bnp85YodUzieXSYznpuV9LqtxJh7RFDeKmG4KPBq12GVCj51t3BHtEL9DunSf67c//nhrhFg+l4L/uyYKV+vEh7EBNPB6NLCTRnO9FRSA9gQ+m5V8OUuyCcXLFPOu5oRxgk0B39GFc1dL4rB73p+IiIKTMF6+vGCiJCc4fj781vzIJOM/cbt7uafKUMJ45xeqgDnkqirvYBaE1MTTjmLqqYxqKROnoD6ZaQXqs024xcoDzKP2uuM7dJuFPxZgbxyx1khkQkEwRRPSJK8pQKIONUCbJzBN9sScYSDOueOUVDoif058/wnKYnWd3AfxRrqea3Hu3pj49VPfcMg41lMQg==
Received: from [212.82.98.57] by nm2.bullet.mail.ir2.yahoo.com with NNFMP; 12 May 2016 21:38:06 -0000
Received: from [212.82.98.94] by tm10.bullet.mail.ir2.yahoo.com with NNFMP; 12 May 2016 21:38:06 -0000
Received: from [127.0.0.1] by omp1031.mail.ir2.yahoo.com with NNFMP; 12 May 2016 21:38:06 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 440057.48833.bm@omp1031.mail.ir2.yahoo.com
X-YMail-OSG: Sxi0dz4VM1k_AuLA2l3K.iSTl_NteVlpSFZv6Ei5E2gCeQdHU7w3p_beno46BzS
 RaCjT60SkukmD8bsF6Dunq_oQsw4.xEEnhI0LzRHQx8_OlVY0IIk27IRSpdrBwFXpWTmJQVPcFEl
 Qrg_nhZkiXelkpwzdVoxJbTm5IVGBlZI7FNiINx9DCjydEnqQadGAc0fSHM14C.mbEJ0vtscoawe
 j9FOSi5S6q0YQanylSK27VPPKnCq9SSdAzmnHIOS7tZ2nmuYpQEYmAe1CJ5leC.ghgANIsIHOVZs
 vpj5ro4v5L4Chv1yycyltPu_coslbSAtijYIKdO6FyPSPRQ.NsHa4LyB8ZNI_GvhtEkQ.9owE_2N
 dlh9aY1xQdpaeIjXBwUiFLurYzbwN_T9pprVTInDguLvJ3f.QLHH7.GwEFCLn7KHE4eFoihvZ3iR
 em5il4QkX04Iaa9.aUTaJp7E88pK2C7zOd.S9tVFoLMB88xHd4OhIYm.XOAE9wPx6pTjDHcyiDHo
 xBJ1WuvRMaDz3wv4-
Received: from jws11188.mail.ir2.yahoo.com by sendmailws164.mail.ir2.yahoo.com; Thu, 12 May 2016 21:38:05 +0000; 1463089085.852
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294483>

I tried bin-wrappers/ from current git HEAD.

$ git describe
v2.8.2-396-g5fe494c

bin-wrappers/git svn clone https://ironpython.svn.codeplex.com/svn ironpython-old-codeplex

always fails at this rev:

	M	Src/Tests/test_re.py
r7605 = e581bc66eda2b86bf46681191034844c4ba7d7a5 (refs/remotes/git-svn)
Connection reset by peer: Error running context: Connection reset by peer at /home/Nobak-Hin-Tak/tmp-git/git/perl/blib/lib/Git/SVN/Ra.pm line 312.

I am sure there are later revs, as the web front end says so, but git svn clone/fetch does not seem to be able to get at it.

(vger.kernel did not seem to like my posts a while ago - I hope situation has improved and this can go through...)
