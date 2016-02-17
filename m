From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH v4 0/2] merge-recursive: option to disable renames
Date: Wed, 17 Feb 2016 01:15:24 -0200
Message-ID: <1455678926-15105-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 04:17:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVscj-0003qh-1g
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 04:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933756AbcBQDRs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 22:17:48 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33658 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933169AbcBQDRq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 22:17:46 -0500
Received: by mail-qk0-f176.google.com with SMTP id s5so1534046qkd.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 19:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=5rPKhGUiKMqPg65HtPIQnZQoHcYcEBsOJhi+oK8W3rU=;
        b=F6gPuD1zEELDqhLZFLJhjUQMayo3RVEXHJYDu6KxJ05Pl2dmcvhOf+40tv4mKnkOuW
         D0rVhEn9od4ajhJRgbzNCf9wdvue1/WaP/1E+7f4n5aeWhYxCyxwdzXcunM610lbp5r6
         UQbXNnZo97ZnjwpLOHkPzkFqBkbm5yjDr6nphOMyk6obLTa6ASHKiPwnYbXs68gC9eh8
         HveRCLmvKE2Ud6R0BSnMQop/M3jtlDRGAa0DQ2ijralOtX8srSlBwy/jBU9fOmZsQOzh
         Ngm0rzBU1qHH1EVzm0jh+1nPSy3Ulb/Zk2Z/Lv9u58CRA10uGzQ/GbkAh/MEjEA9hKeI
         fDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=5rPKhGUiKMqPg65HtPIQnZQoHcYcEBsOJhi+oK8W3rU=;
        b=VoryQqATudg9coJV4Fm/Ja/AxBjBMBCTdY+X9yz7tpCOP+M7sbYRcoaI64w5/4yQRZ
         xwYLvpTJmeHaXBAQjTzfLhM2vf2TZiwH3SeVolPmZjb99cInymnkjIj3fWHJEi77+uFN
         SaUmkVJc+1SUwQl1QONF7gueUZFGChOM9aQlvm1eQa32LM1jeLvAA2wsgZ3Jfi8/2Pcl
         FJcVF4xx7hhWSvBVafbLVDSbqZ1/VtaxYuuShjESdoPDsLwfNndhtu5TXUk9ZkFvh/EA
         3NbvrjarUhzvk+UH1BPb89DnL+aWoHYnLW1sGpmu1Qg/VDivm3JvvFNiUGw13BSG1aD2
         6y1g==
X-Gm-Message-State: AG10YOQdPYSxTnQBtaJMNJG9qxVutoihvnYytGpcgdY/rX1YHK40ZYRuZMX9d332dGSFPA==
X-Received: by 10.55.79.134 with SMTP id d128mr31440555qkb.73.1455679066086;
        Tue, 16 Feb 2016 19:17:46 -0800 (PST)
Received: from traveller.moon ([187.34.45.132])
        by smtp.gmail.com with ESMTPSA id b111sm14501148qge.47.2016.02.16.19.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 19:17:45 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.289.ga0c045c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286477>

Incorporate documentation input from Eric Sunshine. Fix missing signoff=
=2E

The first part is unchanged.

No tests are included for now. This work is being done in parallel and =
should
be properly included in future proposals.

=46elipe Gon=C3=A7alves Assis (2):
  merge-recursive: option to disable renames
  merge-recursive: more consistent interface

 Documentation/merge-strategies.txt | 12 ++++++++++--
 merge-recursive.c                  | 12 +++++++++++-
 merge-recursive.h                  |  1 +
 3 files changed, 22 insertions(+), 3 deletions(-)

--=20
2.7.1.289.ga0c045c
