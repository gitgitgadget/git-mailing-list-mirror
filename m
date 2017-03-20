Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2FEC20958
	for <e@80x24.org>; Mon, 20 Mar 2017 16:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755282AbdCTQIy (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:08:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50851 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755348AbdCTQIv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 12:08:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6EEAC79560;
        Mon, 20 Mar 2017 12:02:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Bv3/ZLnLo2SSTa5XhaYeGvQsyNQ=; b=evONoV
        Nte9JhY0CichgSWtyk/Q7E1wmOGhlwkvPo5kb1M0ZR2o3f1L7FUyg+UjAr1MRKIO
        X+N2qzMkFTlOUcC/l/AXv4hgMHL4CFgqJJqy3O50YL0ctWYj713gIy29Helk3McH
        C4VDFCejZVAQjvzE+PaZn4p0ThNg04u/WguHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WLOKwvHQhrGe4KDZpzAYlWLUZqC10Tfn
        R7azKHeXg73Pg4i9DHhmoeE/CVvDvc+ysbelSQ4MtnBwWe1ECIU/FsnEroKTxTCy
        Zu8ZI/noeIzJ6C/0wzz7+T7vPNlemuLOfKv4StMjHl6qdSaMBCMfGiN0A6TlbkvO
        UenedRV+sBQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6879D7955F;
        Mon, 20 Mar 2017 12:02:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C1A007955E;
        Mon, 20 Mar 2017 12:02:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] diff --no-index: support symlinks and pipes
References: <20170318210038.22638-1-dennis@kaarsemaker.net>
        <xmqqo9wwzzpl.fsf@gitster.mtv.corp.google.com>
        <1490006404.15470.12.camel@kaarsemaker.net>
Date:   Mon, 20 Mar 2017 09:02:04 -0700
In-Reply-To: <1490006404.15470.12.camel@kaarsemaker.net> (Dennis Kaarsemaker's
        message of "Mon, 20 Mar 2017 11:40:04 +0100")
Message-ID: <xmqqa88gx7gj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 906F0F74-0D86-11E7-B4D9-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> On Sun, 2017-03-19 at 15:08 -0700, Junio C Hamano wrote:
> ...
>> > - A --derefence option was added and the default is no longer to dereference
>> >   symlinks.
>> 
>> I do agree that it makes sense to have --[no-]dereference options,
>> but I do not think it was my feedback and suggestion to make it
>> optional (not default) to dereference, so please do not blame me for
>> that choice.
>
> Then I misinterpreted your message at 
> http://public-inbox.org/git/xmqqk29yedkv.fsf@gitster.mtv.corp.google.com/
> No blame inteded, my apologies for coming across as blaming.

s/blame/credit/ then.  I do not too deeply care which one is the
default, and if we were adding --no-index without any existing users
today, I probably would suggest making it deref by default (i.e. to
make "diff --no-index" match better what other peoples' diffs do),
but that would be a behaviour change to existing users if done today,
so I think what you did probably is a good thing.

Thanks.
