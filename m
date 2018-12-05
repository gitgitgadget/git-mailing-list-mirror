Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EA70211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 19:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeLETmH (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 14:42:07 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:39022 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeLETmG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 14:42:06 -0500
Received: by mail-wr1-f48.google.com with SMTP id t27so20930877wra.6
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 11:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GWEqvsAJ252UBD+6+V46CuayjtvMZF6TuFOf6kOiwEc=;
        b=h7fTF2l3gWeDfcDnJYfK46CfD7OL7poke3foFACDL628Q3sw/HxM6N6cKymzAxo8w5
         sm16bllODIvGko2iZBaRwPbVkI7Rvl2ANNBkqF1Ho3VDBOIwOo1E+h0sga0RETNr3ZCk
         526NPfhRncai3UwwB460/GNdW2tsVVey6iD6/ixjy29sf5RkuwN9eaQOUhAlIG2jt3ht
         QV85fmyryNmXWEIqjAAgjf2A+/8sl7gxqSPpvcE6IXZDyc7GuDOmOyPfY8VSp4I9MG58
         SoipsaHq2q4mm8d6or3bzyVRCWUtIQyttIqp3HeqgSF1Cgbuqu61K7NdNP9vqrD79bmv
         EDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GWEqvsAJ252UBD+6+V46CuayjtvMZF6TuFOf6kOiwEc=;
        b=szMrTZ81OFiGaQLODNo03+aVDkSQ2hnedt3dyL8ElJWzIAy8Riwk4iAPVDQuwapLeH
         Rrhjyn90lJGDEtWwbJRQ7O6IbZoyKdAs5R0TM/drns9+Cuilb+1thopEOvUp2UxC8cfB
         sqSZxBeYluSxwzOHnFurFgBoYqfk13hNm0suaa9OjD7T9lCEizRrugRXdJDBL4dn2ckX
         sm8dydRSdZspFIj0tG4M6HJKP4fAak5chQSzM24SZSEuPke6Co9nOIwf19oX+swbO3QN
         3sIGVin+PPL+qRpWX/S+BeJeDseLYucn/wy0aMDinimeIMbEpqtmQsH32HyLfGYMtpw1
         2v5Q==
X-Gm-Message-State: AA+aEWZeKHWV9sU2kDPx3G/NNphplQqL2/WAXwj6fv5rZRgGpCVmK+Kb
        2dDWeARgbibefQmOiEs=
X-Google-Smtp-Source: AFSGD/UdKf0j+UqkYWpEfRHlxofsGlthxF7zbjqfd8x0tgjBFXM1f6H2WNFeSNdB2oX72iCEn8KmPQ==
X-Received: by 2002:adf:b3c3:: with SMTP id x3mr22949311wrd.294.1544038925063;
        Wed, 05 Dec 2018 11:42:05 -0800 (PST)
Received: from [192.168.25.100] (ip-176-199-47-168.hsi06.unitymediagroup.de. [176.199.47.168])
        by smtp.googlemail.com with ESMTPSA id c13sm45810303wrb.38.2018.12.05.11.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:42:04 -0800 (PST)
Subject: Re: BUG: CR marker ^M doesn't show up in '-' lines of diffs when the
 ending of the removed line is CR+LF
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <1f068f3a-d636-9b9c-f501-51d33412b964@googlemail.com>
 <4dca3f64-4851-6d48-8266-dfe55f597739@kdbg.org>
 <edadf857-2d4b-f058-5e07-286afb312901@googlemail.com>
 <80ffe850-b966-a37b-09bd-44e04d769944@kdbg.org>
 <2858f03b-89a7-be52-501f-55b6d281bebc@googlemail.com>
 <30442f9c-a1cb-4635-d8e3-a301d94a56fd@kdbg.org>
 <xmqqzhtwzghr.fsf@gitster-ct.c.googlers.com>
 <f06b734a-fc8e-221a-c983-f2ab9daba17f@kdbg.org>
 <xmqqva4jv2kc.fsf@gitster-ct.c.googlers.com>
 <3e24a770-47fc-50e4-d757-1e4a28dcd019@kdbg.org>
 <xmqqk1kwr5tp.fsf@gitster-ct.c.googlers.com>
 <7a4ecc75-2dc4-041b-3d12-46cddae0a27f@googlemail.com>
 <xmqqmupnh0lo.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>
Message-ID: <7796f0ac-d3db-68f9-89fa-9262d2187f57@googlemail.com>
Date:   Wed, 5 Dec 2018 20:43:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <xmqqmupnh0lo.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Am 03.12.18 um 02:15 schrieb Junio C Hamano:
> Frank Schäfer <fschaefer.oss@googlemail.com> writes:
>
>> Hi Junio,
>>
>> Am 29.11.18 um 03:11 schrieb Junio C Hamano:
>> [...]
>>> This was misspoken a bit.  Let's revise it to
>>>
>>>  	When producing a colored output (not limited to whitespace
>>>  	error coloring of diff output) for contents that are not
>>>  	marked as eol=crlf (and other historical means), insert
>>>  	<RESET> before a CR that comes immediately before a LF.
>> You mean
>>      ...
>>      <RESET> *after* a CR that comes immediately before a LF."
>>
>> OK, AFAICS this produces the desired output in all cases if eol=lf.
> OK, yeah, I think I meant "after", i.e. ... CR <RESET> LF, in order
> to force CR to be separated from LF.
>
>> Now what about the case eol=crlf ?
> I have no strong opinions, other than that "LF in repository, CRLF
> in working tree" would make the issue go away (when it is solved for
> EOL=LF like the above, that is).
>
>> Keeping the current behavior of '-' lines is correct.
>> But shouldn't ^M now be suppressed in '+' lines for a consistent behavior ?
> If "LF in repository, CRLF in working tree" is done, there would not
> be ^M at the end of the line, not just for removed lines, but also
> for added lines, no?
Just to be sure that I'm not missing anything here:
What's your definition of "LF in repository, CRLF in working tree" in
terms of config parameters ?

Regards,
Frank

