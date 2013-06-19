From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: [Request] Git reset should be able to ignore file permissions
Date: Wed, 19 Jun 2013 09:40:55 -0700
Message-ID: <CAE1pOi36RDWXa_ESvh83Rpvq1AO-=njAxC9swMBetJxC+6Fbog@mail.gmail.com>
References: <CACuz9s31OUWNxTqCmj7ukAo7=TpXK7zBv5kTFZ5obpXKOju9ng@mail.gmail.com>
 <vpqsj0fr19j.fsf@anie.imag.fr> <CACuz9s1KGKsL-pGftAtAWyX5gUA5c-PYyJUSstf+xw151rZLtA@mail.gmail.com>
 <vpq7ghrqzrv.fsf@anie.imag.fr> <CACuz9s0=7z-M1-zgRNUs2hS-4LcuXrsWbqyDaMnuvFXRnP7E-Q@mail.gmail.com>
 <vpqppvjpjz3.fsf@anie.imag.fr> <CACuz9s2DfN5O91ZF8QOnWuA0V3bGFuUG5RVmkmjeL7Jien+fYg@mail.gmail.com>
 <CACuz9s1H2Gi+B7=Fc3yJ+PC9oDueLQzXstSX0C9uAy3_MN4Kag@mail.gmail.com>
 <vpqy5a7mmsg.fsf@anie.imag.fr> <CACuz9s2KEne5_PwHwmsd1X7iE=GB3pC=iUzxSo=t6TbF+ZjCxA@mail.gmail.com>
 <vpqsj0emzdu.fsf@anie.imag.fr> <CACuz9s0jqe9zErBLZ5+kv2OCKW5fFHq0sifc2GS=n4jFpDiQZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Alexander Nestorov <alexandernst@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 18:41:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpLRi-0004Xf-1q
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 18:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934865Ab3FSQlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 12:41:17 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:40925 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934170Ab3FSQlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 12:41:16 -0400
Received: by mail-vc0-f180.google.com with SMTP id gf11so4008550vcb.11
        for <git@vger.kernel.org>; Wed, 19 Jun 2013 09:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ylYNPr5iAl/ZllskKGbvGJJ3KqctsS1hNMH4Vr1NqEw=;
        b=PIM5cnsJg1zl3O3bGmCcy1yW75f231kMR02Uu5+zqyDt/VJxx4NOu0kieUAuXEs5iC
         IUo+06sIzF853V1kdMTD8ELfsx8Y+ONoqxLfO7sxC0LpXyBMDeFWwjIDuCowsu8r1uJf
         +fxlQzBDYWkvQG3PACn4vW5zzHzPXAVpIkbbbwfqo/n+T8zNC1exaP1L+iZixb2Swd48
         RhtiXbVzlYrvTVaF22a0M+C9G+1LCpnk1t7XwPQvK7iDils3niUA6C0aLV6hUKFNEQTG
         cUr7zZ16GOHgWsO1pVeBTms+MaUnVwE7j1aoHrbZKuRSSqq6z83Aeap+HBV1delqo+at
         Uz0A==
X-Received: by 10.58.68.138 with SMTP id w10mr1168689vet.92.1371660075671;
 Wed, 19 Jun 2013 09:41:15 -0700 (PDT)
Received: by 10.58.229.106 with HTTP; Wed, 19 Jun 2013 09:40:55 -0700 (PDT)
In-Reply-To: <CACuz9s0jqe9zErBLZ5+kv2OCKW5fFHq0sifc2GS=n4jFpDiQZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228398>

On 19 June 2013 01:00, Alexander Nestorov <alexandernst@gmail.com> wrote:
> Ok, this is how it looks. If everything is ok, I'm sending it to the ML
>
> From 262bdfb5cc84fec7c9b74dc92bb604f9d168ef9a Mon Sep 17 00:00:00 2001
> From: Alexander Nestorov <alexandernst@gmail.com>
> Date: Wed, 19 Jun 2013 09:55:42 +0200
> Subject: [PATCH] Add example for reseting based on content changes instead of
>  stat changes
>
> ---
>  Documentation/git-reset.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index a404b47..da639e9 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -289,6 +289,18 @@ $ git reset --keep start                    <3>
>  <3> But you can use "reset --keep" to remove the unwanted commit after
>      you switched to "branch2".
>
> +Reset only files who's content changed (instead of stat information)::

You should use "whose" here instead of "who's".

> ++
> +------------
> +$ git update-index --refresh               <1>
> +$ git reset --hard                         <2>
> +------------
> ++
> +<1> Make Git realize which files actually changed instead of
> +checking out all files whether their content changed or only
> +their mtime changed.
> +<2> Now git reset --hard will checkout only the files that
> +actually changed.
>
>  DISCUSSION
>  ----------
> --
> 1.8.1.msysgit.1
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
