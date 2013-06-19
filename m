From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 0/7] Re-roll rr/rebase-checkout-reflog
Date: Wed, 19 Jun 2013 13:34:42 +0530
Message-ID: <1371629089-27008-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 19 10:08:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpDRK-0001ly-8I
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 10:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671Ab3FSIII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 04:08:08 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:39669 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755576Ab3FSIH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 04:07:58 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so4817259pbc.2
        for <git@vger.kernel.org>; Wed, 19 Jun 2013 01:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=srS+WJfsX68ibeBrfzVVg3VQPM6jIrM/HHb16xOIE/Y=;
        b=E7MOw6kK4lyQK1NbkpqbTH1NIQPZ6HPFrOeK0BFveQOxi5phQLUEV5B4j4qGxVp/R3
         L7ofhOAb/36fF+wlUvoX0a9ZSz0Cp5oPizlD8FdRcrKUMpizP1fg4NTxwfkp1m1lyjcE
         6+VCnOONOvgQBLDjddz5t7i1PuuynaiyRbGjsusrG0oNjijzQNY5s4+KkORtZPyNh1im
         C5VSoDQ+7CZ1aKy+eb9CeOdCp6avqqKvnWkHJc6GCqHeVCG/wluw7yLyRgmOYR7FFye4
         vRwUXYJ5oTxkmdY8m4QK8qGkgTlclNRGs5UFfLBCasncfqkT31BkrMxlzYNK6pmD6fSb
         h7jw==
X-Received: by 10.66.122.8 with SMTP id lo8mr5436108pab.165.1371629277665;
        Wed, 19 Jun 2013 01:07:57 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id vz8sm23663400pac.20.2013.06.19.01.07.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 01:07:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.449.g41b32a4.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228371>

So, this is hopefully the final re-roll.  [6/7] and [7/7] have updated
commit messages and comments describing what this new
base_reflog_action is.  Also, to prevent breakages with another
in-flight topic, the test that Junio contributed to [7/7] uses a
different branch name.

Thanks.

Junio C Hamano (1):
  t/t7512-status-help: test "HEAD detached from"

Ramkumar Ramachandra (6):
  wt-status: remove unused field in grab_1st_switch_cbdata
  t/t2012-checkout-last: test "checkout -" after a rebase
  status: do not depend on rebase reflog messages
  checkout: respect GIT_REFLOG_ACTION
  rebase: write better reflog messages
  rebase -i: write better reflog messages

 builtin/checkout.c            | 11 +++++++---
 git-am.sh                     |  4 +++-
 git-rebase--am.sh             |  7 +++++++
 git-rebase--interactive.sh    | 14 +++++++++----
 git-rebase.sh                 | 18 +++++++++++++++--
 t/t2012-checkout-last.sh      | 34 +++++++++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh | 15 ++++++++++++++
 t/t7512-status-help.sh        | 47 ++++++++++++++++++++++++-------------------
 wt-status.c                   |  7 ++++---
 9 files changed, 123 insertions(+), 34 deletions(-)

-- 
1.8.3.1.449.g41b32a4.dirty
