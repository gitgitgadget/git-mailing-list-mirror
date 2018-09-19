Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2DD41F453
	for <e@80x24.org>; Wed, 19 Sep 2018 20:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbeITBqK (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 21:46:10 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46627 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeITBqK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 21:46:10 -0400
Received: by mail-ot1-f67.google.com with SMTP id v44-v6so7027098ote.13
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 13:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=56kHPyEX+yGGkEMSq/iFe/bnulIPWiVPuE2jNIhH+NE=;
        b=Use4pKC1Z1ZWCV7fVJq4NOWrm5DB8UXQe8y8/phMBRU8kPj3dSKPnIZSWCEsjyPBJ5
         PKrMF7tkOybqyPDi589Xu8J1BRVt45zuDeiImzD2ZE7fHF0bQev5gBm6FJ9UUWRmcrXL
         YwAVKAQgvdkqJevXnKk6Pi/RS5/5OcmjOfDhcGHeoY8xhVafI81oXbm7BW+2bL+2Ea8K
         uFCxv22R413h5Q5DeLYynj8xU8tjnXRCCNkfuQrXA1SpEX/YoZBXMZWqBdG1M7uTU2FI
         FhKuqqm/GIbow5zWL/lgZ+anGyc0X/Dx+5ZjazOGEKjFlW/6IYXC/XVcFYMP66HBnsTs
         BtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=56kHPyEX+yGGkEMSq/iFe/bnulIPWiVPuE2jNIhH+NE=;
        b=fDi5OIG2rNqcPSpuJ/3dd4nDF1uw1gXfeCf8onJXL+8mJxiOTjpAtvX8uRfow1ay67
         G6X4z22Nj8LkGRuLQFmWWDxo2tCQtRRjstR5mmmMEeDsDPRLhNq6dq6+rB/CkpuJEdbC
         0NOD2a98BhkU6U6diwJbbnKGdMUoarmtma+zkcpKbY+rrUR8XHxsFTNnEVwQ0d4izizf
         mwIysMP8slT+wq4/nITaIxvkIMPDfGXxQEX2vORJrug8vNuETVeutu9aITp5JKX/l+JZ
         E7/CTzEWtUwU0mAuHyL4hZkqZ+vPmk/ZnSsyHfsf/K0Nptc5Qo8vsgUchX9gwStWjzWI
         5sGw==
X-Gm-Message-State: APzg51AmBTxVKjEsSgdNibz8SGlODr5P/yAEINI6+KexyDDIWPQApkPH
        TomjpzmLe2tlIsg9maNhlLw/ZdIk8017Rl458Ti6OCsWpuXV
X-Google-Smtp-Source: ANB0VdYpmwUERVIAjEG/sfsZs3szT63Y7l6sI/LDe1rx3E8WT0wiQpvrk5KUm2+RKQbQAjHNNasJJfyYhxfuDpq+Gxo=
X-Received: by 2002:a9d:1e9:: with SMTP id e96-v6mr21312764ote.68.1537387599262;
 Wed, 19 Sep 2018 13:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537223021.git.matvore@google.com>
 <c625bfe2205d51b3158ef71e4bf472708642c146.1537223021.git.matvore@google.com>
 <CAPig+cSzddcS+8mx=GMbJ5BP+=fPtza+7UdA5ugN+83NuOHyiw@mail.gmail.com>
 <CAMfpvhKejvbgzwtTv93iqLG8fMxqZW_MRTAU0q9bDArqJU2zUg@mail.gmail.com> <xmqqo9ct4lap.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo9ct4lap.fsf@gitster-ct.c.googlers.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Wed, 19 Sep 2018 13:06:27 -0700
Message-ID: <CAMfpvhLYjmb4kF8tObAiROtcDHfpah0J=Y1KhUHZnvFoyK6sgA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] CodingGuidelines: add shell piping guidelines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     sunshine@sunshineco.com, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 19, 2018 at 5:36 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Tue, Sep 18, 2018 at 10:11 PM Matthew DeVore <matvore@google.com> wrote:
> > Yes, it's probably better to add a point about that. Here is the new
> > documentation after applying your suggestions:
> >
> >  - If a piped sequence which spans multiple lines, put each statement
>
> s/which//
Done.

On Wed, Sep 19, 2018 at 7:24 AM Junio C Hamano <gitster@pobox.com> wrote:
> The formatting advice to place '|' at the end applies equally to
> '&&' and '||' because these three syntactic elements share exactly
> the same trait: the shell knows you haven't finished speaking when
> it sees them at the end of the line and keeps listening, and humans
> would know that too, so there is no need for explicitly continuing
> the line with backslash.
>
I've reworded the text to indicate the advice applies to && and || as well.

> Organizationally speaking, I wonder if the above about formatting
> would better appear separate from the latter two points that are
> about semantics.
>
I moved the formatting point to right under the point about formatting
if statements, which does seem like a more natural progression.

Here is the new patch to summarize the changes (warning: tabs are mangled):

--------------------------------------------------------------------------------

    CodingGuidelines: add shell piping guidelines

    Add two guidelines:

     - pipe characters should appear at the end of lines, and not cause
       indentation
     - pipes should be avoided when they swallow exit codes that can
       potentially fail

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 48aa4edfb..6d265327c 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -118,6 +118,24 @@ For shell scripts specifically (not exhaustive):
                 do this
         fi

+ - If a command sequence joined with && or || or | spans multiple
+   lines, put each command on a separate line and put && and || and |
+   operators at the end of each line, rather than the start. This
+   means you don't need to use \ to join lines, since the above
+   operators imply the sequence isn't finished.
+
+        (incorrect)
+        grep blob verify_pack_result \
+        | awk -f print_1.awk \
+        | sort >actual &&
+        ...
+
+        (correct)
+        grep blob verify_pack_result |
+        awk -f print_1.awk |
+        sort >actual &&
+        ...
+
  - We prefer "test" over "[ ... ]".

  - We do not write the noiseword "function" in front of shell
@@ -163,6 +181,15 @@ For shell scripts specifically (not exhaustive):

    does not have such a problem.

+ - In a piped chain such as "grep blob objects | sort", the exit codes
+   returned by processes besides the last are ignored. This means that
+   if git crashes at the beginning or middle of a chain, it may go
+   undetected. Prefer writing the output of that command to a
+   temporary file with '>' rather than pipe it.
+
+ - The $(git ...) construct also discards git's exit code, so if the
+   goal is to test that particular command, redirect its output to a
+   temporary file rather than wrap it with $( ).

 For C programs:
