Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42A221F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 00:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfKSAVL (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 19:21:11 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39227 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKSAVL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 19:21:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id x28so11206494pfo.6
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 16:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=piLQhO8y70mCGljngh/h62UNS1tyivHR2mv7BEsXQpo=;
        b=GZZcP42Az8Cxxl7Cbvf9YHxHbOU3kGevEMaqyt3+WdnfheyWCjSgnrNTzZwMvDKw1r
         TQxqOhAv71trA0k7AKCJvMyS/gDf645aKYoDdmskzO71pOeJ9680fY1uWTmHiVljdgs+
         t/5xqBuEIXVvo/JXxHQbBWfTXKaI0nXJO7HEPaJJRhRO43j+0fCBii21JBsW8seCvuvS
         bRnc66BbN+y28Qfg4ngQuydUsQbNY2dpqAU6u8sCfjULlMYWfnklw5raC/TfL6xKR8eR
         ce7+44LQlTahU3npu1DjG0xPDnQ+AC7FKdu3b0dVbV0UAS8NSCGxNi9/ljisVOaAfF/w
         q2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=piLQhO8y70mCGljngh/h62UNS1tyivHR2mv7BEsXQpo=;
        b=JrznmUY7k3qdzLk5/j6TRuVnZ9ipAbvajsKE/h76gFDsug6OPR71yXd3JnDRtNeCii
         z7oEj/Oj6ZG1baVIj6Zeyj2ramyuZDK5tmiV//20yEpo7Hdq8qBUlkTtW+Cl7XbHbnGW
         /TXONdZ5htyajZgqt2iKNEvqA2K1MrmFfL8hVAlY+B0h5gePQUePTk5H0/3PmkAHPkFh
         tOBkYQujLI/ipbOOEXbheWIfQAo1F4TZ6pmwaMHBTnJxfsfFBISX0FIXbrlZzGlcMQb4
         aVNrM2g1CvgFd8560VrX1UNppX/7GU97Rb5HvHwFEblxGdiEL92UNBAImUBF5sLY972/
         +SOA==
X-Gm-Message-State: APjAAAXQLugrW2MVjWMdVekLviGACOv/d28Ut3V2O4Qx1l2aFaN3A3A9
        vn0Y2d6eD3beA8rk2g6ayqutZ62r
X-Google-Smtp-Source: APXvYqz0RyxPZVxZUYxar2T59L6GLYmcotb7m21Wqx2yNIbd+MyqtU34aOlyxvxbWE2JxTUhIkARJg==
X-Received: by 2002:a63:5511:: with SMTP id j17mr2327696pgb.70.1574122869617;
        Mon, 18 Nov 2019 16:21:09 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id c2sm22333523pfn.55.2019.11.18.16.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 16:21:08 -0800 (PST)
Date:   Mon, 18 Nov 2019 16:21:06 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v4 00/11] learn the "reference" pretty format
Message-ID: <cover.1574122784.git.liu.denton@gmail.com>
References: <cover.1573764280.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1573764280.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On this mailing list (and many others) the standard way to reference
other commits with the "reference" format, e.g. "f86a374 (pack-bitmap.c:
fix a memleak, 2015-03-30)". Since it's so commonly used, let's
standardise it as a pretty format.

Patches 5-7 were cleanup patches that were critical in earlier
iterations of the series but no longer are critical for the rest of the
patchset. Nonetheless, let's include them since they improve the quality
of the codebase.

Changes since v3:

* Change one reference from "summary" to "reference"

* Clarify --pretty=reference documentation

* Add a squashable patch at the end to implement overridable --date

Changes since v2:

* Rename from "summary" to "reference"

* Implement the feature as a canned userformat

* Implement the %*s (short date) format string element

* Remove the enclosing dqs around the subject

Changes since v1:

* Replace more references to "sha1" with "hash"

* Clean up 8/10 by losing the allocation and making the subject less
  misleading

* Add tests in 7/10 to ensure 8/10 does not change any behaviour

Denton Liu (10):
  SubmittingPatches: use generic terms for hash
  pretty-formats.txt: use generic terms for hash
  SubmittingPatches: remove dq from commit reference
  completion: complete `tformat:` pretty format
  revision: make get_revision_mark() return const pointer
  pretty.c: inline initalize format_context
  t4205: cover `git log --reflog -z` blindspot
  pretty: implement 'reference' format
  SubmittingPatches: use `--pretty=reference`
  squash! pretty: implement 'reference' format

René Scharfe (1):
  pretty: provide short date format

 Documentation/SubmittingPatches        | 16 ++++--
 Documentation/pretty-formats.txt       | 29 +++++++---
 Documentation/pretty-options.txt       |  2 +-
 Documentation/rev-list-options.txt     |  4 +-
 contrib/completion/git-completion.bash |  2 +-
 pretty.c                               | 23 ++++++--
 revision.c                             |  4 +-
 revision.h                             |  4 +-
 t/t4205-log-pretty-formats.sh          | 79 ++++++++++++++++++++++++++
 9 files changed, 137 insertions(+), 26 deletions(-)

Range-diff against v3:
 1:  d0f0b86f5f =  1:  3b9b72feec SubmittingPatches: use generic terms for hash
 2:  aabd7574d2 =  2:  2cc7cc6e75 pretty-formats.txt: use generic terms for hash
 3:  ef0adc260d =  3:  61e1a25f93 SubmittingPatches: remove dq from commit reference
 4:  d7e4dc9154 =  4:  5d9fd9d632 completion: complete `tformat:` pretty format
 5:  cc219ec513 =  5:  bfb216954b revision: make get_revision_mark() return const pointer
 6:  883517ee65 =  6:  34e1b6a7ac pretty.c: inline initalize format_context
 7:  b35b287635 =  7:  78e4d75d2b t4205: cover `git log --reflog -z` blindspot
 8:  b0ac175d6f =  8:  9d4dfcc115 pretty: provide short date format
 9:  a4b87ad271 !  9:  5042161d73 pretty: implement 'reference' format
    @@ Documentation/pretty-formats.txt: This is designed to be as compact as possible.
     +
     +	  <abbrev hash> (<title line>, <short author date>)
     ++
    -+This format is useful for referring to other commits when writing a new
    -+commit message. It uses the following canned user format:
    -+`%C(auto)%h (%s, %as)`. This means it will not respect options that
    -+change the output format such as `--date` `--no-abbrev-commit`, and
    -+`--walk-reflogs`.
    ++This format is used to refer to another commit in a commit message and
    ++is the same as `--pretty='format:%C(auto)%h (%s, %as)'`.  As with any
    ++`format:` with format placeholders, its output is not affected by other
    ++options like `--decorate` and `--walk-reflogs`.
     +
      * 'email'
      
    @@ Documentation/rev-list-options.txt: Under `--pretty=oneline`, the commit message
      This option cannot be combined with `--reverse`.
      See also linkgit:git-reflog[1].
     ++
    -+Under `--pretty=summary`, this information will not be shown at all.
    ++Under `--pretty=reference`, this information will not be shown at all.
      
      --merge::
      	After a failed merge, show refs that touch files having a
10:  04d24cbf4b = 10:  888c496991 SubmittingPatches: use `--pretty=reference`
 -:  ---------- > 11:  580aa7c88c squash! pretty: implement 'reference' format
-- 
2.24.0.420.g9ac4901264

