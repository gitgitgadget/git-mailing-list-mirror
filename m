From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] t3401: modernize style
Date: Sat, 10 Dec 2011 00:21:58 +0530
Message-ID: <CALkWK0mip_pzUDQO=YLxaVwsWEAUdrk_EKcNG94Xr5+N+kzBtw@mail.gmail.com>
References: <1323449952-14161-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 19:53:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ5ZP-00087A-L8
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 19:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927Ab1LISxO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 13:53:14 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56831 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477Ab1LISxO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 13:53:14 -0500
Received: by wgbdr13 with SMTP id dr13so6192775wgb.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 10:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=xHLsXZZiB4DGhThwkh7iL5JzDlGxqfLqY4+NJo9MzOQ=;
        b=sUkG8R63sXlNGWtymgzQ+7lWxjgpezisLfikMxp4S9U2gDJ1lJbNUw3txYFnMr+k6i
         Tu/ExvRwRxTnKgLE+TqqfqwiqfzITH68gnGkjmrZsXF8dXTiGDE43Wp9f5ioV37FdIM6
         sL8RM8B4ty/kwt7ZDmPxCAVmmyUMEq41UvnEo=
Received: by 10.227.209.85 with SMTP id gf21mr7633864wbb.5.1323456793018; Fri,
 09 Dec 2011 10:53:13 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Fri, 9 Dec 2011 10:51:58 -0800 (PST)
In-Reply-To: <1323449952-14161-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186663>

Hi Martin,

No cover letter, so I'm assuming these are just two random one-off
patches. The motivation is unclear: lazy afternoon? :P

Martin von Zweigbergk wrote:
> [...]
> diff --git a/t/t3401-rebase-partial.sh b/t/t3401-rebase-partial.sh
> index aea6685..d7c874c 100755
> --- a/t/t3401-rebase-partial.sh
> +++ b/t/t3401-rebase-partial.sh
> @@ -11,51 +11,50 @@ local branch.
> =C2=A0'
> =C2=A0. ./test-lib.sh
>
> -test_expect_success \
> - =C2=A0 =C2=A0'prepare repository with topic branch' \
> - =C2=A0 =C2=A0'echo First > A &&
> - =C2=A0 =C2=A0 git update-index --add A &&
> - =C2=A0 =C2=A0 git commit -m "Add A." &&
> +test_expect_success 'prepare repository with topic branch' '
> + =C2=A0 =C2=A0 =C2=A0 echo First > A &&
> + =C2=A0 =C2=A0 =C2=A0 git update-index --add A &&
> + =C2=A0 =C2=A0 =C2=A0 git commit -m "Add A." &&

Style nit: >[^ ] is prevalent FWIW.

$ git grep '> [^ ]' t/ | wc -l
3091
$ git grep '>[^ ]' t/ | wc -l
9271

Sure, the regular expressions aren't tailored to make sure that only
redirections are caught, but I suppose it's safe to assume that one
number is significantly larger than the other.

> [...]
> -test_expect_success \
> - =C2=A0 =C2=A0'rebase topic branch against new master and check git =
am did not get halted' \
> - =C2=A0 =C2=A0'git rebase master && test ! -d .git/rebase-apply'
> +test_expect_success 'rebase topic branch against new master and chec=
k git am did not get halted' '
> + =C2=A0 =C2=A0 =C2=A0 git rebase master &&
> + =C2=A0 =C2=A0 =C2=A0 test ! -d .git/rebase-apply
> +'

While at it, why not change this "test ! -d" to
"test_path_is_missing"?  My rationale is that you're touching the file
anyway to do a generic cleanup; might as well finish it.

Thanks.

-- Ram
