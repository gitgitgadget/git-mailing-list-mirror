Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2076C2047F
	for <e@80x24.org>; Tue,  1 Aug 2017 20:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbdHAURM (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 16:17:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53133 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752101AbdHAURM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 16:17:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 919E7A01DD;
        Tue,  1 Aug 2017 16:17:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OhnCF4iG0GSs1a2x6cCRXgMZJeM=; b=K2kGEt
        GqwV1GwBZIQwECScq6VMK028Po8F7U9LVgZvgM+nSiNsKwwWX6h6pA/QrX8fYXB/
        /uT6Kd0zDLomGQVBIRFt2jNce3SXE3j04HNpCdts/wnJBwyp4TDsNxUe4jzWZtPz
        THOhavF2LRsnlx46z15mJRqCg/wDK9r0OTzNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pcyl/2kiLng9EFEN7WwPwxNdjwOs9JuL
        OvZN/Xq51fimtVvOmrE6AvNoqdz86h7wh/ntekA6AXhMuqJkvdogb66bn1XFH/o6
        GJh7/sEsSBAahGiX+Ez53lIoBzfJin4eizcf3RM+K0OzWYzAuU2WmqSEH17v5Yjx
        ilPfbVY0Au8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8AA70A01DC;
        Tue,  1 Aug 2017 16:17:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED0A0A01DB;
        Tue,  1 Aug 2017 16:17:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git-fast-export doesn't support mergetag header
References: <9955b90cde034eee8c2cdb33064b9262@exmbdft7.ad.twosigma.com>
Date:   Tue, 01 Aug 2017 13:17:04 -0700
In-Reply-To: <9955b90cde034eee8c2cdb33064b9262@exmbdft7.ad.twosigma.com>
        (David Turner's message of "Tue, 1 Aug 2017 20:10:44 +0000")
Message-ID: <xmqqbmnzf3gf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63675412-76F6-11E7-88EE-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <David.Turner@twosigma.com> writes:

> It looks to me like git-fast-export doesn't export the mergetag
> header on a commit.  Is this intentional, or an oversight?

Most likely the latter, combined with that probably not many people
use the tool with histories with merges in them (hence not reported
as a bug so far).
