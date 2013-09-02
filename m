From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 2/4] transport-helper: add no-private-update capability
Date: Mon, 2 Sep 2013 02:28:42 -0500
Message-ID: <CAMP44s0rvsEixDz8v2aqAu2UCfXb8qTFAb+1CpwAyhC-6QONYw@mail.gmail.com>
References: <CAMP44s2aV8X8TJigSqiSPB2HkK7hdxC2dFPWf5X62h90Y7M8Jg@mail.gmail.com>
	<1378106388-27992-1-git-send-email-Matthieu.Moy@imag.fr>
	<1378106388-27992-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Sep 02 09:28:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGOZ7-0004M3-1x
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 09:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757260Ab3IBH2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 03:28:45 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:55909 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646Ab3IBH2o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 03:28:44 -0400
Received: by mail-lb0-f173.google.com with SMTP id o14so3483658lbi.18
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 00:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mAiwj8RTxRk7IA+4U1sdz6x2jNwfexhWMKI6QDVMmnI=;
        b=cu241uiIuONHIGggtRjWpSt31uecDdOaAUhrwAM1aov7cKHgoAbKROh3ZYhy7EmW8+
         ypvxjlynk+mSPEXYBzdWEVQBt1HXcg3r7pqDGdo6qZ5wpRZK/O+r8uXPpR4H5RmBAMxd
         zCro5Judd1I9npPZ4smqIHUuzo1UI8bAeXbEa6A0pgoVivKvMLiaLy/+oOh2Th/MDgak
         2UqJ3usjy4chfc9u4h7cGyy148ZFqi04Zb0DNAsoLRsuiEj/TMQfklFi7SADAwquDqru
         bR/ey0JCgHSa5l2NE7/6ka7fI5J+JHOquQvpN6z9j1olgL5cEhKbXaNv+MfP3tNVN86J
         7FXQ==
X-Received: by 10.112.167.230 with SMTP id zr6mr603827lbb.35.1378106922896;
 Mon, 02 Sep 2013 00:28:42 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Mon, 2 Sep 2013 00:28:42 -0700 (PDT)
In-Reply-To: <1378106388-27992-2-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233627>

On Mon, Sep 2, 2013 at 2:19 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Since 664059fb62 (Felipe Contreras, Apr 17 2013, transport-helper: update
> remote helper namespace), a 'push' operation on a remote helper updates
> the private ref by default. This is often a good thing, but it can also
> be desirable to disable this update to force the next 'pull' to re-import
> the pushed revisions.
>
> Allow remote-helpers to disable the automatic update by introducing a new
> capability.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Acked-by: Felipe Contreras <felipe.contreras@gmail.com>

Or Reviewed-by, or whatever.

> ---
> Change since v1: just changed the capability name.
>
>  Documentation/gitremote-helpers.txt |  6 ++++++
>  git-remote-testgit.sh               |  1 +
>  t/t5801-remote-helpers.sh           | 11 +++++++++++
>  transport-helper.c                  |  7 +++++--
>  4 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
> index 0827f69..1eacf1e 100644
> --- a/Documentation/gitremote-helpers.txt
> +++ b/Documentation/gitremote-helpers.txt
> @@ -120,6 +120,12 @@ connecting (see the 'connect' command under COMMANDS).
>  When choosing between 'push' and 'export', Git prefers 'push'.
>  Other frontends may have some other order of preference.
>
> +'no-private-update'::
> +       When using the 'refspec' capability, git normally updates the
> +       private ref on successful push. This update is disabled when
> +       the remote-helper declares the capability
> +       'no-private-update'.
> +
>

There's an extra unnecessary space here, no?

-- 
Felipe Contreras
