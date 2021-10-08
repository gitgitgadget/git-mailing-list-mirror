Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFD0C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 04:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529BA61037
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 04:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhJHEfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 00:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhJHEfv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 00:35:51 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35B4C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 21:33:56 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id x4so5367669pln.5
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 21:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UP4SybYFjuXPpcV/KhBfYUb0nwKz5pxPw8tVrldTgbA=;
        b=lDHXK4d6T9FP8UpzJ/I8SnAeCGwg9MI8TKLvjQvORVjnz/w09SCngT9HW6msejg0AG
         NhAGO4EmXsU9SU/Hl81k7XvhkIt1kutuJv5laYpOgwlukSwByzuGdKuCYxrVw1GlSybj
         JvqHDun8IuqWGOy/gCj/jKsDhuXTzlcw8AIPGbYx5h94pRb3zGRAMkyT9Jsa2dO6Gl7F
         dyklDjLJ4OcLKLeCP1RLQvEzsqsYCiaWQ8QUx6CfnTekzj9F3JNc3fvQe7VfvOWLrr8N
         bix4ZdsK7YiRk+i9F9jxfsML+S6WZMixlcZlDWVAIckXfHYg2C3CMXGFcHOfsFB1sW+U
         fopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UP4SybYFjuXPpcV/KhBfYUb0nwKz5pxPw8tVrldTgbA=;
        b=4fGJEPtjevw3KF+9V4IF3gjKhoNSF5O1KwFWvfcWGovy/6AIPrBB53kAUdXqyjYjJg
         mQW+mav86mosDHoyA9xQp43IuxYJlqh6WOUT+bJ3ih3D/0DMP/FAyGs0btAzwcnNThs3
         3s0KuwkckGsSxBm0aMihbYXAHZkQiPSrgrCLAEn6oP5YXWde9mOa48Rqr+A0jVfEB7ji
         VseltknF5fsK6MzgnxP6AO1QKS0ivYOd+AlPLAMFrBnzQCQSSQrae9Ppxrhf8Ha0NTGb
         EsOcGZDMoUOWJXTNms6xGOXVY20usWBHp45stmmukhEixA+d8fWFCiKKck3B9qOPfMiR
         Up1w==
X-Gm-Message-State: AOAM532jW5aZ5UWHlBgj1Qn6fH61/Y2yLP5ZZlyjRoiscULDOdNVLlhi
        I8kB1H/tZe2985V67hWLW8jtieXA6n8msio0
X-Google-Smtp-Source: ABdhPJwo35m0XBM/Y6GHNPzPZgc+laZl/ioCYR7ElSqCeYLfSIUkGIXAQenKY59aEfXdb8kmKPHNnQ==
X-Received: by 2002:a17:90b:188b:: with SMTP id mn11mr7428246pjb.170.1633667636091;
        Thu, 07 Oct 2021 21:33:56 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-82.three.co.id. [180.214.233.82])
        by smtp.gmail.com with ESMTPSA id k14sm870845pga.65.2021.10.07.21.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 21:33:55 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        "Dr . Matthias St . Pierre" <m.st.pierre@ncp-e.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/2] blame: documentation update
Date:   Fri,  8 Oct 2021 11:33:41 +0700
Message-Id: <20211008043343.189651-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document the default output format for git-blame(1), as well as the
--color-* options which are currently undocumented but mentioned in
usage help.

Changes since v4 [1]:
  - Remove "(see section X)" pointer (suggested by Junio)

Bagas Sanjaya (2):
  blame: describe default output format
  blame: document --color-* options

 Documentation/blame-options.txt | 11 +++++++++++
 Documentation/config/color.txt  | 33 ++++++++++++++++++---------------
 Documentation/git-blame.txt     | 17 +++++++++++++++--
 3 files changed, 44 insertions(+), 17 deletions(-)

Range-diff against v4 [1]:
1:  976c17a485 = 1:  977c3dd77d blame: describe default output format
2:  517dc2cb3d ! 2:  df39496623 blame: document --color-* options
    @@ Documentation/blame-options.txt: take effect.
      	previously processed files.
      
     +--color-lines::
    -+	Color line annotations (see "The Default Format" section) differently if they
    -+	come from the same commit as the preceding line, and if neither `--porcelain`
    -+	nor `--incremental` format option is specified. This makes it easier to distinguish
    ++	Color line annotations, in the default format, differently if they come from
    ++	the same commit as the preceding line. This makes it easier to distinguish
     +	code blocks introduced by different commits. The color defaults to cyan and
     +	can be adjusted using the `color.blame.repeatedLines` config option.
     +
     +--color-by-age::
    -+	Color line annotations (see "The Default Format" section) depending on the age of
    -+	the line, if neither `--porcelain` nor `--incremental` format option is specified.
    ++	Color line annotations depending on the age of the line, in the default format.
     +	The `color.blame.highlightRecent` config option controls what color is used for
     +	each range of age.
     +

[1]:
https://lore.kernel.org/git/20211003105327.215996-3-bagasdotme@gmail.com/T/#u

base-commit: 106298f7f9cca4158a980de149ef217751e1f943
-- 
An old man doll... just what I always wanted! - Clara

