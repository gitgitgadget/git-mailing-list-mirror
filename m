Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 918C22095E
	for <e@80x24.org>; Fri, 24 Mar 2017 04:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbdCXE5F (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 00:57:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60286 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751274AbdCXE5E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 00:57:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 16B7C6DDA9;
        Fri, 24 Mar 2017 00:57:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ny+/3Ru8Imvronte/Dh0KVb+qsU=; b=bX8fc3
        uOOr7BlghyQuenCkE7DYamQUYdGjf9PCME1vOurUIUOgh1ZaZ+uswzDJJcDuMFBC
        ey0NtzCsR3P8patyUdDP9WtmI6W7bWn08J/tL0e0H2M+toH3H69e+foLoXKP7Vfv
        xuRjFQNkPwZR/2XHhAESsAV3cw0Bl7MbuLJRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I0yV12Ov0IUES4djyexPDkSy/7FhD9R0
        FScidjfNMWPR7GOXUKyg/kPl5YMz10hbD5xZ2U3UvghsY3c1Nd62naOYr1/LbDXb
        FiNPzQn8bTPdiuRKVZsBbEqv6em5O2fVjk9t/lT1RBv6K1Q7S1czIn9nD9xqVahw
        41U6UW71RQg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0D246DDA8;
        Fri, 24 Mar 2017 00:57:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58DED6DDA6;
        Fri, 24 Mar 2017 00:57:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] branch doc: update description for `--list`
References: <20170323120326.19051-1-avarab@gmail.com>
        <xmqq1stoexmb.fsf@gitster.mtv.corp.google.com>
        <CACBZZX7vW0TkbrBvLvKWnY=UpHNHzzQ7wuwhEhNOjCCjzPVMjA@mail.gmail.com>
        <xmqq37e3brxz.fsf@gitster.mtv.corp.google.com>
        <20170324004858.GE20794@aiede.mtv.corp.google.com>
Date:   Thu, 23 Mar 2017 21:56:52 -0700
In-Reply-To: <20170324004858.GE20794@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Thu, 23 Mar 2017 17:48:58 -0700")
Message-ID: <xmqqtw6j8e7f.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5131B4EA-104E-11E7-A82A-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The paragraph begins with a sample command line `git branch <name>`
that has nothing to do with the option being described.  Remove it,
but use the space to instead show that multiple patterns can be
given.

Also mention the unfortunate `-l` that can be easily confused with
it.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-branch.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 6a17ca591a..514b0d0b91 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -142,8 +142,13 @@ This option is only applicable in non-verbose mode.
 	List both remote-tracking branches and local branches.
 
 --list::
-	Activate the list mode. `git branch <branchname>` would try to create a branch,
-	use `git branch --list <pattern>` to list matching branches.
+	List branches.  With optional `<pattern>...`, e.g. `git
+	branch --list 'maint-*'`, list only the branches that match
+	the pattern(s).
++
+This should not be confused with `git branch -l <branchname>`,
+which creates a branch named `<branchname>` with a reflog.
+See `--create-reflog` above for details.
 
 -v::
 -vv::
-- 
2.12.1-432-gf364f02724

