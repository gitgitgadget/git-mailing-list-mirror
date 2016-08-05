Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20AC52018E
	for <e@80x24.org>; Fri,  5 Aug 2016 21:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S939728AbcHEVgl (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:36:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58704 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S937449AbcHEVgi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 17:36:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AAC9C33517;
	Fri,  5 Aug 2016 17:36:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6SdUKQlYZsFS36ZIYlYM5OrnQB4=; b=SHsBnI
	5ZWNG/U0MaIHmSq9aQGrMxn7f4aw1ekAJZ9J0z6q2p4aFB5tsJMfL7TLBI2fMpxM
	Era3y0rFgJ5VaeIALUvhsaT/iKasJJIlJnEPndvUKv3wq/izIsy6FzJzzN/n3xAi
	wd5L7zv+dD/gMr2EjHWm0htRKNqMRpTF4JXVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FIwT1Dat7YALwxzwvJQIVj5Ny6S+FnvR
	Y77qk6DWDr4u2NzaF3NQwamcYuuqU84F4YS0MjuWgFuFrBcBsNOzWVbUIlTDXrRR
	3Ak6JaxjblqgL2CArdHuk796GC26sRxvutGD5vHpIN1zUoLNOfUKElC3yFyMcpHO
	B5eIH8Mxr68=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A231233516;
	Fri,  5 Aug 2016 17:36:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 22DB733515;
	Fri,  5 Aug 2016 17:36:36 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, mst@redhat.com, Jens.Lehmann@web.de
Subject: Re: [PATCH 6/6] clone: reference flag is used for submodules as well
References: <20160804195159.7788-1-sbeller@google.com>
	<20160804195159.7788-7-sbeller@google.com>
Date:	Fri, 05 Aug 2016 14:36:34 -0700
In-Reply-To: <20160804195159.7788-7-sbeller@google.com> (Stefan Beller's
	message of "Thu, 4 Aug 2016 12:51:59 -0700")
Message-ID: <xmqqshuivqxp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF85F358-5B54-11E6-BB23-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When giving a --reference while also giving --recurse, the alternates
> for the submodules are assumed to be in the superproject as well.
>
> In case they are not, we error out when cloning the submodule.
> However the update command succeeds as usual (with no alternates).

I covered most of what I want to say on this in my reply to 0/6; I
do not have strong objection against what single layout you chose to
support, nor I have strong opinion on which single layout we should
support by default, or what mechanism, if any, we should give users
to specify different layout.

But please make sure the choice you made is explained for the users.
The end-user documentation should talk about the effect of giving
these two options together.

Thanks.
