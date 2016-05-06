From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 05/13] worktree.c: mark current worktree
Date: Fri, 6 May 2016 17:21:05 +0700
Message-ID: <CACsJy8D+anuZ-278kaz2ewpcLCGOSrdn2Qq1F7fFTuVUTLv5Yw@mail.gmail.com>
References: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
 <1461330096-21783-1-git-send-email-pclouds@gmail.com> <1461330096-21783-6-git-send-email-pclouds@gmail.com>
 <CAPig+cQszEZLaebwqXNny6_EnhFpwU1xYqEX2_0N=vTEXTk2Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 06 12:21:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayctB-0007o7-N8
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 12:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758166AbcEFKVi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2016 06:21:38 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35075 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756399AbcEFKVh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 06:21:37 -0400
Received: by mail-lf0-f52.google.com with SMTP id j8so125949187lfd.2
        for <git@vger.kernel.org>; Fri, 06 May 2016 03:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sK5mpzktuCGsz7NTNC0vIq9Q17I95me27V5lLlgSpag=;
        b=hfVZSJZnd7AN5ULu9WWzT61m9sS0QzK3Cs/iUbTCJd+pl+25T1o0F+hnZUsvwT7TMz
         o4jqDhGd9ekxztfRXf1mnpawLN9ZdyC7Wtjfi+5CRixaIi2K65Cwg/+mRA91DJRf+Ab9
         fj3uimGscV0qxAiAZQ/fkW50E3EQxxOmItxKcWvMrfO47Af5jK3de/7cT9Z8d2GVz/Du
         ZwB0TEd/L+DtMHP2qrCZs9159lxCNw/8g369V3KXEZ6hQeovjJN/MTX+zeW1n70CpshH
         ogwVyWofn3h3Ehl+G9ldgv09/62qrL0yohR8IJEVaYNFbwxa+DKifa2faR7bznT5bWKB
         bq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sK5mpzktuCGsz7NTNC0vIq9Q17I95me27V5lLlgSpag=;
        b=RwAZsBaCNiQUAu09ev1DslPq9RPyaGVDLaEEW4yfB95j85dWLLNqpZPWbv526Oq7fg
         lnNBK3KySNW378rRtbhRuGG6G7FKCYavLAxz9lzZ7ldu2SIDbmCsw9qtoESBMxlTA99z
         HyDIPemQwQUYESQbYYVjAStqaqh3dMnMkwN0102t5iiW0DkeHhh/+wEYgJK0nd8n+mjB
         7ypMHm6dGAxpQxcIn9KeF62KqIDrOYxnag2cLQdTXsyTbNyunF5ehas7KsnY40FXGNZH
         +lZa8XIIavj/cCwhE8o+GFi+Dd9v1Sz8ywH7bHHxv+BGMDyDG4P6EWEVq0grSIjyI9Zr
         EEdA==
X-Gm-Message-State: AOPr4FW3S3rWmTDuVEqvlwgHqPggAqv+hKK8KPnkBWeoe/MBqqdNP0Wfg3t0URThW4hV8utqcFIxAlARMIoCxQ==
X-Received: by 10.112.54.132 with SMTP id j4mr9510880lbp.3.1462530095515; Fri,
 06 May 2016 03:21:35 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Fri, 6 May 2016 03:21:05 -0700 (PDT)
In-Reply-To: <CAPig+cQszEZLaebwqXNny6_EnhFpwU1xYqEX2_0N=vTEXTk2Fw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293756>

On Fri, May 6, 2016 at 2:51 PM, Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
> On Fri, Apr 22, 2016 at 9:01 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> diff --git a/worktree.c b/worktree.c
>> @@ -147,6 +150,25 @@ done:
>> +static void mark_current_worktree(struct worktree **worktrees)
>> +{
>> +       struct strbuf git_dir =3D STRBUF_INIT;
>> +       struct strbuf path =3D STRBUF_INIT;
>> +       int i;
>> +
>> +       strbuf_addstr(&git_dir, absolute_path(get_git_dir()));
>
> This could also just be:
>
>     char *git_dir =3D xstrdup(absolute_path(...));
>
> with a corresponding 'free(git_dir)' below.
>
>> +       for (i =3D 0; worktrees[i]; i++) {
>> +               struct worktree *wt =3D worktrees[i];
>> +               strbuf_addstr(&path, absolute_path(get_worktree_git_=
dir(wt)));
>> +               wt->is_current =3D !fspathcmp(git_dir.buf, path.buf)=
;
>
> Similarly, it looks like 'path' doesn't need to be a strbuf at all
> since the result of absolute_path() should remain valid long enough
> for fspathcmp(). It could just be:
>
>     const char *path =3D absolute_path(...);
>     wt->is_current =3D !fspathcmp(git_dir, path);
>
> But these are very minor; probably not worth a re-roll.

Yeah. I think the use of strbuf is influenced by the code in
get_worktrees(). But since this code is now in a separate function, it
makes little sense to go with the strbuf hammer. If there's no big
change in this series, I'll just do this as a cleanup step in my next
series, worktree-move.
--=20
Duy
