Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 846D01F600
	for <e@80x24.org>; Thu, 20 Jul 2017 14:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965631AbdGTOTo (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 10:19:44 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33068 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753538AbdGTOTk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 10:19:40 -0400
Received: by mail-wm0-f53.google.com with SMTP id v139so1408888wmv.0
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 07:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/JSNml8zZSSPVH5TaWDR5h0xDF3I5YNz8Hz3kO20i6U=;
        b=Cvntedo7WZe1M6ILmsZVIrIsH6xSDbidcdF1BD7F5bNLk9bvz6H4YNU/pUvyb4LWuZ
         oWgwcUGbk5o08LFxf2BixJ4FtvdLDbeiUZ3QAZyM7yEX1TBKQpCjF47DyKzLGpc/hVM8
         CNSvAARat5mlvRiZ5RMf9ebGKLxhaYxUDmopTtSyjiAHygdSv7c38PA6Iq00qac0zHir
         hJ2NmrjdpQbNHHuFaKejrFspIgutxkXXrftEG1AfNcUfITYuZZ1OH0XWFc0U8MlVNzWy
         TOcYACUu5aMbrwQaB/L17utiWqw2iAwiZaWZAJF93DUqUOjg0sH45XxBxt+KOoM5gwn+
         CLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/JSNml8zZSSPVH5TaWDR5h0xDF3I5YNz8Hz3kO20i6U=;
        b=Ms32c/IdwBSxY4BC+bynmnoQdyDHpl8ZQGuh4K7TyMZ9I5WxKNUbTpPiYzDHA1ag+/
         DWlMblzVc/NuYQviw0Fc45mw3g5Dufp1b+vvlHm1f/91yaeofyW7HGkAlEKEtSw/nQgp
         gmkKCzvrWjCWzQrUTW4V1UYVutTenkHakJnD9J8p58c8KusDN+wQICSXFwEYAhFKmFat
         U2UjPSD7JGQR4xmETLWQHy3D7UgUtWpRqdR3t9KEOhW4bBNJ7zS1nD2kWsxkspdWyf2r
         y6E6D/g70dDzlYAL1x1QEhRSbQBxQGzJTB2rTmIUp20VIelF4ewNI5mHPOAJoPkV1bg9
         G+aw==
X-Gm-Message-State: AIVw112WkzWkI632Y54cKt9sZKBYgsjz4VGdr1f/oIRLJhK7FpE+Basx
        p7boun/xZZ2ctIa5XgU=
X-Received: by 10.80.171.165 with SMTP id u34mr3068443edc.99.1500560378891;
        Thu, 20 Jul 2017 07:19:38 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l24sm1630566eda.11.2017.07.20.07.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2017 07:19:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/6] 2.14 RelNotes improvements
Date:   Thu, 20 Jul 2017 14:19:21 +0000
Message-Id: <20170720141927.18274-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c
In-Reply-To: <xmqq7ez6hk2y.fsf@gitster.mtv.corp.google.com>
References: <xmqq7ez6hk2y.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, Jul 13 2017, Junio C. Hamano jotted:
>>
>> Proposed improvements for the release notes (is this a good way to
>> propose RelNotes changes?)
>
> Thanks.  You could also throw a patch just like any bugfix/update
> to documentation, I would think.

Here's a few patches to improve the relnotes. I started just writing
6/6 since I think (I don't care about the wording) that we should in
some way mention the items in the list in the 6/6 commit message.

Along the way I noticed a few more missing things.

Ævar Arnfjörð Bjarmason (6):
  RelNotes: mention "log: add -P as a synonym for --perl-regexp"
  RelNotes: mention "log: make --regexp-ignore-case work with
    --perl-regexp"
  RelNotes: mention "sha1dc: optionally use sha1collisiondetection as a
    submodule"
  RelNotes: mention that PCRE v2 exposes the same syntax
  RelNotes: remove duplicate mention of PCRE v2
  RelNotes: add more notes about PCRE in 2.14

 Documentation/RelNotes/2.14.0.txt | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

-- 
2.13.2.932.g7449e964c

