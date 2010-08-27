From: Robert Zeh <robert.allan.zeh@gmail.com>
Subject: SVN->GIT conversion question: how to make git svn not rebase some git commits
Date: Thu, 26 Aug 2010 19:47:34 -0500
Message-ID: <D153FFD0-67BA-4E1E-BB04-2A6D01EF00C3@gmail.com>
Mime-Version: 1.0 (iPhone Mail 8A400)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 27 02:47:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oon6s-0003VR-0V
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 02:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132Ab0H0Arx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 20:47:53 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61472 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab0H0Arv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Aug 2010 20:47:51 -0400
Received: by iwn5 with SMTP id 5so2053753iwn.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 17:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:content-type
         :x-mailer:message-id:date:to:content-transfer-encoding:mime-version;
        bh=KZSREalb5gNVLmfVesmCFntPpxtlIHfX8dM25M48vTU=;
        b=qvlhrKtR7u5FlCHO1ehM2PeFmnsekkuykCCPFgWyZdqapsILPKiFy9gA7zH4H/xM2N
         GuQDwto9umfrsO2qwKDs1SNQwKUW1qbsXcHkWhzFQqBhCJh8Y++P73ncRCHeR+7UR4wI
         wm6xxgmSlwPOX2HWg545mYFP0b7/ZgfbmgloE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:content-type:x-mailer:message-id:date:to
         :content-transfer-encoding:mime-version;
        b=lOWp78YqZ/8hFyYOY6EdGaH64Dg0hs7ZW4BIytNyXB3+QJKWJQGByvq54qqOulNHvk
         ruhtTZ/Fn78/h/EgfzYrNuJp8Jk6nPgj++WLkDaHGZ7W8W+Dj3BQee9/1NQRroyoBfw4
         9qimrrVS1suAYQFSzJDPDPlxn0hfu/O/8EQHQ=
Received: by 10.231.13.133 with SMTP id c5mr144064iba.73.1282870070266;
        Thu, 26 Aug 2010 17:47:50 -0700 (PDT)
Received: from [10.45.160.126] (mobile-166-137-141-005.mycingular.net [166.137.141.5])
        by mx.google.com with ESMTPS id h8sm3048071ibk.15.2010.08.26.17.47.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Aug 2010 17:47:49 -0700 (PDT)
X-Mailer: iPhone Mail (8A400)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154571>

I am porting a medium size (2GB) subversion repository to git. I have already done an initial git svn fetch with generous filters, to filter out directories for which I do not want history. 

However, I would like to import a snapshot of the filtered directories and, here is the tricky part for me, continue using svn fetch without rebasing the snapshot commit. I would like the history to look like:

S1 -> S2 -> G1 -> S3

Where Sx is a Subversion commit and G1 contains the snapshot. 

I want to maintain this strange history so that I can gradually introduce git as a read only repository in parts of my environment, and then do a full switch over. 

Robert