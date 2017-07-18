Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C568D20387
	for <e@80x24.org>; Tue, 18 Jul 2017 20:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751569AbdGRUDm (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 16:03:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60872 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751457AbdGRUDl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 16:03:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1312379CF5;
        Tue, 18 Jul 2017 16:03:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zbUMClzxMTge64Bfo6vx4KNVUa0=; b=m249EA
        heGmxBQAHgWFMqyT54y+5uyTED5JjZUi3ZwJyq5aQ8iBFCZ+vG9oQhSgcv8otlsb
        E5z00P+hEqbF9xFgnD3hn3UDoIaNsUd5o9WVyTfIrv8xOMqteINfOCODqJWQcghO
        wvYRc5EsVLtnK/IQnf6JsVOuvO2TQBAgoXjyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GKGCX1EW8UzNSKgxL3i3n0r2uvSg0b0A
        IHDv49r/J05rtX6wiqttqzbiBP+DrHS6Yw83ehLvTIq2vs+XOUrVtbMSstACspXp
        MEd5eOU8okT+jzjCDn/GwKXVWh5piC4ARApOf12eb9K1vlTcIvDs8CdG+dbUM6O2
        HDbHC5RN5RI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B0E079CF3;
        Tue, 18 Jul 2017 16:03:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6EF5979CF2;
        Tue, 18 Jul 2017 16:03:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.14.0-rc0
References: <xmqqzic7sy2g.fsf@gitster.mtv.corp.google.com>
        <87mv8638y5.fsf@gmail.com>
        <xmqq7ez6hk2y.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 18 Jul 2017 13:03:32 -0700
In-Reply-To: <xmqq7ez6hk2y.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 17 Jul 2017 13:41:57 -0700")
Message-ID: <xmqqfudto6ln.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D52579E-6BF4-11E7-BFAA-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> As I shoot for shorter summary, going down to too much detail in
> these entries is not welcome.
>
> However, an exception is the top part of the release notes where we
> discuss backward incompatible changes etc. that helps people to
> decide the deployment strategy.  Encouraging migration from v1 to v2
> belongs there, I would think.

I added this at the end of the "Backward compatibility notes" at the
beginning of the release notes, and renamed the entire section to
"Backward compatibility notes and other notable changes."

 * Git can now be built with PCRE v2 instead of v1 of the PCRE
   library. Replace USE_LIBPCRE=YesPlease with USE_LIBPCRE2=YesPlease
   in existing build scripts to build against the new version.  As the
   upstream PCRE maintainer has abandoned v1 maintenance for all but
   the most critical bug fixes, use of v2 is recommended.

Thanks.
