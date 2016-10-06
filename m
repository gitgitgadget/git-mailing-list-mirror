Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E9E01F4F8
	for <e@80x24.org>; Thu,  6 Oct 2016 05:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932871AbcJFFtJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 01:49:09 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36162 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbcJFFtI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 01:49:08 -0400
Received: by mail-io0-f193.google.com with SMTP id z135so321412ioe.3
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 22:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5GdMSeOLnKV79kNtC4MLqWfh4AlUIrTUQmF7nKSF+nw=;
        b=zqT4WzROtLKTM6i3rwetcgc57plGFiGiaZ0dRrUrTmnYUpKNc9+Bt5TSw3zzBVuGIp
         wDGkqOyjREc5g1jRRdsOCUiS+YMB8xrBB+mLZHMrG3+YCzYjV+VG5T/uNsh9owZI9w2Y
         1ULDBxVZjYfGDnrors+XIsu57AYsmK6yQWyParbpsw/eFPkzN3DyW3EEEvpCdK3rXBZ2
         1B4X69g483qXPND4md3Q2PAoEGO8KSoJ2Zk02I/yHIV0EUgPiE+kwrjYxUDO27SzYi+t
         pASdyftsTIosvssjSpPLUl2stizMAy0siLUqnqlZwR/S3Ae8ipMg7EmZhzAKbRrIaXVZ
         1T5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5GdMSeOLnKV79kNtC4MLqWfh4AlUIrTUQmF7nKSF+nw=;
        b=EZK6QEKso2kn83zelI9ZJxcm9bRYgMvwxc1W10lniHJUD5eTXO8tPOS+jYzZtz5qkU
         VrPDm+yP90BGsdLxVXsKysMb1Yylq7SLjMjKU1/Kgili3OqM4F4gaFIvRtBrL6A/WNcc
         dcw1PEzJG3QtAxySzvxnzy+PGbvtgf6ycGq8pfEIrR3poGOsjJqTo1kx5lgjxOI2KluO
         HJWiV/zJIZzij8n1hfHjFlJmg0TCBlhbdWrNIA6WpbYg8RkYKf+fcpcEksgP5sRMqUco
         oTLEUjCNJ5L4ADGSk80uOBlwpPNlU9O9OoCMrBk9ZZr/M+/XkleM3UzEpo+76i+OHWE2
         3TBg==
X-Gm-Message-State: AA6/9RnUNlaMHxvVUogGLWdE/eeGyd/Wwb25toAAFgEYGwYZrXhLJ8xExHFne8Fq1kmibMSTJv8/6pO3twymbA==
X-Received: by 10.107.44.17 with SMTP id s17mr13158441ios.212.1475732947648;
 Wed, 05 Oct 2016 22:49:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.230.206 with HTTP; Wed, 5 Oct 2016 22:48:37 -0700 (PDT)
In-Reply-To: <CA+P7+xr4tYG6xoq4jTSxWyoQBwJSfZp7z=2BstTgaBSsgrs5+A@mail.gmail.com>
References: <20160906214550.Horde.ducOghtmsQb9pQ6lixxddVz@webmail.informatik.kit.edu>
 <20160907151251.30978-1-szeder@ira.uka.de> <20160907151251.30978-6-szeder@ira.uka.de>
 <20160907174841.Horde.Ru1LBEeLKomznlWVG-ZnS-Q@webmail.informatik.kit.edu>
 <20161005033353.Horde.33pf2naqnF4HgwPWSy9DaHV@webmail.informatik.kit.edu>
 <xmqq4m4qrapv.fsf@gitster.mtv.corp.google.com> <20161005232609.Horde.VetzEIKHDJUdcaOod9sHxuK@webmail.informatik.kit.edu>
 <xmqqwphmmoi6.fsf@gitster.mtv.corp.google.com> <CA+P7+xr4tYG6xoq4jTSxWyoQBwJSfZp7z=2BstTgaBSsgrs5+A@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 6 Oct 2016 12:48:37 +0700
Message-ID: <CACsJy8BpYQJjiJ80-9kM7LD35brahctq=yYYg+9j_BxF3YQNEg@mail.gmail.com>
Subject: Re: [PATCH 5/5] versioncmp: cope with common leading parts in versionsort.prereleaseSuffix
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
        Jeff King <peff@peff.net>,
        Leho Kraav <leho@conversionready.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 6, 2016 at 7:40 AM, Jacob Keller <jacob.keller@gmail.com> wrote=
:
> On Wed, Oct 5, 2016 at 3:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>>
>>> Gut feeling tells me that I should take this as a subtle
>>> encouragement to look into adding 'versionsort.postreleasesuffix',
>>> shouldn't I ;)
>>
>> It is more like "this made me realize that these are merely 'suffix'
>> after the real release name, no pre- or post- about them", also
>> known as "I think PREreleasesuffix was a mistake and we weren't
>> thinking clearly enough when we added it."
>>
>> To me, this looks like a list of possible suffixes that can include
>> an empty suffix to denote "the real thing", e.g.
>>
>>     versionsort.suffix =3D "-alpha" "-beta" "" "-gamma" "-delta"
>>
>> and that position in the list determines the order of things inside
>> the same family of versions that share the same "non-suffix" part.
>
> This is what makes sense to me. Perhaps migrade to "releasesuffix" and
> deprecate "prereleasesuffix"?

Even though this is mostly used with tag listing, it can be used with
branch listing and general refs as well, where "release" does not
really make sense. So I prefer the name versionsort.suffix to
versionsort.releasesuffix.

> I don't think that's too painful
> especially if git accepts the old value and warns about it's
> deprecation? That or we can just stick with calling it pre-release and
> they sort based on order with '' being the empty value?

Yeah deprecation is good, we don't want to support to config keys with
different algorithms forever.
--=20
Duy
