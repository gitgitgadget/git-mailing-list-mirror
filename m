Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2601D1F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 17:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758501AbcJQRFl (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 13:05:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55088 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758472AbcJQRFf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 13:05:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FF0146428;
        Mon, 17 Oct 2016 13:05:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YH61828RAcTr
        UdWzTzaLSFzx9Tw=; b=kbZZX8hFLKAso3clecw1BMawg+NFSldScU9svU3f/qqz
        JseIJPBwFDEZuvPqGaGjWEnfIlsW2RUBH1JxXtMqzMgFnEo5jmzLrYbSeWHngzrQ
        q/fDd44NflvNK+8qS+nReXz5HyANq3hmlPIlUfQxhrOqLSJRpCOcrnYM5x6UAyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YMFUMH
        w9hoU0M0w8lCxtGZAJr3OGfWxLJbpWOTVuzbZdE0RehMF/Crn4ZWn4SaYqFX/PtI
        cCt+5H5JXYK27C8mrWX8ILnZ2dHAdPa1E3LCRvlVdnZ+I3iPb/xhTZdHuy/TTx34
        SWyGHsgZ+ACbwEvK0PVVq5lQf1p3QxS9/A7lU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7146F46427;
        Mon, 17 Oct 2016 13:05:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB1E746426;
        Mon, 17 Oct 2016 13:05:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        peff@peff.net
Subject: Re: [PATCH v10 13/14] convert: add filter.<driver>.process option
References: <20161008112530.15506-1-larsxschneider@gmail.com>
        <20161008112530.15506-14-larsxschneider@gmail.com>
        <xmqqint0dlis.fsf@gitster.mtv.corp.google.com>
        <02E73D87-B036-40CA-AF54-F93415A028BC@gmail.com>
        <20161011100946.GA13745@tb-raspi>
Date:   Mon, 17 Oct 2016 10:05:31 -0700
In-Reply-To: <20161011100946.GA13745@tb-raspi> ("Torsten =?utf-8?Q?B=C3=B6?=
 =?utf-8?Q?gershausen=22's?=
        message of "Tue, 11 Oct 2016 10:09:46 +0000")
Message-ID: <xmqqy41mx5wk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EAA0E8EC-948B-11E6-90A3-987C12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> +test_cmp_count () {
>> +	expect=3D$1 actual=3D$2
>
> That could be=20
> expect=3D"$1"
> actual=3D"$2"

Yes, but it does not have to ;-).
