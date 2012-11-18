From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: Motd message on git cloning
Date: Sun, 18 Nov 2012 11:34:31 -0500
Message-ID: <CAM9Z-nkxLqrS5i6Ycz02Amit5itmGJojy=e8+SG9LQYcBHJVxQ@mail.gmail.com>
References: <CANCidP-d0tXfo6ZsC80LmaS1CJ475rew2D7ztrx9TkNa94a-uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Adam Stankiewicz <sheerun@sher.pl>
X-From: git-owner@vger.kernel.org Sun Nov 18 17:35:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta7qJ-0003hn-Vi
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 17:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445Ab2KRQee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 11:34:34 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61793 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383Ab2KRQed (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 11:34:33 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1637507bkw.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 08:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7950bVTPXjkvJ6TbHe3DSMpHlJ/WBdgTOq+8AM65erY=;
        b=NJ0TbfNMRXcyEteI1um65jH8QUUD5qzAxE4R5QPDieITw8h2Vvizzuh2rZ6o23AtQn
         ZNkby7pC1Yf4aNZQ7YkYjBMBQ4OqQHn/VqVTaW1r91UcT+hL4mKdmlwUuDzhV/cGIJyw
         Z3mif78+xPMhleD/ilJXcF9YPb/PG42qQfUvptEGFjZeMmj18W7u2x0oIofWoFKKAXDN
         +bpm4quKaXVzOsYXANt0uOLE8cfUlb0Vq4JCagZR398vntyiNC/zG1FJISwlVidyFAAg
         XC/MkNCwfI0Oo9LrEe4HhE65QaPk3ktEjVl5CIAe4JsrCCdFbVMyp7jJFLYMK6RHyfdb
         F3KA==
Received: by 10.204.152.28 with SMTP id e28mr4115633bkw.3.1353256471867; Sun,
 18 Nov 2012 08:34:31 -0800 (PST)
Received: by 10.205.122.144 with HTTP; Sun, 18 Nov 2012 08:34:31 -0800 (PST)
In-Reply-To: <CANCidP-d0tXfo6ZsC80LmaS1CJ475rew2D7ztrx9TkNa94a-uw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210029>

On Sun, Nov 18, 2012 at 11:04 AM, Adam Stankiewicz <sheerun@sher.pl> wrote:
> I'm dreaming about git feature that shows custom message on git clone.
> It would be extremely helpful for informing the person cloning about
> init scripts he/she need to execute (for example submodule inits or
> hooks set up). For now there is no way to make sure cloning person
> will receive such message (unless he/she will read the README).

So we should clog up the output (which may contain important error
messages) just to protect the user from themselves?

> The server does not need to know if it's fetch or clone, if programmer
> executes git clone on client side, then the MOTD message would be
> shown.
>
> I think good candidate for MOTD message is .git/description (because
> for now no one seems to care about setting repository description).
> Another option is to introduce .git/motd file that would consist of
> some maximum number of non-control ASCII characters.
>
> I don't really see any security concerns. Git could filter any control
> characters from MOTD out, and automation script could add --no-motd
> flag. The could also be limit on MOTD file size so no one could
> "flood" the terminal window with MOTD messages.

While I think that it is helpful and sometimes important to set the
description (especially for public repositories) I suspect that if
somebody is cloning it then they already have a good chance of knowing
what _should_ be in that file. This isn't a text-interactive session
on an FTP server of yore.

> Also it's important to me that such message would be shown
> automatically by default and could be turned off, not the other way
> (for example --motd flag).

Ummm....NO. I cannot see this being an improvement for enough users to
justify the extra noise.

Granted, I am not the definitive word on much of anything around here,
but I cannot see this making much sense in the big picture of things.
If you wanted to make this change to something more like Google's
"repo" wrapper script that would make at least some modicum of sense
to me.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
