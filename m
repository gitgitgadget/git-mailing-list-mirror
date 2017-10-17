Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DC6E202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 03:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbdJQD42 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 23:56:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59876 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751329AbdJQD41 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 23:56:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A249BB814C;
        Mon, 16 Oct 2017 23:56:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=3
        KjZ2Hx00xjGQa8Mxnwf9y/kklc=; b=IqtIniSCYf9E+Hc3BYQDtkflnoPIcRE0y
        KnRoeWaHTatBkUkG8Muh0RkzcdcCS41eqoMewFjJS1An1KAPpznZE/2x2s0SqkiS
        4Qrk06DWsY2svd9sEaT01zjdoRPBH/WZHy+3CyYNB7vGaMVF5IOSG8JsOg9x24EH
        xiwowRlzJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=Fxl
        CMfC0h1gxE8yaIzHsJGLOLBOR1Jd5gPYFriz1BGY0dNqdpAothxHrZsd5yO3ANJ5
        Ex9UWIDsrSrMTgoVpXizt3mIRqvgJtwEhayZuxydPHWlFWjtab9DGuBlYLWA1TUL
        aSflH0uBc2RZIV3153zYHZ6NWa+er+98y9MqyZKg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 999C7B814B;
        Mon, 16 Oct 2017 23:56:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E593EB814A;
        Mon, 16 Oct 2017 23:56:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] fetch doc: src side of refspec could be full SHA-1
Date:   Tue, 17 Oct 2017 12:56:24 +0900
Message-ID: <xmqqinfepguv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25D1EC68-B2EF-11E7-9088-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since a9d34933 ("Merge branch 'fm/fetch-raw-sha1'", 2015-06-01) we
allow to fetch by an object name when the other side accepts such a
request, but we never updated the documentation to match.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/pull-fetch-param.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 1ebbf1d738..733f932479 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -23,9 +23,11 @@ ifdef::git-pull[]
 endif::git-pull[]
 +
 The format of a <refspec> parameter is an optional plus
-`+`, followed by the source ref <src>, followed
+`+`, followed by the source <src>, followed
 by a colon `:`, followed by the destination ref <dst>.
-The colon can be omitted when <dst> is empty.
+The colon can be omitted when <dst> is empty.  <src> is most
+typically a ref, but it can also be an fully spelled hex object
+name.
 +
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`;
 it requests fetching everything up to the given tag.
-- 
2.15.0-rc1-168-g2b9456ab46

