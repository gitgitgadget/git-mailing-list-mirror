Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C1811F404
	for <e@80x24.org>; Wed,  7 Mar 2018 22:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934190AbeCGWoM (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 17:44:12 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33165 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933743AbeCGWoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 17:44:09 -0500
Received: by mail-wm0-f45.google.com with SMTP id s206so24768042wme.0
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 14:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=40kVx7B2sHKy8cB3Ho4AbBNilJnBPb/zP5DWiEAW8a8=;
        b=EIpDqRPtsGqEFx8PHb55XoeHCiO+ce/Urg4pnWMI53UAN2K6rMGDHZpPqwQdM/LA4C
         5kNw9j2MLR8+SD3/nPu2MhKkcNxLSZ4Cddlbh5KUYHkwfc30jctE2jAH1tSXDKVTHaRo
         CUJO0mKAvU5/Gwjo8wdb8ACvOsBzcL6UCtNbSMGfOfBuVKXLWWgtCYvyOhQezLll80nk
         kvMxPxuhy5rbRc+rdI1MN6ICRYq5YJLWQ1QMyYsCFMUnBA9TfJPBxpUj6HE6oAtgN1NZ
         rVehv5aJwO0gDSpkKiQsyIgnXRP3mgTSIB5f96Q4JEPpXQiyn8RkDZbv9YDuqzF5l8bN
         y00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=40kVx7B2sHKy8cB3Ho4AbBNilJnBPb/zP5DWiEAW8a8=;
        b=oLHWFc4IH1aTsXGKcDsSMhtO3PgU/FcPvB/1oONk1f4iQX/aEHSVseCKO1tzN3phH9
         5f9VQ4PC5EdpVXFJwV9zSwXgcUdsqD29bbBjpc6TU2s9UTPQQZcmENfAdaYipGmQP5xu
         KGiI+r6fEZTCkk/Bnsmnh5gV7olRmuC0Rt5+AOuLcWnngPaIPKA+jHedf33XwkBXMVbq
         r6XJESCDrVYru9VZdYTHVw+/O0vN4sZ9bGZ5rOcbFFV4RqIUSUrv+YLUhHteo+S2g0Kh
         Fgk61G+m+hu4szFulaYWeYvGfto8NvpY8QP5Lb6SID+xLT2LO94ZxvVrDnwu0zVKIF25
         /GcA==
X-Gm-Message-State: AElRT7Fo5aiwiq+aQ9+N8Hr2z7BBhfAcct55rBiINV8xaQ1REuwa3ocR
        5nU9N0sIdOEU6b0lRGvObVmh4vG/
X-Google-Smtp-Source: AG47ELsLAQY37qmDgdKMIT3K0DnGFg+/ipxVW1/+pauLonBfx0jut/ehYQu7JBygpKJpQj/GPE7miQ==
X-Received: by 10.28.40.214 with SMTP id o205mr14489519wmo.22.1520462648190;
        Wed, 07 Mar 2018 14:44:08 -0800 (PST)
Received: from [10.6.133.146] (135.red-80-28-119.staticip.rima-tde.net. [80.28.119.135])
        by smtp.gmail.com with ESMTPSA id 62sm18859739wrf.24.2018.03.07.14.44.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Mar 2018 14:44:07 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v10 9/9] convert: add round trip check based on 'core.checkRoundtripEncoding'
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqmuzjzmfi.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 7 Mar 2018 23:44:06 +0100
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <40C38F6A-E536-4C7E-981F-B15746C103B5@gmail.com>
References: <20180307173026.30058-1-lars.schneider@autodesk.com> <20180307173026.30058-10-lars.schneider@autodesk.com> <xmqqmuzjzmfi.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Mar 2018, at 20:59, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> lars.schneider@autodesk.com writes:
>=20
>> +static int check_roundtrip(const char* enc_name)
>=20
> The asterisk sticks to the variable, not type.

Argh. I need to put this check into Travis CI ;-)


>> +{
>> +	/*
>> +	 * check_roundtrip_encoding contains a string of space and/or
>> +	 * comma separated encodings (eg. "UTF-16, ASCII, CP1125").
>> +	 * Search for the given encoding in that string.
>> +	 */
>> +	const char *found =3D strcasestr(check_roundtrip_encoding, =
enc_name);
>> +	const char *next;
>> +	int len;
>> +	if (!found)
>> +		return 0;
>> +	next =3D found + strlen(enc_name);
>> +	len =3D strlen(check_roundtrip_encoding);
>> +	return (found && (
>> +			/*
>> +			 * check that the found encoding is at the
>> +			 * beginning of check_roundtrip_encoding or
>> +			 * that it is prefixed with a space or comma
>> +			 */
>> +			found =3D=3D check_roundtrip_encoding || (
>> +				found > check_roundtrip_encoding &&
>> +				(*(found-1) =3D=3D ' ' || *(found-1) =3D=3D=
 ',')
>> +			)
>=20
> The second line is unneeded, as we know a non-NULL found either
> points at check_roundtrip_encoding or somewhere to the right, and
> the first test already checked the "points exactly at" case.

Eric objected that too [1], but noted the documentation value:

    Although the 'found > check_roundtrip_encoding' expression is
    effectively dead code in this case, it does document that the
    programmer didn't just blindly use '*(found-1)' without taking
    boundary conditions into consideration.

    (It's dead code because, at this point, we know that strcasestr()
    didn't return NULL and we know that 'found' doesn't equal
    'check_roundtrip_encoding', therefore it _must_ be greater than
    'check_roundtrip_encoding'.)

[1] =
https://public-inbox.org/git/CAPig+cR81J3fTOtrgAumAs=3DRC5hqYFfSmeb-ru-Yf_=
ahFuBiew@mail.gmail.com/

Although the line is unnecessary, I felt it is safer/easier to=20
understand and maintain. Since both of you tripped over it, I will
remove it though.


> This is defined to be a comma separated list, so it is unnecessary
> to accept <cre,en> =3D=3D <"FOO, SHIFT-JIS, BAR", "SHIFT-JIS">; if you
> allow SP, perhaps "isspace(found[-1]) || found[-1] =3D=3D ','" to also
> allow HT may also be appropriate.

I don't think HT makes too much sense. However, isspace() is nice
and I will use it. Being more permissive on the inputs should hurt.


>  I think "comma or whitespace
> separated list" is fine; in any case, the comment near the beginning
> of this function does not match new text in Documentation/config.txt
> added by this patch.

Nice catch. Will fix.


Thanks,
Lars

