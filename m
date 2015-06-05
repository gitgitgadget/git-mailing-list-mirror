From: =?UTF-8?q?Johannes=20L=C3=B6thberg?= <johannes@kyriasis.com>
Subject: [PATCH v2] Fix cloning from ref namespace
Date: Fri,  5 Jun 2015 16:12:09 +0200
Message-ID: <1433513531-13423-1-git-send-email-johannes@kyriasis.com>
References: <1433193883-11577-1-git-send-email-johannes@kyriasis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Johannes=20L=C3=B6thberg?= <johannes@kyriasis.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 16:12:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0sMA-0005G6-Nw
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 16:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423108AbbFEOMS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2015 10:12:18 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:52532 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422683AbbFEOMO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 10:12:14 -0400
Received: from theos.kyriasis.com (localhost [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id 642ddc54;
	for <git@vger.kernel.org>;
	Fri, 5 Jun 2015 14:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=theos; bh=aAYLqZ75FZU
	gbI0IQ2JJY/3Odo8=; b=ubmDm0kIiX6DR3PBk9Jl1h+YFZIIU+hqX/tCJEChQD+
	pZb8fz3BUKdURGBNhll/UwCzJya2Fhtbyf6VScPNDHqXgOeWTlYOL1WDJQZA+ZOF
	s/WuK9WhxtxkBNRL3XirA7E2oyzt2X9cUxJZ/rExD8kIV9HivO7PZaL1IQPN3sig
	=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; q=dns; s=theos; b=TVoA9
	0NDobgbjFzxXf5pyWuBbogYLbJ17V3lg46jFHlC0IGrIyFHZ79KTmtfin/zNCTnX
	/mgvjAhXLo6InzPk/l98LO+Swl742Tgbrj8fc4o1FsBxhOY09UY/H3AFFrAItEU7
	694DYAqOcgiAgg0RYAs5bAxR1vvkjqDK2Y3oi8=
Received: from leeloo.kyriasis.com (m77-218-250-201.cust.tele2.se [77.218.250.201]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id 985a9fb7;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Fri, 5 Jun 2015 14:12:13 +0000 (UTC)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433193883-11577-1-git-send-email-johannes@kyriasis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270835>

Since v1:
  * Added a test case

Johannes L=C3=B6thberg (2):
  receive-pack: Create a HEAD ref for ref namespace
  t: Add test for cloning from ref namespace

 builtin/receive-pack.c              | 12 +++++++++++-
 t/t9904-clone-from-ref-namespace.sh | 33 +++++++++++++++++++++++++++++=
++++
 2 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100755 t/t9904-clone-from-ref-namespace.sh

--=20
2.4.2
