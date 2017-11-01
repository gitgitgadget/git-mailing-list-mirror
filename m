Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7A152055E
	for <e@80x24.org>; Wed,  1 Nov 2017 06:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750918AbdKAGOY (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 02:14:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59356 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750716AbdKAGOX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 02:14:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AD659405E;
        Wed,  1 Nov 2017 02:14:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BtZCF4GD8qZB
        tgaGhA1/fVwj3dE=; b=GWfCKr5ZX+Rs7n+aREQ9F4P27KoMOrNCHuSNa/x3u8Nk
        +oPwr1lijjYtwcczRocSZPFjQl4eCJBByu4Wo7hHDIApCx7Xql6s9FhVmbSiuR/h
        WeEzqgy+Oz2fHYlJ9NjEr0WSAdRsd+vSCWZm5ai+NOWx96zcG+mnix7JMKEfLcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=EWUSpR
        d9BbvcbcU+wmemiVtmcojhQpfNDqD/dJmJ/DHv0531Y05ed/93fIyMImvThMw/CC
        q5GJ8gmoYEk7hK4w5iDUuFkL/pItBh3GxNx7PbsCCec38Zk3CBYPO67nyhGvRlvD
        3ZWeTy0R/Qgndr0kZ9SPJry2KmTH3475uwug4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71F3E9405D;
        Wed,  1 Nov 2017 02:14:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB83B94058;
        Wed,  1 Nov 2017 02:14:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] diff: --indent-heuristic is no longer experimental
References: <20171029151228.607834-1-cmn@dwim.me>
        <xmqq1sljzt2i.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 01 Nov 2017 15:14:20 +0900
In-Reply-To: <xmqq1sljzt2i.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 31 Oct 2017 16:15:33 +0900")
Message-ID: <xmqqk1zattj7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E6DF8752-BECB-11E7-BDF9-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Carlos Mart=C3=ADn Nieto <cmn@dwim.me> writes:
>
>> This heuristic has been the default since 2.14 so we should not confus=
e our
>> users by saying that it's experimental and off by default.
>>
>> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>
>> ---
>>  Documentation/diff-heuristic-options.txt | 5 -----
>>  Documentation/diff-options.txt           | 7 ++++++-
>>  2 files changed, 6 insertions(+), 6 deletions(-)
>>  delete mode 100644 Documentation/diff-heuristic-options.txt
>
> I suspect that this patch is incomplete.  The build procedure barfs
> and dies while making git-annotate.html, claiming that it wants to
> find diff-heuristic-options.txt that no longer exists.

The fix is obvious once you have time to sip your tea and look at
the output from "git grep" ;-)

Subject: [PATCH] SQUASH???

---
 Documentation/git-annotate.txt | 1 -
 Documentation/git-blame.txt    | 2 --
 2 files changed, 3 deletions(-)

diff --git a/Documentation/git-annotate.txt b/Documentation/git-annotate.=
txt
index 94be4b85e0..05fd482b74 100644
--- a/Documentation/git-annotate.txt
+++ b/Documentation/git-annotate.txt
@@ -23,7 +23,6 @@ familiar command name for people coming from other SCM =
systems.
 OPTIONS
 -------
 include::blame-options.txt[]
-include::diff-heuristic-options.txt[]
=20
 SEE ALSO
 --------
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index fdc3aea30a..16323eb80e 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -89,8 +89,6 @@ include::blame-options.txt[]
 	abbreviated object name, use <n>+1 digits. Note that 1 column
 	is used for a caret to mark the boundary commit.
=20
-include::diff-heuristic-options.txt[]
-
=20
 THE PORCELAIN FORMAT
 --------------------
--=20
2.15.0-206-g5fb43f7f39

