From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 24/25] worktree move: accept destination as directory
Date: Wed, 11 May 2016 20:34:10 +0700
Message-ID: <CACsJy8CCAan9ALxULPFeGSU7wsfwbrywRWFr4Hsjx3=PGwosLA@mail.gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
 <1460553346-12985-25-git-send-email-pclouds@gmail.com> <CAPig+cRtajkynLFj5Fknd72QQ=Eqevh1T9i9MvApwXfNmtMAFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 11 15:34:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0UHn-0002wV-5N
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbcEKNen convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2016 09:34:43 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:32975 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932125AbcEKNem convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2016 09:34:42 -0400
Received: by mail-lf0-f67.google.com with SMTP id j8so5114710lfd.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gXlZHRBXSH4JT2GX64Uu/zZn4nxZ8szykPT73kllx3o=;
        b=B/8MoiDT4ZbngutNxcIjGv1shW34gXDomC8IPbdZ+6TXdN1Ycxj688kdEKgT250k/y
         Bk0M5LuR/LpUGa3RSRjiRryWChyIVfgsSYr3iedDaMjG4eyv13F4CLwXgden4bAIVIR/
         36ZvinafaWsK0k42PbEE9FgwxQhsn925i+jrJ5QyL1UatTlwpYZNRJ3a16Cws2iL3ddo
         Ci4Krbh2ynlUiVtOVwU+sjDJqrXTxfnWwcqhFhpPk4INU5Cw0zLYtCvCGHqCSE1IxKkK
         Vp0vo1IRFuquuvgxu0jrsxwaQeJJBr9kpRRld9P8zgT3YTSgEHo02azcno5VscFOQ329
         YoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gXlZHRBXSH4JT2GX64Uu/zZn4nxZ8szykPT73kllx3o=;
        b=DGCWcK5ZhcRCgYmFFgcwwrqqVKnSFPekh/T9NBRq4HRi3KxqdQuI5E3/F1dgkcwA2m
         SsQoIrK8s/pZEZeow4mWQ8Jxjyx59zkUQHzaXrxV9qPmN1KXUUcFUjKZ0LjvkQ5/6tuE
         Y7gqyeinx983OG4d2u1ItNV4DUlNOcuV5Z5o5RT1t4GXyhViQbzJ3WWVPwQqjuIvn8Nc
         IIeYa/sYwAYEzwa7tp2uZrrV+G3CdErSdljZ5g9aRfRDxOcZ1jaNuiJ8QjkZBTqo1I9q
         U5CejWO9em/Ej9uKhz+eXnvyGky4jRUaPYNejmYvxr/RZAhqyNwSDuMP1TGx+Xw2Lq+o
         orRg==
X-Gm-Message-State: AOPr4FUslEutlrLQGjr+0fgWMJApdBTsQtS9pMOTpD/l/G9lExf8wi6ajfBBjDgzPyzgajlYCag4mhf6bPvCbg==
X-Received: by 10.112.209.99 with SMTP id ml3mr1542037lbc.26.1462973680494;
 Wed, 11 May 2016 06:34:40 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Wed, 11 May 2016 06:34:10 -0700 (PDT)
In-Reply-To: <CAPig+cRtajkynLFj5Fknd72QQ=Eqevh1T9i9MvApwXfNmtMAFQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294342>

On Wed, May 11, 2016 at 11:43 AM, Eric Sunshine <sunshine@sunshineco.co=
m> wrote:
> On Wed, Apr 13, 2016 at 9:15 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>> Similar to "mv a b/", which is actually "mv a b/a", we extract basen=
ame
>> of source worktree and create a directory of the same name at
>> destination if dst path is a directory.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> @@ -538,7 +538,13 @@ static int move_worktree(int ac, const char **a=
v, const char *prefix)
>> -       if (file_exists(dst.buf))
>> +       if (is_directory(dst.buf))
>> +               /*
>> +                * keep going, dst will be appended after we get the
>> +                * source's absolute path
>> +                */
>> +               ;
>> +       else if (file_exists(dst.buf))
>>                 die(_("target '%s' already exists"), av[1]);
>> @@ -558,6 +564,17 @@ static int move_worktree(int ac, const char **a=
v, const char *prefix)
>> +       if (is_directory(dst.buf)) {
>> +               const char *sep =3D strrchr(wt->path, '/');
>
> Does this need to take Windows into account?

wt->path comes from $GIT_DIR/worktrees/xxx/gitdir, which normally uses
forward slashes, so we should be safe. We already rely on forward
slashes in get_linked_worktree()

> Perhaps git_find_last_dir_sep()?

But this is probably a good thing to do anyway, to be more robust in
future. But it could confuse the reader later on why it's necessary
when backward slashes can't exist in wt->path. I don't know. Maybe
just have a comment that backward slashes can't never appear here?

There is also a potential problem with find_worktree_by_path(). I was
counting on real_path() to normalize paths and could simply do
strcmp_icase (or its new name, fspathcmp). But real_path() does not
seem to convert unify slashes. I will need to have a closer look at
this. Hopefully prefix_filename() already makes sure everything uses
forward slashes. Or maybe we could improve fspathcmp to see '/' and
'\' the same thing on Windows.
--=20
Duy
