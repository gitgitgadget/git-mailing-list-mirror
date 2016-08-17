Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5128A1FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 17:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbcHQRpI (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 13:45:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57084 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752353AbcHQRpH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 13:45:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B22333F1B;
	Wed, 17 Aug 2016 13:45:06 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T+bLjM+lz/URun7OTweg/ikizCw=; b=yfsr8E
	NbzxIEvzI/aGOd3PhYJJtTPaVuKVUt15DdGfl0DONPNnfgCovRKuH2Z0LJUJ9BTd
	ZbmqFEKSc3d/XmvAQJlvayVm3+SoOgxZ5OrvTYIj8wYAoCKuDeDJ+9m8VIDDxUkc
	hRzhiVRWV0Wbt0AnRtAZ90pJAZ/pQti1Zn6K8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mjMacMba6wEmzvswslszFS4c0w3aNR1z
	1vjRQCeJegwryzBYTCd0G2qAGDFy10/tfbV5t3lIua+kD7A/R5M5uQ2a+AiAwT2H
	P2E2dLBhlw8f0/TVG4nPP6mjjxxJr+6345/jjVfYb6m/YVeL8TEA1agRBlSFBL05
	8S6SUDbC1Z8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 54C9E33F18;
	Wed, 17 Aug 2016 13:45:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB28233F16;
	Wed, 17 Aug 2016 13:45:05 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	David Turner <novalis@novalis.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2016, #06; Sun, 14)
References: <xmqqmvkfj7dz.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BYk1t5cfN_dgc8o3HCi8Rqz9aM_5XFWMUkMTKXu2R7=A@mail.gmail.com>
Date:	Wed, 17 Aug 2016 10:45:03 -0700
In-Reply-To: <CACsJy8BYk1t5cfN_dgc8o3HCi8Rqz9aM_5XFWMUkMTKXu2R7=A@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 17 Aug 2016 17:49:26 +0700")
Message-ID: <xmqqpop79tnk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 553FC80E-64A2-11E6-BFDE-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Aug 15, 2016 at 5:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * dt/index-helper (2016-07-06) 21 commits
>>
>>  A new "index-helper" daemon has been introduced to give newly
>>  spawned Git process a quicker access to the data in the index, and
>>  optionally interface with the watchman daemon to further reduce the
>>  refresh cost.
>>
>>  Not quite ready yet, it seems.
>>  cf. <alpine.DEB.2.20.1607061016330.6426@virtualbox>
>>  cf. <CACsJy8AiER_=5aJ65r+GPCE_nXbrPTAMKJi=FuJgT8zzV2-NFw@mail.gmail.com>
>
> David I can take back this series if you are busy or no longer interested in it.
>
> If so, Junio, since I may try some slightly different direction first,
> it may take a while before I resubmit, feel free to drop it if it adds
> work to you.

OK; thanks, both.
