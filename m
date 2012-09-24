From: Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH] submodule: configure submodule.<name>.path on add and init
Date: Mon, 24 Sep 2012 21:32:54 +0200
Message-ID: <CAGHpTB+6AggmTWchcSEFDW1kmv=-Ej4u3RFuiik5KspR=D0ASQ@mail.gmail.com>
References: <1348515040-19986-1-git-send-email-orgads@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Orgad Shaneh <orgads@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 21:33:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGEOu-0000Di-Q7
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 21:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073Ab2IXTc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 15:32:56 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:45426 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757860Ab2IXTcz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 15:32:55 -0400
Received: by wgbfm10 with SMTP id fm10so2953942wgb.1
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 12:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jEs9v7evlVFXsVnGEBqqLWSuaO/7XkWlZrRWUNgjrMI=;
        b=tP5TsAYUGFl20Jqxml0qo71tVgozF/o/FrcOmsIHibUjCMj09O5aGrOA8hlnFcQ3uk
         GyEDGImcD0k++P5HY/OO9mbjhDhvCg09SnxQlNyqS9sqCM7DcrEjguH9iNNpzID2b2BJ
         kRlkVlgbEJzhhFrA0zVUO0UJw/wLT+cxWrpUO3qPF7fDJfHb39zj9AsZxuAjL6gV15sn
         6kozTZLsUphrZGsayzm861kGvNQTmQERq0RggNQdp6lUqdTo6udQzTculrFbQX9ysGPN
         h7Bg6XJ9F4f53Hki+CqSenO14OTDbwy4Tc21V0iR2we6b8Vv0LzncnMMQUYYPmdrOig7
         xTtg==
Received: by 10.216.207.73 with SMTP id m51mr8000193weo.116.1348515174127;
 Mon, 24 Sep 2012 12:32:54 -0700 (PDT)
Received: by 10.194.54.166 with HTTP; Mon, 24 Sep 2012 12:32:54 -0700 (PDT)
In-Reply-To: <1348515040-19986-1-git-send-email-orgads@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206318>

On Mon, Sep 24, 2012 at 9:30 PM, Orgad Shaneh <orgads@gmail.com> wrote:
> In order to read diff options for a submodule, its path must be configured
> ---
>  git-submodule.sh |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 3e2045e..f97bb62 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -359,6 +359,7 @@ Use -f if you really want to add it." >&2
>                         esac
>                 ) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
>         fi
> +       git config submodule."$sm_path".path "$sm_path"
>         git config submodule."$sm_path".url "$realrepo"
>
>         git add $force "$sm_path" ||
> @@ -476,6 +477,7 @@ cmd_init()
>                                 url=$(resolve_relative_url "$url") || exit
>                                 ;;
>                         esac
> +                       git config submodule."$name".path "$name" ||
>                         git config submodule."$name".url "$url" ||
>                         die "$(eval_gettext "Failed to register url for submodule path '\$sm_path'")"
>
> --
> 1.7.10.4
>

Oops, || should have been &&

- Orgad
