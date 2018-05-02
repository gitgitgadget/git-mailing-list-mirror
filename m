Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 587A421847
	for <e@80x24.org>; Wed,  2 May 2018 00:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753380AbeEBAa6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:30:58 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43514 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753332AbeEBAa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 20:30:57 -0400
Received: by mail-qk0-f194.google.com with SMTP id h19so10006019qkj.10
        for <git@vger.kernel.org>; Tue, 01 May 2018 17:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kJnHxGAIR3PL0tNr1FKJeXHog7ZlubiRmK2Gn3z9/cw=;
        b=FXb47l64dgNj7lVPZR+c2NIMPwoWwXUOa/hiQKj9nWM71dGrGKaC9hCvl+mgT6sBCG
         uY6iQYsCmFMkP9xfU0GG81zkAsCP+hXzmDZRyf8v5/shqjAfE+7znTdNt7/QDN4iExl5
         Ke39g4cvRrCmG18TKU8IaCsun7PrSFu+g9TGHb6MvGsSyk366NvQMWxLdcL6gePAemWF
         w57rzlRRm7ce1kFzq7LViBpV9TKTAh6uiaF8xtX/WFsJkghtXTtgIzQ33ppd7ZovJ1wp
         3URXtQQHh8834iygnWUQ3HNz3zW7bn8etTJ0lqoVqSuCNUMKaQamuAVEwvpV2Owud1FO
         X93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kJnHxGAIR3PL0tNr1FKJeXHog7ZlubiRmK2Gn3z9/cw=;
        b=Dp+q23XO1jHSOwA2+EjZZp3K5zRBjMbphyQgoVGu1vt3IoF+uIHkEM9Biw1bNRwwL/
         chHt/eJffulxNMF6/e9OjNAXrOah2VPZR1iVUy7G6YYSTUmjhGweZhXmc9S66S1R71Qq
         ea4z06tNZXFLT+ywflU2QxlTa7EgQ6g+uSZbJyQ/7TYl68EJkVmblk6JOpJCs/aWBEsH
         6tE+oM1gghXimyucgqNrKhnQ/dc0cXjXRk1cOqGBSx4skQpoCM3WT5zKLM2BWu0BoOh9
         LfGKeR+R2eYQncZuo3o0lHQ3ciPKVmWUEpkjauHfoeIOyV0yHSMXi0w6/5zBRUdFtxu3
         /TLw==
X-Gm-Message-State: ALQs6tCvAuMn/JeqOu9PK9kBJB1sKh1X89bhQLdaqOlE5nSjWOw3V6c3
        I4Ck44B98R0hR//flo7QTg1BsTsf
X-Google-Smtp-Source: AB8JxZoHq6uCDqLQqcHHJOzD/X3LFBfB4G5mWLTNu+QxP5doY8G9lrpfD7feVNynFWasDFJyn2BU9A==
X-Received: by 10.55.42.1 with SMTP id q1mr13410472qkh.137.1525221056766;
        Tue, 01 May 2018 17:30:56 -0700 (PDT)
Received: from localhost.localdomain (64-121-142-251.s4089.c3-0.eas-cbr1.atw-eas.pa.cable.rcncustomer.com. [64.121.142.251])
        by smtp.gmail.com with ESMTPSA id q10-v6sm9706428qtk.7.2018.05.01.17.30.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 17:30:55 -0700 (PDT)
From:   Casey Fitzpatrick <kcghost@gmail.com>
To:     git@vger.kernel.org, sbeller@google.com, sunshine@sunshineco.com
Cc:     Casey Fitzpatrick <kcghost@gmail.com>
Subject: [PATCH 0/3] Add --progress and --dissociate to git submodule
Date:   Tue,  1 May 2018 20:27:56 -0400
Message-Id: <20180502002759.8207-1-kcghost@gmail.com>
X-Mailer: git-send-email 2.17.0.1.ge0414f29c.dirty
In-Reply-To: <CAEp-SHV4hP=v_=AJExRS3hqT-x9rXEONofWD=sVQZC79uewATA@mail.gmail.com>
References: <CAEp-SHV4hP=v_=AJExRS3hqT-x9rXEONofWD=sVQZC79uewATA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches add --progress and --dissociate options to git submodule.

The --progress option existed beforehand, but only for the update command and
it was left undocumented.

Both add and update submodule commands supported --reference, but not its pair
option --dissociate which allows for independent clones rather than depending
on the reference.

This is a resubmission with comments from Stefan Beller and Eric Sunshine
addressed.

Casey Fitzpatrick (3):
  submodule: clean up subsititions in script
  submodule: add --progress option to add command
  submodule: add --dissociate option to add/update commands

 Documentation/git-submodule.txt | 17 ++++++++++++++++-
 builtin/submodule--helper.c     | 16 +++++++++++++---
 git-submodule.sh                | 21 ++++++++++++++++-----
 t/t7400-submodule-basic.sh      | 16 ++++++++++++++++
 t/t7408-submodule-reference.sh  | 17 +++++++++++++++++
 5 files changed, 78 insertions(+), 9 deletions(-)

-- 
2.17.0.1.ge0414f29c.dirty

