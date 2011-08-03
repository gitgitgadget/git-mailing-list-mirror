From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: git-archive's wrong documentation: really write pax rather than tar
Date: Wed, 3 Aug 2011 23:17:59 +0100 (BST)
Message-ID: <1312409879.97173.YahooMailClassic@web29501.mail.ird.yahoo.com>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx
X-From: git-owner@vger.kernel.org Thu Aug 04 00:18:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QojlQ-00089m-R8
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 00:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755556Ab1HCWSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 18:18:04 -0400
Received: from nm8.bullet.mail.ird.yahoo.com ([77.238.189.23]:39719 "HELO
	nm8.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755434Ab1HCWSB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 3 Aug 2011 18:18:01 -0400
Received: from [77.238.189.57] by nm8.bullet.mail.ird.yahoo.com with NNFMP; 03 Aug 2011 22:18:00 -0000
Received: from [212.82.108.249] by tm10.bullet.mail.ird.yahoo.com with NNFMP; 03 Aug 2011 22:18:00 -0000
Received: from [127.0.0.1] by omp1014.mail.ird.yahoo.com with NNFMP; 03 Aug 2011 22:18:00 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 75189.67797.bm@omp1014.mail.ird.yahoo.com
Received: (qmail 97194 invoked by uid 60001); 3 Aug 2011 22:18:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1312409880; bh=ee4sIIclzDJz877sWcvyxe+hrC9bAlWEWLu/Vw7/BTw=; h=X-YMail-OSG:Received:X-RocketYMMF:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=w5WwIzU4pnjgZO512oV47uZEZI6LrM+GDWdMdv/LFh8fF37SxVmjWd5yoIWoVxc3YOu/US1HXod4fYE1lugRw3iF0f6SsSUJr4h9Di+gONKFbmFryKLuoQ+gaSSlIlo3N301ZENQ+pcOedckc6mXg2+ICgC3T7VEh+lhedTKFBI=
X-YMail-OSG: b8KDl34VM1nOtceXSJkqkR5FrD1rOZtddBqC8QnkjCsps9i
 dLwCKKbR9wxyrK7U_1wFzmmCNXWjaHA67LpPvtXsWN.c0D0O8Ayyxyg6bOSX
 GpsSIEeHOSG4wuEW1D5CurH6VUBE6DdYkciEz5TvZTsmVXfUP4G7CGhOx5j4
 G6vzQGUTGy_kBlD9J4ivB3SE3wGJRELKnIMVHfCx2qyhU5xfcGsDaDInj.Cy
 0nnKsGrGoyNrO0OPEa.gGh5RTcipdACI_r2apVWJtLSXqPAOsQGgGl4VFL4f
 OCXpSUD_8WJM5O_1rOXVJ6i.aGv1RKmaEgkDsGZcJ0AizpGfJnbgcGw.h6vu
 xHXFZn8hpIW4NIf7UZhzzZU7iNdaaxXINwfcTYM1oBivc7O5gZDuhe07ILPY
 2JbNUB1v.95I8_zWKtMk__Li6swBnGfowodMWHIjZ1redeTl4eZLjJmUFzEm
 VXgq6rNyw9tGKmuuZRKsIKC4dVtuOQXvN4jL747IhpKxt2ilzBPhi_ABvqRe
 10I0yGopPZsBRCXfhe2bbrHEGBqMpPJ7YiJ42j9jiZ__VkdaGq8xr9HjwZqE
 4WfC2V90cLzTLiPsZIlT.r370TbeFGgDNXkZBdXza2YpSoMBwmlEy2RtGjT7
 EwCwQ9KJ84BcpEv1nGTofXKrR0_DKaLcl7MOhHTb6
Received: from [81.101.129.153] by web29501.mail.ird.yahoo.com via HTTP; Wed, 03 Aug 2011 23:17:59 BST
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/14.0.3 YahooMailWebService/0.8.113.313619
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178638>

Had a bit of discussion on R-devel a few months ago, and now that I am doing something similiar again I decided to write and report this issue:

http://r.789695.n4.nabble.com/quot-R-CMD-check-quot-accepts-but-quot-R-CMD-INSTALL-quot-rejects-a-tar-ball-td3420479.html

The summary of the problem is that, git-archive's "--format=tar" option really write the pax format most of the time, and some cross-platform archive extraction library (rather than the all-powerful GNU tar) really does not think that's the tar format and bail out.

Is it possible to (1) add a warning in the man-page, or (2) actually fix the problem in git-archive ( archive-tar.c ) to generate more conformant archive packages?

Thanks. BTW, git (and git archive) is a great tool!
