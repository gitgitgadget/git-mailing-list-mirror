Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABB8D1F406
	for <e@80x24.org>; Mon, 14 May 2018 20:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeENU57 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 16:57:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55560 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeENU56 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 16:57:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id a8-v6so15820792wmg.5
        for <git@vger.kernel.org>; Mon, 14 May 2018 13:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9l/k+U0iOphcnnZVc0g47Wt+Sde4TMUuuuyjNII5sLE=;
        b=IfEdDVoTLI2/dkVqXRwYcI1TP+o3fUzXzoOAcBwDc/hPardAnPX4oq/1Qh+Mi5wmN5
         5kQjnRUCE9vghrymX/lvjC35VJK8F9fQEFwdwr+75aBWPD7Nynyi5WHbQgw2mz6t18Qb
         FeWW5Sxs7YELRlxkWZJ1JvqpyDSqigBzUV1fvWd8/c6WpMJfs/qfzrTZi8LlRroSWCLy
         GQ9cD7QdizWfj9ALI6u+VG3oAsJlTGZ0lNSjW1xRa0DSsegXB1hoTBmYTSmHJPAZp9PL
         aP8Ga1r9cCVdP7yzGRhiBshbGknkNts8krxrm83bCWka5dpgxasnjmWBm4ptq66BXfUu
         xTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9l/k+U0iOphcnnZVc0g47Wt+Sde4TMUuuuyjNII5sLE=;
        b=cHScV0p3t391HZ2XIlnvf+/m02KLvpx8lLoBt5Kfi+lFi9VvKMhmSgGXCXSNscaQ9S
         xoINpDXrlza+8jMt8x+O7b49VumnOt3FjxihHAtT51SQ0NuwKG80eTtDaqEdpPx+eEOf
         uG7zXA7DK3FcHV3CAjznOhH7erNSpeZwPX833dnfW+UgYxTNI1Ee+c6U5Z2O/v921DYs
         LI9u9pMNmoSPvOK2yu22QFdd0mA5uGQLbeQEnx8QOqtfHhF+lymoqlqMC3OCo/Qp2il/
         TIoBOjNrr1ymwGA+qxIfvrz8wCwyEU94kPp6UyvnmxTS4nLjlh7Ql4hCWfmFY0koL8/O
         Yeew==
X-Gm-Message-State: ALKqPwea1xOMQYM4kLwsWz3IdmolkP0oGvxyczlmU5Q44X1gRCjhUnRA
        bBAureRkJAGGESk4qd331cuzlKZ0
X-Google-Smtp-Source: AB8JxZo+I8q4aiZ8OoaLQ42Z3nsUyFQ9zzzYDffcnx+GttGt4807gb7Cmi4Zn63gKipk/OMd9QcrSw==
X-Received: by 2002:a1c:55c5:: with SMTP id j188-v6mr5821170wmb.102.1526331476961;
        Mon, 14 May 2018 13:57:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8071:b6aa:7d00:756b:35b0:cc92:6805])
        by smtp.gmail.com with ESMTPSA id k23-v6sm14121181wrc.59.2018.05.14.13.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 May 2018 13:57:56 -0700 (PDT)
From:   Leif Middelschulte <leif.middelschulte@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com,
        Leif Middelschulte <Leif.Middelschulte@gmail.com>
Subject: [PATCH 0/1] rebased: inform about auto submodule ff during merge
Date:   Mon, 14 May 2018 22:57:36 +0200
Message-Id: <20180514205737.21313-1-leif.middelschulte@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <CAGZ79kaiFkq20Com7gOLin371D2KhTPG7cqn1mQ6OaFU12kKPQ@mail.gmail.com>
References: <CAGZ79kaiFkq20Com7gOLin371D2KhTPG7cqn1mQ6OaFU12kKPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Leif Middelschulte <Leif.Middelschulte@gmail.com>

This patch is in response to Stefan Beller's Commit 0357af480
("merge-recursive: i18n submodule merge output and respect verbosity",
2018-05-10) and is based on the changes it provided.

Leif Middelschulte (1):
  Inform about fast-forwarding of submodules during merge

 merge-recursive.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.15.1 (Apple Git-101)

