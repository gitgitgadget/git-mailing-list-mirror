Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 218DA207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 23:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935096AbcI2XYZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 19:24:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54917 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934911AbcI2XYX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 19:24:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D9BB841BFB;
        Thu, 29 Sep 2016 19:24:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fMFjkdiEdbG8Caw1yiOtTPMIO3s=; b=WG4UWV
        BZ/LcBwJ0307OBYObBNlEjd1coaKGZnNUf+7MvrsKTrrra1vzNatC9gY6kjIHXQ2
        CQve1v8w4XK0rSlnMIGQhslPIePs6fdomOulcjBi8V2ngxv2cfKx7U5qiUzurVxX
        aotRgXT79lVg6mb9KbTOZ9QM8/6usmSZBlKic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sNp5D07lsYhUNFEtx3X5HLQ5c7xLSK0x
        L0vwyJzTbvtM3YdgPWgQlaku38i/70xO9ShEahpxeJP092UlMWjn5ODeG2e9IGQv
        ZiqqZI/Tr766UkYWYdbVBYrF8n86pRUomgAx2Ck89ClzGzTlnWqzBR37pA8BU7xr
        h6iy+FoN2Jc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0E2A41BFA;
        Thu, 29 Sep 2016 19:24:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5B2F941BF8;
        Thu, 29 Sep 2016 19:24:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sebastian Feldmann <sf@sebastian-feldmann.info>
Cc:     git@vger.kernel.org
Subject: Re: Impossible to change working directory
References: <A99D7D06-8214-4C09-BCB2-E4FCE75FF317@sebastian-feldmann.info>
Date:   Thu, 29 Sep 2016 16:24:20 -0700
In-Reply-To: <A99D7D06-8214-4C09-BCB2-E4FCE75FF317@sebastian-feldmann.info>
        (Sebastian Feldmann's message of "Thu, 29 Sep 2016 21:30:10 +0200")
Message-ID: <xmqq37kicmsb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA6AAE5C-869B-11E6-B407-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sebastian Feldmann <sf@sebastian-feldmann.info> writes:

> the script fails because changing the current working directory fails.
> If I echo the current working directory it always echoes the root repository path
>
> Is this expected behavior?

Yes, we always go to the top before doing anything.

If you echo environment variables Git may set up for you, what do
you see?  Do you see GIT_PREFIX that you can use to tell where you
came from, or something like that?
