Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DA991F454
	for <e@80x24.org>; Sat,  2 Nov 2019 19:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfKBT0r (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 15:26:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59050 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726574AbfKBT0r (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 Nov 2019 15:26:47 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9B5EE6046C;
        Sat,  2 Nov 2019 19:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572722805;
        bh=Q8KdG4tBHR87XoRNZz14sNQQwV0lRnfGvitcqUh+8Iw=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=FqRxIg3HWk//O6+gEeKVf52btxpbM3x3/4TrJYW7OJJJ4t61FP+ggmC6SyQo641sO
         cbnMOb34Nfz/lTwnPcCWDyLNlj2pFtWMxUTPKkJEophDWiVWM3+x4vSOKchtLdmou9
         Kpy0XyMSTt3PdqVByj/RLWTyKQDbg0G+BYCvHZhmHnuh7KIivQJ2z2na1tdG+ll9Ye
         3p2jK+/zI4x+Rch2TpIK1Wn8D891IkQ80toLkg4CbMPJ/5wQTnLzWxtdTnqfwx0CDC
         CkYd6W/98449C5f/+ySBGoKmblizsXwi135Xc0IuVWklWw5DQTNFdMg+fzRXxNoyPp
         BS6yuDfvac1CWktP54b4MWFOLc5agAkbulvUEyYKE+ncIgw9FQOAp2qCUwY9qwT+m8
         LqjUn7M66M/a7gVaRF0kQsuLqkmeF3MSZYsRSxLLRfzTtIDmQ1eskTpIQf1unRSkDw
         JczrdNgCu2JJtHgSbkjQZN1l3iCxGufHCopGbiBXxsLLyESa8tP
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 0/4] Documentation for common user misconceptions
Date:   Sat,  2 Nov 2019 19:26:11 +0000
Message-Id: <20191102192615.10013-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.0.rc2.428.g50e10028f1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series includes four patches that update the documentation to
address common user misconceptions.

Changes from v2:
* Move author and committer information to git-commit(1) where people
  will look for it.
* Move guidance on user.name format to git-commit(1) as well and mention
  a shortened form of the advice in the `user.name` description.
* Use a parenthetical to describe a "personal name" without contrasting
  it with a username.
* Offer a potential solution for people who want to ignore tracked
  files by recommending a templating mechanism.
* Be slightly more verbose about why memory is wasted with
  http.postBuffer.

Changes from v1:
* Remove parenthetical which was confusing.
* Add two more patches.

brian m. carlson (4):
  doc: move author and committer information to git-commit(1)
  doc: provide guidance on user.name format
  doc: dissuade users from trying to ignore tracked files
  docs: mention when increasing http.postBuffer is valuable

 Documentation/config/http.txt      |  8 ++++++
 Documentation/config/user.txt      |  7 +++++-
 Documentation/git-commit-tree.txt  | 39 ++++-------------------------
 Documentation/git-commit.txt       | 40 +++++++++++++++++++++++++++---
 Documentation/git-update-index.txt | 16 ++++++++++++
 5 files changed, 72 insertions(+), 38 deletions(-)

Range-diff against v2:
1:  603a9f8f9a < -:  ---------- doc: provide guidance on user.name format
-:  ---------- > 1:  b39b365f54 doc: move author and committer information to git-commit(1)
-:  ---------- > 2:  b7d805427c doc: provide guidance on user.name format
2:  0da41623a5 ! 3:  7644af0b07 doc: dissuade users from trying to ignore tracked files
    @@ Commit message
         pitfalls in the documentation for git update-index so that users know
         they should explore alternate solutions.
     
    +    In additon, let's provide a recommended solution to dealing with the
    +    common case of configuration files, since there are well-known
    +    approaches used successfully in many environments.
    +
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## Documentation/git-update-index.txt ##
    @@ Documentation/git-update-index.txt: The untracked cache extension can be enabled
     +the index when performing certain operations.  In general, Git does not
     +provide a way to ignore changes to tracked files, so alternate solutions
     +are recommended.
    ++
    ++If the file you want to change is some sort of configuration file (say,
    ++for a build tool, IDE, or editor), a common solution is to use a
    ++templating mechanism, such as Ruby's ERB, to generate the ignored
    ++configuration file from a template stored in the repository and a source
    ++of data using a script or build step.
     +
      SEE ALSO
      --------
3:  89fe11b951 ! 4:  d096763e7a docs: mention when increasing http.postBuffer is valuable
    @@ Documentation/config/http.txt: http.postBuffer::
     +server or a proxy only supports HTTP/1.0 or is noncompliant with the
     +HTTP standard.  Raising this is not, in general, an effective solution
     +for most push problems, but can increase memory consumption
    -+significantly.
    ++significantly since the entire buffer is allocated for even small
    ++pushes.
      
      http.lowSpeedLimit, http.lowSpeedTime::
      	If the HTTP transfer speed is less than 'http.lowSpeedLimit'
