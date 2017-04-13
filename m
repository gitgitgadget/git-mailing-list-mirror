Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F9D120970
	for <e@80x24.org>; Thu, 13 Apr 2017 06:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751054AbdDMGbp (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 02:31:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64671 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750745AbdDMGbo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 02:31:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F70F81BA0;
        Thu, 13 Apr 2017 02:31:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JBW/3NXtkG4R
        gE0vKofMhq2pGNw=; b=KKhRxI2ARKIE4GnrwOqzRCOoJCofTFMiFfhml79tVoAv
        XVzldNFBDI2vrJThci3zfpnOHX2NtrxvtJsAtNkTWac5kHI5CVhf7UCmZPnScGv0
        w9zNSmUjaM5J7MV9mDYO81fEZa02ZXlZ+/XxO1h3U8u7+d+JNUmfzeRq/7uXGBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Sn3mEh
        wIVQOvuYGJeDP1vqwQsmcgMyXWiFOGyYaYkp+/DxXetPjbtKZzxFrUlBGljBkCt9
        AAx/uij1K2vxYuK4ndKHZH4OW+reaLVPUvuNcbTCU2p1wJeR4QHQKUmrgxJNZGdt
        YsI0CkyhSw9SGFHbbQUkxjEms8w5rJV+YBhgo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4737A81B9E;
        Thu, 13 Apr 2017 02:31:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F3AC81B9D;
        Thu, 13 Apr 2017 02:31:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Tom G. Christensen" <tgc@jupiterrise.com>,
        Git Mailing List <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5/7] Add support for gnupg < 1.4
References: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
        <20170405130424.13803-1-tgc@jupiterrise.com>
        <20170405130424.13803-6-tgc@jupiterrise.com>
        <CACBZZX6bYLRSUAy2GUYhBVet3tjzrBQ40L49KxetAvBdgx_x+w@mail.gmail.com>
Date:   Wed, 12 Apr 2017 23:31:41 -0700
In-Reply-To: <CACBZZX6bYLRSUAy2GUYhBVet3tjzrBQ40L49KxetAvBdgx_x+w@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 5 Apr
 2017 15:45:54
        +0200")
Message-ID: <xmqq7f2oq0mq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DBC487A8-2012-11E7-AE6B-C260AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Apr 5, 2017 at 3:04 PM, Tom G. Christensen <tgc@jupiterrise.com=
> wrote:
>> This adds an OLD_GNUPG define to the Makefile which when activated wil=
l
>> ensure git does not use the --keyid-format argument when calling the
>> 'gpg' program.
>> This is consistent with how 'gpg' was used in git < 2.10.0 and slightl=
y
>> decreases security.
>
> This changes the code Linus Torvalds added in b624a3e67f to mitigate
> the evil32 project generating keys which looked the same for 32 bit
> signatures.
>
> I think this change makes sense, but the Makefile should have a
> slightly scarier warning, something like:
>
> "Define OLD_GNUPG if you need support for gnupg <1.4. Note that this
> will cause git to only show the first 32 bits of PGP keys instead of
> 64, and there's a wide variety of brute-forced 32 bit keys in the wild
> thanks to the evil32 project (https://evil32.com). Enabling this will
> make GPG work old versions, but you might be fooled into accepting
> malicious keys as a result".

Very good point.  It surprised me somewhat to see that this is the
only change necessary (iow, there is no need to tweak anything in t/
directory).  Perhaps we would need a test or two (and need to figure
out a way to make them work with both old and more recent GnuPG)?
