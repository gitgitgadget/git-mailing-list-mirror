Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 600EF1F4B6
	for <e@80x24.org>; Thu, 16 May 2019 23:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfEPXNs (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 19:13:48 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51523 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfEPXNs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 19:13:48 -0400
Received: by mail-it1-f193.google.com with SMTP id m3so5223338itl.1
        for <git@vger.kernel.org>; Thu, 16 May 2019 16:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YF7R07c+NTQvDRmlMMZdXvFYRBu26WBOcQUzTiWqDg8=;
        b=aflU027cfIWi51brWH3XSTPwABJ4YLc+vQRE4+NRiVi6//VQRyR+52o5LR476W1mWt
         2ffQFNBu4EVwD9BEds45+TFHtV8TiKHKIB7pxfvpdwxINKUHQwEPbe+hCATRxOLzlYMc
         AZqSn1a2zG29o8tKN41GuGr9VIg6H3I0EX5skBrVF7cOtX1i9cQiSVgTSOoPMIn3xag7
         4a3kiP7y7Bp/e9pczdhC5B3Lth6fhNKsYgPSrLdzUe4EeRe1vIHJDuvl9Hp8dj4GeV9J
         btrtyQ7DE8kFQ3hiJKf67cdYL+4RN1W5yR8w+OE/ka9QMt1X6wEp2AcNI+xdT6i5vFPb
         dJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YF7R07c+NTQvDRmlMMZdXvFYRBu26WBOcQUzTiWqDg8=;
        b=iRBNwHCm8o3zGiCcJn7MeXFkAxzZG/2ya+4tBg/xNeJLxFHnAGx6VQ3kJOqWdKbk1z
         M33wUBA/jntNLJ56O06U4iLqMuZ5pNIZUqfxZqHa5sUwId9Hd9EjdsMx/U3s5hLH7Mio
         xKbZfurf0KP23IL7TDd06PpEB7c9aSNIUiUWEqYPQGSkSaLXalLOcq9LyI/v6FMYvG7N
         oBFihBeeHt1BLkJu5WRhsKqES1+zTHO+CO4JRiVKaxlool6nDCwMi7e6A75JNm/sc+f9
         VUOWT9UaUHRNiVxku/spocqgbeAu3bgFTTphvco4INDcIZg+Msjw5MR+YtYLJEp5Rlqt
         Hdww==
X-Gm-Message-State: APjAAAW6/FQv/uNoXe0Jd3yiJCMfjeb0DgZUf8wFOSBQ2UfRsA3f9bad
        nU1UuF3mypTzrygpsvJ0UMIUDiSM
X-Google-Smtp-Source: APXvYqyXAz1madmri3Nflr3XtY33sjxw9UIAOgHrDOfhcXpZU1uED1VQwkSHhcle+SjuSVYsicymDg==
X-Received: by 2002:a24:e3cb:: with SMTP id d194mr14364746ith.100.1558048427259;
        Thu, 16 May 2019 16:13:47 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id 8sm2130445ioe.1.2019.05.16.16.13.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 16:13:46 -0700 (PDT)
Date:   Thu, 16 May 2019 19:13:44 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v4 0/2] format-patch: teach format.notes config option
Message-ID: <cover.1558048212.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I've changed format.notes so that it can accept a boolean as well.
Hopefully, my last email has addressed the remainder of your comments.

Changes since v3:

* Made format.notes accept a boolean instead of "standard" to get
  default notes

Changes since v2:

* Fixed if-else code style
* Fixed typoed errors in 2/2 log message

Changes since v1:

* Made format.notes accept a notes ref instead of a boolean


Denton Liu (2):
  git-format-patch.txt: document --no-notes option
  format-patch: teach format.notes config option

 Documentation/config/format.txt    | 15 +++++++
 Documentation/git-format-patch.txt |  7 ++-
 builtin/log.c                      | 20 ++++++++-
 t/t4014-format-patch.sh            | 70 ++++++++++++++++++++++++++++++
 4 files changed, 110 insertions(+), 2 deletions(-)

Range-diff against v3:
1:  4c3535f25b = 1:  4c3535f25b git-format-patch.txt: document --no-notes option
2:  df864c4adf ! 2:  7cb770e190 format-patch: teach format.notes config option
    @@ -25,14 +25,16 @@
      	format-patch by default.
     +
     +format.notes::
    -+	A ref which specifies where to get the notes (see
    -+	linkgit:git-notes[1]) that are appended for the commit after the
    -+	three-dash line.
    ++	Provides the default value for the `--notes` option to
    ++	format-patch. Accepts a boolean value, or a ref which specifies
    ++	where to get notes. If false, format-patch defaults to
    ++	`--no-notes`. If true, format-patch defaults to `--notes`. If
    ++	set to a non-boolean value, format-patch defaults to
    ++	`--notes=<ref>`, where `ref` is the non-boolean value. Defaults
    ++	to false.
     ++
    -+If the special value of "standard" is specified, then the standard notes
    -+ref is used (i.e. the notes ref used by `git notes` when no `--ref`
    -+argument is specified). If one wishes to use the ref
    -+`ref/notes/standard`, please use that literal instead.
    ++If one wishes to use the ref `ref/notes/true`, please use that literal
    ++instead.
     ++
     +This configuration can be specified multiple times in order to allow
     +multiple notes refs to be included.
    @@ -69,15 +71,17 @@
      	}
     +	if (!strcmp(var, "format.notes")) {
     +		struct strbuf buf = STRBUF_INIT;
    -+
    ++		int b = git_parse_maybe_bool(value);
    ++		if (!b)
    ++			return 0;
     +		rev->show_notes = 1;
    -+		if (!strcmp(value, "standard")) {
    -+			rev->notes_opt.use_default_notes = 1;
    -+		} else {
    ++		if (b < 0) {
     +			strbuf_addstr(&buf, value);
     +			expand_notes_ref(&buf);
     +			string_list_append(&rev->notes_opt.extra_notes_refs,
     +					strbuf_detach(&buf, NULL));
    ++		} else {
    ++			rev->notes_opt.use_default_notes = 1;
     +		}
     +		return 0;
     +	}
    @@ -117,7 +121,7 @@
     +	git format-patch -1 --stdout --no-notes --notes >out &&
     +	grep "notes config message" out &&
     +
    -+	test_config format.notes standard &&
    ++	test_config format.notes true &&
     +	git format-patch -1 --stdout >out &&
     +	grep "notes config message" out &&
     +	git format-patch -1 --stdout --notes >out &&
-- 
2.21.0.1049.geb646f7864

