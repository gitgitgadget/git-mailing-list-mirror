From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/3] hash-object crash fix and new doc and tests
Date: Mon,  4 May 2015 03:25:12 -0400
Message-ID: <1430724315-524-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 09:25:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpAl2-0005Bm-WF
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 09:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbbEDHZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 03:25:37 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:34448 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbbEDHZf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 03:25:35 -0400
Received: by iedfl3 with SMTP id fl3so140468893ied.1
        for <git@vger.kernel.org>; Mon, 04 May 2015 00:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=9+zhXNauVyLX51PuBIE+c0OK47FhrpbwQYhm42hBw80=;
        b=1BjC7ZarzoahMDKMt1e/O3p2YxQIrZd7IUgzkQxFaSyclB3MjqZjgi6/g1UcFQvG/a
         sYfxeSSadJmus4EUxIMQv21JQ5cXWfs3yxhbehWS2UQBnUZ1Gy60RlAH1eY/sKna66gs
         zj258encJ58j+b6FqWzdlDsxCk0s1Xap40WBoiZ94hVRPRaLdhzW3wjqI97C0K5Jwul4
         2/kVPOICRSZL9qVj4CocWTMq+1xBmbSM1YTDHG2Shsi+WHK1hRYKuRd41KncNi7Aj8Pw
         ZPSKHI6ga9LQl40wa4cKRYbLdXBDzNSghQNFh7TLQ0S2hBXpojoB/OoA+Prn2Hm1e73O
         AA1w==
X-Received: by 10.42.132.200 with SMTP id e8mr26006022ict.86.1430724334802;
        Mon, 04 May 2015 00:25:34 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id r4sm4707630igw.12.2015.05.04.00.25.34
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 May 2015 00:25:34 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.319.g7a04823
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268306>

This patch series fixes a buffer overrun triggered by an extra-long
bogus object type specified via hash-object --literally.

It also adds documentation and tests which were missing from the initial
series which introduced "hash-object --literally".

Eric Sunshine (3):
  git-hash-object.txt: document --literally option
  t1007: add hash-object --literally tests
  write_sha1_file_prepare: fix buffer overrun with extra-long object
    type

 Documentation/git-hash-object.txt | 10 ++++++++--
 sha1_file.c                       | 21 ++++++++++-----------
 t/t1007-hash-object.sh            | 11 +++++++++++
 3 files changed, 29 insertions(+), 13 deletions(-)

-- 
2.4.0.319.g7a04823
