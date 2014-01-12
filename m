From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/3] Minor preparation for @{publish}
Date: Sun, 12 Jan 2014 22:41:03 +0530
Message-ID: <1389546666-17438-1-git-send-email-artagnon@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 12 18:10:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2OYm-0007jf-AN
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jan 2014 18:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbaALRKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jan 2014 12:10:48 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:46298 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbaALRKq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jan 2014 12:10:46 -0500
Received: by mail-pd0-f178.google.com with SMTP id v10so10697pde.9
        for <git@vger.kernel.org>; Sun, 12 Jan 2014 09:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5rZN2PHN21exqeoGIVGjfKDMSeAMp2/N5ZCTaMgtWps=;
        b=sO8pRJZGp31gbIKV6jBCX38k5G/ueFc9+LWVsZYEeIi0r3U9wrNXxEfUuhwHDPYZc/
         qUtVc0w6yYq4Rkdchk+5BoeuwGNspoYT7zt/+stLRInTAgDd/kKNVoqiL/EzSLL87/1W
         knblBS4dQdE1kuvQ4t+wXIZMUnDGDQysesqiDrVzLIZpmHN6GT1BNc3UJzn0E0nJEITw
         MUeZTpddVxRv6y76UIzQEFE2wujvCvtfIKcPWqD5ZPUrQBrE1ezCzw5zGwVKStL/mB6S
         bmxVCkX8VKtUISsNufuNr2cd5nFN5M+Bwph822+ggrLY4DGj6OevKs0qLZWSrnzB/tei
         814Q==
X-Received: by 10.68.197.165 with SMTP id iv5mr3980192pbc.150.1389546645577;
        Sun, 12 Jan 2014 09:10:45 -0800 (PST)
Received: from localhost.localdomain ([122.164.134.24])
        by mx.google.com with ESMTPSA id gn5sm14690070pbc.29.2014.01.12.09.10.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Jan 2014 09:10:45 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.313.g5abf4c0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240349>

Hi,

I'm getting ready to switch timezones in a few days, so the @{publish}
series is on hold for some time. In the meantime, I thought I'd send
in a few patches early.

[1/3] is a minor typo fix I happened to notice while writing tests.

[2/3] is an is an excellent patch by Peff, that greatly helped
prettify the code. It's a pure refactor and should have no effect on
functionality.

[3/3] introduces branch->pushremote corresponding to branch->remote,
which is crucial for getting @{publish} from the branch_get()
interface. Peff had sent a similar patch, but mine has some subtle
differences.

Thanks.

Jeff King (1):
  interpret_branch_name: factor out upstream handling

Ramkumar Ramachandra (2):
  t1507 (rev-parse-upstream): fix typo in test title
  remote: introduce and fill branch->pushremote

 remote.c                      | 15 ++++++--
 remote.h                      |  3 ++
 sha1_name.c                   | 83 +++++++++++++++++++++++++++----------------
 t/t1507-rev-parse-upstream.sh |  2 +-
 4 files changed, 68 insertions(+), 35 deletions(-)

-- 
1.8.5.2.313.g5abf4c0.dirty
