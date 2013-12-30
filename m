From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/4] Fix branch.autosetup(merge|rebase) completion
Date: Mon, 30 Dec 2013 20:22:14 +0530
Message-ID: <1388415138-11011-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 30 15:52:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxeCS-0005wb-Vq
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 15:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755956Ab3L3Ovy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 09:51:54 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:58934 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882Ab3L3Ovy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 09:51:54 -0500
Received: by mail-pa0-f54.google.com with SMTP id rd3so11726864pab.13
        for <git@vger.kernel.org>; Mon, 30 Dec 2013 06:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=aKGSnDifAeI2fLipLCz1SeJ8O5JMhIArSG3YOQcih1s=;
        b=D5TTqzjoWWd3Wm6ND8Y4GuU5IDZT3LVK/RIAsOg3IBjx/9JTC609uYTxQfpeYpqtEV
         Pk2v5HN8OmGrfHnzWYPahZLc3OT9trkwPBMAMKvNm60vWBcHat3tQeuJ76oKzmoGGuJi
         hmxVg/N7EQ3rmIkOaC26E2RS6YSJDGd8NByoE69Uo13J583Wy0O8qDmpJtXJrgt/+pt7
         4VcRVoiNbYJl0KjSSmsbx7S/PXsuByZ/if4qVJ3+SgQz97Vc5EM1wsRywqVV8BOUExZa
         jkwl2jiloxVD7sO2zmlE3LjJZiUlUqYqaqsj2qaElF3/XiF8MEoKoUC3QIhC7eFtgRS/
         oklg==
X-Received: by 10.66.191.42 with SMTP id gv10mr10730014pac.125.1388415113702;
        Mon, 30 Dec 2013 06:51:53 -0800 (PST)
Received: from localhost.localdomain ([122.164.121.180])
        by mx.google.com with ESMTPSA id vn10sm82123744pbc.21.2013.12.30.06.51.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Dec 2013 06:51:51 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.227.g53f3478
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239803>

Hi,

I figured that branch.autosetupmerge, branch.autosetuprebase and
remote.pushdefault are very tedious to type out in full, and started
looking into fixing their completions this evening. The solution turns
out to be much more complex than I initally imagined, but I'm quite
happy with the solution.

I hope it's an enjoyable read.

Ramkumar Ramachandra (4):
  completion: prioritize ./git-completion.bash
  completion: introduce __gitcomp_2 ()
  completion: fix branch.autosetup(merge|rebase)
  completion: fix remote.pushdefault

 contrib/completion/git-completion.bash | 43 ++++++++++++++++++++++++++++++++--
 contrib/completion/git-completion.zsh  | 12 +++++++++-
 2 files changed, 52 insertions(+), 3 deletions(-)

-- 
1.8.5.2.227.g53f3478
