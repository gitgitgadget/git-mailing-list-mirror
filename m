Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E639720954
	for <e@80x24.org>; Sun, 26 Nov 2017 03:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbdKZDTy (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 22:19:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54946 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751902AbdKZDTx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 22:19:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 82AB79F310;
        Sat, 25 Nov 2017 22:19:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V86cyUXiyErI4CrtDlixxgxTGaw=; b=dGgFvu
        q+0XXFsBhi75R2sxHvldnSefswQ5LamnVxn8G6KgUuptBdHjpOdf+LHVapX/3y6N
        F4cFNOBYEsrT50YbLwhs4oLtlwSJ1MUdiDKxzLoCAH27q9pRVdZ0h2qJ1sbuPYYf
        CYqmzCZUPd8ALcOatXyI/SY81yDsJFK7Kh3tI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WoZ53+rfmux4RhoEOrD2Y/hk8fmPziSV
        USpmglTtFUcaDSV8gG8dzktsX1YevIRs5CLMywHCRSzWTWmyXnU3+M7h9Thfwgem
        8/OtXCYcMvgBwjr/lFoIkgFfux/Rrc78UAp4uApEln/s7FVJZRq6dta5y2TGP3+i
        rhjOe9cMhMA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7775A9F30F;
        Sat, 25 Nov 2017 22:19:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EEC5B9F30D;
        Sat, 25 Nov 2017 22:19:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ann T Ropea <bedhanger@gmx.de>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v4 1/6] diff: diff_aligned_abbrev: remove ellipsis after abbreviated SHA-1 value
References: <20171119184113.16630-1-bedhanger@gmx.de>
        <20171113223654.27732-1-bedhanger@gmx.de>
        <83D263E58ABD46188756D41FE311E469@PhilipOakley>
        <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com>
        <20171113223654.27732-3-bedhanger@gmx.de>
        <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>
        <20171119184113.16630-5-bedhanger@gmx.de>
        <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com>
        <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley>
        <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com>
        <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley>
        <CAPig+cT-r0uLLv_GyTRddPe=ATX883S1jt-8gc=ANZW21S81Mg@mail.gmail.com>
        <CAPig+cT4MvjLDvFEB6hJOSip=dqkp10ydnpfnoUabK=53OmQkw@mail.gmail.com>
        <20171124235330.15157-1-bedhanger@gmx.de>
        <xmqq4lpjkl4g.fsf@gitster.mtv.corp.google.com>
        <xmqqd145k9td.fsf@gitster.mtv.corp.google.com>
Date:   Sun, 26 Nov 2017 12:19:50 +0900
In-Reply-To: <xmqqd145k9td.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sun, 26 Nov 2017 12:17:34 +0900")
Message-ID: <xmqq609xk9pl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AAA3F78C-D258-11E7-B1E1-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

... and this is a sample of the "remainder" of 6/6 outlined in the
previous message, to become part of 5/6 to show how the new output
would look like in a test form.

 t/t4013-diff-various.sh                                        | 1 +
 t/t4013/diff.noellipses-diff-tree_--root_-r_--abbrev=4_initial | 6 ++++++
 2 files changed, 7 insertions(+)
 create mode 100644 t/t4013/diff.noellipses-diff-tree_--root_-r_--abbrev=4_initial

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 7288b54045..8b5474a087 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -178,6 +178,7 @@ diff-tree --root --abbrev initial
 diff-tree --root -r initial
 diff-tree --root -r --abbrev initial
 diff-tree --root -r --abbrev=4 initial
+:noellipses diff-tree --root -r --abbrev=4 initial
 diff-tree -p initial
 diff-tree --root -p initial
 diff-tree --patch-with-stat initial
diff --git a/t/t4013/diff.noellipses-diff-tree_--root_-r_--abbrev=4_initial b/t/t4013/diff.noellipses-diff-tree_--root_-r_--abbrev=4_initial
new file mode 100644
index 0000000000..26fbfeb177
--- /dev/null
+++ b/t/t4013/diff.noellipses-diff-tree_--root_-r_--abbrev=4_initial
@@ -0,0 +1,6 @@
+$ git diff-tree --root -r --abbrev=4 initial
+444ac553ac7612cc88969031b02b3767fb8a353a
+:000000 100644 0000 35d2 A	dir/sub
+:000000 100644 0000 01e7 A	file0
+:000000 100644 0000 01e7 A	file2
+$
-- 
2.15.0-479-ge11ee266c9

