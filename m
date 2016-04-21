From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 04/12] worktree.c: mark current worktree
Date: Thu, 21 Apr 2016 15:19:48 +0700
Message-ID: <CACsJy8DwzfsPthWy6pG2t0cGVT0kcrJT7xWdyvs+0EPFDbNtSQ@mail.gmail.com>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
 <1461158693-21289-1-git-send-email-pclouds@gmail.com> <1461158693-21289-5-git-send-email-pclouds@gmail.com>
 <CAPig+cR99Nx=dk+zT2Jgpr2ZgYM4v0q2vX7v6TXmWHU5k6ga3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 10:20:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1at9qo-0005Ar-C1
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 10:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbcDUIUX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Apr 2016 04:20:23 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:34131 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbcDUIUU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2016 04:20:20 -0400
Received: by mail-lb0-f179.google.com with SMTP id b1so20043647lbi.1
        for <git@vger.kernel.org>; Thu, 21 Apr 2016 01:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hgd4sbkqA10HpMPtOrxrPY36GNGov81eHQKn42+QwXg=;
        b=hvX8yz07spy+sJz4vZBwKvjVBYZ7eRX54xfWyt8LoKfRizvbyhsIhAwjHoY79NVzlX
         5J1tQ7yClffFkMp60nSeJGsYdmLAjHAgZpssOtMO+Uoa+pnYQt8cvpPE29SAHKDCBA37
         McBIRfNRZj/oZy4XOL6laC903sXmjpOgePCh7XPNTgpdUNNbjEX9EY3ifucsMTGGD1PX
         IaEP3a3CRt9pBVfo6c/PoatsAqAv8hDrI1Cxw5O6DMa6mldny4H/kFm1ogZxvRTRXoIW
         afTDxQHDIYhsX9fERtm0MOPpHLhZeagGyJzpP54xoqsX2DS/udkDNgJlhkfk0W1LauT1
         K2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hgd4sbkqA10HpMPtOrxrPY36GNGov81eHQKn42+QwXg=;
        b=lSSwnjuaVabpDQdyT+ivJGcqFJKYzhK9Y18R5DNYIxvZnNhCqFvn8OU7QOiCXxaXAU
         fbZ8NVZVEGOi6MbzugHXvj66oNCCeIZy5POq7hx67813Fbt0N4Fw34+h5n6wKRYQFw2m
         VQIly0GUqpYkr6ofvUoB1fJhQnRa7+tY7mTBOXzOzIbAn6BIx6ME1wwXJ13eqGUa77tA
         sOlYJiefdLNnMtQ7xCQYgT6OCLTNa9kOfTJwTZYWmxpyYGlMzxU4iMC7wHDNlvujC44C
         4SQxJNJVbk14d0RALQ20jZf9NlpzupFtffk8wS0EX7AzkYRBkCQHgVpEm9nkrvla5C++
         bHnw==
X-Gm-Message-State: AOPr4FUOgm3KLh63AUDT1O9+tLq0W0zHVmhtcIoFN57s1t3nPCLmbC9b4kwmMd/wDg6cd8Zvi8fOxtUwgsQVUA==
X-Received: by 10.112.198.166 with SMTP id jd6mr5695183lbc.12.1461226818302;
 Thu, 21 Apr 2016 01:20:18 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 21 Apr 2016 01:19:48 -0700 (PDT)
In-Reply-To: <CAPig+cR99Nx=dk+zT2Jgpr2ZgYM4v0q2vX7v6TXmWHU5k6ga3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292100>

On Thu, Apr 21, 2016 at 2:20 PM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Wed, Apr 20, 2016 at 9:24 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> diff --git a/worktree.c b/worktree.c
>> @@ -178,6 +182,18 @@ struct worktree **get_worktrees(void)
>>         }
>>         ALLOC_GROW(list, counter + 1, alloc);
>>         list[counter] =3D NULL;
>> +
>> +       strbuf_addstr(&git_dir, absolute_path(get_git_dir()));
>> +       for (i =3D 0; i < counter; i++) {
>> +               struct worktree *wt =3D list[i];
>> +               strbuf_addstr(&path, absolute_path(get_worktree_git_=
dir(wt)));
>> +               wt->is_current =3D !strcmp_icase(git_dir.buf, path.b=
uf);
>
> Can you talk a bit about why this uses 'icase'? Should it be
> respecting cache.h:ignore_case?

It does.That function (in dir.c) is just one-liner

    return ignore_case ? strcasecmp(a, b) : strcmp(a, b);

I admit though, the naming does not make that clear.

>> +               strbuf_reset(&path);
>> +               if (wt->is_current)
>> +                       break;
>> +       }
>> +       strbuf_release(&git_dir);
>> +       strbuf_release(&path);
>
> Minor: Would it make sense to place this new code in its own function
> -- say, mark_current_worktree() -- to keep get_worktrees() from
> becoming overlong?

Good idea. Will do.
--=20
Duy
