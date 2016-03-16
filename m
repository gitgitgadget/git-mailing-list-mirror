From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH 0/1] http: Fix crash when passing malformed URL
Date: Wed, 16 Mar 2016 11:54:06 +0100
Message-ID: <1458125647-32707-1-git-send-email-anton.wuerfel@fau.de>
Cc: Anton Wuerfel <anton.wuerfel@fau.de>,
	Phillip@i4.informatik.uni-erlangen.de,
	"Raffeck <phillip.raffeck"@fau.de, i4passt@cs.fau.de,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 11:54:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag95t-0000Od-Ql
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 11:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050AbcCPKyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 06:54:22 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:55246 "EHLO
	faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753642AbcCPKyV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2016 06:54:21 -0400
Received: from faui49man2 (faui49man2.informatik.uni-erlangen.de [131.188.42.190])
	by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id D8BB458C4CC;
	Wed, 16 Mar 2016 11:54:17 +0100 (CET)
Received: by faui49man2 (sSMTP sendmail emulation); Wed, 16 Mar 2016 11:54:17 +0100
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288956>

When passing a malformed URL to http_init() in http.c, git dies from a null
pointer dereference. An example for a malformed URL is http:/git-scm.com (note
the single slash after the protocol).

I could not reproduce this error within any functions of git - I just noticed it
during development of a git extension together with Phillip Raffeck.

Anton Wuerfel (1):
  http: Fix crash when passing malformed URL

 http.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.8.0.rc1.108.g7827469
