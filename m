From: larsxschneider@gmail.com
Subject: [PATCH v5] git-p4: Obey core.ignorecase when using P4 client specs.
Date: Mon, 24 Aug 2015 23:30:04 +0200
Message-ID: <1440451805-85095-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, pw@padd.com, torarvid@gmail.com,
	ksaitoh560@gmail.com, tboegi@web.de, sunshine@sunshineco.com,
	gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 23:30:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTzJq-0006DH-7C
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 23:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295AbbHXVaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 17:30:10 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37013 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020AbbHXVaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 17:30:09 -0400
Received: by widdq5 with SMTP id dq5so83569204wid.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 14:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=BieaWxqb1kc+kwMa5aX1W5mr27x10K8STTs96ETttSg=;
        b=NiGngldq2Flu/bLy8Q41PmerjKGZRC7XMeTKaUKC8XiPWA7DlBGac1prSFKpI0GMnA
         +jQzvPtksQQs6tu6LHRh3msnnUKIR4hgHwTbl+brSCYBAXtgdf/3jiuGjU5Gdkm4vDQM
         PeJRnF5l1ojm/MPcfossdZcRplpfjY+lTRTywNrNoHevRubz+O+2glptckyouiHxKScG
         ofsPn75qlqUrtojP4zrnHKtKuwOQ0Ql8JG0/++AhCUbHHFOFt8S+l4MGGm+DFsJCCY64
         sMfMhkpiIzDj0WAWNzQY/IEJGCqSvKdyafFEmvvAjSTgWjIKspJrjVAAF360d+Th1XHG
         Op7g==
X-Received: by 10.180.87.230 with SMTP id bb6mr17427130wib.26.1440451808310;
        Mon, 24 Aug 2015 14:30:08 -0700 (PDT)
Received: from slxBook3.fritz.box (dslb-178-008-041-000.178.008.pools.vodafone-ip.de. [178.8.41.0])
        by smtp.gmail.com with ESMTPSA id ft5sm17965584wib.4.2015.08.24.14.30.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Aug 2015 14:30:07 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276488>

From: Lars Schneider <larsxschneider@gmail.com>

Thanks to Luke Diamand I realized the core problem and propose here a
substiantially simpler fix to my PATCH v4.

The test cases remain and prove the problem. In particular
"8 - Clone path (ignorecase)" and
"Add a new file and clone path with new file (ignorecase)" fail with the
current implementation on OS X and Linux.

Lars Schneider (1):
  git-p4: Obey core.ignorecase when using P4 client specs.

 git-p4.py                         |   7 ++
 t/t9821-git-p4-path-variations.sh | 200 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+)
 create mode 100755 t/t9821-git-p4-path-variations.sh

--
1.9.5 (Apple Git-50.3)
