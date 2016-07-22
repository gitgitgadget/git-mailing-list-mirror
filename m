Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E567A203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 20:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbcGVUdf (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 16:33:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59267 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751124AbcGVUde (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 16:33:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D0192E6F0;
	Fri, 22 Jul 2016 16:33:33 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VzbTOEiMftQVRe2SOSm/+beZumI=; b=hXPbaA
	4eG4w5PKVP+N1bQLhA7kSq2Xu//9fXrtO2nXWj6r6SugA/r/Ik2CnBY6EXiTiMo+
	xfLRDGGAzOnnH9rNRluX1tvAYPo1vI8TndDg+/ihrrBUDVxp3y0PVMDntAego8BQ
	swmLQLp6Cfa3n9W0EbEkp7vXCm+yJ1wY0v8WA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tyhZo2XQJgQHPuh7OyF86NXTzu0Vga9z
	twebm6wA6ipnjnqeFEplv2qz4o/3zbkHrc4BZRYoaFUuqlpl8ss5+YosWadDOQjH
	BOUI5Iv39mHI6VVSwrJTwkjPkeKGbUWu6s9voMX8slyP9qgKPErCHZXqILJRY/m/
	4ByG8w956bU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 02B0F2E6EF;
	Fri, 22 Jul 2016 16:33:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 794C12E6EE;
	Fri, 22 Jul 2016 16:33:32 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Richard Soderberg <rsoderberg@gmail.com>, git@vger.kernel.org
Subject: Re: git-prompt.sh incompatible with non-basic global grep.patternType
References: <CAEvc1UQvXKtQCXvCmt-774A84--bkK-sb94BtFeqDDr0Gsf7qw@mail.gmail.com>
	<20160720134211.GA19359@sigill.intra.peff.net>
	<xmqqwpkgcbp9.fsf@gitster.mtv.corp.google.com>
	<20160720205207.GA578@sigill.intra.peff.net>
	<xmqqr3ala37o.fsf@gitster.mtv.corp.google.com>
	<20160722192811.GA18079@sigill.intra.peff.net>
	<xmqqa8h9a1uj.fsf@gitster.mtv.corp.google.com>
	<20160722200545.GA18286@sigill.intra.peff.net>
Date:	Fri, 22 Jul 2016 13:33:30 -0700
In-Reply-To: <20160722200545.GA18286@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 22 Jul 2016 16:05:45 -0400")
Message-ID: <xmqqwpkd8lb9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E82F322-504B-11E6-941D-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But even that is a lesser breakage than taking away grep.extendedRegexp
> entirely. Taking it away breaks anybody who uses it; tweaking (2) only
> breaks people who set both config variables. But why would anyone do
> that?

OK.  Now we have an evidence that we have thought things through
that we can point at when people later complain, I'd feel much safer
to apply that "This will break t7810" patch, together with changes
to t7810 to drop these crazy expectations ;-)

