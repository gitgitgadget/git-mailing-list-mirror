From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 04/12] worktree.c: mark current worktree
Date: Thu, 21 Apr 2016 16:33:09 +0700
Message-ID: <CACsJy8ATaYx0Fk-7HK9Rz_o687hxCLuOJYJ6DkBd4Xk8sP+byw@mail.gmail.com>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
 <1461158693-21289-1-git-send-email-pclouds@gmail.com> <1461158693-21289-5-git-send-email-pclouds@gmail.com>
 <CAPig+cR99Nx=dk+zT2Jgpr2ZgYM4v0q2vX7v6TXmWHU5k6ga3w@mail.gmail.com> <CACsJy8DwzfsPthWy6pG2t0cGVT0kcrJT7xWdyvs+0EPFDbNtSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 11:34:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atAzn-0002GV-J6
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 11:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbcDUJdn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Apr 2016 05:33:43 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35406 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbcDUJdl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2016 05:33:41 -0400
Received: by mail-lf0-f43.google.com with SMTP id c126so57037525lfb.2
        for <git@vger.kernel.org>; Thu, 21 Apr 2016 02:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HU8B0lXyxEUKbayqewSygfxSlCCRnpQhW3Y3omWjyTA=;
        b=MgAw8RKk7zbAsGESIVfl5emPIvgRs4XyQ1tdEYvGmRMO/vAkuWTVDu+XzPwjOu5JKV
         /bRIUcgw3N4EriQYkzveOAdvwZAwO0eHOsNah4w2o17/ltlvB0BYjXEhx+naeq7BDoaQ
         loKVjCBVcTP+R6In6EzGWtB50Xg/fUVkQ195VE/ykh9iTB+KY9oZ20MFMg4AANUQve7N
         0ZnMKzRdexRpsQNnajQ1t0pEUJop12tysEfbcrua/d4sqlmDxhfZ6mOIRvcEWlj9ILDx
         NgsHyHJg8qoffoMSBrxx+EFGRER/fdw2WseGXPXO327m1FvumPLw4u3wsVzYdBwLifRH
         ss0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HU8B0lXyxEUKbayqewSygfxSlCCRnpQhW3Y3omWjyTA=;
        b=EBCHp4MxXfMHg4CC3upnWCm8d2qxx1MkGpHkqybSPDYXQqTdd3kKQ582eyLO5jOyym
         AWGxaJ5x6Q6kIWEL27Nh8PLdK6qtxtkpdoXyo/joyudAhxcoeljmO6yBFPv5gdwAnLXa
         M5MMYSOcDMMMWBSd6E/J/FHcFFXlH3IGttQKVqWxbjFjnldkMgS2f7lIk+SxyjyqRRlR
         ebPygaq4qBoM2/Nsuh7JcDpAzUFBIc9JaDRB9FJJT3YiHYRqlXEhE4rTjwvVk9/PJsM4
         nm3Mcu7pZfDX94YeafXBPRlt/75rOUybcU+lExpLZQsqz/4cjpqzteyjWcD21t5ws+F8
         Jd5g==
X-Gm-Message-State: AOPr4FWgeFUGnVS8jflmX9tDPXnxj2JUVRZAySQ+0sbZVUii5P3twLyr8WgxzoYgPhl2LJ6d/0an3mbn+x6gNA==
X-Received: by 10.25.17.99 with SMTP id g96mr2437065lfi.112.1461231219444;
 Thu, 21 Apr 2016 02:33:39 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 21 Apr 2016 02:33:09 -0700 (PDT)
In-Reply-To: <CACsJy8DwzfsPthWy6pG2t0cGVT0kcrJT7xWdyvs+0EPFDbNtSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292104>

On Thu, Apr 21, 2016 at 3:19 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Apr 21, 2016 at 2:20 PM, Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>> On Wed, Apr 20, 2016 at 9:24 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>> ---
>>> diff --git a/worktree.c b/worktree.c
>>> @@ -178,6 +182,18 @@ struct worktree **get_worktrees(void)
>>>         }
>>>         ALLOC_GROW(list, counter + 1, alloc);
>>>         list[counter] =3D NULL;
>>> +
>>> +       strbuf_addstr(&git_dir, absolute_path(get_git_dir()));
>>> +       for (i =3D 0; i < counter; i++) {
>>> +               struct worktree *wt =3D list[i];
>>> +               strbuf_addstr(&path, absolute_path(get_worktree_git=
_dir(wt)));
>>> +               wt->is_current =3D !strcmp_icase(git_dir.buf, path.=
buf);
>>
>> Can you talk a bit about why this uses 'icase'? Should it be
>> respecting cache.h:ignore_case?
>
> It does.That function (in dir.c) is just one-liner
>
>     return ignore_case ? strcasecmp(a, b) : strcmp(a, b);
>
> I admit though, the naming does not make that clear.

While we're at it, how about renaming it to pathcmp (and its friend
strncmp_icase to pathncmp)?
--=20
Duy
