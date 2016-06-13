From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 3/4] dir: introduce file_size() to check the size of file
Date: Mon, 13 Jun 2016 11:51:44 +0530
Message-ID: <CAFZEwPMXptc33bdvrFXiY9OD4S0aXT0-rKo9W5QKkYmrV-pFag@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160607205454.22576-3-pranit.bauva@gmail.com> <CAPig+cTgnp3tm_S7ybDBiGfesw9mh3J4_OtEV7timnsgL0AGjA@mail.gmail.com>
 <CAFZEwPPWMdOahMP4f0=Lm_n+ZmEtGHg=zHaZAyQjSf9oL8X2ew@mail.gmail.com>
 <5757D49A.304@web.de> <CAFZEwPMiyHqFa0+Z1EAfwG4APcCjJ+1qBeSHjyuOhc6QMb3hLA@mail.gmail.com>
 <3db60187-4b44-85b2-f714-f836e3c3bc6e@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 13 08:21:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCLFv-0007kk-0S
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 08:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933270AbcFMGVr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2016 02:21:47 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:33396 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932165AbcFMGVq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jun 2016 02:21:46 -0400
Received: by mail-yw0-f170.google.com with SMTP id g20so117726921ywb.0
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 23:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F+DjJi+10FYXE5cugiMLFFk/XFPY8qLGrZjT7BUKWvg=;
        b=b5BmExAxUxdaF3wrzwyxnBl91lzr9Qu9x+Z36Kklt/N42xhOph8b8BH0mRZ5soEQDk
         n3HITidLsk4fhcnkZMfmhYlOkuYJfkpjhJv8x7WXDWv79W4W6Er2ss7HFCqFy824ORqJ
         5zznTGBRsGXCIvmQj6ZWet2xBEIMOmPIJ/oalfM5XZOOQ974L/oguTj+UINqZoh5RX4Y
         M6ztqGpaadR78KSlTkWPb4idWSiuZoMWL2FzPnBxn7VHyVOmFqUlDVWrYsQLOEQtGVa8
         JRqDh2jxrZfIWpBKUm2/dsJNcFUEh7vgvMx8XuyO2vTxZ5SWX+VVkYV+ef4JWUEOQMZd
         Ow6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F+DjJi+10FYXE5cugiMLFFk/XFPY8qLGrZjT7BUKWvg=;
        b=BQSl2bhOP338tGsmEoECePeG4Smb8kAfRIw54yo6Kxv82Ynf0pQNaNO4aQ4fLwaam7
         3lRygLovv3bw0zL1z9bvF+3axS58zqlFnJBGx0Nh90qL+ehcw3/x5RmojNv5XvRyvMGZ
         wUXd/ei3aFZzujzwKZqFgBM4h1f/rRs2JmH5I6eQEgsaojdVe0acjbT7MPQk6gnhYmTk
         ZlBNx0OXm8Wp7JYQvGvPwq9Es9nAE6TsHDkP+rwLLQ2Hza9VQohS6t3IKB0O5+FeQH/P
         UxJ97jMD4uVRxTw86UCmpp7S+8BCDr3KlFe1JlvRTfqzwkOeKv93yXhXEoUbIB7J4qgW
         KyBQ==
X-Gm-Message-State: ALyK8tKGmRMhcyqA0qnqlXpQCYapvakKw4IggzPASVtVNXA46ZBl8aOp0G99cWd+8EC34B2znr62JkmkClSTlA==
X-Received: by 10.37.231.137 with SMTP id e131mr7215126ybh.7.1465798905276;
 Sun, 12 Jun 2016 23:21:45 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Sun, 12 Jun 2016 23:21:44 -0700 (PDT)
In-Reply-To: <3db60187-4b44-85b2-f714-f836e3c3bc6e@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297159>

Hey Torsten,

On Sun, Jun 12, 2016 at 4:14 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
>>> So what I understand, you want something like this:
>>>
>>> +ssize_t file_size_not_zero(const char *filename)
>>> +{
>>> +       struct stat st;
>>> +       if (stat(filename, &st) < 0)
>>> +               return -1;
>>> +       return !!st.st_size);
>>> +}
>>
>> For the purpose of bisect_reset(), Yes. BTW a similar function exist
>> in builtin/am.c with the name is_empty_file(). But as Christian poin=
ts
>> out file_size() could help to refactor other parts of code.
>>
>
> Please allow one or more late comments:

That's perfectly fine.

> If is_empty_file() does what you need, then it can be moved into wrap=
per.c
> and simply be re-used in your code.

Thanks for informing. I was unaware about the use of wrapper.c

> If you want to introduce a new function, that can be used for other r=
efactoring,
> then the whole thing would ideally go into a single commit,
> or into a single series.
> That may probably be out of the scope for your current efforts ?

On re-thinking, I think introducing file_size() is out of the scope
for the current efforts and I will stick to is_empty_file(). Will move
it to wrapper.c and then use it in my code. I am not sure but I think
a few other parts could also use is_empty_file(). I will check on that
probably after GSoC as a cleanup.

> What really makes me concern is the mixture of signed - and unsigned:
> ssize_t file_size(const char *filename)
> +{
> +       struct stat st;
> +       if (stat(filename, &st) < 0)
> +               return -1;
> +       return xsize_t(st.st_size);
> +}
>
> To my understanding a file size is either 0, or a positive integer.
> Returning -1 is of course impossible with a positive integer.

True.

> So either the function is changed like this:
>
> int file_size(const char *filename, size_t *len)
> +{
> +       struct stat st;
> +       if (stat(filename, &st) < 0)
> +               return -1;
> +       *len =3D xsize_t(st.st_size);
> +       return 0;
> +}
>
> Or, if that works for you:
>
> size_t file_size(const char *filename)
> +{
> +       struct stat st;
> +       if (stat(filename, &st) < 0)
> +               return 0;
> +       return xsize_t(st.st_size);
> +}
>
> Or, more git-ish:
>
> size_t file_size(const char *filename)
> +{
> +       struct stat st;
> +       if (stat(filename, &st))
> +               return 0;
> +       return xsize_t(st.st_size);
> +}
>
> (And then builtin/am.c  can be changed to use the new function.

I think I will just skip file_size() for now.

Thanks for your comments!

Regards,
Pranit Bauva
