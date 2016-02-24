From: Stefan Beller <sbeller@google.com>
Subject: Re: Some strange behavior of git
Date: Wed, 24 Feb 2016 14:57:10 -0800
Message-ID: <CAGZ79kYGusB_hF6mgbpC3HAiWUUVOZHnEcS+hJiE1PMaehcw8A@mail.gmail.com>
References: <56CE31F8.7090706@ip-5.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Olga Pshenichnikova <olga@ip-5.ru>
X-From: git-owner@vger.kernel.org Wed Feb 24 23:57:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiMv-0001sP-8a
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 23:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756741AbcBXW5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 17:57:13 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:34437 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043AbcBXW5M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:57:12 -0500
Received: by mail-io0-f169.google.com with SMTP id 9so64249909iom.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=w6nnVXcdlUiv2UYOH+ijRYuaPaXoqhfc+6JrQ7wZwC4=;
        b=kFLy1maxIhc+a0dHqFusKs3MwDatVtEjvCZjSQ7NhGVF4yjV3xXCvyGEEXbxc5zRc6
         0pVcUbgqRxKVt4xxEzpP2xmKaPqcHG9rXKXUDYJd4ct+vCW5ok6l8iBnDGNKk45KxBlL
         EbvNXM2vubjpoZqD0iVd1auVt8Pd/xAwBP7KPq7Zgl85KmMr93c8G3V6j5QiP2vOa/bv
         cNQmjXdWBUDTAu8twSQjFuaOTYg405KA4FganLID/AykHPfB47Jh8gImKy6Mr78j+PCd
         NaM/dCrWsrjPgBk3GfvT6Pghu4vOzelzW8uIxGcflKg3XiXwPkAkKb2gn408db05t0Fd
         q07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=w6nnVXcdlUiv2UYOH+ijRYuaPaXoqhfc+6JrQ7wZwC4=;
        b=EsPFcPLspXLKd58q/g7znPIT/yrfiOxmQcxxUNYUjcYIIOhHrCarv321JXs1qpeSRi
         vQ6IEOA5/K6Gw1iSWhhOUdsd5SqJ58WNhAAxiAV4641omW1qnCcZczt1cWqv6QpdxVTU
         8OD+SXj6nRK1o3M+x9Y6J9h0nOp8sFClj5Cq17k5on/+YqH/rjjXjC4y+0zS8JfSgnD7
         TRgICWU+J0MKyE+IbvA5Ktl+IFcs70UaaKDspsz8V7360K0vYylZq4T/DmX0yV9EkB20
         emU0jSIAK44W+Yr9mshqD4x76Hq1pZTWWqe+43d/MlzbxRR24OPvgRrNU8HA4SjpGazJ
         dG5w==
X-Gm-Message-State: AG10YORvcNZuRFRwdkwHM/HTSTIDpaQZ571Atk/1VHyQgk4jrHSzNL8ejeLcWh6dO+glk99svEY3x8LWynNWZBVu
X-Received: by 10.107.168.149 with SMTP id e21mr80076ioj.96.1456354630438;
 Wed, 24 Feb 2016 14:57:10 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Wed, 24 Feb 2016 14:57:10 -0800 (PST)
In-Reply-To: <56CE31F8.7090706@ip-5.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287241>

On Wed, Feb 24, 2016 at 2:43 PM, Olga Pshenichnikova <olga@ip-5.ru> wrote:
> Hello,
> we use git in our project.
> What can be cause for further confusing behavior?
>
>     git@ip5server:~$ git status
>     On branch master
>     Untracked files:
>       (use "git add <file>..." to include in what will be committed)
>
>         app/addons/arliteks/
>
>     nothing added to commit but untracked files present (use "git add" to
> track)
>     git@ip5server:~$ git clean -dn
>     Would remove app/addons/arliteks/
>     Would remove design/
>     Would remove js/
>     Would remove var/langs/en/
>
> Why I don't see all 4 directories in first command?

Look at the effects of the .gitignore file

https://git-scm.com/docs/gitignore

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
