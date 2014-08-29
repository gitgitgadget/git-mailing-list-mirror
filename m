From: Maxim Bublis <satori@yandex-team.ru>
Subject: [PATCH v2 0/2] fast-import: fix segfault and filedelete tests
Date: Fri, 29 Aug 2014 15:53:35 +0400
Message-ID: <1409313217-23198-1-git-send-email-satori@yandex-team.ru>
Cc: Junio C Hamano <gitster@pobox.com>,
	Maxim Bublis <satori@yandex-team.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 13:54:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNKko-00072E-Gz
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 13:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbaH2Lx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 07:53:57 -0400
Received: from 95.108.175.165-red.dhcp.yndx.net ([95.108.175.165]:60401 "EHLO
	95.108.175.165-red.dhcp.yndx.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751678AbaH2Lx4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Aug 2014 07:53:56 -0400
Received: by 95.108.175.165-red.dhcp.yndx.net (Postfix, from userid 1533206276)
	id 13622205B38E; Fri, 29 Aug 2014 15:53:49 +0400 (MSK)
X-Mailer: git-send-email 1.8.5.2 (Apple Git-48)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256145>

Removing root tree with filedelete command would lead to segmentation fault
in store_tree(). First patch from patch series adds filedelete command
tests with test case to show incorrect behaviour on filedelete root operation.
Second one fixes bug by sanity check and load_tree() usage.

Maxim Bublis (2):
  t9300: test filedelete command
  fast-import: fix segfault in store_tree()

 fast-import.c          |   6 ++-
 t/t9300-fast-import.sh | 104 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 1 deletion(-)

-- 
1.8.5.2 (Apple Git-48)
