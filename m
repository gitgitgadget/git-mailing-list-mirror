Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B05EE49A0
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 16:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjHWQOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 12:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbjHWQOm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 12:14:42 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0011E7F
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 09:14:39 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F7FD1A3E9;
        Wed, 23 Aug 2023 12:14:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k5uWis7BTRPoVx3ceLoHgHGxN3CBrme9Yl8wBI
        eI8M8=; b=hDvbDb2rFnSDs2fg+eeoiJ9GHuV+PuEkjdJe1fHOs6E6+5v9aw1CwL
        qIP//HuE8TXXBcaV31d1Nw/vv5EaXWTMUqbImx1K1mFYoFAXSlpUua/H18OYoXqZ
        qx/kG70LzSHK2zb6qgTfu2+qm3y1023jw2KUdQbG3UCbwNkQF0ZDk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 780AD1A3E8;
        Wed, 23 Aug 2023 12:14:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1650B1A3E5;
        Wed, 23 Aug 2023 12:14:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     Christian Hesse <list@eworm.de>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH v2 2/2] t/t6300: drop magic filtering
References: <CAPig+cTFrroZGo=KOXu0aCxeJvNz7eaHAK++HXELZ0ZheJhw9w@mail.gmail.com>
        <20230823065300.21961-1-list@eworm.de> <ZOYHjwOFdFGjFm1W@five231003>
Date:   Wed, 23 Aug 2023 09:14:34 -0700
In-Reply-To: <ZOYHjwOFdFGjFm1W@five231003> (Kousik Sanagavarapu's message of
        "Wed, 23 Aug 2023 18:50:15 +0530")
Message-ID: <xmqqttspg2hh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27295F76-41D0-11EE-A335-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

> On Wed, Aug 23, 2023 at 08:52:17AM +0200, Christian Hesse wrote:
>> From: Christian Hesse <mail@eworm.de>
>> 
>> Now that we ran a trustdb check forcibly it does no longer pollute the
>> output. Filtering is no longer required...
>
> s/forcibly/forcibly, 
>
> s/it does no longer pollute/it no longer pollutes

Thanks.  I've updated the patch locally to read like so:

----- >8 -----
From: Christian Hesse <mail@eworm.de>
Date: Tue, 22 Aug 2023 15:03:15 +0200
Subject: [PATCH] t/t6300: drop magic filtering

Now that we ran a trustdb check forcibly, it no longer pollutes the
output, and filtering is no longer required.

Signed-off-by: Christian Hesse <mail@eworm.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6300-for-each-ref.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 5b434ab451..aa3c7c03c4 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1763,10 +1763,7 @@ test_expect_success GPGSSH 'setup for signature atom using ssh' '
 '
 
 test_expect_success GPG2 'bare signature atom' '
-	git verify-commit first-signed 2>out.raw &&
-	grep -Ev "checking the trustdb|PGP trust model" out.raw >out &&
-	head -3 out >expect &&
-	tail -1 out >>expect &&
+	git verify-commit first-signed 2>expect &&
 	echo  >>expect &&
 	git for-each-ref refs/tags/first-signed \
 		--format="%(signature)" >actual &&
-- 
2.42.0

