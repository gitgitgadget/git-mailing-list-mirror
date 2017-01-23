Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 898BD20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750957AbdAWUQu (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:16:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63218 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750705AbdAWUQt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:16:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26B6B63854;
        Mon, 23 Jan 2017 15:16:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Djd9HCS2EpFdN699M30JQ9nS6AY=; b=McoAbq
        llqCcB40g2oiw6Ag/+l/V9qOEE/L/bCKuFzpkf6pebmQHG9YyD7WyaEMsUkZUIiO
        wUMVj0KI4QDMVnvVrxl/OAnIT7wZyFyfos5txt+W0LlkMGHlqSwYnyqbTsgjtZsn
        L07ooTUu0BeGTa0UAKNulI4Ii6bZZGNgJDx/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UJqfnJxz0wBgf3cnOxJ7VTxDWqNyd2Mk
        oegvr/B2+rEbTjDH0wCt0XXMk1iCZ+Dcvz2a94RX/JCFPmeKgB94BOj+j9om7+Fq
        pDmRLmzjr4XI+/jygbY9IrRfBkCa9ty+F/WYKc13Tn3t6iuS/MmtoZhGhIcLx5UA
        xKKBotMX4VA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1EE3063853;
        Mon, 23 Jan 2017 15:16:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7DF3663852;
        Mon, 23 Jan 2017 15:16:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] rebase: pass --signoff option to git am
References: <20170121104904.15132-1-giuseppe.bilotta@gmail.com>
        <xmqqh94ptzke.fsf@gitster.mtv.corp.google.com>
        <CAOxFTcyuLkvgPOxQuzaDUVuDRu_KJg=JrYtU84pQyjLstChbLg@mail.gmail.com>
Date:   Mon, 23 Jan 2017 12:16:46 -0800
In-Reply-To: <CAOxFTcyuLkvgPOxQuzaDUVuDRu_KJg=JrYtU84pQyjLstChbLg@mail.gmail.com>
        (Giuseppe Bilotta's message of "Mon, 23 Jan 2017 21:03:33 +0100")
Message-ID: <xmqqbmuxr0pd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DDEB4286-E1A8-11E6-86E6-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> On Mon, Jan 23, 2017 at 7:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Should we plan to extend this to the interactive backend that is
>> shared between rebase -i and rebase -m, too?  Or is this patch
>> already sufficient to cover them?
>
> AFAIK this is sufficient for both, in the sense that I've used it with
> git rebase -i and it works.

That is a good news and at the same time a bit awkard one ;-)  

The mention of "passed to 'git am'" twice in the documentation and
help text would lead people to think "rebase -i" would not be
affected and (1) would need more work to do so, or (2) the user does
not want "rebase -i" to be unaffected for whatever reason, and gets
surprised to see that it actually does get affected.

In any case, will queue as-is so that we won't lose the patch while
waiting for people to raise their opinions.

Thanks.
