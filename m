Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 907331F404
	for <e@80x24.org>; Wed,  5 Sep 2018 18:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbeIEWbp (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 18:31:45 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34543 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIEWbo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 18:31:44 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so15430416ois.1
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 11:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mqeFkpYKwf+sc9uu8eKqQ2WlF2+m1qpz50n3CYxXQcw=;
        b=erMnVNdvCs6Cau5shse/LLL3cJsP/tbwU7MmowtCE1d8y6Qk3MVVAj/BkLpDMCuSfU
         PsqAuyFhsGfG78ZkCrfTBTdo74CN4UgDjHOiH49Y2ekzKEhjQmmLJ6uHzrk24VhHa8vs
         v1pF8ogRQEoTHNKPVUCn5DlAyGeMJqWtBo/SgLOV9mh3c38sGGqUIPmPgLu9GVY4y8We
         G0r86WRggCEt3tWSv4LgnV8o/veL7eWGMd7Vf8xWK24bLtjT6hVvWfXbZh/BJ3l7REmx
         5UJgs7yBkmeajh3wOHNMgNFjIuiLAHvFR2EjAY9FdJVnMv8+kD6iVL46TwLvDPEevcx/
         gfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mqeFkpYKwf+sc9uu8eKqQ2WlF2+m1qpz50n3CYxXQcw=;
        b=rMV2HlmmK+dfNd1IQxoQamqtP24c/9KHSw+SLzcqWkIeptrcqeNrQzxBrpfA+0Uhlt
         4metLGlYyyegLxHoJ/KD7IDdIKSmfPzeAHHv9D+cBa7oo8p/uwCkOEDJaW9o9S2e8dHc
         K4aQ2MPZP7sT//BDcF5/0uQ2grBvKJ5cAnw12783fYGdbLLzAGYiZvY06AJvYYvcAuDx
         fw4Z1liCrEzIt10aGUDDemjmA7bcKEvcVlvgmoKJQolPo/c2wmInUp7a7lincknE/quF
         oOwkMq1ouKYezSugedJbcPg17b24QR0Yphyt2xBocgNs1XPUZAqKiOWxtftFN36Vo0pn
         LxWw==
X-Gm-Message-State: APzg51D3yQ+vH8SeymyzoNxcmJvshwiQLZ+XWHYH9v5cenzyDLKuLBQ0
        SWuskBf4U1Hj550K7wnc11xbwhYvBX5JHFlDUYxw
X-Google-Smtp-Source: ANB0Vdbn+H6PIuGtOJqJuSIOMj8+MEpaVQWfP6wZYCd7Xgif6hsgGY93GTIsNl7POHTkXjgqjbcG7N3YO8lb7nualF4=
X-Received: by 2002:aca:a94:: with SMTP id k20-v6mr28974750oiy.29.1536170427379;
 Wed, 05 Sep 2018 11:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1536081438.git.matvore@google.com>
 <6ada2b97faba0ed8012ecd00477eac4e33eeb76f.1536081438.git.matvore@google.com> <xmqq5zzl80nw.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5zzl80nw.fsf@gitster-ct.c.googlers.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Wed, 5 Sep 2018 11:00:15 -0700
Message-ID: <CAMfpvhJ-ncRMK8v+zL4bytpWhQvgYqDbpa5q-Tzc_qMYN2_j1w@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] revision: mark non-user-given objects instead
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com, jeffhost@microsoft.com,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 4, 2018 at 1:31 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matthew DeVore <matvore@google.com> writes:
>
> > diff --git a/revision.h b/revision.h
> > index 5118aaaa9..2d381e636 100644
> > --- a/revision.h
> > +++ b/revision.h
> > @@ -8,7 +8,11 @@
> >  #include "diff.h"
> >  #include "commit-slab-decl.h"
> >
> > -/* Remember to update object flag allocation in object.h */
> > +/* Remember to update object flag allocation in object.h
> > + * NEEDSWORK: NOT_USER_GIVEN doesn't apply to commits because we only support
> > + * filtering trees and blobs, but it may be useful to support filtering commits
> > + * in the future.
> > + */
>
> Just a minor style nit, but our multi-line comment begins with the
> opening "/*" (and closing "*/", too, but you got that right) on its
> own line, i.e.
>
Fixed.

>         /*
>          * Remember to update ...
>
> > -#define USER_GIVEN   (1u<<25) /* given directly by the user */
> > +#define NOT_USER_GIVEN       (1u<<25) /* tree or blob not given directly by user */
>
> Is "given directly by user" equivalent to "given on the command
> line"?  Do objects given via "--stdin" count the same way?  How abot
> those given via "--branches" or "A^@"?  Does "not given directly by
> user" mean roughly the same thing as "discovered by traversal"?
Note that --branches and A^@ expands to commits, and commits can't be
filtered, so perhaps these questions will be unlikely for the time
being. I did clarify the comment a bit.

I also noticed that this commit fixes a bug - before this patch, "git
rev-list" would potentially filter objects given on the command
line/--stdin, while "git pack-objects" would not. That was because
each command used a different function to populate the rev_info
struct, and rev-list's code path did not contain the hack which turned
on USER_GIVEN.

So I added a test to check the desired behavior. Here is an interdiff
for this commit only:

diff --git a/revision.h b/revision.h
index fe4ff1fec..83e164039 100644
--- a/revision.h
+++ b/revision.h
@@ -9,11 +9,7 @@
 #include "diff.h"
 #include "commit-slab-decl.h"

-/* Remember to update object flag allocation in object.h
- * NEEDSWORK: NOT_USER_GIVEN doesn't apply to commits because we only support
- * filtering trees and blobs, but it may be useful to support filtering commits
- * in the future.
- */
+/* Remember to update object flag allocation in object.h */
 #define SEEN (1u<<0)
 #define UNINTERESTING   (1u<<1)
 #define TREESAME (1u<<2)
@@ -25,7 +21,14 @@
 #define SYMMETRIC_LEFT (1u<<8)
 #define PATCHSAME (1u<<9)
 #define BOTTOM (1u<<10)
-#define NOT_USER_GIVEN (1u<<25) /* tree or blob not given directly by user */
+/*
+ * Indicates object was reached by traversal. i.e. not given by user on
+ * command-line or stdin.
+ * NEEDSWORK: NOT_USER_GIVEN doesn't apply to commits because we only support
+ * filtering trees and blobs, but it may be useful to support filtering commits
+ * in the future.
+ */
+#define NOT_USER_GIVEN (1u<<25)
 #define TRACK_LINEAR (1u<<26)
 #define ALL_REV_FLAGS (((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR)

diff --git a/t/t6112-rev-list-filters-objects.sh
b/t/t6112-rev-list-filters-objects.sh
index 2e6a6a32e..a989a7082 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -30,6 +30,16 @@ test_expect_success 'verify blob:none omits all 5 blobs' '
  test_cmp observed expected
 '

+test_expect_success 'specify blob explicitly prevents filtering' '
+ file_3=$(git -C r1 ls-files -s file.3 \
+ | awk -f print_2.awk) &&
+ file_4=$(git -C r1 ls-files -s file.4 \
+ | awk -f print_2.awk) &&
+ git -C r1 rev-list HEAD --objects --filter=blob:none HEAD $file_3 >observed &&
+ grep -q "$file_3" observed &&
+ test_must_fail grep -q "$file_4" observed
+'
+
 test_expect_success 'verify emitted+omitted == all' '
  git -C r1 rev-list HEAD --objects \
  | awk -f print_1.awk \

>
> Not a suggestion to change anything in this patch, but if you can
> come up with a better phrase that helps new readers' understanding
> so that they do not have to ask a question like this, that would be
> great.
>
> Thanks.
>
