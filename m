Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 596E61F407
	for <e@80x24.org>; Tue, 12 Dec 2017 10:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751665AbdLLK67 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 05:58:59 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33093 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdLLK65 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 05:58:57 -0500
Received: by mail-wm0-f67.google.com with SMTP id g130so16948396wme.0
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 02:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=W+sIvvAPpmm7hYPXdju/J4gCE2rvDbIyjfGmhbSwb0s=;
        b=D8xQoZKCZ69XJhkkSrxklhez9PgT/j9eD8OmVTh0HOemNfzxCPKfTAl5S79RqW9fW1
         sN+NCZ8s++BsvmlESrlAu0rC0a8CTzloDv85BWIyqvhP91ZmyqxLvxlxGHAzqzkhDsKB
         SgUNieEHhlpFyOuORUvGRZjuJqejo01wrOOYsIgc8lqdcl02AV049T4lu16t8tJaBkJ/
         6dwM+JPaFlq8+cj7qBOPlGuxuixH+O1j31nXq6+MquX9IgEMMeweSj5eEiGFh6f7o9uK
         CpCiz8CQ/hL9b2H9d5eWzgsCk65916THTzG1a45ETRaBJiRs/q7w9DQXBdDJ97SYAWCS
         s+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=W+sIvvAPpmm7hYPXdju/J4gCE2rvDbIyjfGmhbSwb0s=;
        b=NKEPE9jzoV3wZk/OcV/r/f1/LDmyljEcwjWJ0cJLEaJ6J772ctOYjP3tjcZPXv1zEJ
         jR6Wtz0/t96pbU4VEZMIGllW4RhnwQFvVDq7cgySqQR96QyZnt2h7Of1INo37gH4ddTw
         Piw/qdSRJB6iFNmnZxYcjr6N1+x/MONZ9YKHLmHmbfpOzKBWsJetGaEgIURsb+T1B8ZJ
         ks2VoKbnzEEgjExJV3XFE8qbcYlC5CUmb73MQOLCawQ4mRnjtWOJ9watR+D3A/wZCV90
         k5lYjssCtJQcRQOa56zl9Q5O5Hfb5mpZ6vTq/wM2T9Ogbcsig/7p7ER5rj1ZF/sbcTDq
         PwKw==
X-Gm-Message-State: AKGB3mJM13RCpVt5Fd7ziFBTBwSRMos2/HhMfocDbcf1jVgh5VB2rfSi
        SCyTmjGZn86FbZ1EQ3usjtQ=
X-Google-Smtp-Source: ACJfBos/9SsjK5TUDTy85xUnTFymnh/Yuq8ADn2RQ6Brr0oQWUYn7stzbhn0yP43i94egP6fu29Chg==
X-Received: by 10.28.130.208 with SMTP id e199mr1324346wmd.75.1513076335933;
        Tue, 12 Dec 2017 02:58:55 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id o2sm10727623wmf.27.2017.12.12.02.58.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Dec 2017 02:58:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAPig+cRtsCeWZZcj-jRLsqwb5OSHLBQFyGCvpAXeHRmcbTtT+w@mail.gmail.com>
Date:   Tue, 12 Dec 2017 11:58:55 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>, patrick@luehne.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <3FB29434-D2DE-4215-AD33-69D6BB7DF30A@gmail.com>
References: <20171211155023.1405-1-lars.schneider@autodesk.com> <CAPig+cQ6VSXXSYJOiZeTqUpwijVhvvUYzXF8U3KCBsOQ91HPZQ@mail.gmail.com> <09713FC5-9D71-4B39-BFA3-0CB9C63321A2@gmail.com> <CAPig+cRtsCeWZZcj-jRLsqwb5OSHLBQFyGCvpAXeHRmcbTtT+w@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 12 Dec 2017, at 00:58, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>=20
> On Mon, Dec 11, 2017 at 6:47 PM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>> On 11 Dec 2017, at 19:39, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>>> On Mon, Dec 11, 2017 at 10:50 AM,  <lars.schneider@autodesk.com> =
wrote:
>>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>>=20
>>>> Git and its tools (e.g. git diff) expect all text files in UTF-8
>>>> encoding. Git will happily accept content in all other encodings, =
too,
>>>> but it might not be able to process the text (e.g. viewing diffs or
>>>> changing line endings).
>>>>=20
>>>> Add an attribute to tell Git what encoding the user has defined for =
a
>>>> given file. If the content is added to the index, then Git converts =
the
>>>> content to a canonical UTF-8 representation. On checkout Git will
>>>> reverse the conversion.
>>>>=20
>>>> Reviewed-by: Patrick L=C3=BChne <patrick@luehne.de>
>>>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>>>> ---
>>>> +static int encode_to_git(const char *path, const char *src, size_t =
src_len,
>>>> +                        struct strbuf *buf, struct encoding *enc)
>>>> +{
>>>> +       if (enc->to_git =3D=3D invalid_conversion) {
>>>> +               enc->to_git =3D iconv_open(default_encoding, =
encoding->name);
>>>> +               if (enc->to_git =3D=3D invalid_conversion)
>>>> +                       warning(_("unsupported encoding %s"), =
encoding->name);
>>>> +       }
>>>> +
>>>> +       if (enc->to_worktree =3D=3D invalid_conversion)
>>>> +               enc->to_worktree =3D iconv_open(encoding->name, =
default_encoding);
>>>=20
>>> Do you need to be calling iconv_close() somewhere on the result of =
the
>>> iconv_open() calls? [Answering myself after reading the rest of the
>>> patch: You're caching these opened 'iconv' descriptors, so you don't
>>> plan on closing them.]
>>=20
>> Should this information go into the commit message to avoid confusing
>> future readers? I think, yes.
>=20
> Maybe. However, the code which does the actual caching is so distant
> from these iconv_open() invocations that it might be more helpful to
> have an in-code comment here saying that the "missing" iconv_close()
> invocations is intentional.

Agreed. I will add that in v2.

Thanks,
Lars

