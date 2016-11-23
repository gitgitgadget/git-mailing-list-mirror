Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EDAE1FF30
	for <e@80x24.org>; Wed, 23 Nov 2016 17:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935296AbcKWRek (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 12:34:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54037 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934936AbcKWRej (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 12:34:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FD184E0B2;
        Wed, 23 Nov 2016 12:34:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0k7LrzUezUmU3P9veVvax87z5AE=; b=dlVvlH
        Y9OBlLg2Bmvmv7CXIYj1s7tnGxvcyqRk2Pp39DnNVSL0Y0DOI9pNp5tEOR1bcMT+
        jo779ky/0lBUQOUChENoZ+wJxK7IKBZuYBLzy1OkRggWdowu2CZTP2b7uT2GnV8m
        LzBNnfQiMandUJUSJ9GmnUgJnvuCnXEUT5UbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O7ihPSndrk67w8feQhIlTeKhXNwv2iH8
        p3SZiXKHTJfCwsK/YCBsaZjRpsq1ivyLuk+AVIYaMbjsubwxF3BUX3CQJCcDJTfA
        gtcrJAOlHV9FO8y3Ux1XdTbLbFmiABnb16aNdcGw+DDvctJSPLRzAEgLP34IstK6
        uUQoFxKVsGY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 023A64E0B1;
        Wed, 23 Nov 2016 12:34:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7A9144E0AF;
        Wed, 23 Nov 2016 12:34:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1 15/19] config: add git_config_get_date_string() from gc.c
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
        <20161023092648.12086-16-chriscool@tuxfamily.org>
        <xmqqziljngod.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD0iToVxU+maNL9BFXacp3sER+AfrqAnQXWf7EAwURKmdQ@mail.gmail.com>
Date:   Wed, 23 Nov 2016 09:34:35 -0800
In-Reply-To: <CAP8UFD0iToVxU+maNL9BFXacp3sER+AfrqAnQXWf7EAwURKmdQ@mail.gmail.com>
        (Christian Couder's message of "Wed, 23 Nov 2016 16:04:57 +0100")
Message-ID: <xmqqlgwam76c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B2EC2E8-B1A3-11E6-8486-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Ok it will appear like this in cache.h:
>
> /* This dies if the configured or default date is in the future */
> extern int git_config_get_expire_date_string(const char *key, const
> char **output);

Those who imitate existing callsites never read comments, and you
need to spend effort to get the name right to protect the codebase
from them.

"get-expiry" may be shorter.  Neither still does not say it will
die, though.

