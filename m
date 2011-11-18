From: Scott Parrish <wsparrish@gmail.com>
Subject: test t/t1304-default-acl.sh
Date: Fri, 18 Nov 2011 00:10:32 -0500
Message-ID: <83CC5ED6-5F1E-446A-925C-FC6D2D29CBA9@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 18 06:10:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRGit-0005mH-Lp
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 06:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609Ab1KRFKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 00:10:36 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47583 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab1KRFKe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2011 00:10:34 -0500
Received: by ywt32 with SMTP id 32so2035422ywt.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 21:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:content-type:message-id:date:to
         :content-transfer-encoding:mime-version:x-mailer;
        bh=vBxK+o6Wk6+4c/Yt2RnJJt7Z/N9yrL9Mj31qm06UWko=;
        b=tx0x7eKy1dYp9wpjFwICLWFD5TvNBFY7H9S0xCeB/t7P+p2a9/CRC9cYmd7gcdATi5
         Qbm4l3XeTbcJ9eEGReDEfc3O4yTBSdBRRndrYpnbAV62TITDeiFKDJZ7zLIE4pRqxJJk
         9Mfu0OXo7GPavuBUNa2BSz8XRag5c5nM+GF5s=
Received: by 10.236.124.105 with SMTP id w69mr2017629yhh.2.1321593034122;
        Thu, 17 Nov 2011 21:10:34 -0800 (PST)
Received: from [192.168.1.7] (cpe-065-190-200-190.nc.res.rr.com. [65.190.200.190])
        by mx.google.com with ESMTPS id t62sm9416634yht.0.2011.11.17.21.10.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 21:10:33 -0800 (PST)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185633>

Hi folks,

This test case fails on FreeBSD 8.2. Specifically, the use of the "d[efault]:" syntax in the ACL tag is invalid on FreeBSD. The manpage indicates that default ACL's should be set via the "-d" command line option to setfacl. See http://www.FreeBSD.org/cgi/man.cgi?query=setfacl&apropos=0&sektion=0&manpath=FreeBSD+8.2-RELEASE&arch=default&format=html for details.

Note that the test used "-d" at one time but appears to have been changed to use "d:" to accommodate Solaris where "-d" has the effect of deleting ACL entries. The change was made on this commit: https://github.com/gitster/git/commit/db826571e4099066fe44233d95642591016c831b

So I don't think it is as straight-forward as reverting to the use of "-d".

Thoughts?

Cheers,
-Scott