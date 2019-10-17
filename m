Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2865F1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 00:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391692AbfJQAxo (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 20:53:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45386 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388082AbfJQAxo (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Oct 2019 20:53:44 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2303060424;
        Thu, 17 Oct 2019 00:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1571273623;
        bh=abD1gK+rMFlaWic+AKkTFfPAfeV187gx2mYlzy5RYpM=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=gNAd+9LcD5qG1/1mLe+8mcvT9Ng6ddMFwNovIBAQzd9ii54D8QACJ2L9xawU7hN99
         10KGZo4ZZFm8bMNmsPL99csQTS4ppm5vm8iJiUJBZyLkWQr1GXC6PJrTRciLh/Jmkm
         qTsDfMdFZS6Yg1bpH5csFarM6j4NLCAHEyUjEN+k94fCuGcpk34D0b1xKYSZR6oovd
         dp5sB5qELkQ9i/tLqugnyp/naESwIXtrzwWi71YnUgqVkkWSwrqdsQMtjEzjA+9Sha
         sX/XND8G0fMRWMblPbzzIfGN+eAztlqGOWET6R4CVBEHc3e2DTrWmT6SHjgRvmBqVA
         9w2I/0SrtM6Y9KiKQvrl6TiPLgagH+MjFKTTlyKc7H+MXNGvnH7u2z65qkt2AZtdFh
         aRxfAHZuhrgk7CnJ8RwCFJkJV9GZSXTseOx9ulGiuToNTDXGVInXVn3af14LdjgLcx
         K/f3y+FZWQAPVSQEGmDKUmXB0dG0e+lOiRTKqFk8Fcuxtjkj6K0
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] Documentation for common user misconceptions
Date:   Thu, 17 Oct 2019 00:53:27 +0000
Message-Id: <20191017005330.9021-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series includes three patches that update the documentation to
address common user misconceptions.

The first patch has seen the list before, which is why this is now v2.
It addresses the attempt to use "user.name" as a username for
$GIT_HOSTING_SERVICE instead of a person's personal name.

The second patch is new, and addresses a common desire (as seen on Stack
Overflow) to ignore changes to tracked files.  If folks want, I can add
a paragraph to expand on the common use cases (IDE configuration and
config files) and offer general suggestions for them; if not, we can
leave the patch as it stands.

The final patch, also new, addresses a common source of bad advice in
response to any push problem: raise http.postBuffer.  The patch
indicates why this is almost never an effective solution, so explain
what the option really does and that it is not a panacea.

We probably should have a document such as a FAQ that addresses these
and other common issues, both to make Git more approachable and less
scary for newcomers, and provide accurate information for situations
like these.  I've started on some drafts of such a FAQ, but have gotten
side-tracked with other things and haven't made much progress.

In the mean time, it's my hope that by providing documentation on these
issues, we can point people to it and encourage people to solutions that
solve their problems instead of having them receive incorrect
information which is not effective.

Changes from v1:
* Remove parenthetical which was confusing.
* Add two more patches.

brian m. carlson (3):
  doc: provide guidance on user.name format
  doc: dissuade users from trying to ignore tracked files
  docs: mention when increasing http.postBuffer is valuable

 Documentation/config/http.txt      |  7 +++++++
 Documentation/git-commit-tree.txt  |  6 ++++++
 Documentation/git-update-index.txt | 10 ++++++++++
 3 files changed, 23 insertions(+)

