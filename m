From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 04/12] worktree.c: mark current worktree
Date: Thu, 21 Apr 2016 03:20:07 -0400
Message-ID: <CAPig+cR99Nx=dk+zT2Jgpr2ZgYM4v0q2vX7v6TXmWHU5k6ga3w@mail.gmail.com>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
	<1461158693-21289-1-git-send-email-pclouds@gmail.com>
	<1461158693-21289-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 09:20:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1at8uO-0004ZT-Gv
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 09:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbcDUHUJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Apr 2016 03:20:09 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37805 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbcDUHUI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2016 03:20:08 -0400
Received: by mail-ig0-f181.google.com with SMTP id g8so73293309igr.0
        for <git@vger.kernel.org>; Thu, 21 Apr 2016 00:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=XXZRZ9uX2+Habo17Ee0YsPNZRVd0mbfRrcsOan8cyV4=;
        b=omDDftFNx+fpYw3oi++T60jtgldY9NiBU8RVOprkomZYKfMj/uFcwniD+s//qPXYuZ
         l4UWAx7kaDjk5s7s+Mdhm7pCtJIznIG7l84TtIKMAaVBko61Z+Byq4csOgvKgla0KboM
         0riOZs7hB1SIR8FJwAJl0AHmV3T34pWik8pEvOFzSQpxM6H2YLTLKZoh7mpG2KNrhrJl
         EwwhH8MtGn5y1vOpfd+K3AW1kZf2TF6+vAIGbkFCgJwBdS1yvsT0sn7rAGBz0dfdmC2A
         6LTrOzh6NAx9YoeINSB34BZcOKJantOu98l+yh3Cqw4ZZajmrqVyi/uYQZ+WoLdv31Ms
         dleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=XXZRZ9uX2+Habo17Ee0YsPNZRVd0mbfRrcsOan8cyV4=;
        b=DvnzjNto7N38IXyUp5y2MsRcy+WyJhrBALc7e7DazpN3CoZCWw577lklT5+7Qg5zLd
         fyhTJqv+A4EHVigMfY7qvvuGrKDcLgFIv+2xilHDfM/pU+A4049p/fAgPElLjuKk0/mV
         xupSdrmI59QRt1RW9BVFNWG2dyRKIo3u3+sBf7Qi9SCHE7AwYMHLB6CRWdOVUEK8ehiF
         M6qqHzanm+r9SxqxxgQBbHEXZzISmURjGSuPiRnn+w5M21DTyWkk9VwOuEpe4tHtGVqZ
         qjDvb1FEvcb4urs6o4zDEEe0/xeHZVjG5Zx05BUGT9Mklg0UBHFOySaMFnGIgUJ12akQ
         GeMg==
X-Gm-Message-State: AOPr4FUS/6dqihivepTGBxCVWjeEDonbaXdks1P185cXMMgOeH5StGzFkCXz8KtNkeDQ47ly024nvIDTVLGOZQ==
X-Received: by 10.50.77.107 with SMTP id r11mr1761216igw.91.1461223207339;
 Thu, 21 Apr 2016 00:20:07 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Thu, 21 Apr 2016 00:20:07 -0700 (PDT)
In-Reply-To: <1461158693-21289-5-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: qbiwd_tb5JtHAfu6ZDMdiOUIYeE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292098>

On Wed, Apr 20, 2016 at 9:24 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/worktree.c b/worktree.c
> @@ -178,6 +182,18 @@ struct worktree **get_worktrees(void)
>         }
>         ALLOC_GROW(list, counter + 1, alloc);
>         list[counter] =3D NULL;
> +
> +       strbuf_addstr(&git_dir, absolute_path(get_git_dir()));
> +       for (i =3D 0; i < counter; i++) {
> +               struct worktree *wt =3D list[i];
> +               strbuf_addstr(&path, absolute_path(get_worktree_git_d=
ir(wt)));
> +               wt->is_current =3D !strcmp_icase(git_dir.buf, path.bu=
f);

Can you talk a bit about why this uses 'icase'? Should it be
respecting cache.h:ignore_case?

> +               strbuf_reset(&path);
> +               if (wt->is_current)
> +                       break;
> +       }
> +       strbuf_release(&git_dir);
> +       strbuf_release(&path);

Minor: Would it make sense to place this new code in its own function
-- say, mark_current_worktree() -- to keep get_worktrees() from
becoming overlong?

>         return list;
>  }
