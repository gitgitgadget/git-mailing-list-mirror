From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Mon, 24 Aug 2015 20:52:45 +0530
Message-ID: <CAOLa=ZRbWDBEoSkeGRdL2qS5BCEka=zmJL0JXdE9fvomrmOGcQ@mail.gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
 <vpqzj1hkc5q.fsf@anie.imag.fr> <CAOLa=ZQx_eWdq5cLskAT_c1OjZ-7DwWwZTC9S=ZafEDYHFGncg@mail.gmail.com>
 <vpqvbc490oh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 24 17:23:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTtaj-0001PR-CW
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 17:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832AbbHXPXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 11:23:15 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33258 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738AbbHXPXP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 11:23:15 -0400
Received: by oieu205 with SMTP id u205so11986990oie.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 08:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iMayq7P8myvy1oad+J6pieW3m5a0jvQ3Z9J5fCR2lNE=;
        b=gFD9TtG+loIQk0tQAqxFS9kl9XJtOEJmHi8330gbRFsOnlGwoEkl61SJ4XbKNzy4H6
         QkXCJTdnk2JV08dkiWjN1WnnGk0PBpRQDdIUmEhstoUywaBBC/UlkvmwbibLgkYgY5zf
         2TVOjupIiKplmXz/ekqGG9qY/S4emLJ5qWZPq6EmohP7mEWQ20pJHZ2VIKhLPw4ZfZk9
         ddcDeTAbscmMUZUnnuf+3KsM5KVZh1HE6fKA2EajYpnhrirHUqm0qx8/L3kw0N6XBw71
         xiHRGkVa2kqIIGZ56LKM7JhESeP4DsXO0eupcWb/wOcMms5qzdZLr6m03x6bq6DzAsfy
         j5+g==
X-Received: by 10.202.105.133 with SMTP id e127mr20860860oic.60.1440429794485;
 Mon, 24 Aug 2015 08:23:14 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 24 Aug 2015 08:22:45 -0700 (PDT)
In-Reply-To: <vpqvbc490oh.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276455>

On Mon, Aug 24, 2015 at 8:46 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Mon, Aug 24, 2015 at 1:30 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>>>> index 1997657..06d468e 100644
>>>> --- a/Documentation/git-for-each-ref.txt
>>>> +++ b/Documentation/git-for-each-ref.txt
>>>> @@ -133,7 +133,8 @@ align::
>>>>       `<position>` is either left, right or middle and `<width>` is
>>>>       the total length of the content with alignment. If the
>>>>       contents length is more than the width then no alignment is
>>>> -     performed.
>>>> +     performed. If used with '--quote' everything in between %(align:..)
>>>> +     and %(end) is quoted.
>>>
>>> There's no --quote, there are --shell, --python, ... (well, actually, I
>>> would have prefered to have a single --quote=language option, but that's
>>> not how it is now).
>>
>> That'd be easy to implement, but I didn't because `git tag -l` is
>> human readable and
>> I didn't see the necessity for having something like `--<quote_type>` here.
>
> Agreed: tag does not have --shell, --python & so and does not need it.
>
> But that's not my point: you write "if used with '--quote'", and the
> option name is not --quote. It should be "if used with `--shell`,
> `--python`, ... then everything ...".
>

Oops! misread what you sent, maybe' --<quote_type>' instead.

-- 
Regards,
Karthik Nayak
