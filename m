Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B83011F461
	for <e@80x24.org>; Mon, 13 May 2019 22:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfEMWRH (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 18:17:07 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:39637 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfEMWRH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 18:17:07 -0400
Received: by mail-wm1-f46.google.com with SMTP id n25so808004wmk.4
        for <git@vger.kernel.org>; Mon, 13 May 2019 15:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HKuSnM0+87zcBNVVB2ZgsGXjO/Ig7sEshAb0ibRDlOM=;
        b=fatQwJUkGpXPwDGJxAi4bu55ZlMaptC7sm9Wy7SeuU5aqlG4e8+0FEAu5e5RX9SMS6
         +i1/gpMGG5EPpPaTX86ICYNPCh7gzhSOoOtG6iyNrlWMfrA8fm2seIKn0VE2UBTCmvpw
         cbvKQpKhkb5F1IgohJtqToNw7+fXK47S1Hp7OGEjbp5wtODnFWFrnBm8g5Tfmq2XQcyq
         gdcKjW8TIqTL/sIo0ElWQJeG0ENmOdDxpO6DI10+qh5JIuBT6ES1nugNNyE9MivfUqOR
         OQiJAqegqVj09fFllpUhrd+cOTw7ymteyeYNCXV+cC0X6Y65FvjwPl+KgpPjZoPqcOXi
         vdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HKuSnM0+87zcBNVVB2ZgsGXjO/Ig7sEshAb0ibRDlOM=;
        b=nsOWVsp3OLi6aGoc23IhOP2PxmafadwlAXs2k2GRqd9gNIkbyIBQRCBIKJDfc+CAOt
         LAvMo/YkIoOLsou6Mw5Q87SSvMmYGBjVU++9cq2isF5qnWF9hkDMeAegnv4sExQrm/jk
         tYgkWAxUAqco94k+QiPq8dhLSESTUWEvZNVavAeDDegieELA7UZOsSGt2hlYMMof6pyT
         SM+6t6m7eavnT6L5glNcz6Ly2j2vMCxO/P9V3lco2cod1QUrGpWeg9datgxUqZ3wrc9x
         K284+u4gwcijUUwIC55rChUmuey5eBSif2zQ1nHaZZKt90pWXGx6JvPRa/DagqMwzSj8
         Ydow==
X-Gm-Message-State: APjAAAVbd8pI6Wr/7cvV6S8l7rCWykKyx02S89lL5cp07tlNjhg8sy8h
        YkxoDKc7RlqO5LKhQO7Yklw9a2G7Xn8=
X-Google-Smtp-Source: APXvYqy1/7+CTtwXuAkN+h+2o+claASEsSm8sa0Q5euFFZmcbx/Ruy4eBUexGykrDE3UQahWlpq1Sw==
X-Received: by 2002:a1c:1b49:: with SMTP id b70mr8106853wmb.50.1557785824645;
        Mon, 13 May 2019 15:17:04 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i25sm536426wmb.46.2019.05.13.15.17.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 15:17:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Osipov <michael.osipov@siemens.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] sha1dc: update from upstream
Date:   Tue, 14 May 2019 00:17:01 +0200
Message-Id: <20190513221701.1837-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <3cabed9e-3949-93cc-2c9c-500a9cd9d4cd@siemens.com>
References: <3cabed9e-3949-93cc-2c9c-500a9cd9d4cd@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update sha1dc from the latest version by the upstream
maintainer[1]. See 07a20f569b ("Makefile: fix unaligned loads in
sha1dc with UBSan", 2019-03-12) for the last update.

This fixes an issue where HP-UX IA64 was wrongly detected as a
Little-endian instead of a Big-endian system, see [2] and [3].

1. https://github.com/cr-marcstevens/sha1collisiondetection/commit/855827c583bc30645ba427885caa40c5b81764d2
2. https://public-inbox.org/git/603989bd-f86d-c61d-c6f5-fb6748a65ba9@siemens.com/
3. https://github.com/cr-marcstevens/sha1collisiondetection/pull/50

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

n Thu, May 09 2019, Osipov, Michael wrote:

> Hey there,
>
> Am 2019-05-09 um 09:32 schrieb Ævar Arnfjörð Bjarmason:
>>
>> On Wed, May 08 2019, Osipov, Michael wrote:
>>
>>> Hi folks,
>>
>> Hi see Documentation/SubmittingPatches for how to submit patches inline
>> instead of as attachments.
>
> Do you want me to resend the configure.ac change as per wiki article?
> I can also create a PR on GitHub. I am happy with both as long as I
> don't have to retain the patch for myself only ;-)

Yeah that patch to git.git should be done separately. I see your PR
went in upstream, here's a patch to update our code to match.

> That'd be much more work to extend configure.ac for that because is a
> runtime check. Since there are no real products vailable on x86 for
> HP-UX I'd neglect that. Our HPE salesman told us that this will be
> available somewhere in the future. So, I think this is very good for
> now.

Sure, makes sense. I'm not familiar with HP/UX. So just thought I'd
ask.

 sha1collisiondetection | 2 +-
 sha1dc/sha1.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sha1collisiondetection b/sha1collisiondetection
index 16033998da..855827c583 160000
--- a/sha1collisiondetection
+++ b/sha1collisiondetection
@@ -1 +1 @@
-Subproject commit 16033998da4b273aebd92c84b1e1b12e4aaf7009
+Subproject commit 855827c583bc30645ba427885caa40c5b81764d2
diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 5931cf25d5..9d3cf81d4d 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -93,7 +93,7 @@
 #define SHA1DC_BIGENDIAN
 
 /* Not under GCC-alike or glibc or *BSD or newlib or <processor whitelist> */
-#elif (defined(_AIX))
+#elif (defined(_AIX) || defined(__hpux))
 
 /*
  * Defines Big Endian on a whitelist of OSs that are known to be Big
-- 
2.21.0.1020.gf2820cf01a

