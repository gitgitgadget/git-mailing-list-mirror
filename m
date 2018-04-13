Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1EC51F404
	for <e@80x24.org>; Fri, 13 Apr 2018 00:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753176AbeDMABb (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 20:01:31 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34469 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbeDMAB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 20:01:27 -0400
Received: by mail-wm0-f45.google.com with SMTP id w2so4997034wmw.1
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 17:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d/gm4ug5YG2Hz7jEf43kUQSDU3lA+IAQsTgd6HD5l0Q=;
        b=TwpQ0ZxV4fIUU8wSb2VSdrAuLCEgO45tJ6WKRiL5ZZBo4EQFGooFDqVk7dqoty1LGC
         TMl7rSHrp/cxYHQ4BWpVukPL8E35y9qkbkzNgR+5ySIkfvTX1B61V+VwSgRjp+4fqa6e
         ob0gXUwT6cnA4jYI4K13Mp5jhwOlrVXDxUPXk3iBGS3TaG68zdUY/8CKwCldbXDMP88i
         SeRqkxzkWMB1rLl/GmD+GsuDoxuKNu8bdw+Iqj1IzP8B8Zn+5eS/XjEvGGCLpdl2xBx+
         X5krEp5ZEMiAIk/5hJlo1BfCGxoch6xf7Oyu7es4VXgV+2W0py1mVE2M9NS2sk9nZK5v
         VaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d/gm4ug5YG2Hz7jEf43kUQSDU3lA+IAQsTgd6HD5l0Q=;
        b=VT5f4Grw2KQ7efLfHjayy/XU+8W5lqqyBYCR+v721RsUn2qkpAoFNnqggxLxtjqpfH
         qLYtEU5B9Bt0tzZ+sPyMeqLT1fa8CsNgQHmBMEQTCQlUoczIPNzRlNEMV83SLCS+tFQZ
         5gdS/3JBoLQ+eop5DS2GgZkBMFnYekNqasEeaIiiZpPCqh9xSMsC5dZ6dFelkPOfymBB
         w2E9vB0/7qnkvsTgs+jTZRh6hKKUqmrZCPdF/JJC+CC+DZsDKKbxRpHuM9lbBdf9TWov
         qTqk/MURDoUv0zTOR6LtCznRAjYCXtVCzuuHHkzHaAmlYIVPyM9qFu2iTGPD9GsNQk9O
         WCqw==
X-Gm-Message-State: ALQs6tCLq9U0xmFnkkd1sfgw5SW+awhCy+fpgIFr11XmOTCSHCpL/ICF
        kwtEbbmre4FDih9xj5ydZp4=
X-Google-Smtp-Source: AIpwx4+sX/nFDdiOFEf5/ATkTNkk3l1tAt7qvO8Ud3NR52VT3rfvC0PhGLYCHu99Ith4eTcJzjUHcw==
X-Received: by 10.28.131.2 with SMTP id f2mr2186662wmd.111.1523577686521;
        Thu, 12 Apr 2018 17:01:26 -0700 (PDT)
Received: from localhost.localdomain (x4db19442.dyn.telefonica.de. [77.177.148.66])
        by smtp.gmail.com with ESMTPSA id n8sm5652336wrh.51.2018.04.12.17.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Apr 2018 17:01:25 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Matthew Coleman <matt@1eanda.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Stephon Harris <theonestep4@gmail.com>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] specify encoding for sed command
Date:   Fri, 13 Apr 2018 02:01:05 +0200
Message-Id: <20180413000105.21708-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.366.gbe216a3084
In-Reply-To: <CBA1FB4A-C586-48E0-A64E-371CCD2F6AC4@1eanda.com>
References: <0102016293c8dca7-6626fcde-548d-476e-b61f-c83ecdeedfe1-000000@eu-west-1.amazonses.com> <87605616vr.fsf@evledraar.gmail.com> <DB5A1CE2-7844-4CB6-A03E-6AAC4EC13D66@gmail.com> <3FE7BFB6-769A-4F11-9C3B-86D681B3502F@gmail.com> <CBA1FB4A-C586-48E0-A64E-371CCD2F6AC4@1eanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> I did a little more digging into this issue today.

> The issue isn't actually caused by `sed`: it's caused by the way that
> the `set` builtin outputs characters in the Unicode Private Use Area
> (PUA) in the build of Bash 3.2.57 that macOS Sierra ships with.
> 
> Powerline uses several PUA code points to make some of its pretty text
> UI elements:
> 
> Code point (hex value): description
> U+E0A0 (0xEE82A0): Version control branch
> U+E0A1 (0xEE82A1): LN (line) symbol
> U+E0A2 (0xEE82A2): Closed padlock
> U+E0B0 (0xEE82B0): Rightwards black arrowhead
> U+E0B1 (0xEE82B1): Rightwards arrowhead
> U+E0B2 (0xEE82B2): Leftwards black arrowhead
> U+E0B3 (0xEE82B3): Leftwards arrowhead
> 
> macOS Bash 3.2.57's `set` builtin has garbled output where Powerline's
> special symbols should be in the PS1 variable, but Bash 4.4.19
> (installed on macOS via homebrew) and Bash 4.3.38 (Ubuntu 16.04) both
> display it correctly in the output of `set`. `echo $PS1` does display
> the symbols correctly on these versions of Bash.

Thanks for digging.

> I think the best way to move forward with this is a new patch that uses
> `awk` instead of `sed`: I tested several `awk` variants and the command
> was portable without requiring any changes to LANG or LC_ALL.
> 
> Does that sound like a good plan?

No ;)
Could you please give the patch below a try?

I intended it as a fix for a minor performance regression introduced in
the same commit that triggered this issue, but if it can work around
this issue, too, all the better.

I'm just not sure whether we should burden this otherwise nice and short
commit message with the details of this Powerline-macOS-Bash-sed issue...


  -- >8 --

Subject: [PATCH] completion: reduce overhead of clearing cached --options

To get the names of all '$__git_builtin_*' variables caching --options
of builtin commands in order to unset them, 8b0eaa41f2 (completion:
clear cached --options when sourcing the completion script,
2018-03-22) runs a 'set |sed s///' pipeline.  This works both in Bash
and in ZSH, but has a higher than necessasry overhead with the extra
processes.

In Bash we can do better: run the 'compgen -v __gitcomp_builtin_'
builtin command, which lists the same variables, but without a
pipeline and 'sed' it can do so with lower overhead.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>

TODO: as an unexpected bonus, this might work around the issue with
'sed' and invalid UTF-8 characters in the environment as well, at least
in Bash.

  https://public-inbox.org/git/0102016293c8dca7-6626fcde-548d-476e-b61f-c83ecdeedfe1-000000@eu-west-1.amazonses.com/
---
 contrib/completion/git-completion.bash | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b09c8a2362..4ef59a51be 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -282,7 +282,11 @@ __gitcomp ()
 
 # Clear the variables caching builtins' options when (re-)sourcing
 # the completion script.
-unset $(set |sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*\)=.*/\1/p') 2>/dev/null
+if [[ -n ${ZSH_VERSION-} ]]; then
+	unset $(set |sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*\)=.*/\1/p') 2>/dev/null
+else
+	unset $(compgen -v __gitcomp_builtin_)
+fi
 
 # This function is equivalent to
 #
-- 
2.17.0.366.gbe216a3084

