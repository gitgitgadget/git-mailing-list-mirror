Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63A5C1F45F
	for <e@80x24.org>; Fri, 10 May 2019 18:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfEJShE (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 14:37:04 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39440 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbfEJShE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 14:37:04 -0400
Received: by mail-it1-f196.google.com with SMTP id 9so3573851itf.4
        for <git@vger.kernel.org>; Fri, 10 May 2019 11:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TwNMhJBbnYIOO4nEJrt/JraFjY4XW5erU+5lRmG+xYo=;
        b=ZKhdB5lqdqRbTHEBA22vFtMwwyBfYmbqGZb+cGqxiHAUoOe5O/s7H4Ju6gK1jdDIHf
         xqRF5zIeRMkU20kGNjRfIywYSHAGjetvu087ySmcCqzIoH9SR0y0osTp04wdGbjlMAD+
         6HuajDqLDRtJc7v1xt/WXEFQrVu3V/IROlyzmJJPqV6iPH32i4d+Xzhaah/Wwy6Mp/yp
         sjHrINCMGUVR+JK/JxLy/4i7MXCP8AllbjjBJVrJRfbf+/Jb64e4ogeQlJ2SeLvVH2mE
         DESkKrNzA4iA5HtitynbkIT3EjU3TqaAD6P6nOo23lEQUuR6MAKSU+dsQ8RHjyiarf21
         cA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TwNMhJBbnYIOO4nEJrt/JraFjY4XW5erU+5lRmG+xYo=;
        b=Cb5K+lf4b6oMilTh4Md79mvhTl4+p/SQPEiJTtfUAqywLLqw9TstJ74ZzQN5+/gqlB
         q9P9rt6m0JohnLqs/sEWg5GbmkOyvvchZm68eJ1KoW3bfHWh5juaVFc3O0QuTIkOg4q6
         iu3tpGMthE3XOciIVrVlVTzFbGK9l+/Og+uP6msEEnpaFTrMAf9QfHCTZj0IRctU2h4R
         IkmcG6o/FGwfuia2hvgoENqXyBeFYl26phsah39Nc/3QSoZaWe5ao4gWlxY9rI+I0izP
         ZYH/uRFRu+XOMwSXECtj1IeDQPnSYVfGSLiK7u872OjGI6ViLt7qp1PjhBttaOF0fbZI
         CZJQ==
X-Gm-Message-State: APjAAAUgap7D9u9LXzKjXrbm9DGjmKOlKgDv0wbh8TaaQPw7sQfxLyiW
        jOmH27qq0MFiRg8B886DnjoWavQE
X-Google-Smtp-Source: APXvYqy4QQ3+sOFbsBt6X1Vn4/75xk03h26gaCoZbIIYQNsyWVPtXRaWQrNi499KRZtUCTFYgrzdZA==
X-Received: by 2002:a24:22cc:: with SMTP id o195mr7856478ito.2.1557513422889;
        Fri, 10 May 2019 11:37:02 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id p189sm2809919itp.42.2019.05.10.11.37.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 11:37:01 -0700 (PDT)
Date:   Fri, 10 May 2019 14:37:00 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v3 0/2] format-patch: teach format.notes config option
Message-ID: <cover.1557513353.git.liu.denton@gmail.com>
References: <cover.1557327652.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1557327652.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Beat, thanks for catching the style errors. This version fixes those.

Changes since v2:

* Fixed if-else code style
* Fixed typoed errors in 2/2 log message

Changes since v1:

* Made format.notes accept a notes ref instead of a boolean


Denton Liu (2):
  git-format-patch.txt: document --no-notes option
  format-patch: teach format.notes config option

 Documentation/config/format.txt    | 13 ++++++
 Documentation/git-format-patch.txt |  7 ++-
 builtin/log.c                      | 18 +++++++-
 t/t4014-format-patch.sh            | 70 ++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 2 deletions(-)

Range-diff against v2:
1:  4c3535f25b = 1:  4c3535f25b git-format-patch.txt: document --no-notes option
2:  fe674bf63e ! 2:  df864c4adf format-patch: teach format.notes config option
    @@ -8,8 +8,8 @@
         that they may forget to include it and generate a patch series without
         notes.
     
    -    Teach git-format-patch the `format.notes` config option its value is a
    -    notes ref that will be automatically be appended. The special value of
    +    Teach git-format-patch the `format.notes` config option. Its value is a
    +    notes ref that will be automatically appended. The special value of
         "standard" can be used to specify the standard notes. This option is
         overridable with the `--no-notes` option in case a user wishes not to
         append notes.
    @@ -71,9 +71,9 @@
     +		struct strbuf buf = STRBUF_INIT;
     +
     +		rev->show_notes = 1;
    -+		if (!strcmp(value, "standard"))
    ++		if (!strcmp(value, "standard")) {
     +			rev->notes_opt.use_default_notes = 1;
    -+		else {
    ++		} else {
     +			strbuf_addstr(&buf, value);
     +			expand_notes_ref(&buf);
     +			string_list_append(&rev->notes_opt.extra_notes_refs,
-- 
2.21.0.1049.geb646f7864

