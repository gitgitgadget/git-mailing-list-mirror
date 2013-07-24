From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH v2 00/16] First class shallow clone
Date: Wed, 24 Jul 2013 18:50:49 +0200
Message-ID: <b66fdf09-5e84-4ecc-899d-cebc644f74b7@email.android.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com> <1374314290-5976-1-git-send-email-pclouds@gmail.com> <79A9AB6FF00042D1B3E0D26B9855CCAB@PhilipOakley> <CACsJy8AJjXMATEPrAgSYOgpZcR_khC=9S28H8LuCvuTuJk0x8w@mail.gmail.com> <8BDFF5EEBDC8422681F1AB2C0A153CC6@PhilipOakley> <CACsJy8AzFogspTih4mJoog6MGEWgmuae2KmFysQ0-siCvfH2yA@mail.gmail.com> <CAA01CsrHaCGrt37r4bn1OBY-=skJXZBHOaPH=Gsz-8BCmiW6jQ@mail.gmail.com> <CACsJy8BouRHZAmCKQ779iAUiEX-rK9_FSrxu9V-bn6MCBTBEzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 18:51:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V22HQ-0004Ki-JL
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 18:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805Ab3GXQvH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Jul 2013 12:51:07 -0400
Received: from mail-bk0-f45.google.com ([209.85.214.45]:47856 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762Ab3GXQvG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 12:51:06 -0400
Received: by mail-bk0-f45.google.com with SMTP id je9so271028bkc.4
        for <git@vger.kernel.org>; Wed, 24 Jul 2013 09:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=b8ATzRueXCq0XsWhvs2vvv0VHACruWrY0MksiVkkoMs=;
        b=x6G9KtSiJQnLT5czQzdhwub639BvLmCxuR0tILSOQq5hb4/iDWdjzm/JFrRgbtmvd3
         9LOCzSct0WBifPapli+Q+JIKfkHdSj0XFz4j1d9fKhAVfrNSSd3YRHPgFfIO4R4C1xSZ
         gyuXmkOxnAvOjikbww1UOyqFoyNsZIWmgR8dwk0f+Z+u4n5Zaj6pVNqlc8hmxYbjzciM
         rQU9gOv7tXxLwDmDb8pQHWIRLSE2X/pZv2c90RZJKhBUwOE0Lvh35eZ0Ga8p2o5bleMN
         VgKduHOKDBB2t9DckKzns2q8u+TJAJpMs64rvQMGQ8D+ASAqutVp7q1U3EQ6roEE/HPi
         yfYA==
X-Received: by 10.204.61.193 with SMTP id u1mr5481625bkh.119.1374684663864;
        Wed, 24 Jul 2013 09:51:03 -0700 (PDT)
Received: from [100.104.126.139] ([46.77.124.240])
        by mx.google.com with ESMTPSA id ct12sm9943230bkb.12.2013.07.24.09.51.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 24 Jul 2013 09:51:03 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <CACsJy8BouRHZAmCKQ779iAUiEX-rK9_FSrxu9V-bn6MCBTBEzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231106>

Duy Nguyen <pclouds@gmail.com> napisa=C5=82:
>On Wed, Jul 24, 2013 at 3:30 PM, Piotr Krukowiecki
><piotr.krukowiecki@gmail.com> wrote:
>> (resending, as my phone mail client decided to send it in html, sorr=
y
>> about that)
>>
>> On Wed, Jul 24, 2013 at 3:57 AM, Duy Nguyen <pclouds@gmail.com>
>wrote:
>>> On Wed, Jul 24, 2013 at 5:33 AM, Philip Oakley
><philipoakley@iee.org> wrote:
>>>> There have been comments on the git-user list about the
>>>> problem of accidental adding of large files which then make the
>repo's foot
>>>> print pretty large as one use case [Git is consuming very much
>RAM]. The
>>>> bigFileThreshold being one way of spotting such files as separate
>objects,
>>>> and 'trimming' them.
>>>
>>> I think rewriting history to remove those accidents is better than
>>> working around it (the same for accidentally committing password).
>We
>>> might be able to spot problems early, maybe warn user at commit tim=
e
>>> that they have added an exceptionally large blob, maybe before push
>>> time..
>>
>> I can imagine a situation where large files were part of the project
>> at some point in history (they were required to build/use it) and
>> later were removed because build/project has changed.
>>
>> It would be useful to have the history for log/blame/etc even if you
>> could not build/use old versions. A warning when checking
>> out/branching such incomplete tree would be needed.
>
>That's what shallow clone is for. You fetch the latest (not including
>old large blobs) and work on top. For archaeology, make a full clone.
>Or do you mean log/blame/etc other paths that don't touch big blobs,
>and the clone is still incomplete?


Yes, for example if large files were removed recently the last-n-commit=
s-shallow would be useless from blame/log POV.=20
