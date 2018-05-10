Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EBFD1F406
	for <e@80x24.org>; Thu, 10 May 2018 19:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751223AbeEJTaK (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 15:30:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35472 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbeEJTaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 15:30:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id o78-v6so6289373wmg.0
        for <git@vger.kernel.org>; Thu, 10 May 2018 12:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sogjedUGvCsaHVNjhhiNAZ2AvfbZqnkNxosLGJsIMQE=;
        b=E+d9uDbWB7Ny8DIfIO3QmfIzBbsOZJIsxW4HF7er+gIFHhZIZh4kXbyB22M2u3rbpc
         SfH67Tq5GUeGojMrd/OKijGQUdzI45sZ3F+HtGxo/JLhm4q8EMoVk5U1L8lvmUVvwDm6
         zoB2FAPIJxrtjytPp0W+ctgkaVewih5ttZWyk+bNQv7QQLK7sYGLcrHoAbH8TnOZf162
         KktlJ0x7LZUQZnHooLYJwBgflodFhlTEaIFc7uXYpKCefjHS9sH0cjF8NrJzUkc9twC3
         pbhbWxw4XYIN8+Ks2Yk2MYaYOvx880brBd2yMjJ8ROIAgWTHfs/EuELWKy7pA5lTjn4e
         iJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sogjedUGvCsaHVNjhhiNAZ2AvfbZqnkNxosLGJsIMQE=;
        b=KeiAHIqA6VO+ABYk2dJiouM2VYhae33TjHEWCiiOb+ZS7kJEjx6ei0UxTz0jcAqoZX
         ysXc9MnKw280YC4wIIkZ7jAq0f/65GoYYcvKoYnbVid4Gyizx7TcOiSWZf7nLVRsEvDx
         D2xByPoA0dkEJaMlegLfVddmh4cHniwAc2E+qcT0zFjM9TZdyF3l5WNB/pFs+My8CU0k
         xX+7eeVRDtdWsQRy2PaokzFeDiYCon9kf64/FbGQV7neIKj6rjSFjuJ7gbgxac2nfrg8
         LvHeGfR5DvwFTVl1JEUTX1qljG2kSQUhriNKqopmYUHLHYTrXVEm9TgZahLg/9q6UIxA
         58BQ==
X-Gm-Message-State: ALKqPwfMSQqSlFT7QxVncPWktfh36URhOTeKiyMKlmSBsS45UMfA5wcc
        TqRpEGpg9kfgpzFO29NBg3bnj7rpCoY=
X-Google-Smtp-Source: AB8JxZpk06/dvwDbMy/yNHbmjDtbW+5vgRRM6TkkxYhNb3JTIjFZV38KUIuPACKqR0JC6tuEGiJN2w==
X-Received: by 2002:a50:fc0c:: with SMTP id i12-v6mr3838077edr.74.1525980607567;
        Thu, 10 May 2018 12:30:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id z11-v6sm870817edh.60.2018.05.10.12.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 May 2018 12:30:06 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        David Turner <novalis@novalis.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 0/3] refs: handle zero oid for pseudorefs
Date:   Thu, 10 May 2018 21:29:53 +0200
Message-Id: <cover.1525979881.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <CAN0heSp-rxqAVJ3Q1KMD=eYqPUkcDP8xBTVTDtGfom6v5WpBLQ@mail.gmail.com>
References: <CAN0heSp-rxqAVJ3Q1KMD=eYqPUkcDP8xBTVTDtGfom6v5WpBLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7 May 2018 at 12:05, Martin Ågren <martin.agren@gmail.com> wrote:
> On 7 May 2018 at 09:39, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Thanks for the patch. This looks good to me. But it it seems that the
>> test coverage related to pseudorefs is still not great. Ideally, all of
>> the following combinations should be tested:
>
> Thank you for your comments. I was not able to find much
> pseudoref-testing. I think what I should do is a patch 1/2 adding the
> tests you outlined (some will be expected failures), then turn this
> patch into a patch 2/2.

Well, it turned into three patches. One to move away from "sha1" in some
error messages before spreading them to the test suite, then one to add
the tests, then one for the actual fix.

Martin

Martin Ågren (3):
  refs.c: refer to "object ID", not "sha1", in error messages
  t1400: add tests around adding/deleting pseudorefs
  refs: handle zero oid for pseudorefs

 t/t1400-update-ref.sh | 60 +++++++++++++++++++++++++++++++++++++++++++
 refs.c                | 22 ++++++++++++----
 2 files changed, 77 insertions(+), 5 deletions(-)

-- 
2.17.0

