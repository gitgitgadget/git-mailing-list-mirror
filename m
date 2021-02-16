Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E687DC433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA66864ECE
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhBPSyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 13:54:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55392 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhBPSyX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 13:54:23 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D66CA631D;
        Tue, 16 Feb 2021 13:53:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yJyytBpkaE5W
        1bSy4x/Bgrz4Xks=; b=G3RD71O2bdEeq+fZvDwkzTQw3pfnCr00jYPNeLVNn1U+
        IYqvo0cjotpMRmSAshc6Oih9S8EfR3QL+dH6AGcTmgYF2S3FLnP86QcNleOxr3OE
        8RTVWxAY7mA8pVBPiqnsdwAyooXZxJWA28Vs550mtV37+4pOLVXzk5dw9DxpTuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=W2y/xz
        cxuc9gzHQ1UJjvkAUISPqc3O0/ml5N+0movUGPA3yj5vYuBO4yUvoS4wZXkvc15c
        RVsfLp0QsDNjwbeDZX/no2e1He8Qz0GC65F+LkzTGEezxJam558+p8hweHWYBzZB
        aQcF7FvOljZyTLfkYgUpZrJlKtDr9626szrSk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02C01A631C;
        Tue, 16 Feb 2021 13:53:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FCC8A631B;
        Tue, 16 Feb 2021 13:53:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jan =?utf-8?B?4oCcS2hhcmRpeOKAnSBTdGFuxJtr?= <khardix@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-send-email: smtpserver in $HOME
References: <CAG+K25Pk0+sOAYuWS2OF7CXLXJLjGMKyBB_SOLpoO5RFiktN5g@mail.gmail.com>
        <xmqqo8gksqr4.fsf@gitster.c.googlers.com>
        <CAG+K25NbifB9k9ugU5ZjLAOKxLyfEZcphfZXNS9_Whi6gZcBLA@mail.gmail.com>
Date:   Tue, 16 Feb 2021 10:53:39 -0800
In-Reply-To: <CAG+K25NbifB9k9ugU5ZjLAOKxLyfEZcphfZXNS9_Whi6gZcBLA@mail.gmail.com>
        ("Jan =?utf-8?Q?=E2=80=9CKhardix=E2=80=9D_Stan=C4=9Bk=22's?= message of
 "Tue, 16 Feb 2021 04:49:20
        -0800")
Message-ID: <xmqq7dn7rgi4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 48DF8A44-7088-11EB-9147-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jan =E2=80=9CKhardix=E2=80=9D Stan=C4=9Bk  <khardix@gmail.com> writes:

> On 2021-02-15, Junio C Hamano wrote:
>> I haven't given too much thought, but offhand do not think of a
>> reason why a change like the attached would break things.
>
> Seems reasonable, but I figured I rather ask beforehand.
>
>>  git-send-email.perl | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git c/git-send-email.perl w/git-send-email.perl
>> index 1f425c0809..ff58ac5046 100755
>> --- c/git-send-email.perl
>> +++ w/git-send-email.perl
>> @@ -1006,6 +1006,8 @@ sub expand_one_alias {
>>  		}
>>  	}
>>  	$smtp_server ||=3D 'localhost'; # could be 127.0.0.1, too... *shrug*
>> +} elsif ($smtp_server =3D~ /^~/) {
>> +	$smtp_server =3D glob($smtp_server);
>>  }
>
> This introduces a special case just for handling $smtp_server=E2=80=A6

Yes, and that was very much deliberate, as I think

	git send-email --smtp-server=3D~/bin/my-phoney-sendmail

won't be affected by %config_path_settings.  $smtp_ssl_cert_path has
the same problem already, and I didn't want to make things worse (I
think %config_path_settings is a mistake---it is fine to have a list
of variables that can use ~tilde expansion, but I do not see why it
makes sense to allow the ~tilde expansion when the value came from
configureation files, and not from the command line).

> My concern was that if there is a SMTP server actually named
> i.e. `~someone.example.org`, this change would break that.

Can tilde appear in a valid DNS name?  I doubt it.
