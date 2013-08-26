From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v8 0/2] some enhancements for reporting branch tracking info
Date: Mon, 26 Aug 2013 15:02:47 +0800
Message-ID: <cover.1377500206.git.worldhello.net@gmail.com>
References: <7v7gfiojz7.fsf@alter.siamese.dyndns.org>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 26 09:10:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDqwL-0000go-RX
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 09:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756198Ab3HZHKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 03:10:12 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:62495 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755057Ab3HZHKL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 03:10:11 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so3117913pdj.1
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 00:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vE8yQdRORT6DA3r2maey5tpGHiBQt8vMAlCfNrhOsn8=;
        b=rbmylBr6dZv/Gvt9ioEQgiHp+IFIcqIPrzFBvWh63pJuTvWwBbtRl7xaCuPyPUB3M7
         AIys/h3BTr9D6LY/6z9hoG+0bDp5TbNUaGYFuivfb7H+QhsyW79tDz69F4wogqWUs3aF
         XOU+rYf+DpuNSdZ5W8tp40RnJrO5ZNzPmYDu/Cl7EIGqbTKMPhe/ha4uSBCZzMFI1dA5
         ph0NJDtWIx6rYsEhgpNIZi8R1vGCBcPHASuATML8CH34tgIm3Ljz9HBMMB8+4NipaYZr
         RdlZAJ3FPPhnZrY43dJ3LS9lrads9PNql8WsYITUdZrbSDuRlTNVyblZitFq7SADdhvM
         QtmA==
X-Received: by 10.66.139.166 with SMTP id qz6mr13128602pab.88.1377501008441;
        Mon, 26 Aug 2013 00:10:08 -0700 (PDT)
Received: from localhost.localdomain ([114.248.144.150])
        by mx.google.com with ESMTPSA id kd1sm17994787pab.20.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 Aug 2013 00:10:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.2.g434fd97
In-Reply-To: <7v7gfiojz7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232977>

Changes since v7:

* Squashed patch 1/3 and patch 2/3 into one big patch.

But not s/gone/absent/ as Matthieu suggested.

Jiang Xin (2):
  branch: report invalid tracking branch as gone
  status: always show tracking branch even no change

 builtin/branch.c         | 36 ++++++++++++--------
 remote.c                 | 72 +++++++++++++++++++++++++--------------
 t/t6040-tracking-info.sh | 89 +++++++++++++++++++++++++++++++++++++++++++++---
 wt-status.c              | 26 +++++++++++---
 4 files changed, 175 insertions(+), 48 deletions(-)

-- 
1.8.4.rc3.2.g434fd97
