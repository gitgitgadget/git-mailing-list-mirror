Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57FB21F454
	for <e@80x24.org>; Sun, 10 Nov 2019 09:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfKJJ7s (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 04:59:48 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44301 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbfKJJ7s (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Nov 2019 04:59:48 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5B9DB21AD2;
        Sun, 10 Nov 2019 04:59:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 10 Nov 2019 04:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lastninja.net;
         h=date:from:to:subject:message-id:mime-version:content-type; s=
        fm2; bh=AnRdkEz089FqULyp3Cm4DYFyaaaTVLK9Qgv+aoiX20k=; b=OlIDQkhO
        co4IXhQvjar4PlEy2wQg7Xo+HaWbEq8vPOVl276pVJt4T8xkji/mY7ER96rW/VnQ
        pZTGHO3a+YSJouTqts+kgO6NkhGpIkp+Sm8u6VXy6dgATIX3KlQNZ9zchQWaGLgs
        G7hrFdXCO7jTU1cu0rWLitixYSRR3BHVrrd5qt2L9iCojKyCvgkocmaA//E1XtKt
        pnnGKKiTYWGBJKR3oMhT5L2LOhzk74RkrorfxABrw3rZ+5MhlexT+/bCrbOm+SNE
        3E/RjmU1BY7gdDucJiyIkYzgD8ICj9uXKq9rG58S/0sahGLqOsgz4bulQr7dh52D
        IzTLj63zN/vFEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=AnRdkEz089FqULyp3Cm4DYFyaaaTV
        LK9Qgv+aoiX20k=; b=Vva+et7N2ZmXR3N1RBnV8YUcwZLJU8HR6lsxDhqlTktD3
        NNvxvzNDOQDNC8+k+H4JCuVIAtGF5HEiTlfvgkJeT5QW0T3qPb2RrXyH1leO2PAS
        fsCTOVcqSWcQ8QNLROBeodqdZ0f73o+BDmbdskX9tCaw8a1TXX/3AD7swOONDoY+
        3aqjGx8frdqItdwSzXh8aV8t9mwe56z7tSSM9nfMySnv5M0/Xo0l/cTGDgJonntO
        837ma2Q+KX0xKlHslP9n9MOQuoSKyoOTFH42leiDWzSDWIPIFMc7nVdBwMZIUlO2
        3Kp5IaL7MKf8KCoqy86TGXQij68GfL+EdD+Lmvjzg==
X-ME-Sender: <xms:k9_HXYEGn1lk4nqJk2I-P38HonUjRVgyWo5-u0jtvzfnRcgPf4o7oQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedruddvhedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtuggfsehttdertd
    dtredvnecuhfhrohhmpefprghvvggvnhcupfgrthhhrghnuceonhgrvhgvvghnsehlrghs
    thhnihhnjhgrrdhnvghtqeenucfkphepuddruddvledrvddvuddrudekheenucfrrghrrg
    hmpehmrghilhhfrhhomhepnhgrvhgvvghnsehlrghsthhnihhnjhgrrdhnvghtnecuvehl
    uhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:k9_HXfzHCoPmVjLG9nf96-vaSgOCN4pA08KgP29Kvzatm5RHj7grVw>
    <xmx:k9_HXUw-Y49fSIRSpPnRHSOi-Ez4q0_ezUwWsVQVCgc44OePQBKD1A>
    <xmx:k9_HXVbkvpe2HHucuPkbjS1QlG_DXjo4rgMBJWu-x7a4VjkbItYvWA>
    <xmx:k9_HXacHZFB0Yb-Pf9sqGpNa3lFqYcKJsilFVDE600y2Ntl3e0iRAg>
Received: from a.local (unknown [1.129.221.185])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4EBF93060057
        for <git@vger.kernel.org>; Sun, 10 Nov 2019 04:59:46 -0500 (EST)
Date:   Sun, 10 Nov 2019 20:59:42 +1100
From:   Naveen Nathan <naveen@lastninja.net>
To:     git@vger.kernel.org
Subject: [PATCH] doc: improve readability of --rebase-merges in git-rebase
Message-ID: <20191110095942.GB6071@a.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When --rebase-merges was introduced in 427c3bd28a the sentence
describing the difference between --rebase-merges and --preserve-merges
is a little unclear and difficult to parse. This patch improves readability
while retaining original meaning.

Signed-off-by: Naveen Nathan <naveen@lastninja.net>
---
 Documentation/git-rebase.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 639a4179d1..6a826b47bd 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -442,9 +442,9 @@ i.e. commits that would be excluded by linkgit:git-log[1]'s
 the `rebase-cousins` mode is turned on, such commits are instead rebased
 onto `<upstream>` (or `<onto>`, if specified).
 +
-The `--rebase-merges` mode is similar in spirit to the deprecated
-`--preserve-merges`, but in contrast to that option works well in interactive
-rebases: commits can be reordered, inserted and dropped at will.
+The `--rebase-merges` mode is similar in spirit to `--preserve-merges`
+(deprecated) but actually works with interactive rebases, where commits
+can be reordered, inserted and dropped at will.
 +
 It is currently only possible to recreate the merge commits using the
 `recursive` merge strategy; Different merge strategies can be used only via
-- 
2.21.0

