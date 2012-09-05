From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Does or could git handle file licensing information?
Date: Wed, 5 Sep 2012 11:17:13 +0200
Message-ID: <CACBZZX5DOgfwot=Murke4i4=QgUPiLJFSOicYRX_DZu1-3-_ZQ@mail.gmail.com>
References: <201209051251.51203.yohann.ferreira@orange.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Yohann Ferreira <yohann.ferreira@orange.fr>
X-From: git-owner@vger.kernel.org Wed Sep 05 11:17:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9Bjy-0007eD-Pv
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 11:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758196Ab2IEJRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 05:17:36 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50865 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623Ab2IEJRf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 05:17:35 -0400
Received: by ieje11 with SMTP id e11so654920iej.19
        for <git@vger.kernel.org>; Wed, 05 Sep 2012 02:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UqnOLIdzYLV4Xvl6Jg6DAMGsvKmAMhmOxR7dZNee9rY=;
        b=o4g+n2yIiZt82bWnmTJKFJmsVFW/FDTvHkfvx1cQMHuTXi+eyWFU3HbrlWF0SNEUHf
         ThgOVs4pNdAL38LjJ66eMEHZ4m8XHteGgf/NnhY4kcQpBCK1hhfzI93vM6GBr3pxfYvR
         20IqGklAGWuMD89K/RB/gZz5xWXeDvvJWbP/ibI6jeiIrYbf3kfhHmlYemNdHVjt0IYK
         7LKsXILbR9kC+m50nEvWLQsLXbZodAGKLvVJ+dHaqAOg0fPj52zNQ2v4iR1yaigD+Mxd
         yMOeYJHFN4+i9UrGh8/sE2GInMG48e//2cAqWRE6WqNOxijvQQV6TiRjgpNn6E/MV1s+
         WigA==
Received: by 10.182.86.200 with SMTP id r8mr5978584obz.98.1346836654141; Wed,
 05 Sep 2012 02:17:34 -0700 (PDT)
Received: by 10.182.48.34 with HTTP; Wed, 5 Sep 2012 02:17:13 -0700 (PDT)
In-Reply-To: <201209051251.51203.yohann.ferreira@orange.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204806>

On Wed, Sep 5, 2012 at 12:51 PM, Yohann Ferreira
<yohann.ferreira@orange.fr> wrote:
> As a day-to-day hard git user ;), I also have to manage files with different
> licenses I need to track.
> As git handles all those files in a very smart way, I wondered whether git
> could also handle that information, at least somehow.

Say you have files like:

    main.c
    imglib.c
    config.c

Why not just have these files:

    license-info/GPL
    license-info/SOME-OTHER-LICENSE

Which would contain, respectively:

    main.c
    config.c

And:

    imglib.c

Then just have a script, maybe add it as a hook on your server before
it accepts a push which ensures that all files currently in the tree
are listed in those license-info/* files.

You could also just add a license header to each of these files, and
have a script that ensures that everything has such a header. I think
the Debian project has such a script that you could adapt.

Git just tracks files, so just do this in some file-based manner and
you'll be fine.
