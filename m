Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D72E1F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 17:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeJIAgd (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 20:36:33 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35987 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeJIAgd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 20:36:33 -0400
Received: by mail-ot1-f67.google.com with SMTP id k5so7901020ote.3
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 10:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PH/9umUvrsBiHESS/vF2Y8bTsgn0D56/2QvWLKqlKAA=;
        b=V5g7SZX7gBLIJ6fN7ohPE0kmFte3v9FJX+iM0tmTce/hKuWJwL1j80HUkn9NyNauXp
         YPHM5IRXwgf4WsezRgvo+6WHPiyaJk8+xo0wdwPr/5YceuZ12bw2KtBGjL2lCDx7EACi
         BU+ar5H6b6BR/RFet5Yw560kI07aLCbGtcjWd7fES3VFwD4kmjvA/EmoQdEPzHqAh4Lh
         j1TCpios+uU9A6I8rVr6McQJMqmFKoiTE8PDLyDoF9SW/tB7Wv4PvCf+tk+YFFD899GQ
         zqEuAwGbR4aa1m62I0vlJ5zsiPykzsuiprPEMrU5fEGUjMeG33OF/Me4podvjdiQqJ3x
         jUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PH/9umUvrsBiHESS/vF2Y8bTsgn0D56/2QvWLKqlKAA=;
        b=JlxPgrpl31MaI0aAihvMIIPUR1WPObHCQiiwS4Fqgev0sXBq4WD0hxLTBncxtvS0cU
         T8xn+43vpIxy51xEBP6Gs5tJaH9AX2y+xQ30UaNFFhqzNzkt/V/W+1Qv72BwFm8oVOI6
         x5MEYSdxb9JytsgqKaQeCkhg/YKcqbAu6F+GdGDTxM3k9w3q7/eDZ00S9om+APX2jJVl
         LjaVoXowRc3nqM8ReKHyft9iqHQg6xkUgiAWLO0gOf7e5cHLDqXzYnufXC3q+rcdarr1
         TnxPidPGzrMCBwFKvK5DtmCwdtYHNvx4cfQOJmyZLRhgjGKgpNR/gsxtzrFtvVJUf11u
         bmPw==
X-Gm-Message-State: ABuFfoihWsJ/+z3fpRx02DiGSOYqdGi0IwAEvQz7GEU9t5CiF+B5B/cT
        o4JJx7fPJkCZSwMTHB4K8PayiQCAt0rOpJ4sHILp
X-Google-Smtp-Source: ACcGV605CnPKwv+T6cMuEmZU1gY9J0VjbqF+fWHcyX6Hm50V2IVhRtYa6uq4FtavUu3AtlYJverP7O+L4EsA8eDLT0Y=
X-Received: by 2002:a9d:6014:: with SMTP id h20mr10535154otj.349.1539019428636;
 Mon, 08 Oct 2018 10:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1538774738.git.matvore@google.com>
 <6ca50a28e292f32127ea706a2aef39f834ac7702.1538774738.git.matvore@google.com> <xmqqpnwmvcow.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnwmvcow.fsf@gitster-ct.c.googlers.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Mon, 8 Oct 2018 10:23:36 -0700
Message-ID: <CAMfpvhJi+T+zRS8pkZkN_x5xYD3gxTjeczm18VLYWtxfb4Zvmw@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] list-objects-filter: implement filter tree:0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        git@jeffhostetler.com, jeffhost@microsoft.com,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 6, 2018 at 5:10 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> As output made inside test_expect_{succcess,failure} are discarded
> by default and shown while debugging tests, there is no strong
> reason to use "grep -q" in our tests.  I saw a few instances of
> "grep -q" added in this series including this one
>
>         test_must_fail grep -q "$file_4" observed
>
> that should probably be
>
>         ! grep "$file_4" observed
Yeah, I remember I read in the testing guidelines that you should just
use ! for non-Git commands since it's not our job to make sure these
tools are not crashing. Thank you for pointing this out.

>
> > +     printf "blob\ncommit\ntree\n" >unique_types.expected &&
> > ...
> > +     printf "blob\ntree\n" >expected &&
>
> Using test_write_lines is probably easier to read.

Done. Below is an interdiff. Let me know if you want a reroll soon.
Otherwise, I will send one later this week.

- Matt

diff --git a/t/t5317-pack-objects-filter-objects.sh
b/t/t5317-pack-objects-filter-objects.sh
index 510d3537f..d9dccf4d4 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -69,7 +69,7 @@ test_expect_success 'get an error for missing tree object' '
         test_must_fail git -C r5 pack-objects --rev --stdout
2>bad_tree <<-EOF &&
         HEAD
         EOF
-        grep -q "bad tree object" bad_tree
+        grep "bad tree object" bad_tree
 '

 test_expect_success 'setup for tests of tree:0' '
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 53fbf7db8..392caa08f 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -192,7 +192,7 @@ test_expect_success 'use fsck before and after
manually fetching a missing subtr
         xargs -n1 git -C dst cat-file -t >fetched_types &&

         sort -u fetched_types >unique_types.observed &&
-        printf "blob\ncommit\ntree\n" >unique_types.expected &&
+        test_write_lines blob commit tree >unique_types.expected &&
         test_cmp unique_types.expected unique_types.observed
 '

diff --git a/t/t6112-rev-list-filters-objects.sh
b/t/t6112-rev-list-filters-objects.sh
index c8e3d87c4..08e0c7db6 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -38,8 +38,8 @@ test_expect_success 'specify blob explicitly
prevents filtering' '
                  awk -f print_2.awk) &&

         git -C r1 rev-list --objects --filter=blob:none HEAD $file_3
>observed &&
-        grep -q "$file_3" observed &&
-        test_must_fail grep -q "$file_4" observed
+        grep "$file_3" observed &&
+        ! grep "$file_4" observed
 '

 test_expect_success 'verify emitted+omitted == all' '
@@ -240,7 +240,7 @@ test_expect_success 'verify tree:0 includes trees
in "filtered" output' '
         xargs -n1 git -C r3 cat-file -t >unsorted_filtered_types &&

         sort -u unsorted_filtered_types >filtered_types &&
-        printf "blob\ntree\n" >expected &&
+        test_write_lines blob tree >expected &&
         test_cmp expected filtered_types
 '
