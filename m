Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 014E8207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 18:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162640AbcIZSGj (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 14:06:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60154 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1034290AbcIZSGh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 14:06:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C4094168E;
        Mon, 26 Sep 2016 14:06:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ki9Rh7dB3T4VA636COGhiuzPDvk=; b=VHLiwd
        I0Mzw+mavVkls9I2ZTgVPbeoXF9TpQ/5qKXSsSToN2pbsJDVcAD07JKyMLP0U6E3
        Agutpc2pYN3/aBoWzCoO1MkUoMAjEPfCjIKymA8wtlkieoFQtNqwnPoyDKDx1aXX
        v3pjL166YF6Ew+Duntm3e0ZLTPagJ8voDY+8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jy+tNP/EypJX5/lnMhvN96NjG3NUXHRy
        7YuVqk4eYYZcM7ETuH6V/ygnjdzK1Ynccq02h9SID6PGFv/LzDuclx+Qs6YxBPbb
        mJpRft+ZFB5YGdf0weBie3ICNNP7yBj5QpvgTVVlEgHdj9l3kMHb2Ci3fDa85Zxf
        FgyxgBRwymo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54FD84168D;
        Mon, 26 Sep 2016 14:06:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CF97C4168C;
        Mon, 26 Sep 2016 14:06:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Gustavo Grieco <gustavo.grieco@imag.fr>
Cc:     git@vger.kernel.org
Subject: Re: Stack read out-of-bounds in parse_sha1_header_extended using git 2.10.0
References: <1825523389.8224664.1474812766424.JavaMail.zimbra@imag.fr>
        <xmqqbmzbwmfc.fsf@gitster.mtv.corp.google.com>
        <790613313.8353074.1474912139102.JavaMail.zimbra@imag.fr>
        <xmqq37kmtukf.fsf@gitster.mtv.corp.google.com>
        <48506427.8357405.1474912907126.JavaMail.zimbra@imag.fr>
Date:   Mon, 26 Sep 2016 11:06:33 -0700
In-Reply-To: <48506427.8357405.1474912907126.JavaMail.zimbra@imag.fr> (Gustavo
        Grieco's message of "Mon, 26 Sep 2016 20:01:47 +0200 (CEST)")
Message-ID: <xmqqy42esfh2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6A52B68-8413-11E6-B67B-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gustavo Grieco <gustavo.grieco@imag.fr> writes:

> Fair enough. We are testing our tool to try to find
> bugs/vulnerabilities in several git implementations. I will report
> here my results if i can find some other memory issue in this git
> client.

Thanks.  With or without security implications, it is basic codebase
hygiene to identify and correct these issues, and your help is
highly appreciated.
