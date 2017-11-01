Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD8D520450
	for <e@80x24.org>; Wed,  1 Nov 2017 06:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750749AbdKAGXb (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 02:23:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64844 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751517AbdKAGXa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 02:23:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D41394230;
        Wed,  1 Nov 2017 02:23:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wE48hs56kdFPJKImQoNVb6bQnMM=; b=lWKwqk
        c/q+0qTjmoTkvOmWzze0xYjmK5S+ntKUNq81KdbGAGeEkuYeg3AZ/7DBGe6gc+jK
        rdgN5673yI8+JP95Tubcwal5FKYYBZtTV+6/amaly9M6ZuQFL2JtNep+Bw2D6fxl
        7CVuovF+G7gx6EZgChSe4l4baz7A9i+f81+zI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bXVPPlsk/stBenxAKW5la2kd/SKLfnZy
        yAfjm+8UIf/iF0BKPk+9wS5v/2jxr2pHEFh1h8e8IcoRiygPvc4O8imwpQOExNoo
        bgVGgc/fOt3rvVrPgrPvaDZUpExMQPKBWWsfQweH0ZJQJKa3pEE4uCzr8iwGpSHw
        FizmMqjXd4U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6469F9422E;
        Wed,  1 Nov 2017 02:23:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8741B9422D;
        Wed,  1 Nov 2017 02:23:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 0/8] convert diff flags to be stored in a struct
References: <20171030194646.27473-1-bmwill@google.com>
        <20171031181911.42687-1-bmwill@google.com>
Date:   Wed, 01 Nov 2017 15:23:28 +0900
In-Reply-To: <20171031181911.42687-1-bmwill@google.com> (Brandon Williams's
        message of "Tue, 31 Oct 2017 11:19:03 -0700")
Message-ID: <xmqqfu9ytt3z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D4D3756-BECD-11E7-994A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Changes in v3:
>  * Now always pass struct diff_flags by reference and don't return the struct
>    but rather modify the passed in struct.
>  * Don't clear TEXTCONV_SET_VIA_CMDLINE when --no-textconv is passed
>  * added additional patches (set out separately before) to remove the macros
>    and change the struct members to lowercase

The result looks pleasant overall, although I suspect I'd need some
time to get used to them being all explicit bitfields.

Queued.
