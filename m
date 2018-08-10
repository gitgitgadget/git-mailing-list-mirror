Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3FB71F405
	for <e@80x24.org>; Fri, 10 Aug 2018 03:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeHJFpa (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 01:45:30 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41961 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725725AbeHJFpa (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Aug 2018 01:45:30 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8F25F21AEC
        for <git@vger.kernel.org>; Thu,  9 Aug 2018 23:17:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 09 Aug 2018 23:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailworks.org;
         h=content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=B+mEwYR1I+FRvuUXHm+8FkFVzmiB+JzBU9BUPlEB97s=; b=hnfoIBXh
        xtGRAfzVxYHE4w9kx/5DqFqqH1Tl+E4VDELS7Qk/zOUUgGHafojBqmFshE48H83B
        LvNdf0alzfyvJLnKL8RuwQl0At8AkAgC3hk1kMmrq6DWA/nIhx6YHI9ebNAY3Ft7
        j+eIkLv2MaCHZj0lpVIWV0JKvLtZp2JnwtexrICPdW3kCns5sq7wYaB2fqbXGnef
        tzvqlsTI7u+6Sp214Ba1JnzTWOuTLyeew4pkWGBBt0Qn0mXxwj285L0/ooYqLQM8
        1hIJmYedsR4bADcjuibB3TPTdW+1sD9Ce6upkxN03otozUr/mvtaxowNsURuuAhF
        978iw6pcJo5ing==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=B+mEwYR1I+FRvuUXHm+8FkFVzmiB+
        JzBU9BUPlEB97s=; b=Dlcg3HYCYPYEGd9Zzw6XmRINdNAMYdJU+WOO/sN+WrWe/
        bAEuczcQsB7BXhFh8aRhEw1xlodW+3TUrhkakV8g54F8XS/l5XhAFqaUS70eYajT
        qJS3DDA/IZ5Nubk/6rosacNl1+W7qXaS/hHmpJktl1YUGQ4wDTIxwPr9rhX8eBDT
        x4pKXj9eFhsv6sco/XPLEigOM+GIlinBxXJ5uBLRo7hceLeDPf3AWI5uQAUiHIYW
        HZn3eYGGWTam2reQ5wnscGLdJDVhCk6CWLNcR82wbfrEWXDhzGWn6CSB5VgQWWUi
        Xi9J0xVo8UJmF4UkSIrf6jhr5qSiL8tx/spNv+PIw==
X-ME-Proxy: <xmx:0QNtW3cgQ1KAp290EcWZHAejkmd0C8E2SA2Hhe2P2-Y_fCUcmLgTPg>
    <xmx:0QNtW9ayvKkt3uiDHB2_PR87HLZSX4OmuB1MG6wdA2JU0p-KkOL9PA>
    <xmx:0QNtWyWyJmefX3NO2JnJfWPoHkcesdzaQ-xbtDHa4WRZGNWSIGeOow>
    <xmx:0QNtW3iVaemr4CGIb_FfiMn4Ekf3zdN3BFVscpOFwR2hQwP7k0AVkQ>
    <xmx:0QNtW4Vfdrb50Gl1ygy4t8rW8eezppdBhOu_CPjWa0T6Rc25xJCgGQ>
    <xmx:0QNtWwYf71ypiyBAdCDPLWt1_DzwFK9ttQ8FFb2ECLB-s0EjjE34Mg>
X-ME-Sender: <xms:0QNtW3LFHDsmTsvfutFo43gRXLbZu_eARzc0lIzMlb3otDVvN91oUw>
Received: from freeip.amazon.com (54-240-196-191.amazon.com [54.240.196.191])
        by mail.messagingengine.com (Postfix) with ESMTPA id 114CA10261
        for <git@vger.kernel.org>; Thu,  9 Aug 2018 23:17:36 -0400 (EDT)
From:   Philip White <philip@mailworks.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Bug? Git won't apply a split hunk that went through a text editor
Message-Id: <43C90F94-C9B8-49E4-A9E9-C1D652B52E2F@mailworks.org>
Date:   Thu, 9 Aug 2018 20:17:36 -0700
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, git enthusiasts,

I=E2=80=99d like to report what I suspect is a bug in Git, tested in =
2.18 and 2.14. (I=E2=80=99d be delighted to be corrected if it is my own =
misunderstanding.) I=E2=80=99m reporting it here based on guidance from =
https://git-scm.com/community.

I created a minimal testcase with a detailed README here: =
https://github.com/philipmw/git-bugreport-2018-hunk-fail

Overview of the bug:

When interactively selecting hunks to apply, using `git checkout -p =
<tree> <file>`, git will correctly apply an unmodified hunk, but will =
refuse to apply a hunk that went through a text editor ("e" command), =
even when I made no changes in the text editor.

Thanks for any advice or attention you can give to this matter.

=E2=80=94=20
Philip=
