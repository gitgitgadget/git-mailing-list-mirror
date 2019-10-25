Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2FB71F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 03:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404116AbfJYDXn (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 23:23:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51051 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731941AbfJYDXm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 23:23:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF22328C62;
        Thu, 24 Oct 2019 23:23:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s0Z6X0Cde9cI3FdOUjqU2l2n6b4=; b=EGvolg
        VFEbxnIRm/Y1gdXlcfGx4xw9KlFBx5o6ubtIseZmnEo+6mBO0ws+ixg2p2FD0fya
        IhMAtrYs2F4sbmNf0p8UNTbKRIxajKTQC8278V4r/FHng329NaFO6mj07E4idLe8
        wdMyr4w49HOJac9ZXCLdQ8vnQsjjP/bSgby6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uf8jZ384/Y+P1HMXq9vfMwoF8Yam3dBD
        6WvyZajoIuecedHeAazv5sWJ7pN1dpwTOWpL57QOPTADcIBuYe4tfDuiciXp3aiS
        0wsqqgqJTP0BIwM3TZ5KdGEexn++q5HkcdGq9wQeTPFxA8QRyPCKPZ//KSbRdD8m
        a37KHSPr3OA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A656F28C61;
        Thu, 24 Oct 2019 23:23:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1357228C60;
        Thu, 24 Oct 2019 23:23:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 09/23] fsck: unify object-name code
References: <20191018044103.GA17625@sigill.intra.peff.net>
        <20191018045613.GI17879@sigill.intra.peff.net>
        <xmqq8spafzjt.fsf@gitster-ct.c.googlers.com>
        <20191024180710.GC12892@sigill.intra.peff.net>
Date:   Fri, 25 Oct 2019 12:23:39 +0900
In-Reply-To: <20191024180710.GC12892@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 24 Oct 2019 14:07:10 -0400")
Message-ID: <xmqqa79pecec.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6EF53AA-F6D6-11E9-B11B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Heh. I originally wrote just "put" and "get" for brevity, but then
> worried that wasn't clear enough. Let's just use the full names. We can
> afford the extra few bytes, and it makes it easier if we later need to
> grep for them or whatever. Here's a replacement patch (I won't send the
> whole series just yet, as it seems it hasn't gotten a whole lot of
> review so far).

It seems that you sent the original instead X-<.

I'll just replace the original 09/23 with the following squashed in
for now.

Thanks.

 fsck.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fsck.h b/fsck.h
index f6f0c40060..6228f0b2d4 100644
--- a/fsck.h
+++ b/fsck.h
@@ -73,13 +73,13 @@ int fsck_finish(struct fsck_options *options);
  * If fsck_enable_object_names() has not been called, all other functions are
  * noops.
  *
- * Use put_object_name() to seed initial names (e.g. from refnames); the fsck
- * code will extend that while walking trees, etc.
+ * Use fsck_put_object_name() to seed initial names (e.g. from refnames); the
+ * fsck code will extend that while walking trees, etc.
  *
- * Use get_object_name() to get a single name (or NULL if none). Or the more
- * convenient describe_object(), which always produces an output string with
- * the oid combined with the name (if any). Note that the return value points
- * to a rotating array of static buffers, and may be invalidated by a
+ * Use fsck_get_object_name() to get a single name (or NULL if none). Or the
+ * more convenient describe_object(), which always produces an output string
+ * with the oid combined with the name (if any). Note that the return value
+ * points to a rotating array of static buffers, and may be invalidated by a
  * subsequent call.
  */
 void fsck_enable_object_names(struct fsck_options *options);
