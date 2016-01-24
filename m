From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] convert: legitimately disable clean/smudge filter with an
 empty override
Date: Sun, 24 Jan 2016 16:35:13 -0500
Message-ID: <CAPig+cSo5vHXgBSzWQ6HtL=4XCigw6VdoAifmov7mhLiRMSkHQ@mail.gmail.com>
References: <1453638170-52041-1-git-send-email-larsxschneider@gmail.com>
	<56A4E86B.1010909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	jehan@orb.com
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 24 22:35:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNSJb-000183-4i
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 22:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbcAXVfP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jan 2016 16:35:15 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33786 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbcAXVfO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jan 2016 16:35:14 -0500
Received: by mail-vk0-f52.google.com with SMTP id e64so65549659vkg.0
        for <git@vger.kernel.org>; Sun, 24 Jan 2016 13:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=piC5ACxhqTLXk2CQYLzfjU1kd+Cst6prnoS8ZkVyMjo=;
        b=ro5kMzH0mKUljjF1ik2kYNPuprDPVCzfwqoHzE4wjmt8HNgVLFYEcXderpbDyKWlvw
         MaVgSo1Ob/YWVV5tBE7REkNRuQJEMpU9FYpXzPZ4hkPTKRE8MmxbbzKyogAdV5Lr7Asj
         sBjNGuoqDKAhuWz5cjRZbeE9/gdC8IGAo6h0LIAirqtJEKIYxoI0QAVCatJtUzMPNb9S
         Ri/N2oNartjhaAzk7QXY/nl6EP96FZYpkPP6GeEZAD8R+qb0oOPb4sxy+WIbLUUS0+Fg
         aLZR8+Z8MJwH1dQNDmTNBRzmIadrDyJ8KLIdjpVE7/espcro0RkXXY5GmzXAYEQy01i/
         gOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=piC5ACxhqTLXk2CQYLzfjU1kd+Cst6prnoS8ZkVyMjo=;
        b=WTw/g0yBopNo873QYt3hbygNJt213qZS816l6smv4Gxb7EegC/T8aolk+tTDfmgP2v
         Q5qUWR+7EnYpDIlR/sI8z1AxG//3qs2YfQveiO6qHdccRpmTigVqzBXN5P3sip3yVEI0
         yU1x1eJJfiDJt1+HIu/Kt1tVbRmKNY/3bTc0b5Y+Vz7P2AsZUw4L4KErzLn9Fsp1e1jP
         y9pwM6G0NV4rv92zvx3eamY0m06xDUmKPBnLZ52WDFkk+sYFHq2ujPgTYLxjP4wB4T1R
         8s2SIOgWtkNgZRwI4bKWZ9p11vU45MBW+yxibbFZC1WwYUH/NLYKr7RjuMM4iMqeK+lf
         Xr5Q==
X-Gm-Message-State: AG10YORFkXDApUHLB5a4KmfdgU1gHwyj0gYl5BCsa2ja0/TSOnMp1fNIRJ54tlnZ17G9Oy3Dq1oMJmUe//J9iw==
X-Received: by 10.31.41.20 with SMTP id p20mr2434341vkp.151.1453671313070;
 Sun, 24 Jan 2016 13:35:13 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 24 Jan 2016 13:35:13 -0800 (PST)
In-Reply-To: <56A4E86B.1010909@web.de>
X-Google-Sender-Auth: zXbgDGx91Ke_Oa7UXtNp-9SypeI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284694>

On Sun, Jan 24, 2016 at 10:06 AM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> On 24.01.16 13:22, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> diff --git a/convert.c b/convert.c
>> @@ -786,7 +786,7 @@ int convert_to_git(const char *path, const char =
*src, size_t len,
>>       struct conv_attrs ca;
>>
>>       convert_attrs(&ca, path);
>> -     if (ca.drv) {
>> +     if (ca.drv && ca.drv->clean && strlen(ca.drv->clean)) {

More idiomatic:

    if (ca.drv && ca.drv->clean && *ca.drv->clean) {

>>               filter =3D ca.drv->clean;
>>               required =3D ca.drv->required;
>>       }
>> @@ -835,7 +835,7 @@ static int convert_to_working_tree_internal(cons=
t char *path, const char *src,
>>       struct conv_attrs ca;
>>
>>       convert_attrs(&ca, path);
>> -     if (ca.drv) {
>> +     if (ca.drv && ca.drv->smudge && strlen(ca.drv->smudge)) {

Ditto.

>>               filter =3D ca.drv->smudge;
>>               required =3D ca.drv->required;
>>       }
>> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
>> @@ -252,4 +252,18 @@ test_expect_success "filter: smudge empty file"=
 '
>> +test_expect_success 'disable filter with empty override' '
>> +     git config filter.disable.smudge false &&
>> +     git config filter.disable.clean false &&

test_config perhaps?

>> +     echo "*.disable filter=3Ddisable" >.gitattributes &&
>> +
>> +     echo test >test.disable &&
>> +     git -c filter.disable.clean=3D add test.disable 2>err &&
>> +     ! test -s err &&
> How about
> test_cmp /dev/null err
> to make debugging easier ?

Even better:

    test_must_be_empty err &&

>> +     rm -f test.disable &&
>> +     git -c filter.disable.smudge=3D checkout -- test.disable 2>err=
 &&
>> +     ! test -s err
>> +'
