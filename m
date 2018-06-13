Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4953B1F403
	for <e@80x24.org>; Wed, 13 Jun 2018 03:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933058AbeFMDKq (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 23:10:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64047 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754364AbeFMDKp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 23:10:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A89A7FD394;
        Tue, 12 Jun 2018 23:10:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=diX0
        nZ9HBRnMtMT/gj//PaAup8w=; b=uBVgUyDG5IIeEjwLhySpXfL0V0Vd8kS+uX8W
        Din565HB0+iuv9jc452iH0Pa1Z3zwMpQMDmrOF21yFLOUu3vDqRgt/I7A3KiBbMy
        ifW9CxP7DjFjH1NZydI/8Pd9BB86HObKnct/06nT/9RByiXSSMM2zBR1SeG1Zric
        q1cBjH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        cUWrRP/glotwxPeqHewJpDJy8psHS0hPQXmS4hDAOofxyuixsYRKFceonAsnB1Tp
        uyh/ifV4eTGwk+WnHuqB0u1kxvQN8fFM2OhTINArOktFnBZuIqnw6eBuj2H9lK2E
        8sL+rkouOQuWCMJpT0Ul8fexO6Bhw8w9sRGIYNXdOJE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85F6BFD392;
        Tue, 12 Jun 2018 23:10:44 -0400 (EDT)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.85.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A046FD38B;
        Tue, 12 Jun 2018 23:10:42 -0400 (EDT)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Luis Marsano <luis.marsano@gmail.com>,
        Ted Zlatanov <tzz@lifelogs.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 1/4] git-credential-netrc: make "all" default target of Makefile
Date:   Tue, 12 Jun 2018 23:10:36 -0400
Message-Id: <20180613031040.3109-2-tmz@pobox.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607051958.759-1-tmz@pobox.com>
References: <20180607051958.759-1-tmz@pobox.com>
X-Pobox-Relay-ID: 5C1CCB9C-6EB7-11E8-A1D2-44CE1968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running "make" in contrib/credential/netrc should run the "all" target
rather than the "test" target.  Add an empty "all::" target like most of
our other Makefiles.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 contrib/credential/netrc/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/credential/netrc/Makefile b/contrib/credential/netrc/Makefile
index 0ffa407191..6174e3bb83 100644
--- a/contrib/credential/netrc/Makefile
+++ b/contrib/credential/netrc/Makefile
@@ -1,3 +1,6 @@
+# The default target of this Makefile is...
+all::
+
 test:
 	./t-git-credential-netrc.sh
 
