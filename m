From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv3 0/3] Implements the GIT_TRACE_CURL environment variable
Date: Wed, 20 Apr 2016 16:28:22 +0000
Message-ID: <20160420162825.62380-1-gitter.spiros@gmail.com>
Cc: tboegi@web.de, ramsay@ramsayjones.plus.com, gitster@pobox.com,
	sunshine@sunshineco.com, peff@peff.net,
	Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 18:28:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asuzV-0000N1-1A
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 18:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbcDTQ2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 12:28:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34529 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbcDTQ2b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 12:28:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id n3so15268973wmn.1
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 09:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=fNPI6lZ2iFgniVUe/NvyS1+BRRElLwXWQdLnPNmcldc=;
        b=j7Mwb21gPvmzj+EzGaBGpKaizWw20YAIrFLg/NyHn45WnSdeVQ1KfXPMMV19D3R+gi
         jCResgqoHUTxJkKCjQcMEVR9qDT+t1TrhTqw7bEgwEoVHL1X1pUJNlgiPIeQJ4foiWOq
         q8gYlQsD/fns8mv2EDcKF1YLQdv2Le5mVF0SQ8Iwb0mnkMWuHd2HAr/U2sNgSlvfVljX
         Xg+IiJECS05LnoHmCzMmPgLTe09O2dtLjIVAruG5LfGgfvY2tWtGMgt3EOiYakwvLr+L
         ilgLomIbCep2PKVfFUr/6QASpkzabmBDeSxM3QlU0iCdjVqjHGDjeSDD/IfNLaCdpJ1d
         qFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fNPI6lZ2iFgniVUe/NvyS1+BRRElLwXWQdLnPNmcldc=;
        b=f1Pb6DjVxDUMdo75lYnMMZLRWvmePt4XuaNc9mfcCfwpNRPxVTiGHIkznJEnWl+goF
         CLbh2l1BnG164PLcD0Y8s0/07PcCbFGmFRv1Ki4dVR/bjxu68Nh8kC63ymcTr+VHm8+a
         a6+AzqeKqnCuRx88DRG80Z5R6R8pGcGMbeLy+R+X5OsP+38Ua7NnB8NCENHzqNzbm05p
         y6zVmmpsOQOCz50x2b5kuVTmnI+A2VCUrqQEZCXYak4S+9IxGqwxJL/qvN7oesE71fEt
         VCalbPXiZTawNrlCEWA+/XiTlcs3i96TsWuZE3g2mAt1fNl8967i9tPUHthYPF5DXpTv
         x5qg==
X-Gm-Message-State: AOPr4FWDbfdnWYHk9bfDzMRPBQHZgGfsz1x1+xfRdFrAb2Ay8H2MR6xA3sRiECq4Q9ZwWg==
X-Received: by 10.194.133.161 with SMTP id pd1mr11057821wjb.66.1461169710000;
        Wed, 20 Apr 2016 09:28:30 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id qt3sm6368445wjc.32.2016.04.20.09.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Apr 2016 09:28:29 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.383.g31b84cc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292040>


This is the third version but in reality is the complete rewriting of the patches discussed here
(here called V1)

$gmane/290520
$gmane/290521

*Changes from V2
($gmane/291868)

- fix garbage comment in http.c (i am very sorry for that)
- add final '.' to the commit message for imap-send.c and to other commit messages
- typofix double ; in http.c
- merge the nice cleanup and code refactoring of Ramsay Jones (Thank you very much !!)
- squash the previous commit 2/4

*Changes from V1

- introduced GIT_TRACE_CURL variable with its documentation
- changed the name of the temporary variable "i" in "w" in the helper routine
- used the c escape sequences instead of the hex equivalent
- dropped the previous GIT_DEBUG_CURL env var
- curl_dump and curl_trace factored out to a shared implementation
in http.c

Elia Pinto (3):
  git.txt: document the new GIT_TRACE_CURL environment variable
  imap-send.c: introduce the GIT_TRACE_CURL enviroment variable
  http.c: implements the GIT_TRACE_CURL environment variable

 Documentation/git.txt |   8 ++++
 http.c                | 101 +++++++++++++++++++++++++++++++++++++++++++++++++-
 http.h                |   6 +++
 imap-send.c           |   6 +++
 4 files changed, 120 insertions(+), 1 deletion(-)

-- 
2.8.1.383.g31b84cc
