From: Caleb Thompson <cjaysson@gmail.com>
Subject: [PATCH v3 0/5] commit: support commit.verbose and --no-verbose
Date: Mon, 26 May 2014 13:56:21 -0500
Message-ID: <1401130586-93105-1-git-send-email-caleb@calebthompson.io>
References: <20140525062427.GA94219@sirius.att.net>
Cc: Jeff King <peff@peff.net>, Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 20:57:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp05F-000260-Mq
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 20:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbaEZS5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 14:57:11 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:44964 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbaEZS4k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 14:56:40 -0400
Received: by mail-ig0-f170.google.com with SMTP id uy17so291312igb.3
        for <git@vger.kernel.org>; Mon, 26 May 2014 11:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sLXUJmtTJjYeZmHJAbMUqUF3uf+XCrSNW8StAIWiyMc=;
        b=uC9NZdn7wDCQ4bjISlMQIyUmotZUlubR+XENFmRQDy+68lruruwy48PYdg6kYObAd1
         9o/ZVI8KDqyE92Oy9m4ixoS+Ed88s7v7vooe2BJSC7mBx5j95IR880lplt5d2AcaoleF
         0mI6ufCvwKhduXcjDczGVKI7mx9lI6KrDlIXM9awn8LAEsswkGIrDDaXKGlWymmZ7uJ0
         TdBR7ZHM6BQFHWBuANsr4Re1owZfCcaNeZ28jCfoLsFF/R7fabUJeJ3vXlOQBNebq0Ts
         DzoFdXnDhWQckYiNSMDUlbwF3emx6h/9AFZjD85yKxbm2YjGCPgK9ru8ybNm4vhaZHI0
         KjOw==
X-Received: by 10.50.25.105 with SMTP id b9mr27943688igg.28.1401130599421;
        Mon, 26 May 2014 11:56:39 -0700 (PDT)
Received: from sirius.att.net (107-216-44-113.lightspeed.austtx.sbcglobal.net. [107.216.44.113])
        by mx.google.com with ESMTPSA id ql7sm1708857igc.19.2014.05.26.11.56.38
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 11:56:38 -0700 (PDT)
X-Google-Original-From: Caleb Thompson <caleb@calebthompson.io>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <20140525062427.GA94219@sirius.att.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250116>

This patch allows people to set commit.verbose to implicitly send
--verbose to git-commit. It also introduces --no-verbose to
override the configuration setting.

This version incorporates changes suggested by Eric Sunshine, Duy
Nguyen, and Jeremiah Mahler.

It introduces several cleanup patches to t/t7505-commit-verbose.sh to
bring it closer to the current state of the tests as Eric has explained
them to me, then adds the verbose config and --no-verbose flag.

Caleb Thompson (5):
      commit test: Use test_config instead of git-config
      commit test: Change $PWD to $(pwd)
      commit test: Use write_script
      commit test: test_set_editor in each test
      commit: support commit.verbose and --no-verbose

 Documentation/config.txt               |  5 ++++
 Documentation/git-commit.txt           |  8 +++++-
 builtin/commit.c                       |  6 ++++-
 contrib/completion/git-completion.bash |  1 +
 t/t7507-commit-verbose.sh              | 68 ++++++++++++++++++++++++++++++++++++-------------
 5 files changed, 69 insertions(+), 19 deletions(-)
