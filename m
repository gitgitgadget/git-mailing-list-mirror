From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] Modified flag field type in rev_list_info struct in
 bisect.h. There is no need for flag field to be signed, as it is not supposed
 to be used as decimal.
Date: Thu, 24 Mar 2016 18:56:43 -0400
Message-ID: <CAPig+cQcviTXYAGBTATgYXoaPtvxxeOUtCGYkLyW5oTFvLjEUA@mail.gmail.com>
References: <1458848469-12663-1-git-send-email-motroniii@gmail.com>
	<1458848469-12663-2-git-send-email-motroniii@gmail.com>
	<CAGZ79kZmzo+f9YF1K1oC2GfOrzdaojmrca7bUm3cBRoDreeA-g@mail.gmail.com>
	<56F44788.2050509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>
To: work <motroniii@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 23:56:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajEBO-0001af-6i
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 23:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbcCXW4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 18:56:46 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35225 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbcCXW4o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 18:56:44 -0400
Received: by mail-vk0-f67.google.com with SMTP id e185so6520070vkb.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 15:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Y7zyF7YGyOedJ6V+ixiBtjQqggrZ+FsI4EtMwR+K5S0=;
        b=Id22WHJ/qpSDOY+jiZJ9k7m7/BkFgOPF2oFgyGJBLI+kf3jL/pW/2PaBMVWE2IVpy0
         FMSYG3l8TtwGvFKlO0ay/VmD118Zz/uKusOfcm7MccuY0qh/n97cei9QP+X7eXdWrlRD
         NaapnpB6GMiKCtqeu6jZeiV6M5a5CaUcJgJKMQd/6n8gNqgXtSrUKprwsR8dNUJamHdl
         XjaKdogNwXxUhA8T5s1lP5lZXl8VHKlMp/Y1hJeHfgzM0x3noz+3YyK6YHEj84NRKxzS
         A3KK1KuF3JGC1aYwfQ3DeSHrKU8UICfoNyssdakDsdw0nm/OF6aJfgneZteErLoq1E6Y
         940g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Y7zyF7YGyOedJ6V+ixiBtjQqggrZ+FsI4EtMwR+K5S0=;
        b=Uu85ODJ7QMSg9GwK2POyjb+GedQpGreBWemmFxQnVtWsTo5n3dAd7/0+pQ2Mt112nN
         SxyimlH5EmHDOIIvTqjhBDurnac+diSfxYUQep+BfpI05GOwD+L72/zrbhrwx1qyNZyi
         GEk/v2dtCGC+d92KpsDyDZmwMZnhkgT23DJWgd0aQBI2shNLLA96XiqJoeFJ03aLio6W
         SSAs9sc1wWtYtBxHzrlYD9gZWqKpLIHHXrfHF5vVVQxUWNEsXGhC2iue/cGiXSZ8MsxS
         DdgXSgTgApXuosbXTupgKpuJLm2A9nHCM1Iq+p39Olk5UU+2S8waeLPQVzdSZ2K26c3q
         zigQ==
X-Gm-Message-State: AD7BkJIhpwDWMbN3LI9QyoskVsjvRltdFBM9V8DVHh734EhWf9nXUDB0/4rA7/E5Zq6ysPIMHZpXH9/Mi3gCtw==
X-Received: by 10.159.37.101 with SMTP id 92mr5898221uaz.66.1458860203691;
 Thu, 24 Mar 2016 15:56:43 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 24 Mar 2016 15:56:43 -0700 (PDT)
In-Reply-To: <56F44788.2050509@gmail.com>
X-Google-Sender-Auth: 6VQV_3LBtLvcIjJlc-AiV3755A8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289819>

On Thu, Mar 24, 2016 at 4:01 PM, work <motroniii@gmail.com> wrote:
> On 03/24/2016 10:51 PM, Stefan Beller wrote:
>> On Thu, Mar 24, 2016 at 12:41 PM, Motroni Igor <motroniii@gmail.com>
>> wrote:
>>> From: Pontifik <motroniii@gmail.com>
>>
>> Here is a good place to put reasoning for why this is a good idea.
>> I see you have a long subject, so maybe we can shorten the first line
>> (down to less than ~ 80 characters) and put the longer explanation
>> here.
>>
>> How about:
>>
>>    bisect: use unsigned for flag field
>>
>>    The flags are usually used as a unsigned variable, because it makes
>>    bit operations easier to follow.
>
> Yep, it's definitely a good idea to shorten subject in order to put more
> explanations in body of a message.

It is also very important is to explain that you audited all clients
of this field and found that none of them treat the sign bit specially
(for instance, by checking the value with '< 0' or some such),
therefore such a change is safe, in addition to making the code
clearer.

As an example, a diligent reviewer may wonder why you changed this
field to 'unsigned' but not the 'flags' variable in
rev-list.c:show_bisect_vars() to which this field is assigned. This is
something your re-roll of the patch should take into consideration.

>>> diff --git a/bisect.h b/bisect.h
>>> index acd12ef..a979a7f 100644
>>> --- a/bisect.h
>>> +++ b/bisect.h
>>> @@ -16,7 +16,7 @@ extern struct commit_list *filter_skipped(struct
>>> commit_list *list,
>>>
>>>   struct rev_list_info {
>>>          struct rev_info *revs;
>>> -       int flags;
>>> +       unsigned int flags;
>>
>> You can also drop the int here and make it just
>> unsigned.
>
> In fact, I just wanted to keep this code clear to understand (as I see
> this). Unsigned short is also unsigned, but a reader should know that
> "unsigned" type stands for "unsigned int". Anyway, I'll keep this in mind in
> future, thanks a lot.

While it's true that 'unsigned short' is indeed never negative, the
clueful reader should never accidentally interpret bare 'unsigned' as
anything other than the native word size. However, I think what Stefan
really meant is that, in this code base, it is (somewhat) more common
to declare these "flags" variables as 'unsigned' rather than 'unsigned
int':

    % git grep -E 'unsigned\s+flags' | wc -l
    80
    % git grep -E 'unsigned\s+int\s+flags' | wc -l
    57
