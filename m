From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] convert: legitimately disable clean/smudge filter with an empty override
Date: Wed, 27 Jan 2016 10:49:30 +0100
Message-ID: <897531AD-96CE-458B-8F9D-9C7937732132@gmail.com>
References: <1453638170-52041-1-git-send-email-larsxschneider@gmail.com> <56A4E86B.1010909@web.de> <CAPig+cSo5vHXgBSzWQ6HtL=4XCigw6VdoAifmov7mhLiRMSkHQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 10:50:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOMk3-0002Ys-FJ
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 10:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbcA0JuK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2016 04:50:10 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37970 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbcA0Jte convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2016 04:49:34 -0500
Received: by mail-wm0-f50.google.com with SMTP id p63so17494872wmp.1
        for <git@vger.kernel.org>; Wed, 27 Jan 2016 01:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=A/xjftabQ5FOLvAwAiEmkNsxM6FnqXVmQb/dBdzilL4=;
        b=ZDlqSI2K52c6N9OzJD8hnwib95j26VhXaqB+ndL37dDrJEeil37KSNaOsi1sedpg/C
         AOILj8G1ZqR3H0rKc1SJtXf3HcOrOGCogaOfcz+G5qpBAq96DfYwTZE+llfFNEb8pLre
         AEpEibwVs3NqISy2IHO+7WJEX5VLdC//XrORe6RC8FiGk1PfVSxzZ+0T4kLBUUmgE5tp
         0TH7g770eVw7Ys2T29N+gvXxwbhDvn/Z/qVpWOSO6a7JiOPKF4E3Y3bI3BT3nfXpBvS/
         fSIZqF9szZnqLpmmLz8atjJJ7R1b17HPuskULJJJvC3h1ud45URB2MamjK28Xuankfwx
         p94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=A/xjftabQ5FOLvAwAiEmkNsxM6FnqXVmQb/dBdzilL4=;
        b=fnXkPzolxRIML2isCkAjGz3JxQY9+x2zUKK/lvT4xZKLjaC5fyfsE5kJVmPT8D6Hzh
         F2sst2S1TkQk8jsXfdX7Act7Me0oiaPSYNJ8EzYW2OD2n0C9mTdZ9089qpvN01P6atdI
         jsUDBjIneLGqdVcEBxeR07+qF8mMK+in1x/8t/BXTQldFkKyGi/eMbzENvlqOBUZ4qtD
         QVxXXn34/Q42o4HcvO9BdkNGm/8cbJ1qCpLVDD2PXV4g9g+jcKyyfxZZ/KXMRLTQDLgm
         e36xuabypGRZy9pLuzSy3mepVXSM6zfllJMuMmKEv+DiIivabwEiOp84EEmEt17e8dwm
         YGNw==
X-Gm-Message-State: AG10YOSd4pkSVUMnETtGtb85PlByNSfjlV1fx6P+hmK9AXxm6j+AbsUf7biybNKt0OfIIQ==
X-Received: by 10.28.0.79 with SMTP id 76mr31340998wma.27.1453888173213;
        Wed, 27 Jan 2016 01:49:33 -0800 (PST)
Received: from slxbook3.fritz.box (p508BA675.dip0.t-ipconnect.de. [80.139.166.117])
        by smtp.gmail.com with ESMTPSA id z137sm6780386wmc.8.2016.01.27.01.49.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jan 2016 01:49:32 -0800 (PST)
In-Reply-To: <CAPig+cSo5vHXgBSzWQ6HtL=4XCigw6VdoAifmov7mhLiRMSkHQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284903>


On 24 Jan 2016, at 22:35, Eric Sunshine <sunshine@sunshineco.com> wrote=
:

> On Sun, Jan 24, 2016 at 10:06 AM, Torsten B=F6gershausen <tboegi@web.=
de> wrote:
>> On 24.01.16 13:22, larsxschneider@gmail.com wrote:
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>> diff --git a/convert.c b/convert.c
>>> @@ -786,7 +786,7 @@ int convert_to_git(const char *path, const char=
 *src, size_t len,
>>>      struct conv_attrs ca;
>>>=20
>>>      convert_attrs(&ca, path);
>>> -     if (ca.drv) {
>>> +     if (ca.drv && ca.drv->clean && strlen(ca.drv->clean)) {
>=20
> More idiomatic:
>=20
>    if (ca.drv && ca.drv->clean && *ca.drv->clean) {
Agreed! Although I will go with Jeff's suggestion to implement that
logic in apply_filter.


>=20
>>>              filter =3D ca.drv->clean;
>>>              required =3D ca.drv->required;
>>>      }
>>> @@ -835,7 +835,7 @@ static int convert_to_working_tree_internal(con=
st char *path, const char *src,
>>>      struct conv_attrs ca;
>>>=20
>>>      convert_attrs(&ca, path);
>>> -     if (ca.drv) {
>>> +     if (ca.drv && ca.drv->smudge && strlen(ca.drv->smudge)) {
>=20
> Ditto.
>=20
>>>              filter =3D ca.drv->smudge;
>>>              required =3D ca.drv->required;
>>>      }
>>> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
>>> @@ -252,4 +252,18 @@ test_expect_success "filter: smudge empty file=
" '
>>> +test_expect_success 'disable filter with empty override' '
>>> +     git config filter.disable.smudge false &&
>>> +     git config filter.disable.clean false &&
>=20
> test_config perhaps?

I was wondering about that, too. Especially because I could also use te=
st_config_global.
Why does no test in t0021 use these functions? Should that be fixed?


>=20
>>> +     echo "*.disable filter=3Ddisable" >.gitattributes &&
>>> +
>>> +     echo test >test.disable &&
>>> +     git -c filter.disable.clean=3D add test.disable 2>err &&
>>> +     ! test -s err &&
>> How about
>> test_cmp /dev/null err
>> to make debugging easier ?
>=20
> Even better:
>=20
>    test_must_be_empty err &&

True! I will use that.

Thanks,
Lars
