From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 3/4] dir: introduce file_size() to check the size of file
Date: Wed, 8 Jun 2016 18:38:00 +0530
Message-ID: <CAFZEwPMiyHqFa0+Z1EAfwG4APcCjJ+1qBeSHjyuOhc6QMb3hLA@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160607205454.22576-3-pranit.bauva@gmail.com> <CAPig+cTgnp3tm_S7ybDBiGfesw9mh3J4_OtEV7timnsgL0AGjA@mail.gmail.com>
 <CAFZEwPPWMdOahMP4f0=Lm_n+ZmEtGHg=zHaZAyQjSf9oL8X2ew@mail.gmail.com> <5757D49A.304@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 08 15:08:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAdDS-000632-Pi
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 15:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161717AbcFHNIE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2016 09:08:04 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:32986 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161643AbcFHNIC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2016 09:08:02 -0400
Received: by mail-yw0-f177.google.com with SMTP id g20so6635837ywb.0
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 06:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lXruZDD/yTxh0RQcTJIPPvoyzsqPboXxwYdgyfEk/tw=;
        b=YuyJ9hoTfMQrxS1J9k1jR9rXecO9Py701Wn44P9Owq6XwULMsQbjXw0ptO9dfsJHyh
         32mSZgHXL8q1P5WEsolZcamUaDOTkMBg7jN1HHTRU5KliQWfe/0asmHF+pdXBoqjgfTU
         yFhhjz2NZSCtlYU/5gkS1Dc+7r/1PDpJi39aNEmgAjmJoEfjwpgpcd/aoHa4CnoTMiD8
         Ep2M7zhByZyvqd9WCxvGWNVY46zlX6Q+jbCK1MVLYD1vg/6b8Xn0uVTEQAfhUbtGXr85
         GKeep79l3d87XL0qMKoW30YOedrWMao3RA5qptSKl1V00YcVP16SGl2XE2uAy7br7dUy
         lNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lXruZDD/yTxh0RQcTJIPPvoyzsqPboXxwYdgyfEk/tw=;
        b=CktgJyaXxORb/G6NJnDIG71T2h98Kzkpzhir3iJ7QhlnzE55KzuzvqljUgdUSgyDmK
         hMxrRVEQ5Eh+r3nf7wI0jh7x2U9tiVltmfCIwbKSiJDfnJpzlGqVY1XmbMBD+ax5r+1P
         2yY1avouUx88MJGJh/JFx+URkfb7Sp1K45Ud1ckaS5/vNDkmZMcSb8yiBRYWtVY4PGv8
         jHYm6ZSyg0yRsd4As4Tha8RWN2pzN3H5uRbqHPTgOUvX6JD68gS9ABXPCnzVoEJE+NM8
         91E+Svp+k148wnALQXzwJNE5o1qfW6S2Wv42JapDoXAqwgRXSmaDkkjT9zi7wfWqXFoc
         p81A==
X-Gm-Message-State: ALyK8tJQIKsAwbJ+oIHGU7dFnmYM7lHGy1a2FmLUfkouxcQHyp/fbMd0eiCoc7sZcTzY2Eo8iM44FqKwaBQClQ==
X-Received: by 10.129.90.135 with SMTP id o129mr2838715ywb.20.1465391281147;
 Wed, 08 Jun 2016 06:08:01 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Wed, 8 Jun 2016 06:08:00 -0700 (PDT)
In-Reply-To: <5757D49A.304@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296794>

Hey Torsten,

On Wed, Jun 8, 2016 at 1:47 PM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> On 06/08/2016 09:57 AM, Pranit Bauva wrote:
>>
>> Hey Eric,
>>
>> On Wed, Jun 8, 2016 at 1:07 PM, Eric Sunshine <sunshine@sunshineco.c=
om>
>> wrote:
>>>
>>> On Tue, Jun 7, 2016 at 4:54 PM, Pranit Bauva <pranit.bauva@gmail.co=
m>
>>> wrote:
>>>>
>>>> dir: introduce file_size() to check the size of file
>>>>
>>>> At times we require to see if the file is empty and get the size o=
f the
>>>> file. By using stat we can get the file size without actually havi=
ng to
>>>> open the file to check for its contents.
>>>
>>> The sole caller of this function in patch 4/4 does so only to check=
 if
>>> the file exists; it doesn't even care about the file's size, thus
>>> neither this function nor this patch seem justified and probably ou=
ght
>>> to be dropped unless some better and stronger justification can be
>>> shown.
>>
>> Umm, actually there is a subtle difference between file_exists() and
>> file_size(). file_exists() *only* checks whether the file exists or
>> not while file_size() can also be used to check whether the file is
>> empty or not also see the implementation of both of them which shows
>> the difference. In fact it doesn't care at all about the file size.
>> Now there are a lot of instances in shell scripts where there are
>> quite some differences with -f and -s and some places *do care* abou=
t
>> this subtle difference. For eg. in bisect_reset() we test whether th=
e
>> file .git/BISECT_START has some contents in it. But I guess I can ad=
d
>> some more justification in the commit message. What do you think?
>>
>>>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>>>> ---
>>>> diff --git a/dir.c b/dir.c
>>>> @@ -2036,6 +2036,14 @@ int file_exists(const char *f)
>>>> +ssize_t file_size(const char *filename)
>>>> +{
>>>> +       struct stat st;
>>>> +       if (stat(filename, &st) < 0)
>>>> +               return -1;
>>>> +       return xsize_t(st.st_size);
>>>> +}
>>>> +
>>>> diff --git a/dir.h b/dir.h
>>>> @@ -248,6 +248,13 @@ extern void clear_exclude_list(struct exclude=
_list
>>>> *el);
>>>> +/*
>>>> + * Return the size of the file `filename`. It returns -1 if error
>>>> + * occurred, 0 if file is empty and a positive number denoting th=
e size
>>>> + * of the file.
>>>> + */
>>>> +extern ssize_t file_size(const char *);
>>
>>
> So what I understand, you want something like this:
>
> +ssize_t file_size_not_zero(const char *filename)
> +{
> +       struct stat st;
> +       if (stat(filename, &st) < 0)
> +               return -1;
> +       return !!st.st_size);
> +}

=46or the purpose of bisect_reset(), Yes. BTW a similar function exist
in builtin/am.c with the name is_empty_file(). But as Christian points
out file_size() could help to refactor other parts of code.

Regards,
Pranit Bauva
