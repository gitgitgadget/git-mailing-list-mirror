Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A46601F42D
	for <e@80x24.org>; Fri, 25 May 2018 19:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967999AbeEYT2Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 15:28:24 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38163 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967587AbeEYT2X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 15:28:23 -0400
Received: by mail-wr0-f194.google.com with SMTP id 94-v6so10945909wrf.5
        for <git@vger.kernel.org>; Fri, 25 May 2018 12:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=glj5RLJmvfXSWRNgxEkUXDnCreOtMRVy274GCBZc+nk=;
        b=tOgu6iYlvRoAvUz66dTFJI2wsrA8+uiow7zlG1K+zE38pVX7liHaZJD8Q2pFD0HPMG
         DrVrFXQ8HVtiytdq42sN/7+S0knRzCLeyvYadMYfYoNU/2vez6u2KX9mjz11CCYAdCgB
         C0AFWbPlxgyaCJEC3Hcj/xfF6QfwRrsx5GMrDB9xdps3Xrr4girKyZMTRTkGuKG3xzly
         qDQnP87LCqyXbCKhFRpaTGOAiQ+KIILzEbkORq2Bi5hLohTYElVl1GeYPdyOOuwgKA8H
         RwocLHSRsPBnWHp2rPirqOH9bNEWVg3dIX7dyaTDhQ85bq/prOm2RqTfdmdOkTBERRpk
         OlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=glj5RLJmvfXSWRNgxEkUXDnCreOtMRVy274GCBZc+nk=;
        b=W2lomjoj8YoL3VdmPPlvvLOxsAXMnLCr36ki7pemgveedTyhTw4dkqg/Yaf30oEmLw
         nPrIQjWF18x2fDkv9+clsYvS6HgxwlcAAACRPvHjzSYgyBAlEn8+ny/Vd8THQBeEjCmm
         0B9137RdfYpS+cfjPPlIvsg8gVgVSDG4FBIc/eHRxKYeysIwIG4SVQUYYKjI+WK0eKX9
         P8cdou01NxIkpTTbFkEctKtOKv1bFchjAmntCaS1LPAZKgS6qqAblLNAQTBl1iO1WVCa
         57CrTuHIqwt5LbRTQaoCL2dEnMqhwSRUi+ZQ+iXfHxsQV0STBOL1VlChZFV937WDguSU
         334A==
X-Gm-Message-State: ALKqPwfdabC031RM/t2FRV3jo4+Sue5oa9l9O5SNJMxuZ7WxQkWb9nML
        XgUmo4W5BPCYM5HrrwIeCoNJWVxL
X-Google-Smtp-Source: AB8JxZr7mFx3xihkl0V8Mk18NbR1WKmi8lzdvlGUT5UgONZiNwG1dsG18S7nvE/rMnLY2AuPsiVM/A==
X-Received: by 2002:adf:e8c3:: with SMTP id k3-v6mr2943662wrn.182.1527276501446;
        Fri, 25 May 2018 12:28:21 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a69-v6sm7276518wma.7.2018.05.25.12.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 May 2018 12:28:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/5] fsck: doc fixes & fetch.fsck.* implementation
Date:   Fri, 25 May 2018 19:28:06 +0000
Message-Id: <20180525192811.25680-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180524193516.28713-1-avarab@gmail.com>
References: <20180524193516.28713-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This should address all the comments to v1. Inter-diff:
    
    1: a9cd795db5 ! 1: 3d61e44cb8 config doc: don't describe *.fetchObjects twice
        @@ -1,10 +1,6 @@
         Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         
             config doc: don't describe *.fetchObjects twice
        -    
        -    Change the copy/pasted description of the fetch.fsckObjects and
        -    receive.fsckObjects variables to refer to transfer.fsckObjects
        -    instead.
             
             Let's not duplicate the description of what *.fsckObjects does twice.
             instead let's refer to transfer.fsckObjects from both fetch.* and
    2: 637c2d4241 ! 2: 9683fd2ec6 config doc: unify the description of fsck.* and receive.fsck.*
        @@ -64,21 +64,21 @@
         +unless someone is being deliberately malicious.
          
          fsck.skipList::
        --	The path to a sorted list of object names (i.e. one SHA-1 per
        + 	The path to a sorted list of object names (i.e. one SHA-1 per
         -	line) that are known to be broken in a non-fatal way and should
         -	be ignored. This feature is useful when an established project
         -	should be accepted despite early commits containing errors that
         -	can be safely ignored such as invalid committer email addresses.
         -	Note: corrupt objects cannot be skipped with this setting.
        -+	Like `fsck.<msg-id>` this variable has a corresponding
        -+	`receive.fsck.skipList` variant.
        ++	line) that are known to be broken in a non-fatal way and
        ++	should be ignored. This feature is useful when an established
        ++	project should be accepted despite early commits containing
        ++	errors that can be safely ignored such as invalid committer
        ++	email addresses. Note: corrupt objects cannot be skipped with
        ++	this setting.
         ++
        -+The path to a sorted list of object names (i.e. one SHA-1 per line)
        -+that are known to be broken in a non-fatal way and should be
        -+ignored. This feature is useful when an established project should be
        -+accepted despite early commits containing errors that can be safely
        -+ignored such as invalid committer email addresses. Note: corrupt
        -+objects cannot be skipped with this setting.
        ++Like `fsck.<msg-id>` this variable has a corresponding
        ++`receive.fsck.skipList` variant.
          
          gc.aggressiveDepth::
          	The depth parameter used in the delta compression
    3: 55dc555196 < -:  ------- config doc: elaborate on what transfer.fsckObjects does
    -:  ------- > 3: 8e9646a6ce config doc: elaborate on what transfer.fsckObjects does
    -:  ------- > 4: 2b3aafdfde config doc: mention future aspirations for transfer.fsckObjects
    4: 13f4d994c0 ! 5: be32b19696 fetch: implement fetch.fsck.*
        @@ -67,16 +67,16 @@
          When `fsck.<msg-id>` is set, errors can be switched to warnings and
          vice versa by configuring the `fsck.<msg-id>` setting where the
         @@
        - unless someone is being deliberately malicious.
        - 
        - fsck.skipList::
        --	Like `fsck.<msg-id>` this variable has a corresponding
        --	`receive.fsck.skipList` variant.
        -+	Like `fsck.<msg-id>` this variable has corresponding
        -+	`receive.fsck.skipList` and `fetch.fsck.skipList` variants.
        + 	email addresses. Note: corrupt objects cannot be skipped with
        + 	this setting.
          +
        - The path to a sorted list of object names (i.e. one SHA-1 per line)
        - that are known to be broken in a non-fatal way and should be
        +-Like `fsck.<msg-id>` this variable has a corresponding
        +-`receive.fsck.skipList` variant.
        ++Like `fsck.<msg-id>` this variable has corresponding
        ++`receive.fsck.skipList` and `fetch.fsck.skipList` variants.
        + 
        + gc.aggressiveDepth::
        + 	The depth parameter used in the delta compression
         
         diff --git a/fetch-pack.c b/fetch-pack.c
         --- a/fetch-pack.c

The "mention future aspirations for transfer.fsckObjects" patch is
new. I've split up the "we're probably going to quarantine fetches
too" part of this.

Ævar Arnfjörð Bjarmason (5):
  config doc: don't describe *.fetchObjects twice
  config doc: unify the description of fsck.* and receive.fsck.*
  config doc: elaborate on what transfer.fsckObjects does
  config doc: mention future aspirations for transfer.fsckObjects
  fetch: implement fetch.fsck.*

 Documentation/config.txt        | 112 ++++++++++++++++++++------------
 fetch-pack.c                    |  32 ++++++++-
 t/t5504-fetch-receive-strict.sh |  46 +++++++++++++
 3 files changed, 148 insertions(+), 42 deletions(-)

-- 
2.17.0.290.gded63e768a

