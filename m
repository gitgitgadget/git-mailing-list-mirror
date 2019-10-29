Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A0341F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 13:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388791AbfJ2Nh6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 09:37:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34012 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388578AbfJ2Nh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 09:37:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id v3so2015301wmh.1
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 06:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=qsIrXDlMhYI1gdEM9wSsZmLuaEuDzDm3aUUF4qhfpz0=;
        b=GR5TMjh17/Prybi2xnGe2fAClhOVt0QYMLj5Mnmxaw+aZZC9+2eiQcGUYFYBhorsFe
         kcD31iTXjXhSwLjf293J3K15hoDxrJnL+P09yuMMtb5xExlXmnwYO5tjo9kbBYwMT0+k
         Kyw8gzJLw27aVkuY/WrtMBybLAHBFNFS0jm4eMgCfPQto9tWjn1Q7dNNkEI7aMLywz81
         Zs3Dg9OHuLQ2SoSpWNduEH6tn9X7dGrRCJnLrl1Xqd/ngcCNVu5iLNDfLJp46YBujbaI
         DM6AvWbeI0z/LXG/rAGbvfdM8DWavqchDgRMZDErL3rJ++9Ujdz5IWrEHzK9jTYCyIJZ
         1g8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=qsIrXDlMhYI1gdEM9wSsZmLuaEuDzDm3aUUF4qhfpz0=;
        b=tryUNkbDpeMdglFFNKIzJYg4i8jsiR0J87g2m30rIEtrpRz4aysLPtx8oL9Y5cVHPO
         g++E2TmzhIsfYcQlRIErMLOEUg9Dgmld8jSO/wthTvVWIBcYjOkbzmFbgnPhBgpM2FU/
         ABrXIcCstMvniKeCWRLCi0odtNw7feiW84hDAXlBVuFgh8bT4u5v3D5CO52SiDyQo8HN
         jL7QYPoCKR+yQs2sgkVye8QwvIuTOPrc4AZe91xcDFFqq00ILr+hwIp78amMvoJnhaFG
         35372GC03U71xNb3N7iphat9BcAM68VvZNvMiJvb9kTTA31zI1/sit5bsGFQyxrF6MVK
         gnXw==
X-Gm-Message-State: APjAAAUv+k+ecEVV7AyeE4NXC1aTi4DdB/3C9o842e4m02fv+MRVRMKn
        piUdj7xIGRP32ZOfbHI0VmT7HJ4V
X-Google-Smtp-Source: APXvYqwG21XkttdMF4ja+gZLwEhsuiaZ2eWHu3WUtBUtv/KSCPVULn5546XRPr9a13tBjmn8P2MuNw==
X-Received: by 2002:a1c:1d41:: with SMTP id d62mr4152657wmd.32.1572356273946;
        Tue, 29 Oct 2019 06:37:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u21sm3239375wmu.27.2019.10.29.06.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 06:37:53 -0700 (PDT)
Message-Id: <pull.428.v2.git.1572356272.gitgitgadget@gmail.com>
In-Reply-To: <pull.428.git.1572274859.gitgitgadget@gmail.com>
References: <pull.428.git.1572274859.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Oct 2019 13:37:51 +0000
Subject: [PATCH v2 0/1]  Fix t5516 flakiness in Visual Studio builds
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Among the flaky tests, it seems that the Azure Pipeline suffers relatively
frequently from t5516 failing with the Visual Studio builds. Essentially, we
grep for an error message, but that error message is produced twice, once by
a fetch and once by the upload-pack spawned from it, and those error
messages are usually interleaved because of MSVC runtime fprintf() 
idiosyncracies. 

The commit message of this patch is based, in part, on 
https://github.com/gitgitgadget/git/pull/407. The patch itself is a much
more minimal alternative (using xwrite() instead of fprintf()) to the code
of https://github.com/gitgitgadget/git/pull/407, avoiding the complexity of
the part of the code that allows for unlimited messages.

While it would seem theoretically more elegant to allow for unlimited
messages, in practice too-long messages cause more problems than they solve,
and therefore we already clip them, and this patch does not change that
behavior.

This fixes https://github.com/gitgitgadget/git/issues/240.

Changes since v1:

 * Changed the oneline to be more accurate (thanks Junio).
 * Improved the commit message (e.g. talking about the xwrite() function
   this patch uses, rather than the write_in_full() function used by an
   earlier iteration, thanks Gábor).
 * Revamped the actual code to account for insanely long prefixes (thanks
   for the advice, Junio).

Johannes Schindelin (1):
  vreportf(): avoid relying on stdio buffering

 usage.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)


base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-428%2Fdscho%2Ffix-t5516-flakiness-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-428/dscho/fix-t5516-flakiness-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/428

Range-diff vs v1:

 1:  455026ce3e ! 1:  e426627e14 vreportf(): avoid buffered write in favor of unbuffered one
     @@ -1,6 +1,6 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    vreportf(): avoid buffered write in favor of unbuffered one
     +    vreportf(): avoid relying on stdio buffering
      
          The MSVC runtime behavior differs from glibc's with respect to
          `fprintf(stderr, ...)` in that the former writes out the message
     @@ -16,7 +16,9 @@
          Let's avoid this predicament altogether by rendering the entire message,
          including the prefix and the trailing newline, into the buffer we
          already have (and which is still fixed size) and then write it out via
     -    `write_in_full()`.
     +    `xwrite()`.
     +
     +    We still clip the message to at most 4095 characters.
      
          The history of `vreportf()` with regard to this issue includes the
          following commits:
     @@ -36,39 +38,45 @@
                                  so it's safe to use xwrite() again
          5e5be9e2 (2016-06-28) - recv_sideband() uses xwrite() again
      
     -    Note that we need to be careful to handle the return value of
     -    `vsnprintf()` that indicates the _desired_ byte count.
     +    Note that we print nothing if the `vsnprintf()` call failed to render
     +    the error message; There is little we can do in that case, and it should
     +    not happen anyway.
      
          Also please note that we `fflush(stderr)` here to help when running in a
          Git Bash on Windows: in this case, `stderr` is not actually truly
          unbuffered, and needs the extra help.
      
     -    Co-authored-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
     +    Helped-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
     +    Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       diff --git a/usage.c b/usage.c
       --- a/usage.c
       +++ b/usage.c
      @@
     + void vreportf(const char *prefix, const char *err, va_list params)
       {
       	char msg[4096];
     - 	char *p;
     --
     --	vsnprintf(msg, sizeof(msg), err, params);
     +-	char *p;
      +	size_t off = strlcpy(msg, prefix, sizeof(msg));
     -+	int ret = vsnprintf(msg + off, sizeof(msg) - off, err, params);
     - 	for (p = msg; *p; p++) {
     ++	char *p, *pend = msg + sizeof(msg);
     + 
     +-	vsnprintf(msg, sizeof(msg), err, params);
     +-	for (p = msg; *p; p++) {
     ++	p = msg + off < pend ? msg + off : pend - 1;
     ++	if (vsnprintf(p, pend - p, err, params) < 0)
     ++		return; /* vsnprintf() failed, there is nothing we can do */
     ++
     ++	for (; p != pend - 1 && *p; p++) {
       		if (iscntrl(*p) && *p != '\t' && *p != '\n')
       			*p = '?';
       	}
      -	fprintf(stderr, "%s%s\n", prefix, msg);
     -+	if (ret > 0) {
     -+		if (off + ret > sizeof(msg) - 1)
     -+			ret = sizeof(msg) - 1 - off;
     -+		msg[off + ret] = '\n'; /* we no longer need a NUL */
     -+		fflush(stderr);
     -+		xwrite(2, msg, off + ret + 1);
     -+	}
     ++
     ++	*(p++) = '\n'; /* we no longer need a NUL */
     ++	fflush(stderr);
     ++	xwrite(2, msg, p - msg);
       }
       
       static NORETURN void usage_builtin(const char *err, va_list params)

-- 
gitgitgadget
