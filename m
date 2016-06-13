From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 1/6] worktree.c: add find_worktree()
Date: Mon, 13 Jun 2016 19:22:29 +0700
Message-ID: <CACsJy8BC=Fx7f6QAg_u_4HuwkV_-wvm9se5fU-kkp0mnhUpC=A@mail.gmail.com>
References: <20160530104939.28407-1-pclouds@gmail.com> <20160603121944.28980-1-pclouds@gmail.com>
 <20160603121944.28980-2-pclouds@gmail.com> <57519BA3.207@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 14:23:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCQtm-0007Jh-VA
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 14:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422720AbcFMMXM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2016 08:23:12 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36004 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161242AbcFMMXK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jun 2016 08:23:10 -0400
Received: by mail-io0-f193.google.com with SMTP id o127so13723773iod.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 05:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G/YRhWfcypCSpXvYDQBD8UXyqaFXVbPHyGCsQL1mwqM=;
        b=v2FpzA3qQWgM98V13DHiMyi9XRKRkacSFWLlLycVu18dyCO2khNkHPaW4sU9vnikgC
         7gWawrVgtVswVfEX+09t+C+mNtVuePMfEtpVnBkruf917Bkq8vlRvGYtaHMG/8fe1rjy
         p8hcPOHSMBZlJW6nSqDChLo268u3bISkyemKzbl0TgFBchUcSwRMaem1BR8DRnvNaOQx
         9E169Kk6JPUIv13z74t8rilu2zzGi4+dt7+93KY6qS2R8Y7a9EncrdNqNGMml7zldNDV
         vXD8iA/HWzhT7zFiC6jJAS6QcyjJCxnZT6WJJnLJZq186sfMw167KZKmOkLZtaFR4D+0
         t3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G/YRhWfcypCSpXvYDQBD8UXyqaFXVbPHyGCsQL1mwqM=;
        b=gbmLbxiX+ZgNrC1oNSK3BNs54Qo70u2hT1VCS12PASgl77msa1KWYR+hhO34Qa/RGg
         nbTIwUrng9PDiJh/TO1gGC/eUNROR+xCAHSnlMMPPaw0JuodObgUXscZMTNyxAkMQdi+
         a6AVvS0tw4n9ZQjh6zRJy7jglCVTu7YfSWn/t5LqJSl7/9pe4Zi53YE/taj1QnA/EwWp
         3UL6s2Fc5v+ssJphxh+fso/dQHYrW55yWysz6uUteisDbqbcbei5E4F7tx1xGaF9SWyV
         5RiAVUd5Hjn0tOjTrE6Y7NnM6sU7cFnIzGEv1G3yOx9uCx9rwRmmle5UGtN8EyRegOEF
         L/FQ==
X-Gm-Message-State: ALyK8tK3YXmX0kdrQy5i2o/CK7yJxmV6u7GwrEFpM2WFysEszudw1YfynycMrDtjneLaPjOHhOQ7whLLdyEnww==
X-Received: by 10.107.22.131 with SMTP id 125mr22090834iow.128.1465820579162;
 Mon, 13 Jun 2016 05:22:59 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Mon, 13 Jun 2016 05:22:29 -0700 (PDT)
In-Reply-To: <57519BA3.207@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297188>

On Fri, Jun 3, 2016 at 10:00 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 03/06/16 13:19, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> So far we haven't needed to identify an existing worktree from comma=
nd
>> line. Future commands such as lock or move will need it. The current
>> implementation identifies worktrees by path (*). In future, the func=
tion
>> could learn to identify by $(basename $path) or tags...
>>
>> (*) We could probably go cheaper with comparing inode number (and
>> probably more reliable than paths when unicode enters the game). But=
 not
>> all systems have good inode that so let's stick to something simple =
for
>> now.
>>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  worktree.c | 15 +++++++++++++++
>>  worktree.h |  8 ++++++++
>>  2 files changed, 23 insertions(+)
>>
>> diff --git a/worktree.c b/worktree.c
>> index e2a94e0..554f566 100644
>> --- a/worktree.c
>> +++ b/worktree.c
>> @@ -214,6 +214,21 @@ const char *get_worktree_git_dir(const struct w=
orktree *wt)
>>               return git_common_path("worktrees/%s", wt->id);
>>  }
>>
>> +struct worktree *find_worktree(struct worktree **list,
>> +                            const char *prefix,
>> +                            const char *arg)
>> +{
>> +     char *path;
>> +
>> +     arg =3D prefix_filename(prefix, strlen(prefix), arg);
>> +     path =3D xstrdup(real_path(arg));
>> +     for (; *list; list++)
>> +             if (!fspathcmp(path, real_path((*list)->path)))
>
> The results of the call to real_path() should probably be cached
> in the worktree structure, since real_path() is relatively expensive
> (it calls chdir(), lstat(), readlink() etc.), so you don't want to
> re-compute the same result time-after-time ...

Urgh.. I missed this after sending out v5. Because find_worktree is
probably called once or twice per process, I don't think we need to
optimize this yet. If nr. worktrees goes up to hundreds then this is
one of many items we need to do to make worktree list fast.
--=20
Duy
