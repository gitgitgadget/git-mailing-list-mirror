Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B8BC433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 00:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiBOAQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 19:16:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiBOAQD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 19:16:03 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9D010AEE9
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 16:15:55 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D36D120940;
        Mon, 14 Feb 2022 19:15:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BGp6kGbvAvxZ
        NRrEiX3N3hNnlZXUldbbi32r85D7nqM=; b=HjuhrwYN1+9H7FHTY7M5+x0+sMTj
        1lOjjkTLnFHcDbxW++2OpwQEvv+hRfSZ6fKCsjc/jeC14Gvw8IgpA79R2RGKcDh+
        Gvl+RthOCPT10ebnddty40Mar8cpoFSFKUC6iot2zYjiObk4CB3hIOOWmZSAqh/4
        2bofKQHv+NJrpHA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30DAB12093F;
        Mon, 14 Feb 2022 19:15:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7F5A312093E;
        Mon, 14 Feb 2022 19:15:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Improvements to tests and docs for
 .gitattributes eol
References: <20220111021507.531736-1-sandals@crustytoothpaste.net>
        <20220214020827.1508706-1-sandals@crustytoothpaste.net>
        <xmqqilth2u28.fsf@gitster.g>
        <20220214204631.mquj645jt5qajwku@tb-raspi4>
Date:   Mon, 14 Feb 2022 16:15:52 -0800
In-Reply-To: <20220214204631.mquj645jt5qajwku@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Mon, 14 Feb 2022 21:46:32
 +0100")
Message-ID: <xmqq8rud0ytj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 703065E8-8DF4-11EC-A24E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> ---- >8 -----
>> From: brian m. carlson <sandals@crustytoothpaste.net>
>> Subject: doc: clarify interaction between 'eol' and text=3Dauto
>>
>> The `eol` takes effect on text files only when the index has the
>> contents in LF line endings.  Paths with contents in CRLF line
>> endings in the index may become dirty unless text=3Dauto.
>
> That is a nice, precise and short summary here in the commit message
> as well as the patch further down.

Thanks.  Then let's queue it for 'next' and merge it down.

>>
>> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  Documentation/gitattributes.txt | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git c/Documentation/gitattributes.txt w/Documentation/gitattrib=
utes.txt
>> index 60984a4682..a71dad2674 100644
>> --- c/Documentation/gitattributes.txt
>> +++ w/Documentation/gitattributes.txt
>> @@ -161,11 +161,12 @@ unspecified.
>>
>>  This attribute sets a specific line-ending style to be used in the
>>  working directory.  This attribute has effect only if the `text`
>> -attribute is set or unspecified, or if it is set to `auto` and the fi=
le
>> -is detected as text.  Note that setting this attribute on paths which
>> -are in the index with CRLF line endings may make the paths to be
>> -considered dirty. Adding the path to the index again will normalize t=
he
>> -line endings in the index.
>> +attribute is set or unspecified, or if it is set to `auto`, the file =
is
>> +detected as text, and it is stored with LF endings in the index.  Not=
e
>> +that setting this attribute on paths which are in the index with CRLF
>> +line endings may make the paths to be considered dirty unless
>> +`text=3Dauto` is set. Adding the path to the index again will normali=
ze
>> +the line endings in the index.
>>
>>  Set to string value "crlf"::
>>
