Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C12E11F461
	for <e@80x24.org>; Sat,  7 Sep 2019 21:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406361AbfIGVgO (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 17:36:14 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41168 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392847AbfIGVgO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 17:36:14 -0400
Received: by mail-io1-f66.google.com with SMTP id r26so20558536ioh.8
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 14:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v3j4GCxf7pzno4Ay86DxKgjVu8Y20s38lA03KAnSVZo=;
        b=RBnX1bet38IFOT3oK9JAxMUD+FgMS9qNOcIRFNmpOb+XaXeoHcRCdZHrPxz1gKXM8g
         UDpwbUXQsKPNHoVUPnUcwi0CaGFPakpANOemQ4ALti3WMkX+CLUmkXgdKVTwfoJSYOvC
         NnnRf8hCXA8EcDkQXuVhhnieVNiGS8Y6Kj91+H3niNEDoRtgTQZoLPNs3nQbVNYcwPP+
         fwjcA+AAd6YzN4GVShTF1Loy8NrgfyqZ+QGGs+J6ql92s2oVbPdJ5hhp4jobkPNo0LK9
         9CiEwfsF+pW3y4eo0D5jclwCUsgHrxf18/BRkk5lpyoyLQ/lgrB7csyAUQ5olms3YqQ6
         i/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v3j4GCxf7pzno4Ay86DxKgjVu8Y20s38lA03KAnSVZo=;
        b=dnlxr3U4sRljoIvIGclW0kVk7wSCdXx5lZYrxU/pmun0QFRz9/0Z0O0kwcZChCWidw
         uTA4Rg5SSfOZpMI4Q3W3kgduOLDglVeDZjluK3iBVx0H3M0kZLOSP9wqqBYecUKsDHks
         zC8HPb8ChRI+GQDe0UWBMQjIgPtIgkJzLsKjBkqQCYdVDaxN4cPMrXZSlAjiKmVJYR7P
         X85mLf9aVvj0klv1cmtAVjD7z71LSo5lOZ5691ij8OVj3qs+VcOQcMvj9uDgjF5obhVl
         rheszdTZF0bbjR6ChbfMg+ML9NmiSp7Ew8XATKkDrjr6FAoPr3NmFVl3BFIAnfepcwOc
         v+Ow==
X-Gm-Message-State: APjAAAUYTxfoPVWydImQZODnvZaU5EFeVvpR48+n43bVXF465i8Mflr2
        80GziHzrb+G8jYCRAWAXPltApwpu
X-Google-Smtp-Source: APXvYqwAgM8KDsBjjJbJI0gUGLY4KcvfN5RkfoCplfCG9M5akk1CRLTp6w+dLracCQHXaSlRWV78JA==
X-Received: by 2002:a02:1109:: with SMTP id 9mr18278601jaf.90.1567892173303;
        Sat, 07 Sep 2019 14:36:13 -0700 (PDT)
Received: from ericfreese.hsd1.co.comcast.net ([2601:285:8280:27a7::c608])
        by smtp.gmail.com with ESMTPSA id x5sm4379774ior.46.2019.09.07.14.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 14:36:12 -0700 (PDT)
From:   Eric Freese <ericdfreese@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Freese <ericdfreese@gmail.com>
Subject: [RFC PATCH 0/1] for-each-ref: Add '--no-symbolic' option
Date:   Sat,  7 Sep 2019 15:36:45 -0600
Message-Id: <20190907213646.21231-1-ericdfreese@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I was recently using git-for-each-ref in a script to get a list of
remote refs that pointed at a particular commit so that they could
automatically be updated and pushed back to that remote. This fails when
it comes across refs/remotes/origin/HEAD, which is a symbolic link.

I was able to solve the problem with:

```
git for-each-ref ... --format="%(refname) %(symref)" | grep " $"
```

But that feels a little clumsy to me. I would have expected there to be
a flag like `--no-symbolic` that would exclude symbolic refs from the
output. So I went ahead and added it :)

I could forsee this option also being added to git-branch and git-tag,
but decided to keep it to git-for-each-ref to test the waters before
investing any further time into it.

Cheers

Eric Freese (1):
  for-each-ref: add '--no-symbolic' option

 Documentation/git-for-each-ref.txt | 3 +++
 builtin/for-each-ref.c             | 4 +++-
 ref-filter.c                       | 4 ++++
 ref-filter.h                       | 3 ++-
 t/t6302-for-each-ref-filter.sh     | 6 ++++++
 5 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.23.0

