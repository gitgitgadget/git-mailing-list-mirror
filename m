From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/3] preparatory patches for the submodule groups
Date: Mon,  2 May 2016 15:24:01 -0700
Message-ID: <1462227844-10624-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Tue May 03 00:24:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axMGH-0003lb-Gy
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 00:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216AbcEBWYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 18:24:12 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34435 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166AbcEBWYM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 18:24:12 -0400
Received: by mail-pf0-f182.google.com with SMTP id y69so1004391pfb.1
        for <git@vger.kernel.org>; Mon, 02 May 2016 15:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=6KB9V1Q6ZUHLTZiNnep5WOxNvSRVzMqmhN+BC22G1hg=;
        b=DaJEqydlm7BoDiXumqoO2ZfomwFXDRkcDorl+SaabA9etC/pgTTBlfN30BuaImYLC8
         XWg/D/xQxMATMHV/0XN1HAYBrafwYMtpplMBxyftGcByxX3pMW/wpD1Y6u+zlRj729l9
         TsfJhEWDAAV5+KJG1H60J1r6WV1y5z66ytQZVFq+Hxwsx/spsd/fQ95r5WhjoqF/EEZM
         t+XT2bDDn2kwvxZC/jA9BsGiksINRQAs+IfSCxakN46mCeaMGNmLDhbDUl51wHTo6DFn
         yM6TmoDRmF6ayvyr3Vh4AKPQL01G47dbdLhPnAAn6Zqd1uFnsUEdsVP+tVRim7+JOQHN
         ZgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6KB9V1Q6ZUHLTZiNnep5WOxNvSRVzMqmhN+BC22G1hg=;
        b=BjEDshJR5tKonm+yczv4b3sy4vGohwt3Py1BhbTtqM8z9N8t+t+/eFep7UIWI5rZCY
         qAyK4HKtAOAkCop3aLML2l6IbV3sGkoqGKz7JgHClm18NsJm4Nrz2CA0F3DBPmoV4uM2
         IKRW02IBnBWERAaNjvxqDbKZoDLuAC+HMukqHpkvIKJT5S7v6+aEwXKhojtZTRRspSEN
         rJbaWoRPuOd3LCmNDse1YnywjW5gHkTsRJ0pmzKTTGei14+rMZ5E6HitSWxViOTrDw4u
         6+DsNwcPdyhJC0mwwTx3YE8NGbv71JQRZ3Sr3SeA5mv5y1lOJYmu9a26EjY1UuLOa2g0
         YBWA==
X-Gm-Message-State: AOPr4FUOTw3gE6Ljz9SlM6uTBCljt71zKNf+YWbUUdaphWNDQ91DvVS6eQuTJm1D4kcKY2NI
X-Received: by 10.98.9.83 with SMTP id e80mr55282239pfd.34.1462227850932;
        Mon, 02 May 2016 15:24:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9831:74f0:67fd:61ba])
        by smtp.gmail.com with ESMTPSA id d184sm295656pfc.27.2016.05.02.15.24.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 02 May 2016 15:24:10 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.37.gb114fff.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293296>

These patches build on top of origin/sb/submodule-init and are preparatoy for
the submodule groups series. Junio asked to send these preparatory patches
as its own series to have a better mental focus when reviewing the groups
series later.

When sending out a similar series end of last week[1], I went to far and included
some questionable patches in the series, this series is about the minimum needed.
(patch 1 is a test suite correctness patch, which would not be strictly needed)

Thanks,
Stefan


[1] http://thread.gmane.org/gmane.comp.version-control.git/293087

Stefan Beller (3):
  submodule deinit test: fix broken && chain in subshell
  submodule deinit: lose requirement for giving '.'
  submodule init: redirect stdout to stderr

 builtin/submodule--helper.c |  3 ++-
 git-submodule.sh            |  5 -----
 t/t7400-submodule-basic.sh  |  7 +++++--
 t/t7406-submodule-update.sh | 24 ++++++++++++++++++------
 4 files changed, 25 insertions(+), 14 deletions(-)

-- 
2.8.0.37.gb114fff.dirty
