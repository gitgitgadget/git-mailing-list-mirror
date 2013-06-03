From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v5 0/7] Rebase topology test
Date: Mon,  3 Jun 2013 13:42:08 -0700
Message-ID: <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
References: <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 03 22:42:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjbaK-0000d8-Im
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 22:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757714Ab3FCUm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 16:42:28 -0400
Received: from mail-qe0-f74.google.com ([209.85.128.74]:63138 "EHLO
	mail-qe0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544Ab3FCUm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 16:42:26 -0400
Received: by mail-qe0-f74.google.com with SMTP id b4so121195qen.5
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 13:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=o3XcC2xEVGDo0HTIEnekeaM6bNlSY9byFIxrG9hVSdA=;
        b=B6G6qnWC+tH90znwkHhsbXWIOVmluuWuBwkUTVWejomRbhhuD+Ox0Rs1CNfb04hX/u
         8zCK/inlbG2AsO5KyG+Dw9Xy9O2CAXn8XJpYJPXbkArfVpA2W6nrHWMXsCJK+GgLi/hg
         gzvDbtSoCqQiUim7k5TUd46jp3BFM3/HSdh9wCiA47iqiqvz4lkthSn9AXWQ5J0UrHxX
         y6yf/+cWCcWDQx9S8Rv+zYCRUTa+5L4DDbBjzOlJPiwxPn1iWwIEkRYsJtCQkt86FT1j
         GdiGTAbGZ6pN8MFNWBK+J4wZt6BUBF7x1S73/19Q/hq+hExEoHKRi5rKDXdZ+3CtHVgw
         b68A==
X-Received: by 10.236.87.79 with SMTP id x55mr14129962yhe.54.1370292146118;
        Mon, 03 Jun 2013 13:42:26 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id 10si3726147yhj.6.2013.06.03.13.42.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Mon, 03 Jun 2013 13:42:26 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id E498D31C1E2;
	Mon,  3 Jun 2013 13:42:25 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 41DF9101619; Mon,  3 Jun 2013 13:42:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.497.g83fddbe
In-Reply-To: <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQnNRzzKrtzgIYEPYpheinnfCI5nJPINXaX4zkuwqD/q3aClmeoCaZzOvX3kDnCPF+F+/uIpMxLvFXDB+W9pmdHGO6PehJn+uH+LdDO5wnXaZC/ZJrWBHTHnitZOy+BzcB04RiN/lVJpjNZh4Xni0curW0aHcENwsayVEcgfkBMex/htiLuk9f7FT+lpytwdsVEzFcF6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226278>

The only change since v4 should be that t3420 was renamed t3421.

Martin von Zweigbergk (7):
  add simple tests of consistency across rebase types
  add tests for rebasing with patch-equivalence present
  add tests for rebasing of empty commits
  add tests for rebasing root
  add tests for rebasing merged history
  t3406: modernize style
  tests: move test for rebase messages from t3400 to t3406

 t/lib-rebase.sh                   |  32 ++++
 t/t3400-rebase.sh                 |  53 +-----
 t/t3401-rebase-partial.sh         |  69 --------
 t/t3404-rebase-interactive.sh     |  10 +-
 t/t3406-rebase-message.sh         |  50 +++---
 t/t3409-rebase-preserve-merges.sh |  53 ------
 t/t3421-rebase-topology-linear.sh | 350 ++++++++++++++++++++++++++++++++++++++
 t/t3425-rebase-topology-merges.sh | 258 ++++++++++++++++++++++++++++
 8 files changed, 672 insertions(+), 203 deletions(-)
 delete mode 100755 t/t3401-rebase-partial.sh
 create mode 100755 t/t3421-rebase-topology-linear.sh
 create mode 100755 t/t3425-rebase-topology-merges.sh

-- 
1.8.3.497.g83fddbe
