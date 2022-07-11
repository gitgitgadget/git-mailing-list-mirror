Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132F8C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 13:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiGKNRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 09:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiGKNRo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 09:17:44 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC253FA1B
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 06:17:43 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so5012860wme.0
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 06:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:references:from:cc:in-reply-to
         :content-transfer-encoding;
        bh=lhIDQlgm/wdeU9RR37RDRGAVW1PNp54RinoCTXte/bY=;
        b=Xqk6GewZX3GWBC6BT1ShNzluEyU9kRtMfnb5e5ZspsHEfRbGiNa2q60uu/KvtBEUw1
         RG3FwFpp2npmRlCH2jdvA46TOhtLFK+yo9yg2vum2N2gyE/Yg1csjiom1mKclgX52TCa
         xzY6p+JwSaiAGVE0beubK+HaXxDUfDp/+MtByB4cWbmOteon67q5IkriZouCIasA7Dwj
         E457uBh9MgCee2UArFSG2vxvbo6TlNDILuDUDM9lF+iUKaOXSdk5ia0khYUqtmp6qSzg
         2FCJFWqn2rTnyMu0xkcomVDeXTYqcW8QZAVIlDnXmESkxcBXGaitD3+1v0jwI5qHQrqD
         /z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:references:from:cc:in-reply-to
         :content-transfer-encoding;
        bh=lhIDQlgm/wdeU9RR37RDRGAVW1PNp54RinoCTXte/bY=;
        b=XhyYbu1wFdx5Wdr1izuCZhF0/T4Hze9jKBV+lT+sXeXAE+EnB7M0bBgKeE6zaZW6DB
         oUSxeINDJUM+qrb+WHKLjnKQ+rcAPlrMXcFfAY5goNunG8KECUaU0IgbmS2CvBnZng/y
         sd6NOk9eSulKB3xkbrWBFyuALGODSmXSyZi+NllbuV0XyHRPYDAGA0sOxUZngGB1lILa
         JsSdSUI/oG6M6E2WDPMZqo85mkL8GnTd92/0zN+h/cnaqGwQhhxhX3+VeN7wyht7StXD
         6j8KYXKXAUwyVzmSk6Qia4UC4rBHg/HTjWYe+ZimOWVc1Iyee7jf80xS7Oi4TfjJmZlK
         HChQ==
X-Gm-Message-State: AJIora+Ugkew2wumMQdtgCe8fsNbETT71/TqINdP4ze9nFQcW54blUh5
        mcGWvCjfuWI0LhVfCPZj4l4=
X-Google-Smtp-Source: AGRyM1voQySU/bKS+4auF5P8A2ZV5FAdIWyiJXiZNZP6UxdiITedhkrKysXuHaHHs606+0a4nStcDw==
X-Received: by 2002:a05:600c:4f95:b0:3a2:e2af:2090 with SMTP id n21-20020a05600c4f9500b003a2e2af2090mr12029190wmq.158.1657545462065;
        Mon, 11 Jul 2022 06:17:42 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c2ca600b0039c63f4bce0sm10106812wmc.12.2022.07.11.06.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 06:17:41 -0700 (PDT)
Message-ID: <0c07f6ca-d52a-f285-56cc-1b673f7d98fb@gmail.com>
Date:   Mon, 11 Jul 2022 14:17:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Automatic code formatting
Content-Language: en-GB-large
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
In-Reply-To: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian

On 10/07/2022 22:50, brian m. carlson wrote:
> Most projects written in languages like Rust or Go use an automatic
> formatter.  In Go's case, the formatter is specifically stated to be a
> fixed style that is nobody's favourite, but because there's an automatic
> formatter, everybody just uses it.  Personally, I don't love our coding
> style now (I'm a 4-space person in C), but I would love it a lot more if
> I didn't have to think about it.  I am substantially less picky about
> what the style is than that we have an automated tool to tidy our code,
> and I'm okay with us producing the occasional slightly suboptimal style
> for the improved efficiency we get.
 > [...]
 > I should note that we already have a .clang-format file, so we can
 > already use clang-format.  However, we cannot blindly apply it because
 > it produces output that is not always conformant with our style.  My
 > proposal here is to define our style in terms of the formatter to avoid
 > this problem.

I agree it is lovely not to have to think about the style rules when 
writing code for a project that has an automatic formatter. As Junio 
said I think it would take a bit of work to persuade clang-format to 
match our style and I'm concerned that adopting the style it produces 
now would lead to a lot of churn. Below is an example taken from [1] 
that shows one area for improvement. At the moment its struct formatting 
seems inconsistent (one struct ends up with one field per line and the 
second has more than one field per line with a completely different 
indentation to the first) and I'm not sure we want it reformatting the 
whole definition when a new member is added. When Han-Wen Nienhuys 
submitted that patch I did have a brief play with the clang-format rules 
to try and improve it but didn't get anywhere.

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/2c2f94ddc0e77c8c70041a2a736e3a56698f058c.1589226388.git.gitgitgadget@gmail.com

@@ -3173,30 +3282,31 @@ static int files_init_db(struct ref_store 
*ref_store, struct strbuf *err)
  	return 0;
  }

-struct ref_storage_be refs_be_files = {
-	NULL,
-	"files",
-	files_ref_store_create,
-	files_init_db,
-	files_transaction_prepare,
-	files_transaction_finish,
-	files_transaction_abort,
-	files_initial_transaction_commit,
-
-	files_pack_refs,
-	files_create_symref,
-	files_delete_refs,
-	files_rename_ref,
-	files_copy_ref,
-
-	files_ref_iterator_begin,
-	files_read_raw_ref,
-
-	files_reflog_iterator_begin,
-	files_for_each_reflog_ent,
-	files_for_each_reflog_ent_reverse,
-	files_reflog_exists,
-	files_create_reflog,
-	files_delete_reflog,
-	files_reflog_expire
-};
+struct ref_storage_be refs_be_files = { NULL,
+					"files",
+					files_ref_store_create,
+					files_init_db,
+					files_transaction_prepare,
+					files_transaction_finish,
+					files_transaction_abort,
+					files_initial_transaction_commit,
+
+					files_pack_refs,
+					files_create_symref,
+					files_delete_refs,
+					files_rename_ref,
+					files_copy_ref,
+
+					files_write_pseudoref,
+					files_delete_pseudoref,
+
+					files_ref_iterator_begin,
+					files_read_raw_ref,
+
+					files_reflog_iterator_begin,
+					files_for_each_reflog_ent,
+					files_for_each_reflog_ent_reverse,
+					files_reflog_exists,
+					files_create_reflog,
+					files_delete_reflog,
+					files_reflog_expire };
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 4458a0f69cc..8f9b85f0b0c 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1641,29 +1641,19 @@ static int packed_reflog_expire(struct ref_store 
*ref_store,
  }

  struct ref_storage_be refs_be_packed = {
-	NULL,
-	"packed",
-	packed_ref_store_create,
-	packed_init_db,
-	packed_transaction_prepare,
-	packed_transaction_finish,
-	packed_transaction_abort,
-	packed_initial_transaction_commit,
-
-	packed_pack_refs,
-	packed_create_symref,
-	packed_delete_refs,
-	packed_rename_ref,
-	packed_copy_ref,
-
-	packed_ref_iterator_begin,
-	packed_read_raw_ref,
-
-	packed_reflog_iterator_begin,
-	packed_for_each_reflog_ent,
-	packed_for_each_reflog_ent_reverse,
-	packed_reflog_exists,
-	packed_create_reflog,
-	packed_delete_reflog,
-	packed_reflog_expire
+	NULL, "packed", packed_ref_store_create, packed_init_db,
+	packed_transaction_prepare, packed_transaction_finish,
+	packed_transaction_abort, packed_initial_transaction_commit,
+
+	packed_pack_refs, packed_create_symref, packed_delete_refs,
+	packed_rename_ref, packed_copy_ref,
+
+	/* XXX */
+	NULL, NULL,
+
+	packed_ref_iterator_begin, packed_read_raw_ref,
+
+	packed_reflog_iterator_begin, packed_for_each_reflog_ent,
+	packed_for_each_reflog_ent_reverse, packed_reflog_exists,
+	packed_create_reflog, packed_delete_reflog, packed_reflog_expire
  };
