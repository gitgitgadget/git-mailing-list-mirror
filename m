From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Ubuntu may break Git upstream translations
Date: Tue, 10 Dec 2013 21:39:01 +0800
Message-ID: <CANYiYbHgY298yKdfQOB7wDo-U-E1MuywCJ1T2B3fvdMeyFuLsw@mail.gmail.com>
References: <CANYiYbF--_51hJmp=28ucwBa6YEuUn97kTAd87POuqrD4SU5gw@mail.gmail.com>
	<CAA0ZMxhYounVC0_mpMmty=wbh5fPmG0+=da9pQQ9i0UnciRY8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?David_Rodr=EDguez_de_Dios?= 
	<deivid.rodriguez@gmail.com>, Git List <git@vger.kernel.org>,
	Paco Molinero <paco@byasl.com>
To: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 14:39:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqNWn-0007aj-7O
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 14:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571Ab3LJNjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 08:39:04 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:55584 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454Ab3LJNjC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 08:39:02 -0500
Received: by mail-wg0-f44.google.com with SMTP id a1so4834089wgh.11
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 05:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6gYUF8rceOq0x1N+0xgnmpF1KuvV+6ulnLeD5/IcweM=;
        b=s0JQ2K8d+t3yQW23WDd29iX7zHdCw8ycMR3QGufwffkyfy9oFxbuJLx8+bwBfeQ96Q
         V5V7zBPrZ4TwlrBPgQ3c9syHrZzAGStJS9mP0XgzmC7FwLGOXoud8E4dyhfWpfM1tQ7u
         YgvIs1uSopnUktFuJ70ZkxyUw2EvYRurQAEg0tKeWt8Mk6leWKwPc0aow0aTOmgL74uG
         jRz+C8p9i69IOWPmapPWeZ8Km04NBMoggH7l5+dsJ/Im051c8+GUeUHC5Z723mQ6XKAq
         A042LNPKh+s13UKJfbN+TK6GAsubEeJhMhmzBpdLNTHFdYeQL4DMKEdhbhHi7Uf4VkAS
         Nkfw==
X-Received: by 10.180.14.195 with SMTP id r3mr19302138wic.51.1386682741085;
 Tue, 10 Dec 2013 05:39:01 -0800 (PST)
Received: by 10.216.213.207 with HTTP; Tue, 10 Dec 2013 05:39:01 -0800 (PST)
In-Reply-To: <CAA0ZMxhYounVC0_mpMmty=wbh5fPmG0+=da9pQQ9i0UnciRY8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239137>

2013/12/10 Dimitri John Ledkov <dimitri.ledkov@canonical.com>:
> Hello all,
>
> Ubuntu is a distribution which does have a wide variety of users.
> Typically users use stable releases, or even LTS releases (every 2
> years). Given different schedules across all projects, naturally
> Ubuntu ships a snapshots across all packages available at the time. On
> the other hand our users and translators expect to be able
> continuously improve & provide translations across a wide snapshot of
> packages. Therefore in the beginning of the Ubuntu project
> translations from all core packages (those that are in the "main"
> portion of the archive) were imported into the launchpad translation
> component. Ubuntu translation teams can update translations using the
> web interface, contributing from one string or all of them. All new
> translations done in launchpad, are done under permissive BSD license
> and are shared across the infrastructure, such that translators get
> helpful suggestions and don't have translate the same term over again
> (and/or different from how it's used across the operating system).
> These translations do not require one to know version control systems,
> upstream, mailing lists. But those translation updates are pushed out
> automatically to the users at point releases (or more often, if
> manually triggered). You can see the translation statistics for Ubuntu
> 12.04 LTS at [1]
>
> All of these translations are done in good faith. Or at times by
> frustrated users that cannot see something in their own language and
> can't take for an answer "contribute upstream, wait for new release,
> wait for that to be packaged & upgrade to new release to get them".
>

Thank you for the quick response. I understand that

1. release of l10n things in separate package will help Ubuntu to
    improve l10n continuously, without recompiling the whole
    package (Git or others). This may save bandwidth when user
    upgrade.

2. bundle l10n things of hundreds of packages for one specific
    language in one package, will save disk usages a bit for users.
    Because user will only install the prefer language, won't
    install l10n things for other languages.

That's OK.

> Naturally, maintenance cost of translations downstream is significant.
> And where possible we do try to redirect translators upstream. E.g.
> there are good translators links / cooperation to Debian (package
> descriptions, debconf question templates), d-i, GNOME, etc.
>
> In an ideal world there would be enough community developer to manual
> handle all new translations and redirect / introduce them to
> upstreams. Unfortunately that is not the case. And on behalf of the
> Ubuntu project, I do apologize for any inconvenience caused. But
> please do, try to understand the distribution perspective on the
> overall problem with localisation and internationalization.
>

What makes Debian/Ubuntu outstanding? I believe it is the apt
package management system. It's easy to write a debian package,
and quilt patches are upstream-friendly. I mean using quilt
commands (such quilt push, quilt pop, quilt refresh,...), patches
can upgrade to the new upstream easily.

But Ubuntu l10n things are not upstream friendly, substitute
upstream l10n things instead of patching. The word patching
here, not means using quilt patches. Since Ubuntu has a
large database full of break down msg-ids, and each break
down msg-id has its upstream translation and Ubuntu translation,
your Ubuntu guys can invent your own patching system.
E.g. Generate your new custom ".po" file based on a fresh
upstream template using 3-way merge (prefer upstream
change), and then substitute upstream with yours.


-- 
Jiang Xin
