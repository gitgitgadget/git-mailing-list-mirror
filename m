Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 987711FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 18:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994AbcFPSZc (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 14:25:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55989 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752512AbcFPSZc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jun 2016 14:25:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AEB6D255D9;
	Thu, 16 Jun 2016 14:25:30 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tZga17prUXrT
	s62nzvSByNxzHeU=; b=a1sOjJ+xLlIAQW1LxNw1M4qxrzh6V9WC/kpvCoMneDAh
	uS0ENLOokTjAGFmXrtwbgwhoOrNqlRMC+933cDeKtrtObx63l+fSvC1/1y3xoKSu
	kcCFfKhCJDrM5r+M86BBRS44bwLXuIgyGseyiZJfrIRCqEMDJeo9F43pxAoeHWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=h8nY2o
	WpbEeKGAkfCjHtLcJQLkrtDn8symdAwLed6r2biAL7/D5aoR7Kk5jwWP8S7CIwbg
	YDvJzue62KkRoNeURe+1mMcfu1Yf9ZCYZGuvRIBDLI86ydpabThX0hlipI31eSor
	2UQysYX/FSdkxN21YQi5IpxL0ew57LT7RywJE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A746A255D8;
	Thu, 16 Jun 2016 14:25:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4198A255D6;
	Thu, 16 Jun 2016 14:25:30 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, josef@kufner.cz
Subject: Re: [PATCH 0/2] Log pretty format alignment improvements
References: <20160616131838.14440-1-pclouds@gmail.com>
Date:	Thu, 16 Jun 2016 11:25:28 -0700
In-Reply-To: <20160616131838.14440-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Thu, 16 Jun 2016 20:18:36 +0700")
Message-ID: <xmqqtwgt3s9z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B4AC9954-33EF-11E6-ACB8-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> The first patch was from a long time ago. The concern was it may be
> breaking existing user expectation [1]. I still maintain that it's a good
> thing to do and should not break anything. Hence the resubmission.

I do not think "it's a good feature to have" was a question from the
beginning.  Thread [1] stopped with me saying "as long as >(N) can
be used as Duy claims as a workaround to get the original behaviour,
it is good to allow using >|(N) for this new output format; I didn't
check if >(N) does behave that way, though".  What was necessary to
resurrect the patch was "Yes, >(N) can be used that way and here is
a test" or something like that.

> The second patch adds negative column specifier to >|() and friends.
> A positive number 'n' specifies the n-th column from the left border
> of the screen, '-n' specifies the n-th column from the _right_ border.

That is quite nice enhancement.
