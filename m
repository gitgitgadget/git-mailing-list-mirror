Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2CD920189
	for <e@80x24.org>; Sat, 18 Jun 2016 12:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbcFRMZY (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 08:25:24 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33916 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbcFRMZX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 08:25:23 -0400
Received: by mail-pa0-f67.google.com with SMTP id us13so7557057pab.1
        for <git@vger.kernel.org>; Sat, 18 Jun 2016 05:25:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=chP+cDa2Cb3VaqrkBnBkUzl4wMKEdKgnAsOtPkHFbkY=;
        b=aKgvR4bwVbCosb/TbtpV1XXAsIJ0kzQaC6JuKHAtJMj24rw876SlTa9SoL6rQjzQm+
         VXgFB9j/3nXbzwCCHLcGUwPIomdTR6udrTMF/f+PRLnYmuX0QzegYFL/5D/6Dnpl83+T
         KZqnaOG38QrbfLwnjDTMHikta0qhhPlkJ+484u0o9FeBqVFIIbc+9Uhz3MJljrabTVzT
         fJKEhpxZWnL/s9giCMTcucyZYAV8g7Xx2A8iPVxLGSTElX1eYbRQgO9Hvv3kkH1Xgl+8
         tAg0r8O2YqQMsLM+iVU36buzouX/NFSrYLRxHtvmSowwU3xsYs1BrxGw1g5XNZtw/LJc
         AXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=chP+cDa2Cb3VaqrkBnBkUzl4wMKEdKgnAsOtPkHFbkY=;
        b=ZtWi9W7/+wT4+nyNM4XXYjlfToRHx9a2jU807hEfEgaxscjB4fKse5vHWjuKJ+xt7B
         M1qBI66LlW+nCwS2gxeALAEQplDAt3yyrf/Rn0P/1gOarDZHAYnC58b68o05Rrc7NFPD
         zu1TrNjfvFs61l9gOqRI3c10QptIOw31wN5FGu8ZmVLY67bWS/iijhxhbT6eSgr/q5BM
         cPOKtqwOBsy7X25LTcTy+aKT11Ej3iraLVwEZJHLLU5vPJOB185bAHJFWeE5eB0sN3O8
         YQGkH2IKeqAQ3Loh0WmgmZbbExEz47K5rx3V+qM2aOOLec9Qm6MjRw/9zjdhSjmrQRFK
         +WZg==
X-Gm-Message-State: ALyK8tJ7aRr5OpF5cq5GGMQD8Ftgz0HNMP0FQUUmfOCojQXZLlxDt+hE+9Af1k0TypoVUQ==
X-Received: by 10.66.101.136 with SMTP id fg8mr8751360pab.144.1466252723001;
        Sat, 18 Jun 2016 05:25:23 -0700 (PDT)
Received: from localhost.localdomain ([223.176.148.194])
        by smtp.gmail.com with ESMTPSA id y63sm48966279pfb.13.2016.06.18.05.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Jun 2016 05:25:22 -0700 (PDT)
From:	Mehul Jain <mehul.jain2029@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v2 0/2] Introduce log.showSignature config variable
Date:	Sat, 18 Jun 2016 17:55:08 +0530
Message-Id: <20160618122510.5105-1-mehul.jain2029@gmail.com>
X-Mailer: git-send-email 2.9.0.rc0.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Add a new configuratation variable "log.showSignature" for git-log and
related commands. "log.showSignature=true" will enable user to see GPG signature
by default for git-log and related commands.

Changes:
	* Order of patches is reversed as suggested by Junio[1].
	* A new test has been introduced for "--no-show-signature"
	  option.

Previous patch: http://thread.gmane.org/gmane.comp.version-control.git/296474

[1]: http://thread.gmane.org/gmane.comp.version-control.git/296474/focus=296476

Mehul Jain (2):
  log: add "--no-show-signature" command line option
  log: add log.showSignature configuration variable

 Documentation/git-log.txt |  4 ++++
 builtin/log.c             |  6 ++++++
 revision.c                |  2 ++
 t/t4202-log.sh            | 35 +++++++++++++++++++++++++++++++++++
 t/t7510-signed-commit.sh  |  7 +++++++
 5 files changed, 54 insertions(+)

-- 
2.9.0.rc0.dirty

