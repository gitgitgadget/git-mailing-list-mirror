Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 274FC200B9
	for <e@80x24.org>; Fri,  4 May 2018 18:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbeEDS1E (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 14:27:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34882 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbeEDS1D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 14:27:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id o78-v6so6429464wmg.0
        for <git@vger.kernel.org>; Fri, 04 May 2018 11:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :references:content-transfer-encoding;
        bh=X5BB9FP2whEIlh7AasqXZtUU+5UkD8QXqdjUJScArCQ=;
        b=iLQ9G7DHSHMx+fPSDgcgqyq7Te2w60TR8PYf96eRsYcMjsOADHnK5DLOF5eTkeBW6d
         tPzs2PFLRJv9j/ml3ulMq9zOajNiVw9nK9w9AFMw18FGvvTrPrB9GVeckTFokk1k5voQ
         KkBL/n/BNEN6u8440KcyDSXY9RNW9jawZaYLo7AqZaDNVYjG6rTUMu9Is7EEfz2hKvTo
         y1mCzTTbuZkgOHNUYfpnRHaT2kaoHeP8tf78ulAJpuNSEJubBXF4NsAPHCZI1vr/vRQW
         IJbTY50kg/FOQbUHw3g87KaYK5dbaqc227jsrMA8hPW+/zDo4fx3MUP55/SgddmTpjdT
         I22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:references:content-transfer-encoding;
        bh=X5BB9FP2whEIlh7AasqXZtUU+5UkD8QXqdjUJScArCQ=;
        b=pfg++1AYWEFpD3h2AZkTYn2p42Tlzkg+gW8c0kqwB1Jgp8yA+TfbTkRsISDu/BN2tc
         cOjDvpF514zpAD8s76SmKrZxsJBCm2hOFGwlLIdBRl23oYtzyoK69U9y0E1xnGtpJiA1
         RvrOx1dp/nEHm47wdBiHqzFE3/uk/Bklt5RkJDzLR716sx6t2o4Pywjl2NPSFkDeq9Gh
         uP9RFfF1f6Y2KM0OaqTArxs1KYK/o3ywQUCOV9lSdUEpSH367AeRp4/aewW4TD8uefMK
         TpilSQTQsCLcrM8kg79aYbjn+zKOdoa3hbJWvIWU+dVanVMe5LgBQdQ2CP+A2XErkmv0
         lZrA==
X-Gm-Message-State: ALQs6tAoQ4B3L2ewvHlTkDNf9bG8NDYFmtT8Waz5PgZpTbSuXa01Dyn2
        /ewtD+9aPGxf5lOGpgbag5I=
X-Google-Smtp-Source: AB8JxZpbmE3KunmJiMf/ouhXLU1bzoJowm6tHXxvRX9i6th0d14iNHGCYjc8I7wzoMr7Esk9PmTj0g==
X-Received: by 10.28.40.6 with SMTP id o6mr11627573wmo.151.1525458422791;
        Fri, 04 May 2018 11:27:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id s14sm2935714wmb.5.2018.05.04.11.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 May 2018 11:27:01 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twopensource.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: git update-ref fails to create reference. (bug)
Date:   Fri,  4 May 2018 20:26:46 +0200
Message-Id: <20180504182646.7738-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.392.g7fa371e468
MIME-Version: 1.0
In-Reply-To: <cced9e2c-7d02-47fd-109a-1185eed13e63@gmail.com>
References: <cced9e2c-7d02-47fd-109a-1185eed13e63@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rafael,

On 4 May 2018 at 18:28, Rafael Ascensão <rafa.almas@gmail.com> wrote:
> While trying to create a pseudo reference named REF pointing to the
> empty tree iff it doesn't exist, I stumbled on the following:
>
> I assume both are valid ways to create such reference:
>         a) $ echo -e option no-deref\\nupdate REF $(git hash-object -t
>         tree /dev/null) 0000000000000000000000000000000000000000 | git
>         update-ref --stdin
>         b) $ git update-ref --no-deref REF $(git hash-object -t tree
>         /dev/null) 0000000000000000000000000000000000000000
>
> While a) works, b) will throw:
>         fatal: could not read ref 'REF'


I can reproduce this and I agree with your understanding of what should
happen here. The patch below makes this work according to my and your
expectations, at least in my command-line testing.

The die("... already exists") could instead be a no-op, trusting that
the backend discovers the problem. "die" could also be strbuf_addf(...),
I'm just following 2c3aed138 here.

Anyway, that's not where I'm stuck... Regardless of how I try to write
tests (in t1400), they just pass beautifully even before this patch. I
might be able to look into that more on the weekend. If anyone has
ideas, I am all ears. Or if someone feels like picking this up and
running with it, feel free.

Martin

diff --git a/refs.c b/refs.c
index 8b7a77fe5e..cdb0a5ab29 100644
--- a/refs.c
+++ b/refs.c
@@ -666,9 +666,12 @@ static int write_pseudoref(const char *pseudoref, const struct object_id *oid,
 	if (old_oid) {
 		struct object_id actual_old_oid;
 
-		if (read_ref(pseudoref, &actual_old_oid))
-			die("could not read ref '%s'", pseudoref);
-		if (oidcmp(&actual_old_oid, old_oid)) {
+		if (read_ref(pseudoref, &actual_old_oid)) {
+			if (!is_null_oid(old_oid))
+				die("could not read ref '%s'", pseudoref);
+		} else if (is_null_oid(old_oid)) {
+			die("reference '%s' already exists", pseudoref);
+		} else if (oidcmp(&actual_old_oid, old_oid)) {
 			strbuf_addf(err, "unexpected sha1 when writing '%s'", pseudoref);
 			rollback_lock_file(&lock);
 			goto done;
-- 
2.17.0.392.g7fa371e468

