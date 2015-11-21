From: Luke Diamand <luke@diamand.org>
Subject: [PATCH v2 0/2] git-p4: allow submission from detached head
Date: Sat, 21 Nov 2015 09:54:38 +0000
Message-ID: <1448099681-20183-1-git-send-email-luke@diamand.org>
Cc: larsxschneider@gmail.com, Junio C Hamano <gitster@pobox.com>,
	peff@peff.net, sunshine@sunshineco.com,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 21 10:55:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a04so-0007p6-La
	for gcvg-git-2@plane.gmane.org; Sat, 21 Nov 2015 10:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759558AbbKUJy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2015 04:54:56 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36016 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbbKUJyx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2015 04:54:53 -0500
Received: by pacdm15 with SMTP id dm15so141300358pac.3
        for <git@vger.kernel.org>; Sat, 21 Nov 2015 01:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fvfxi2hayzvStPgzB96jJf8ZOMN1PwFKxEw0DMHbSyw=;
        b=PrieKU1UokyzwgVtRSnTG7RJDVls2s08JN996SdPTqBdqjbMAn3s3Z5TcRJqGQrb4b
         eGKCPgPRmxBszJN+Li+mMIYPu995f8U66/+v5fqLdocL/koOac/VIEcxaZW23wEnkEHt
         5wd99l79ODU7EicY83nJHAnbI8ox0LOKbih9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fvfxi2hayzvStPgzB96jJf8ZOMN1PwFKxEw0DMHbSyw=;
        b=AaRuXvkdpatEFAIvpi1VdvwnUd8x/0IX7v88n+8dUJzuUMzyujTtawpKLMFyBdZK8E
         Xp/0KA1DMUn9W8H1hZRkzFA+3v/62vrcdMZacCHveh8vt5yUQS4tcM5582fz/73E6SHk
         DG1bq15fnAj9QgHPZNyhtdKvXh/DPoYJxJwXjQCBoGp09Spxk/TzvUOxr3GjyT0BG9A+
         16u00mjr2lhF22SpgDKvO6JlSzWMAHGgcGeEPWAccduAO5EcvTCWUPZi9bIKlmaq6UQ4
         x2MKFDqidwssrF14+HbDVCHWERZehwXVz0EKm7vRSiivQs6D1nfKwJ88WH47W0Z02+Zp
         JOwA==
X-Gm-Message-State: ALoCoQn6bPlMJqJuRVki/Us/IS9cd9pmX1oWcPkNBDqNvlQJndRfigGbsGsyNQ4hQd/dgu6tXtgY
X-Received: by 10.98.12.151 with SMTP id 23mr4575332pfm.60.1448099693295;
        Sat, 21 Nov 2015 01:54:53 -0800 (PST)
Received: from lgd-kipper.corp.roku ([216.38.147.4])
        by smtp.gmail.com with ESMTPSA id xi8sm2949984pab.9.2015.11.21.01.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Nov 2015 01:54:52 -0800 (PST)
X-Mailer: git-send-email 2.6.3.492.g06488d6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281548>

I'm resending my reroll of my earlier patch to teach git-p4
about detached heads.

It uses Junio's suggestion of calling "git symbolic-ref"
to determine if we're on a detached head, rather than
parsing text strings.

Luke Diamand (3):
  git-p4: add failing test for submit from detached head
  git-p4: add option to system() to return subshell status
  git-p4: work with a detached head

 git-p4.py               | 29 ++++++++++++++++++++---------
 t/t9800-git-p4-basic.sh | 16 ++++++++++++++++
 2 files changed, 36 insertions(+), 9 deletions(-)

-- 
2.6.0.rc3.238.gc07a1e8
