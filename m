From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] Conflicting PREFIX usage
Date: Thu,  5 May 2016 22:28:52 +0100
Message-ID: <1462483733-3496-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git-for-windows <git-for-windows@googlegroups.com>
To: GitList <git@vger.kernel.org>, Self <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu May 05 23:29:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayQpe-0003FO-HG
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756135AbcEEV3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 17:29:05 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:28596 "EHLO
	smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755959AbcEEV3E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:29:04 -0400
Received: from localhost.localdomain ([92.22.61.226])
	by smtp.talktalk.net with SMTP
	id yQpRaUc28eSy4yQpRagc17; Thu, 05 May 2016 22:29:02 +0100
X-Originating-IP: [92.22.61.226]
X-Spam: 0
X-OAuthority: v=2.2 cv=bsEOPwSi c=1 sm=1 tr=0 a=PhzTUH1fCcwppfJjoMy/AA==:117
 a=PhzTUH1fCcwppfJjoMy/AA==:17 a=1ONsvdka4NMjdkHCuWAA:9
X-Mailer: git-send-email 2.8.1.windows.1
X-CMAE-Envelope: MS4wfI7vgFOllc9dkECLHpUYoHh/OXziKet9Tj9q3TnIS0m/gRs2fhODIu9UB6Chcp7ESsk0GorVWNjHh+tcppi4VCjRi9MhmQuhuXusp6FXZX0HAyUasfOD
 Q7qfQxltSXStJBkobYRDfrP6rrmcZ8tInU4yo5Xv9KT3TdVzXRDCXz4krDOpHrJBNSZV67lHCVGrdISw78Acu1KIpLEHzkHbT4wMMekfNWyAWgGwHIqjRK3F
 mRqOoduTpQz+5GVxIaVEjCTAcbUAZVDdpaZAyRnI2WEd3gtLeyB+i2Ego0dvQE6zFq8fOypcn9A471/BmnOFDH5Amdx4LpJLvNIDA7SKWyw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293682>

While trying to resurrect the MSVC/Visual Studio capability for Git
for Windows I noticed this little nuance.

The PREFIX in Windows was introduced in 35fb0e8 (Compute prefix at runtime
if RUNTIME_PREFIX is set, 2009-01-18) and in sideband.c at ebe8fa7
(fix display overlap between remote and local progress, 2007-11-04) though
clash has not been noticed before.

The attached patch simply gives the two PREFIXs more purposeful names of
EXEC_PREFIX and DISPLAY_PREFIX.

Philip Oakley (1):
  exec_cmd.c, sideband.c, Makefile: avoid multiple PREFIX definitions

 Makefile   | 2 +-
 exec_cmd.c | 4 ++--
 sideband.c | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.8.1.windows.1
