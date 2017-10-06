Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D9601FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 02:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbdJFCji (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 22:39:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54707 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751418AbdJFCjh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 22:39:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1FEB4A7E40;
        Thu,  5 Oct 2017 22:39:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sxhyoVt2Gc5DjbtEDtRQ4btjqMI=; b=gHSLin
        8VC6iiAZYXbF7m1CSll7aPVbSasSvmNmFrpiRcEXmmK+dB9/vkCD7VqQc1g9X8rv
        BSuGsVWl9sjJoJpjTApD4BTceW4Qmqh3NhYnjtOFJNjuy3Xv3B/JqmfEA/sBcLEy
        nGlFWjoyF7PuAeCf+yYhrDbJFTosTXgJsm8Oo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wYa99GWUdrH34yffVAMacrgnCYnAPS2T
        rFnbkyczQ5Ft9WIY7SydKJuiiGF2ol/36pw2upRFlDP6CDpMQWsZurIXYsULJc8h
        Kr3bcuGD0BWoe29ytcr329v1aO5dMLgQqP/kIaFXVyNjDD99ttrDGSjr2/z3ryrZ
        XYMrkXOX+is=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 18AC4A7E3F;
        Thu,  5 Oct 2017 22:39:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8EFB6A7E3E;
        Thu,  5 Oct 2017 22:39:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Vandiver <alexmv@dropbox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] Reporting index properties
References: <alpine.DEB.2.10.1710051625430.812@alexmv-linux>
        <xmqqzi955cnx.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.10.1710051745060.812@alexmv-linux>
Date:   Fri, 06 Oct 2017 11:39:35 +0900
In-Reply-To: <alpine.DEB.2.10.1710051745060.812@alexmv-linux> (Alex Vandiver's
        message of "Thu, 5 Oct 2017 17:47:36 -0700 (PDT)")
Message-ID: <xmqqzi95xamw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97E304C6-AA3F-11E7-8455-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Vandiver <alexmv@dropbox.com> writes:

> On Fri, 6 Oct 2017, Junio C Hamano wrote:
>> > Do folks have feelings about surfacing this information, and where such
>> > logic should live?
>> 
>> Probably one of the t/helper/test-dump-*.c programs, if we already
>> do not have one.
>
> The goal would be to be able to extract this information from
> repositories, with a standard git install.  That directory only
> contains developer tools, which aren't part of the install, no?

Yes, and I am saying that such logic should not live in standard
install outside developer tools ;-)
