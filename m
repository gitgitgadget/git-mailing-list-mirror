Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53DDD20C13
	for <e@80x24.org>; Fri,  1 Dec 2017 02:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbdLACcn (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 21:32:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58464 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751790AbdLACcm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 21:32:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FF5EB1997;
        Thu, 30 Nov 2017 21:32:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=jHuF3sEWV3NcvfDdODgeO0eSZZ0
        =; b=l8F3lLXw+QIL1ZNqssOEqOy7aV6BugQFQ+QrmiZU9U704cMVInvw+Dw+x0T
        N6eOq+dWu6MNJXsQIvlYceFS2GcF6hM/Qv23YjUEMytVdhOB4jhA9S31M/4aQw06
        bWU3Jh1a8pzNnHsgTlauxY2Z742UraGZl5+HQY11jehusqJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id; q=dns; s=sasl; b=KU/MMhgjlaMj8cYYj3yUC
        xQEpaJthpK1opNMO/Stv4OnApws8EG+BzZlwnQb2QAxURuBBKgvmM10BPCPz11E7
        cHFBMSv6ga7XFY+Rn83kjMLe04EWE0rmEqiny2LYQI9dBQRGKn/fn1OiUQGZHAFL
        oA0hdEJoXfUyMww6wjIync=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97562B1996;
        Thu, 30 Nov 2017 21:32:41 -0500 (EST)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.94.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C9DCB1993;
        Thu, 30 Nov 2017 21:32:41 -0500 (EST)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>
Subject: [PATCH 0/2] t/lib-git-svn.sh: improve svnserve tests with parallel make test
Date:   Thu, 30 Nov 2017 21:32:37 -0500
Message-Id: <20171201023239.26153-1-tmz@pobox.com>
X-Mailer: git-send-email 2.15.1
X-Pobox-Relay-ID: E764F67C-D63F-11E7-BEF6-8EF31968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests are not run by default nor are they enabled in travis-ci.  I
don't know how much testing they get in user or other packager builds.

I've been slowly increasing the test suite usage in fedora builds.  I
ran into this while testing locally with parallel make test.  The
official fedora builds don't run in parallel (yet), as even before I ran
into this issue, builds on the fedora builders randomly failed too
often.  I'm hoping to eventually enable parallel tests by default
though, since it's so much faster.

I'm not sure if there's any objection to changing the variable needed to
enable the tests from SVNSERVE_PORT to GIT_TEST_SVNSERVE.  The way
SVNSERVE_PORT is set in this patch should allow the port to be set
explicitly, in case someone requires that -- and they understand that it
can fail if running parallel tests, of course.  Whether that's a
feature or a bug, I'm not sure. :)

The indentation of lib-git-svn.sh didn't use tabs consistently, in only
a few places, so I cleaned that up first.  I can drop that change if
it's unwanted.

Todd Zullinger (2):
  t/lib-git-svn: whitespace cleanup
  t/lib-git-svn.sh: improve svnserve tests with parallel make test

 t/lib-git-svn.sh | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

-- 
2.15.1

