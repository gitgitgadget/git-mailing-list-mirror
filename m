Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3200A1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 11:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbeKAU7P (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 16:59:15 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:45868 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbeKAU7P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 16:59:15 -0400
Received: by mail-wr1-f45.google.com with SMTP id n5-v6so19768283wrw.12
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 04:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=34gkC/GhL+f4OIvnUH83ZqOAB8EAHKNBWmGqSi1iG9s=;
        b=Ug7p7UcbQs0tbU8rcxhbStiPTpd0il/CsQgkHlTP1/L/witzGKgZNWH8AO9iT3NCwG
         41wu5kSfaMFWPyicpNF1chT81ZWo9rB+b1f2l7fYPYJRAxOZmownC9901Fs89qGtVm1y
         mdtK5xp4ouE99biNlRYLbuAe/XuApzbIP2yKRPtWSK2QK5PsQfNZlg7uowvYspI4FhSA
         IBDldE3uQFEGmOUjR7q59BL5JwDGZTNtDQgu0nQztGw/Z77q4FVO3mvYeHSblkw/4ZF2
         b+ejzacktK1rpKn+Pxzo78XPmMPSOqdxrzgl1zoXnswiPPKtUomsjgT7ezEJ+/iFJoZN
         XRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=34gkC/GhL+f4OIvnUH83ZqOAB8EAHKNBWmGqSi1iG9s=;
        b=ugQl259CcgooGBWx+IXOI8IwKDjkEScSDAUtnnQaRZq5+lOyXtchKnRbfZcqMm7v70
         d5kjIJPvWtHdy517ptZI/cQaNdgyXzUjFnWyledKOWfGQ0lZMuKt223G3SPAOeflkkrL
         E0NdkdJKVRWb9NHY3rlRpqmLhUjFbQPLbJqw/ixZsJpq1n6Bgcv6JD14IXrBksFzX7PX
         oqp5aV9xEjVKVoJtYx9ZKFbAwPWAlsRWB4kHSkMfvb8BiknYDUBWe904QBrxXumf+bVz
         Tl+QAlwqo1gNJILNsn3h6/lwBptc0oRCQp/ACScN1rXtmYcT2KtCdT74p4A2d6/3Fblv
         Acrg==
X-Gm-Message-State: AGRZ1gLWOulZHsxnovzP1bdqrABk6kpEFWz3RnHLFnkQOLf81RNppbBH
        qYMUMGge2HOKEHT9hrhwB1qdt07k
X-Google-Smtp-Source: AJdET5cmfWN2KBeZqNUPNwn14ytTgRGBcYwkp3GYIu8SRuxrQkBKBZCYxAtiK6+VSaTttG+lHsrItA==
X-Received: by 2002:adf:9c90:: with SMTP id d16-v6mr6160543wre.11.1541073395010;
        Thu, 01 Nov 2018 04:56:35 -0700 (PDT)
Received: from localhost.localdomain ([31.223.156.57])
        by smtp.gmail.com with ESMTPSA id 4-v6sm27084686wrk.52.2018.11.01.04.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 04:56:34 -0700 (PDT)
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
X-Google-Original-From: Slavica Djukic <slawica92@hotmail.com>
To:     slavicadj.ip2018@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        slawica92@hotmail.com
Subject: [PATCH 0/3] [Outreachy] make stash work if user.name and user.email are not configured
Date:   Thu,  1 Nov 2018 12:55:46 +0100
Message-Id: <20181101115546.13516-1-slawica92@hotmail.com>
X-Mailer: git-send-email 2.19.1.windows.1
In-Reply-To: <9ea38cd8e98890b8264696dfd647c1f9e709ae9e.1540494231.git.slawica92@hotmail.com>
References: <9ea38cd8e98890b8264696dfd647c1f9e709ae9e.1540494231.git.slawica92@hotmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enhancement request that ask for 'git stash' to work even if 
'user.name' and 'user.email' are not configured.
Due to an implementation detail, git-stash undesirably requires 
'user.name' and 'user.email' to be set, but shouldn't.

Slavica Djukic(3):
  [Outreachy] t3903-stash: test without configured user.name and
    user.email
  [Outreachy] ident: introduce set_fallback_ident() function
  [Outreachy] stash: use set_fallback_ident() function

 builtin/stash.c  |  1 +
 cache.h          |  1 +
 ident.c          | 17 +++++++++++++++++
 t/t3903-stash.sh | 15 +++++++++++++++
 4 files changed, 34 insertions(+)

-- 
2.19.1.windows.1

