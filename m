From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 05/13] worktree.c: mark current worktree
Date: Fri, 6 May 2016 03:51:59 -0400
Message-ID: <CAPig+cQszEZLaebwqXNny6_EnhFpwU1xYqEX2_0N=vTEXTk2Fw@mail.gmail.com>
References: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
	<1461330096-21783-1-git-send-email-pclouds@gmail.com>
	<1461330096-21783-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 09:52:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayaYS-0001YX-2I
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 09:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756767AbcEFHwC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2016 03:52:02 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:32891 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756737AbcEFHwA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 03:52:00 -0400
Received: by mail-ig0-f195.google.com with SMTP id rc4so4365372igc.0
        for <git@vger.kernel.org>; Fri, 06 May 2016 00:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=oSOXsUnbEEv5hrmaynKj/gVAPHRB65wSxfSdgaUIy+k=;
        b=TbD0kXTQ8PNcqXqUWqcNLBb/ZDdpomjIxitkxWECSlUapREn4P3z85Pj3flUchZ5VQ
         u6mrxNKj867eVF7sXCUP1lPvWo8UCLpT9dVzwfh0bpJaH6RYONNMrC1Bx6iAHjWFTBYC
         UoCxA/SolQENjYeUnY5SXj+eU8vjr8ztmghnIr3O+aJCiwk0s57BRZIfLBExiSs8Phd+
         sUxVruYvt9EH3QUTauK4L5GI4v9Tqa8YHVdnGjMzfWiqX6CLtK4wzpR6boijTFZ4r6b6
         Ky4AMFNe632B0zPGe593fAa02PQ6JIGwD2jMNYi7LcHgK8T+JIGbKSavoNIPYoaepd4w
         qd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=oSOXsUnbEEv5hrmaynKj/gVAPHRB65wSxfSdgaUIy+k=;
        b=NAcMjoN0ZL4atZUD6danjxQeXVzcQoQLam0dKKU3N0Msi5FQUI3EPcTGBLdos1Uf9f
         sSV+aE/YVZ3MRSdfRU9hpBxy8vULmhCrVhAMpDxWl65cwRKViKZYoiEWjKJFG8OzqslB
         ddd6NAmrxZjBF4ExRH69ipPIExnBRVburbUd8VGv/+TkfMNMp27sIp2p2CgCIk2cTSPp
         EjV4+B2IXbR95U35/RSzqfEnkpA4UlcQYjxtMEyrejgByNOCR0+NtXOTihVdkvO19AXT
         VlUdHk2CY4viswaZ/d/hYkgjLQL+fGoih0un/c76gneucsrqG/NDL0kO/18p6VUriynH
         Z+7w==
X-Gm-Message-State: AOPr4FVelCvz1W9Y2q1Dlqli5bwTpxCLmfWI9rqUEM0ssH1grk9XX/wKBajD0N9EiCwjubaVguTIJSjuGY5BYw==
X-Received: by 10.50.3.105 with SMTP id b9mr8801291igb.17.1462521119924; Fri,
 06 May 2016 00:51:59 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Fri, 6 May 2016 00:51:59 -0700 (PDT)
In-Reply-To: <1461330096-21783-6-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: oNu7VkZyNBwongRZNBIZv4VHmx8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293752>

On Fri, Apr 22, 2016 at 9:01 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/worktree.c b/worktree.c
> @@ -147,6 +150,25 @@ done:
> +static void mark_current_worktree(struct worktree **worktrees)
> +{
> +       struct strbuf git_dir =3D STRBUF_INIT;
> +       struct strbuf path =3D STRBUF_INIT;
> +       int i;
> +
> +       strbuf_addstr(&git_dir, absolute_path(get_git_dir()));

This could also just be:

    char *git_dir =3D xstrdup(absolute_path(...));

with a corresponding 'free(git_dir)' below.

> +       for (i =3D 0; worktrees[i]; i++) {
> +               struct worktree *wt =3D worktrees[i];
> +               strbuf_addstr(&path, absolute_path(get_worktree_git_d=
ir(wt)));
> +               wt->is_current =3D !fspathcmp(git_dir.buf, path.buf);

Similarly, it looks like 'path' doesn't need to be a strbuf at all
since the result of absolute_path() should remain valid long enough
for fspathcmp(). It could just be:

    const char *path =3D absolute_path(...);
    wt->is_current =3D !fspathcmp(git_dir, path);

But these are very minor; probably not worth a re-roll.

> +               strbuf_reset(&path);
> +               if (wt->is_current)
> +                       break;
> +       }
> +       strbuf_release(&git_dir);
> +       strbuf_release(&path);
> +}
