Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7925420193
	for <e@80x24.org>; Thu,  4 Aug 2016 21:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934031AbcHDV2O (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 17:28:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56784 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753041AbcHDV2N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 17:28:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DD5FE321C1;
	Thu,  4 Aug 2016 17:28:11 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=87Ivrrz+LRk0CEXceLZDtxn89Hk=; b=isHVNi
	vVidc3chs1Hzrycqz3fW+7tbLO9AB/HQj3Yafe/1iYoJs3kvP6SWSLYst/r6Ekpg
	+QJMWb8Z0VHXwE9DE8dItdjljYndaUSt1f1wQd8R/SJJdxkQoCki/qYFjCsbJ4QS
	np0JzG90HOmsVCfjP13MfBRXyXD0kqU5a1eKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RU3aBasHhKTbLwL9U+nWGBrQyNCCMS6J
	87CKVXaeBGG53OkJ+yb1+nI0Gho3HOBx/DU/kwRr914qdPbDNBU6VNh46A8A7lsJ
	6ZIZfXpAV5OKpfP2EcSDI0kIMyg7CHE1nh2CJgS362DQfnUd5wF8Q0pWDGihycG9
	y84wN7o8bCQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D40B2321C0;
	Thu,  4 Aug 2016 17:28:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5EED3321BE;
	Thu,  4 Aug 2016 17:28:11 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Christian Couder <christian.couder@gmail.com>,
	larsxschneider@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 3/7] trace: use warning() for printing trace errors
References: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
	<20160803225826.hlr273h4cy2hcfyk@sigill.intra.peff.net>
	<xmqqk2fw1d41.fsf@gitster.mtv.corp.google.com>
	<20160804212157.cn7ecyxcbyf4okd7@sigill.intra.peff.net>
Date:	Thu, 04 Aug 2016 14:28:09 -0700
In-Reply-To: <20160804212157.cn7ecyxcbyf4okd7@sigill.intra.peff.net> (Jeff
	King's message of "Thu, 4 Aug 2016 17:21:57 -0400")
Message-ID: <xmqqy44cz0k6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58407E76-5A8A-11E6-B728-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I wondered if that would then let us drop set_warn_routine(), but it
> looks like there are other warning() calls it cares about. So that would
> invalidate the last paragraph here, though I still think converting the
> trace errors to warning() is a reasonable thing to do.

Yes.  That is why tonight's pushout will have this series in 'jch'
(that is a point on a linear history between 'master' and 'pu') and
tentatively ejects cc/apply-am topic out of 'pu', expecting it to be
rerolled.

Thanks.

