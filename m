Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EDB31F453
	for <e@80x24.org>; Tue, 23 Oct 2018 01:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeJWJe5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 05:34:57 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:56916 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeJWJe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 05:34:56 -0400
Received: by mail-ua1-f74.google.com with SMTP id 32so3994142uaf.23
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 18:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DmknxeTaccpN+GRuOkLpwpZym8FiMCk0n3Abr87HNwM=;
        b=p9/z4gzOEFCttUhJ/mnr3AfVx9fwTljl5R+rkLZYxKKg3AXldg2rMZ4ktbxs+a6gpj
         XGyUDE0eRT0doxrquJzz5fpKnmFZ6FHLhOvJT2YPb2aw1dsyszxRtVwZThRRuFCZ4fGQ
         UlLBHJcEzmAvxVJ6wRg7i4AV+jIIDoURWSy7eLUHZhgPOT0hFmFoeRdIVpOpZVq4jV5g
         e74mH742UfqKUG+q0Oj8uSNeDXIVwvbk3p4BXRJQHazQ8dNCGxhTpp9SN3jCnKpt5Cr4
         uBp48wW27Ig0+wEfTf+W2tXjCQOF8vvNR49TBcCjDF+vv5RhJB1/yUlSM95muUpEqTDH
         ogsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DmknxeTaccpN+GRuOkLpwpZym8FiMCk0n3Abr87HNwM=;
        b=aRDJq4CTrMYkV1RRXkizIDURWO4c5bgSnlD6Mi4jm53LlONngcjU9NPn9TSBo3flK0
         qavcJMYgzAb4Cf+QD4PD9HB/LfBFJ3BMCU5mKqbIJrngE26op7NnaIXOt97krr/5ycjK
         kUsll9n1TGEE1JVKzT4CA550y06fn9yW8rcQGKbcCxtBEeVoahN0akXry8zIR7dzzz4Z
         NXR2Fz2HldunQ6+O0SyGIFOiG9m95+7fRm/4JtwN9rsPG6qKWAENQazX5lIOuoRQwMvz
         rcXKEDgRmSHATdNlSv0pRAK80OgOGIvNgPHkBc+S5bob0lYlTpr568ftPIj+Cl+w1Q3N
         AUTg==
X-Gm-Message-State: AGRZ1gJovFHr3HoSNrtWfrvVbQeeM3rLi/YSxFGdFKq+m9fqz8ytrGnu
        M3uHsAJOVVl7ZXXO0QSOEk28kwvxhSggWtKugG2e/xVHcnWx/fnoDXjQW8XgCoqu9jkC19Ly2eq
        TssuTfM8py4SzibAwqvAKJZoEVHHqxrjTFp6TBGfhJXLCUKkWHaMyowLZx2c=
X-Google-Smtp-Source: AJdET5clIbr5QRp7JAeLfhn5eDZPe6MfKeRnAAA4a7cR+cVlFFDMFfA9fZ17LQOcFLkT1awpEG5pgWmEL6dL
X-Received: by 2002:a1f:8ac4:: with SMTP id m187mr8600726vkd.3.1540257236313;
 Mon, 22 Oct 2018 18:13:56 -0700 (PDT)
Date:   Mon, 22 Oct 2018 18:13:41 -0700
In-Reply-To: <cover.1540256910.git.matvore@google.com>
Message-Id: <06bb0dd35081f950cd9196f1af0949565bce2f73.1540256910.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1540256910.git.matvore@google.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [RFC 1/2] Documentation/git-log.txt: do not show --exclude-promisor-objects
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, gitster@pobox.com,
        pclouds@gmail.com, peff@peff.net, jonathantanmy@google.com,
        jeffhost@microsoft.com, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do not suggest that --exclude-promisor-objects is supported by git-log,
since it currently BUG-crashes and it's not necessary to support it.
Options that control behavior for promisor objects should be limited to
a small number of commands.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 Documentation/rev-list-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5f1672913b..bab5f50b17 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -761,7 +761,6 @@ Unexpected missing objects will raise an error.
 +
 The form '--missing=print' is like 'allow-any', but will also print a
 list of the missing objects.  Object IDs are prefixed with a ``?'' character.
-endif::git-rev-list[]
 
 --exclude-promisor-objects::
 	(For internal use only.)  Prefilter object traversal at
@@ -769,6 +768,7 @@ endif::git-rev-list[]
 	stronger than `--missing=allow-promisor` because it limits the
 	traversal, rather than just silencing errors about missing
 	objects.
+endif::git-rev-list[]
 
 --no-walk[=(sorted|unsorted)]::
 	Only show the given commits, but do not traverse their ancestors.
-- 
2.19.1.568.g152ad8e336-goog

