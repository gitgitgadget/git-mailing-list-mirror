Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A85F01F453
	for <e@80x24.org>; Thu, 18 Oct 2018 20:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbeJSEqU (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 00:46:20 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:38308 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSEqU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 00:46:20 -0400
Received: by mail-it1-f202.google.com with SMTP id d10so1482283itk.3
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 13:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Tl4X264t7uZiHEoayofFk2puWUO70Q73q1epExM0rV8=;
        b=g+FdUL8zzQqEfj9t07mGx/zgbN1G4Oew4+ulZ/w2KFuMHXFR2+a2jthyK7fkmH+qmW
         6B7F9CWdtokS47boRmo6+MqNKjfDdUeEu8fTUmI1BuZLocZsjrus5yLRhwY3lQbxczCs
         osyaeHqKLTEwl7EkeHHGINjfZkOV2z9UpYwkpxfpT+gJ2ZGc9/NPxnlEI1XZo0of4G/x
         /I8wlLqySc/ic5Ucrw2OlroI8ou3ygS7oTqC/RKEOrv+Zci/Uguc4Y6MEXQQMkoZG6QV
         67KCDSOvZu8e2NtDJZ7xzF7fz6Vx704h8H+5BrLFrE2Y+hjYc71QgBOht23ssS22hrej
         dx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Tl4X264t7uZiHEoayofFk2puWUO70Q73q1epExM0rV8=;
        b=Ab3Fzq+sTpUbEsHfZGMfKgj77u4wSvGwjq9Ifs73yWcDNxGiedbeznK0SMKJXuvyYg
         sT2dmrVEZoo6ilK0af3Es4VmTO5YhcXBCi7fGCNuJp/BmTmewxDiR330fpkVLQI5YYKt
         6pyO3HeRzWJANwox9IfJstzbc1xRwFrQP17qtq0xbrSw5aCvSuvz9ghD9q7SwuSCi539
         c8xCxEcnpK5LSdl2auB3zsrZqFyy86iWgNiKWu8vohpuzOPrFBvRDrFEMLWDzyc6Uns5
         azYDb2rION/otYkJ7k6QYuqNH5Up53H/G4Fh/zTSd2M9G2d5akXZb2C4PlJfxoY2pEEB
         cE/Q==
X-Gm-Message-State: ABuFfogwAzUsUpdjmf/ew8kruHLbugvLXv6ylJeH5EH82WdFVjfNYAgt
        PdPQaTm55S+KJynxc4zLfUdbwCrPTIsKtNvYaHMsXJfae5pHqCNVY8cjh3kka9NfYZo6PM33uXd
        KC8AIG8qFlGf3HqAzg/1e2VrrVkM91GmHsT96UAK0zb5FMLLUl962emlMmG/kNVvwl0DiKSyJ4E
        1G
X-Google-Smtp-Source: ACcGV62fXtB4MZQXHnI9Gw6dunxowMOpp6MwAeiLbhr4ZbI/bjCjXiBusva5QGpmncNgGd9HLdmdC0tsdHigWI3b5F5A
X-Received: by 2002:a24:6cc2:: with SMTP id w185-v6mr22474896itb.5.1539895413216;
 Thu, 18 Oct 2018 13:43:33 -0700 (PDT)
Date:   Thu, 18 Oct 2018 13:43:26 -0700
In-Reply-To: <20181016215850.47821-1-jonathantanmy@google.com>
Message-Id: <cover.1539893192.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181016215850.47821-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2 0/3] Clear flags before each v2 request
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To explain the differences in this version of the patch set, I'll quote
an email [1] from Junio:

[1] https://public-inbox.org/git/xmqq5zxzvnq1.fsf@gitster-ct.c.googlers.com/

> The change to the code itself sort-of makes sense (I say sort-of
> because I didn't carefully look at the callers to see if they mind
> getting all these flags cleared, but the ones that are cleared are
> the ones that are involved mostly in the negotiation and shold be
> OK).

I have included 2 additional patches for these reasons:

 - After reading the section of Junio's email quoted above, I took
   another look at the flags, and found that not only is state stored in
   the flags between invocations of upload_pack_v2(), state is also
   stored in the want_obj and have_obj global variables. The additional
   patches help clean those up.

 - To help reviewers who want to see if the callers mind getting all 8
   flags cleared, I have included a discussion of all 8 flags in the
   commit message of patch 3. The additional patches made the discussion
   easier.

Responses to other points:

> Hmph, what if commit O had a long history behind it?  
> 
> Should fetching of B result in fetching the whole history?

I think so - when we fetch without --depth or any similar arguments, I
think it's reasonable to have all objects referenced by the fetched
tips.

> Would we
> notice that now all of A's parents are available locally and declare
> that the repository is no longer shallow?

We could, but I think this is outside the scope of this patch set.

> Use test_seq instead, or you'll get hit by test-lint?

Thanks for the pointer to test-lint. I've used test_seq, and checked
that test-lint doesn't print any errors.

> Applied on 'master' or 'maint', this new test does not pass even
> with s/seq/test_&/, so there may be something else wrong with it,
> though.

Thanks - there was a copy-and-paste error (should have grepped for
"fetch< version 2", not "git< version 2").

Jonathan Tan (3):
  upload-pack: make have_obj not global
  upload-pack: make want_obj not global
  upload-pack: clear flags before each v2 request

 t/t5702-protocol-v2.sh |  25 +++++++
 upload-pack.c          | 153 ++++++++++++++++++++++++-----------------
 2 files changed, 115 insertions(+), 63 deletions(-)

-- 
2.19.0.271.gfe8321ec05.dirty

