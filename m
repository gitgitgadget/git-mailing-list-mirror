Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F3081F935
	for <e@80x24.org>; Wed, 21 Sep 2016 19:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935221AbcIUTjG (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 15:39:06 -0400
Received: from sdaoden.eu ([217.144.132.164]:39294 "EHLO sdaoden.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933900AbcIUTjF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 15:39:05 -0400
Received: by sdaoden.eu (Postfix, from userid 1000)
        id 9FAD01604A; Wed, 21 Sep 2016 21:39:01 +0200 (CEST)
Date:   Wed, 21 Sep 2016 21:40:04 +0200
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: v2.10.0: ls-tree exit status is always 0, this differs
 from ls(1)
Message-ID: <20160921194004.QOizfyGm8%steffen@sdaoden.eu>
References: <20160921132655.h49HMsHbp%steffen@sdaoden.eu>
 <xmqqr38d9ova.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqr38d9ova.fsf@gitster.mtv.corp.google.com>
Mail-Followup-To: Steffen Nurpmeso <steffen@sdaoden.eu>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
User-Agent: s-nail v14.9.0-pre1-42-g7211cd5
OpenPGP: id=95F382CE;
 url=https://www.sdaoden.eu/downloads/steffen.asc
X-BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors
 in the world can make no bugs.
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=-=AIRt7XpAYOD8B8E-EUBPGovVGh5jiBFZF1nB=-="
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.

--=-=AIRt7XpAYOD8B8E-EUBPGovVGh5jiBFZF1nB=-=
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

Junio C Hamano <gitster@pobox.com> wrote:
 |Steffen Nurpmeso <steffen@sdaoden.eu> writes:
 |> I think this behaviour contradicts the manual which strongly links
 |> ls-tree to ls(1):
 |
 |Patches to the documentation is very much welcomed.

The below could serve this purpose.

 |Somewhere the similarity must end, and actually it ends a lot
 |earlier, as "/bin/ls" takes exact paths while "ls-tree" (or any
 |other Git command for that matter) takes a pathspec pattern,
 |and not having a path that matches the pathspec pattern is not
 |an error condition.

I was just surprised to see nothing and get no feedback at all.
Ciao!

--steffen

--=-=AIRt7XpAYOD8B8E-EUBPGovVGh5jiBFZF1nB=-=
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="git-ls-tree-doc.diff"

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index dbc91f9..8ebeced 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -33,6 +33,10 @@ in the current working directory.  Note that:
    However, the current working directory can be ignored by passing
    --full-tree option.
 
+ - the behaviour is different to that of "/bin/ls" in sofar as non-existing
+   '<path>' arguments are silently ignored and not reflected in the exit
+   status code.
+
 OPTIONS
 -------
 <tree-ish>::

--=-=AIRt7XpAYOD8B8E-EUBPGovVGh5jiBFZF1nB=-=--
