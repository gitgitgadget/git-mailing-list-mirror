From: Ivan Ukhov <ivan.ukhov@gmail.com>
Subject: Re: [PATCH] parse-options: fix the description of defval
Date: Sun, 29 Mar 2015 20:02:06 +0200
Message-ID: <BE8DB6BF-DB95-4D9B-A01B-3D3BCE4C3C9C@gmail.com>
References: <E8C3474A-5A3A-4A51-A798-84FB9AD46A9F@gmail.com> <CACRoPnTjAu_pyPp2TXZGou=H8mkXBmQqgxGNusjW6u8peEfw6Q@mail.gmail.com> <xmqqsicnya81.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2093\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 20:02:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcHXL-0000Hf-Jd
	for gcvg-git-2@plane.gmane.org; Sun, 29 Mar 2015 20:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbbC2SCL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Mar 2015 14:02:11 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:34488 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbbC2SCJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Mar 2015 14:02:09 -0400
Received: by lagg8 with SMTP id g8so102526577lag.1
        for <git@vger.kernel.org>; Sun, 29 Mar 2015 11:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9g7Py2Q8PR5INjkObjY2VwGflvqmWL0qCo2RdfY3JWY=;
        b=iFqbfqAG+SQAN4j7q1WCJHb0qmP5xbsYyNwZiUv2wZ2E/lWTwZ5pKSa2xxK0m1VowX
         yY/7/MKdAPtCnUE9sRQIOn4n7TxSvE9zxvw0+8E3sdPgEVsacNEEpVfOw/umTofxjnTJ
         NL4Jg3CuCkioroQnlbVyVPATmw7C1vo3AyCzto+r3RSc0pi8R6Ys/TceKwW2eb6FXn9g
         Gf458zl9r5oM2HpKuh4vGbk15hP3fkdQrsNpmNNUg9MiJP0i8bIT+9zw1yY1N8p+eNYv
         Rj2beAYmfqwD9+TcfiEuT7lhSbYKK46DiwRvpKTJ4iQ19Ih6HNhghPYqnwrkb1hGgq0x
         3rqQ==
X-Received: by 10.152.27.202 with SMTP id v10mr25646760lag.90.1427652128111;
        Sun, 29 Mar 2015 11:02:08 -0700 (PDT)
Received: from c-15c6e455.011-537-6c6b701.cust.bredbandsbolaget.se (c-15c6e455.011-537-6c6b701.cust.bredbandsbolaget.se. [85.228.198.21])
        by mx.google.com with ESMTPSA id ps2sm1597940lbb.20.2015.03.29.11.02.06
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 29 Mar 2015 11:02:07 -0700 (PDT)
In-Reply-To: <xmqqsicnya81.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.2093)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266443>

Hello Junio,


Yes, actually my intention to fix that comment was solely based on its =
content. I saw that the elements in the first set, {BIT,SET_INT}, did n=
ot match the elements in the second, {mask,integer,pointer}. Then I fou=
nd that commit removing OPT_SET_PTR, and =E2=80=9Cpointer=E2=80=9D seem=
ed to be a leftover, which I decided to eliminate. My commit message wa=
s saying something different, I should admit)

I totally agree with your about mentioning only the general principle a=
nd leaving details to particular macros.


Regards,
Ivan

> On Mar 29, 2015, at 7:39 PM, Junio C Hamano <gitster@pobox.com> wrote=
:
>=20
> Paul Tan <pyokagan@gmail.com> writes:
>=20
>> On Sun, Mar 29, 2015 at 4:32 PM, Ivan Ukhov <ivan.ukhov@gmail.com> w=
rote:
>>> Since the deletion of OPT_SET_PTR, defval can no longer contain a p=
ointer.
>>>=20
>>=20
>> Actually, it can contain a pointer for OPTION_CMDMODE, OPTION_STRING
>> and OPTION_FILENAME. Since we are on the topic of updating the
>> documentation, I think it would be great if the documentation
>> mentioned these option types as well.
>=20
> Actually, both of you are correct ;-)
>=20
> The patch text you are responding to is not saying anything wrong.
> The only thing Ivan stated incorrectly is the log message.
>=20
>    parse-options.h: OPTION_{BIT,SET_INT} do not store pointer to defv=
al
>=20
>    When 20d1c652 (parse-options: remove unused OPT_SET_PTR,
>    2014-03-30) removed OPT_SET_PTR, the comment in the header that
>    describes what the option did to defval field was left behind by
>    mistake.  Remove it.
>=20
> or something, perhaps?
>=20
> It is a different issue if we want to describe uses of `defval` by
> all other macros like OPTION_STRING.  We should make it easier for
> our contributors (me included) to find how each option macros can be
> used, and how OPTION_XYZ uses defval must be described somewhere,
> but I personally think bloating the description of `defval` is not a
> good way to do so.  Description of OPTION_XYZ may be the first place
> for programmers to go to find how it should be used, so perhaps it
> is a better idea to enrich descriptions there instead of here.
>=20
> In other words, it may be an improvement to say only the general
> principle shared across all uses e.g. "default value to fill .value
> with", without mentioning specifics of exceptions (e.g. "for
> OPTION_BIT it is not even a default, it is _the_ value") in this
> section.  Instead, comment OPTION_BIT with "the defval field is used
> to store the bitmask used to set/clear/flip" or something.
>=20
> But as I said, that is a different issue.
>=20
>> diff --git a/parse-options.h b/parse-options.h
>> index 7940bc7..c71e9da 100644
>> --- a/parse-options.h
>> +++ b/parse-options.h
>> @@ -95,8 +95,7 @@ typedef int parse_opt_ll_cb(struct parse_opt_ctx_t=
 *ctx,
>>  *
>>  * `defval`::
>>  *   default value to fill (*->value) with for PARSE_OPT_OPTARG.
>> - *   OPTION_{BIT,SET_INT} store the {mask,integer,pointer} to put i=
n
>> - *   the value when met.
>> + *   OPTION_{BIT,SET_INT} store the {mask,integer} to put in the va=
lue when met.
>>  *   CALLBACKS can use it like they want.
>>  */
