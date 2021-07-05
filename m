Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F572C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 19:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3306761955
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 19:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhGEUCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 16:02:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54113 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhGEUCT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 16:02:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 410C113F0FA;
        Mon,  5 Jul 2021 15:59:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gnPmSKbIuni9JLE1Otdu1T8ibQD0bn4HqGfN/H
        8S4zQ=; b=wq+ziiRST1lV57SIv4hYKMlFDL2XpAVjEbWKTgFshs7KkQyaMss6wi
        VtBB6Ndb+QWTT8l96UgRoZowo01ZfB0Ss6azfdiFR4w3Fv6Yc5ZoxSHsX8mkCzHf
        Te5pxhVJECdVTfURlVJEmRU/E+Bh0ij5vKH/iRTiJVKCmQC/0jmKA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 38CE013F0F9;
        Mon,  5 Jul 2021 15:59:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AEEE813F0F8;
        Mon,  5 Jul 2021 15:59:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Andrew Berry" <andrew@furrypaws.ca>
Cc:     git@vger.kernel.org, "Bagas Sanjaya" <bagasdotme@gmail.com>
Subject: Re: [PATCH] docs: .gitignore in parents is current repo only
References: <20210702222044.72767-1-andrew@furrypaws.ca>
        <b9da43a8-897b-7cce-ecbc-ea56078f0f09@gmail.com>
        <889D9AD1-1114-49B4-ADB0-BF78160743E4@furrypaws.ca>
Date:   Mon, 05 Jul 2021 12:59:38 -0700
In-Reply-To: <889D9AD1-1114-49B4-ADB0-BF78160743E4@furrypaws.ca> (Andrew
        Berry's message of "Mon, 05 Jul 2021 13:30:50 -0400")
Message-ID: <xmqq4kd8mt05.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 882711F8-DDCB-11EB-B5F6-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Andrew Berry" <andrew@furrypaws.ca> writes:

> On 2 Jul 2021, at 20:06, Junio C Hamano wrote:
>
>> I would have thought that "up to the toplevel of the work
>> tree" would be sufficiently clear where the upward traversal of the
>> directories ends, i.e. at the repository boundary.
>
> Seems reasonable. What if we move that note to come after "any parent
> directory"?

Meaning something like the following?

I do agree that it makes it a lot clearer.

 Documentation/gitignore.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git c/Documentation/gitignore.txt w/Documentation/gitignore.txt
index 53e7d5c914..58c2e41bbe 100644
--- c/Documentation/gitignore.txt
+++ w/Documentation/gitignore.txt
@@ -27,8 +27,8 @@ precedence, the last matching pattern decides the outcome):
    them.
 
  * Patterns read from a `.gitignore` file in the same directory
-   as the path, or in any parent directory, with patterns in the
-   higher level files (up to the toplevel of the work tree) being overridden
+   as the path, or in any parent directory (up to the toplevel of
+   the work tree), with patterns in the higher level files being overridden
    by those in lower level files down to the directory containing the file.
    These patterns match relative to the location of the
    `.gitignore` file.  A project normally includes such
