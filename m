Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D26BD1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 23:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfGAX2b (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 19:28:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44681 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfGAX2b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 19:28:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so7275322pfe.11
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 16:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=dBsezipqesHxhYYfbaCRw8uz8c7SFwpyRYAxWKEHW28=;
        b=XBv6AYeTq6If3FS2vawtSJqLljhKj0Hk+gtxAtuxbwbmDMWwtQlzPKBQqmc4g2ZY75
         23dUamR5QlptOz9SwHZitvbjG9xlVeA+fHm74HCi09OnuSHdNV4F0nT5nERd9Vd4YTeC
         +jGcJwSBd/iTwF96uqSAqdBRybtSx6POb1Ep3/jmC36towUGVR1BFlK00H5e5RO7352R
         KVptdKrHOxGDRiXsgYdVi4nS5y5pLvEq8h202DgM8Ur3i8MorugPE8WJoywk7RlJv8ru
         Bt+yMPQRXgeK/KVyn4LDn3RH346yIHIwA6ZJ9hls5A5vKiz2AqmwWpXavwpv4/k+ZQZ2
         Y9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=dBsezipqesHxhYYfbaCRw8uz8c7SFwpyRYAxWKEHW28=;
        b=Pd9XsX9XxmwZvmgWPU1acf5Pol6k8XQGMMRy6LZqDAYXmnWRPj2Zqq1LU2Q/qrvklP
         L7JZm+MoCknM3I10JyUI2XRq1Sv8U0fF2SRAnLjlT0YM6ZIjl5ig6SzAfBQQP5upGsHI
         VfGcpZ9n/F8pMtU0i8QBDmDf7VCHfFWFZNn1f1jMmtALO2t+2zhgAEbQhpYiYrZjIOxI
         Agi5hvudi/U6v7zQKkinAC5x7lTcn8tlWlioS6pzDB/8QMOhH+PMhwTFheWMPVOA8tNE
         7fSedEB+Quab5qRCrVXz87mXe7qkc8yObc/MEjgqBIinHdQOirezzaxtSlMfoflnVUEo
         ZUCA==
X-Gm-Message-State: APjAAAXvA+3noSEuTWBSKV/DGMumOU7trPY4BKcp5/skuYaO5hpjuTCX
        gwXaSeEx3YhEc9CgWoserAQ+NAjBC9l7jw==
X-Google-Smtp-Source: APXvYqyv59RDzJsvpktpTo21P/POmcoWu0JxhhSrQ3aHo1ykPSwEC2f/E7RETXIPQl4WzEYeULlrDg==
X-Received: by 2002:a65:530c:: with SMTP id m12mr27596976pgq.363.1562023710743;
        Mon, 01 Jul 2019 16:28:30 -0700 (PDT)
Received: from aermolenko.office.atlassian.com ([103.233.242.9])
        by smtp.gmail.com with ESMTPSA id e5sm8713051pfd.56.2019.07.01.16.28.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 16:28:30 -0700 (PDT)
From:   Anton Ermolenko <aermolenko@atlassian.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: [QUESTION] Git fails to detect merge conflict?
Message-Id: <E42B8D46-0CA0-44E0-946F-8ADA96993629@atlassian.com>
Date:   Tue, 2 Jul 2019 09:28:26 +1000
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello folks,

I'm writing on behalf of a customer and I wonder if you could help me to =
clarify
if the following test case should be considered a bug or if it is =
expected
behavior.

  # create repository
  git init
  # add initial content
  cat << EOF > example.txt

--- START ---
  LINE 1
  LINE 2
  LINE 3
---  END  ---

EOF
  # commit the changes
  git add example.txt && git commit -m "Initial Commit"

  # create a branch
  git checkout -b change-a
  # introduce a change
  cat << EOF > example.txt

--- START ---
  LINE 1
  LINE 2
  LINE 3
  LINE 4
  LINE 5
  LINE 6
  LINE 7
  LINE 8
  LINE 9
---  END  ---

EOF
  # commit the change
  git commit -am "change a"

  # return to master and create another branch
  git checkout master && git checkout -b change-b
  # introduce another change
  cat << EOF > example.txt

--- START ---
  LINE 1
  LINE B
  LINE 3
  LINE D
  LINE E
  LINE 3
---  END  ---

EOF
  git commit -am "change b"

At this point the "change-a" diff with master is:

diff --git a/example.txt b/example.txt
index 1cebaff..605f2b0 100644
--- a/example.txt
+++ b/example.txt
@@ -3,5 +3,11 @@
   LINE 1
   LINE 2
   LINE 3
+  LINE 4
+  LINE 5
+  LINE 6
+  LINE 7
+  LINE 8
+  LINE 9
 ---  END  ---

and "change-b" diff with master is:

diff --git a/example.txt b/example.txt
index 1cebaff..cf5c0b2 100644
--- a/example.txt
+++ b/example.txt
@@ -1,7 +1,10 @@

 --- START ---
   LINE 1
-  LINE 2
+  LINE B
+  LINE 3
+  LINE D
+  LINE E
   LINE 3
 ---  END  ---

If a user to merge branches with "no-fast-forward" strategy, git does =
not detect
a conflict:

  # merge change-a first
  git merge --no-ff -m "merge change-a" change-a
  # merge change-b now
  git merge --no-ff -m "merge change-b" change-b

And the resulting content of "example.txt" is:

--- START ---
  LINE 1
  LINE B
  LINE 3
  LINE D
  LINE E
  LINE 3
  LINE 4
  LINE 5
  LINE 6
  LINE 7
  LINE 8
  LINE 9
---  END  ---

My understanding is that recursive merge here won't consider that =
situation to
be a merge conflict as the changes have been introduced in different =
spots in
the file.

Am I correct or is this a bug?

Thank you,
Anton.

