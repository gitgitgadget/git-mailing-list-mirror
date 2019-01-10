Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5AAF1F803
	for <e@80x24.org>; Thu, 10 Jan 2019 18:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbfAJSSE (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 13:18:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42173 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729791AbfAJSSE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 13:18:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so12452585wrx.9
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 10:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=cNDOLbzjbwe4aNmc9wcA0qWHcLlWYNsg7c9mo95gUak=;
        b=AzJ/P12VT8iDHvt4fulZBGpyHosf44ZBg1YkSwIrWMmS1/+aW8hRYRrA3bX9skq1i+
         n8feYqXaCv8tNU/B/gfeosFDDRTlLB7Ii+3tOWaMXhQphhSPz7poPScKk37+gFi+wrBT
         uH+d4y9K3cR6LPGXGsNwzpTFJdyD32towCnFQxpl1BrWjwbrT6TK4NgBm68lr67gQ8vs
         7rfunSiVxLwx6p+OxnDAnURunfITvC2zeVI7OHd7TU3JCjGK7rY/hY0iknDpjRinrg6r
         bgzTijQ3xiufIlt8u1R6Djpzk+n/Dg6uBQdoFLgiHFQb/tCw7An/c4KPJuDBcaWW7JYX
         tg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=cNDOLbzjbwe4aNmc9wcA0qWHcLlWYNsg7c9mo95gUak=;
        b=CRj5dHhFAkKuKOeGIzxSu/dpl+fhMsr2Bx6c2wYReeLIA23n4irkullZb/ncgiF9+P
         QOek9J65kaLnZ+wStKdyV23eWvDjxaHpKAsbYU7jlDWURXWRin5+9yCeMqoCgo8wHKji
         7P1cqDgroKjaXxFezOrfZBhrLglpxV7GsOek37GAGDIjhJh/CkX+reUD38fvkPLX22BW
         leFBWwYbUWMCywjC6Yqy5dzfIb3kb1G12VFHqxjbiexb8Ci6L7GU8XYIgSiRimTQej+1
         r11yR0+BOQLRevatBuJf30uhuRSRFaslr6AHyJVTNPmMxLTysbDx5lIMiOjDHgyY6T4E
         Apag==
X-Gm-Message-State: AJcUukeLfulmRUqraJcYSVPE1UZVh4Kkejw5hTfwmRQQS3iRnXYYGFku
        yB7UxdDpfKE2ft1rmeLJr+s=
X-Google-Smtp-Source: ALg8bN7ULEqORgbDL7oKzl/40JGFnPU2I9R1bZ6mA/Z0bL3N/g3Ub8FhnH5wYICqRUhSNwgNhtJ0xw==
X-Received: by 2002:adf:81c6:: with SMTP id 64mr3373605wra.186.1547144281431;
        Thu, 10 Jan 2019 10:18:01 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c15sm14046890wml.27.2019.01.10.10.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 10:18:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] ref-filter: add new formatting options
References: <CAL21BmnoZuRih3Ky66_Tk0PweD36eZ6=fbY3jGumRcSJ=Bc_pQ@mail.gmail.com>
        <CAL21BmnmfxpMgbW_Yz9D=FVZk_AzWF0uyrNZeSGPCs63PH1oag@mail.gmail.com>
        <CAL21Bm=stCR8-yJ-eh396veQ2kAoGwLX5ci_T0N-6femAwk4jA@mail.gmail.com>
Date:   Thu, 10 Jan 2019 10:17:59 -0800
In-Reply-To: <CAL21Bm=stCR8-yJ-eh396veQ2kAoGwLX5ci_T0N-6femAwk4jA@mail.gmail.com>
        (=?utf-8?B?ItCe0LvRjyDQotC10LvQtdC20L3QsNGPIidz?= message of "Thu, 10 Jan
 2019 09:25:40
        +0300")
Message-ID: <xmqqpnt42x7s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Оля Тележная  <olyatelezhnaya@gmail.com> writes:

> Just fixed 1 cast from (intmax_t) to (uintmax_t).

Thanks.

As the previous one already is in 'next', let's queue this on top of
it instead.

-- >8 --
Subject: [PATCH] ref-filter: give uintmax_t to format with %PRIuMAX

As long as we are casting to a wider type, we should cast to the one
with the correct signed-ness.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ref-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index d8d3718abb..b22cab133e 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -897,7 +897,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 			v->s = xstrdup(type_name(oi->type));
 		else if (!strcmp(name, "objectsize:disk")) {
 			v->value = oi->disk_size;
-			v->s = xstrfmt("%"PRIuMAX, (intmax_t)oi->disk_size);
+			v->s = xstrfmt("%"PRIuMAX, (uintmax_t)oi->disk_size);
 		} else if (!strcmp(name, "objectsize")) {
 			v->value = oi->size;
 			v->s = xstrfmt("%lu", oi->size);
-- 
2.20.1-98-gecbdaf0899

