From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v7 0/3] some enhancements for reporting branch tracking info
Date: Fri, 16 Aug 2013 10:29:31 +0800
Message-ID: <cover.1376618877.git.worldhello.net@gmail.com>
References: <7vzjsio99d.fsf@alter.siamese.dyndns.org>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Aug 16 04:31:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA9pA-0007Xa-LO
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 04:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461Ab3HPCb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 22:31:26 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:38447 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438Ab3HPCbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 22:31:25 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so1474000pbc.37
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 19:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UX5d6UU8mb2gGjIPF7s2yoZMOgnFh6/ql+ydjUdFn3g=;
        b=LnPRUcdzxEUA+s1JPC2DhOmXZpp8QGoyAzg4WyugnLC6dfg8F/26cc2cAIumMrvIl0
         q2BLqpRk3u6PHHEbbIt3rGyC8fNilAAo5oIQmptuc4LoK+vO22IAdyJqDfDZDRN7OgVy
         qpDKoNPihggS1vDXLQrRrCUmZHx6/kRHl+Pb6N0p2lSaLmF3VZYxjpjJrYA+X+89XpTw
         NhnncMFNMFs5WsTFqeZ6mL0JrG9XEpNoc64DKIPo7x6zrny+71HB3lqCDt2hdF5oJ6iN
         76sRkDfgiNEzhi4GKNHNINfvVAhOzp6O+vwL2+PUxJOjrvgLzUzJeCUWBAlA4uxz0dm5
         Rl/A==
X-Received: by 10.68.211.233 with SMTP id nf9mr18867366pbc.26.1376620284119;
        Thu, 15 Aug 2013 19:31:24 -0700 (PDT)
Received: from localhost.localdomain ([114.246.129.124])
        by mx.google.com with ESMTPSA id pw9sm2698975pbb.20.2013.08.15.19.31.20
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 15 Aug 2013 19:31:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc2.479.g44abce8
In-Reply-To: <7vzjsio99d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232392>

Changes since v6:

* s/broken/gone/ in [PATCH 2/3] (branch: mark missing tracking branch
  as gone)

* rewrite commit log for [PATCH 3/3] (status: always show tracking
  branch even no change)

Jiang Xin (3):
  branch: not report invalid tracking branch
  branch: mark missing tracking branch as gone
  status: always show tracking branch even no change

 builtin/branch.c         | 36 ++++++++++++--------
 remote.c                 | 72 +++++++++++++++++++++++++--------------
 t/t6040-tracking-info.sh | 89 +++++++++++++++++++++++++++++++++++++++++++++---
 wt-status.c              | 26 +++++++++++---
 4 files changed, 175 insertions(+), 48 deletions(-)

-- 
1.8.4.rc2.479.g44abce8
