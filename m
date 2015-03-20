From: <mdconf@seznam.cz>
Subject: Git ignore help
Date: Fri, 20 Mar 2015 11:36:51 +0100 (CET)
Message-ID: <47F.3lxhK.7IviRa5Gutr.1L2}X3@seznam.cz>
Mime-Version: 1.0 (szn-mime-2.0.2)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 20 11:37:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYuIZ-0001Lz-He
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbbCTKgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:36:55 -0400
Received: from mxf2.seznam.cz ([77.75.76.123]:56987 "EHLO mxf2.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830AbbCTKgx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:36:53 -0400
Received: from email.seznam.cz
	by email-smtpc6a.ng.seznam.cz (email-smtpc6a.ng.seznam.cz [10.23.10.165])
	id 671753e6bf8da35364a8e916;
	Fri, 20 Mar 2015 11:36:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
	t=1426847812; bh=j9jUaW2y3qAy6tRQb0NlOCOFBYuOoPMxTvbaVokruZY=;
	h=Received:From:To:Subject:Date:Message-Id:Mime-Version:X-Mailer:
	 Content-Type:Content-Transfer-Encoding;
	b=YaoQ43y0CiaoGMMf4m8uxnTC6fp9tSV8VOtoGyKMSzVd+ydI4MAF74G8lMr8mCTf2
	 32jjBJuo2qyHvcMGv/JYfbAQkbILq4DRgbmhG1xMJqg6Wsj1DMF8Aq5vtZViTnL6q5
	 /Kuv4bFMbakzITfe6mojJR3vKdH4Foio+pWEX8F8=
Received: from ip-94-113-145-153.net.upcbroadband.cz
	(ip-94-113-145-153.net.upcbroadband.cz [94.113.145.153])
	by email.seznam.cz (szn-ebox-4.4.269) with HTTP;
	Fri, 20 Mar 2015 11:36:51 +0100 (CET)
X-Mailer: szn-ebox-4.4.269
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265901>

Hello,
I am trying to setup my git ignore (resp. .git/info/exclude) so that I exclude
 all directories and files except the content of directories that I 
specifically include (incl. anything within them recursively).

I set the .git/info/exclude with the following content:

========
# Exclude everything
/*
# Except the below that we include
!/db/data/load/base/bootstraponly
!/db/data/load/base/safetoload
!/db/ddl
!/labels
!/reports/usrint
!/scripts
!/src/cmdsrc/usrint
========

However it does not do what I anticipated. It indeed excludes everything but 
the include part does not work - it only works for !/labels and !/scripts 
directories (i.e. the first level directories). All other are still ignored - 
so when I create file /db/data/load/base/bootstraponly/somefile.txt git still 
ignores it...

Any idea what I am doing wrong?

I tried all of the following combinations but still with the same result:
!/db/data/load/base/bootstraponly
!/db/data/load/base/bootstraponly/
!/db/data/load/base/bootstraponly/*
!/db/data/load/base/bootstraponly/**

When I add just "!/db" to exclude then it works. But that's not what I want - 
I really want to include just the /db/data/load/base/bootstraponly and its
all content...

Thank you,
Martin
