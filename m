From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/3] Make httpd tests run
Date: Wed,  8 Apr 2015 17:05:23 +0200
Message-ID: <cover.1428505184.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 17:05:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfrXs-0005LC-Tz
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 17:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbbDHPFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 11:05:31 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38509 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753841AbbDHPF3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Apr 2015 11:05:29 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id AC70F209AF
	for <git@vger.kernel.org>; Wed,  8 Apr 2015 11:05:23 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Wed, 08 Apr 2015 11:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:message-id:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp;
	 bh=v6iVa73sbcSeZqEnIOrqc79Ygbo=; b=c65+ysMBuf2PVSglGxFhYVYK4y/X
	Lphx66DtXhaF/e6mC0BlIZjL5J6geLGUZbh1sTZeGspHkucxaCI7o4ptgPipaVyY
	6zAj39IveksQxf/y7rCXHiF2OOS5vsJCKNlHOkSxV1KdgOiA5d08Rt+582DAX1Q5
	zRuaDiOwYdsHHQU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=v6iVa73sbcSeZqEnIOrqc79Ygb
	o=; b=RUHYfuU/NcDioVY2BgCp5xqKyYPj3NWFboATHQnRrCmjrO3W39AcLiDtB+
	yZaTRZWMvsJhHiPH/1noSq3VDN/m5G8ZkAcZpAv1mPdpaGDczdW7AVF05zveWh8P
	0fM6w5W/BNtRmeiWaI96L254K5/llHbbYb8jSRSHqVJR1tghE=
X-Sasl-enc: hGBg8RvGzoKZZfKaL7qxre3jWEtes1cDl4/EYwt3N9LQ 1428505527
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 391F5C0001D;
	Wed,  8 Apr 2015 11:05:27 -0400 (EDT)
X-Mailer: git-send-email 2.4.0.rc1.221.gf7021fb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266962>

This series grew from an attempt at enlarging my personal test run coverage
on a standard Fedora 21 64bit box. Aka chain-lint fall-out.

With 1/3, I get all httpd tests to run (when port is set, of course).

2/3 and 3/3 are an attempt at getting git-svn over http tests to run.
2/3 is certainly correct but not sufficient.
3/3 gets httpd to run but svn does not connect. This is WIP and RFH,
and maybe requires rewriting lib-git-svn to use a config which depends
on the apache version (like lib-hhtpd does), or to leverage lib-httpd.

Michael J Gruber (3):
  t/lib-httpd: load mod_unixd
  t/lib-git-svn: check same httpd module dirs as lib-httpd
  t/lib-git-svn: adjust config to apache 2.4

 t/lib-git-svn.sh        | 7 +++++--
 t/lib-httpd/apache.conf | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.4.0.rc1.221.gf7021fb
