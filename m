Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A52D11F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 04:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbeKNOec (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 09:34:32 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54254 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeKNOeb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 09:34:31 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FF1729410;
        Tue, 13 Nov 2018 23:33:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cg20/j7d+nZ1
        IVjCfNVI23m3wJk=; b=MD2Wa+zolabnaLYo+7JhuuzuN0spkjWDAsQ1OjUUEJ1F
        DTO6EtfLGUYRGBkWaMYv/vwI5GVkacoFCPwbBExLs3iDLTWI0kml2hqbNFWWPdLF
        UzYE7/+OWpPNE4PxdVNXgcyFeDfO78sEl0Lqoa448pgWeiVFvnM5vrCwR5ePFUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=CHHXhs
        WaUu6GjMNIkUU4MfMapohs3oFjClAfjiDyb2JFIvUiGx7NMJDDQ5m8Zry80x6uL5
        3wW9fiNPyCwp2xW1H0QCMqw25sDAIAjuFbr1wSdCMXnqNnZ09670emt20qOeC70o
        BzBu/56GnkagHrt4FBR2PmOs9iKd93rdOFUSc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 593F72940F;
        Tue, 13 Nov 2018 23:33:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6ADEF2940A;
        Tue, 13 Nov 2018 23:32:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Matthieu Moy <git@matthieu-moy.fr>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] push: change needlessly ambiguous example in error
References: <20181113203909.30740-1-avarab@gmail.com>
        <1615698920.2718456.1542145071499.JavaMail.zimbra@matthieu-moy.fr>
        <87wopg1w2z.fsf@evledraar.gmail.com>
Date:   Wed, 14 Nov 2018 13:32:57 +0900
In-Reply-To: <87wopg1w2z.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 13 Nov 2018 22:55:32 +0100")
Message-ID: <xmqqva50p9c6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5D968A34-E7C6-11E8-B5DB-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> This "git push origin HEAD" is IMHO less common. It may confuse users.
>> Or users may learn it and be happy thanks to your message. I don't kno=
w.
>
> I was hoping for the latter. I'm slightly embarrassed to say that for
> the entire time I've been using git I've been doing:
>
>     # on branch 'topic'
>     git push origin topic:topic
>
> Where 'topic' is a tracking branch of 'origin/master' (I use
> push.default=3Dupstream). I only recently discovered that I could push =
to
> 'HEAD" to do the same thing. So one ulterior motive is to make that mor=
e
> prominent.

Personally I do not think you should feel embarrassed at all.  I
didn't know it myself, and I do not recall designing such a
behaviour, so I would not be surprised if it is merely what the code
right now happens to do.  FWIW, I would have expected that a "git
push origin HEAD" when HEAD is a symref to a branch 'x' would behave
as if "git push origin x" were given, going through the usual
simple/upstream/matching etc. dance.

Do we consider the current behaviour useful?  Is it documented
already and widely known?  If the answers are yes/no, of course we
should document it, but if they are no/no, it may not be a bad idea
to deprecate it and replace it with a saner version (i.e. deref HEAD
to branch name and behave the same way as pushing that branch) over
time.


