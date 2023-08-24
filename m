Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66E8C88CB2
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 20:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243608AbjHXUzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 16:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243588AbjHXUzD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 16:55:03 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A460E1BC2
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 13:55:01 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D9E961A0E69;
        Thu, 24 Aug 2023 16:54:57 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=vH5H+6Br1OfNMdB85EoHsoCx6dnfPvO9GyZ7y9ugMJk=; b=ZmgT
        ArwRDcHlrMWwripQYBt+IQD7OdzwF+F+nrrSLJoJqYo2OESIdLvaJg4B14MmsbjI
        Ok9SV8Eu6Z+NFW4aa+CC1ZD2U8cdNH9bkfmX+vmixkCozy5BONxRRvmoOoj0IOYW
        MUb2jMnqwV+ld3SZdxCOlc61NXYjDhTwy0BvkQc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D09FF1A0E68;
        Thu, 24 Aug 2023 16:54:57 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4882F1A0E67;
        Thu, 24 Aug 2023 16:54:57 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/4] code clean-up for rerere
Date:   Thu, 24 Aug 2023 13:54:52 -0700
Message-ID: <20230824205456.1231371-1-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-29-gcd9da15a85
MIME-Version: 1.0
X-Pobox-Relay-ID: 7BCAE054-42C0-11EE-87BA-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are to clean up some odd code and in-code comment that invited
"Huh?" while I was reviewing the code paths involved in "git rerere"
recently.  None of them is intended to change any behaviour.

Junio C Hamano (4):
  rerere: simplify check_one_conflict() helper function
  rerere: fix comment on handle_file() helper
  rerere: try_merge() should use LL_MERGE_ERROR when it means an error
  rerere: modernize use of empty strbuf

 rerere.c | 46 +++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

--=20
2.42.0-29-gcd9da15a85

