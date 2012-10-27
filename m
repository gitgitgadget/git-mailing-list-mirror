From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: git config error message
Date: Sat, 27 Oct 2012 12:36:36 +0200
Message-ID: <CAB9Jk9COSZOske5xzgnE=1oHe7qiwwOzHYE6pJkuZ0sZyZYhng@mail.gmail.com>
References: <CAB9Jk9AQkSiv=F8NeYs+uspR5f4CeJS5L-hwZUXdq7dts1W5ng@mail.gmail.com>
	<m2bofo9v93.fsf@linux-m68k.org>
	<CAB9Jk9CONVSZvBUgnZHiniwPHHvcap8Wyjyw-sCHaSokDoNRWA@mail.gmail.com>
	<CAP30j15pUwX9sD3FXAfroxFK9paHmb1eAg+M5YAHT4aB22DBEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andreas Schwab <schwab@linux-m68k.org>, git <git@vger.kernel.org>
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 12:36:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TS3l4-00046J-TI
	for gcvg-git-2@plane.gmane.org; Sat, 27 Oct 2012 12:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475Ab2J0Kgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 06:36:38 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:63462 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab2J0Kgh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 06:36:37 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1678191dak.19
        for <git@vger.kernel.org>; Sat, 27 Oct 2012 03:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Wce4SWv+4PPSJXrihEdpJLo8Yn+1gDB64keSfnURgs4=;
        b=Q3gyWkP3f/n/pGD2Q6OM3jAAibdUD+5aeu09Qq7nJdZeRvvkDUVDbz0p/gJqChnj6y
         0yg1G3gDY835bMrc0SYUk+07kDi49ajORuU90AjHHy0sLdvi8fvlqhbYPoJ5+YW0zpbm
         7D+mSI79fJ26VaPO4y6pHmZn98bTko2p67AfaLV11v4vyxewedaUUXGfTGECn2Sa8r71
         KF2Yj+M2UmitOmUhnskxY3EbdVDcdb5EvpQpJ1zQsB3dCB6y8AfTQCVttuSLcjYZbQhY
         5AZ5kA06URwfFu/jfDOExyVKRxxmN6kEPZWjhO3MspO7B52JH14EO9DC58hTtEx3AVzU
         rTxA==
Received: by 10.66.87.163 with SMTP id az3mr68865773pab.62.1351334196943; Sat,
 27 Oct 2012 03:36:36 -0700 (PDT)
Received: by 10.67.3.101 with HTTP; Sat, 27 Oct 2012 03:36:36 -0700 (PDT)
In-Reply-To: <CAP30j15pUwX9sD3FXAfroxFK9paHmb1eAg+M5YAHT4aB22DBEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208504>

Hi Ben

> This still wouldn't be an error condition though, especially in terms
> of how "git config" should treat it.

The man page says:

   "This command will fail with non-zero status upon error."

Of course, one might claim that this does not mean the truth of the
reverse condition, i.e. that when the command returns 1 that is
necessarily an error, but I would leave that avenue of thinking to
philosophers. Besides that, it is common practice in *nix OSs to
consider a return != 0 as an error.

> It should be up to the consumer
> of the information to display, or not, any error or diagnostics that
> don't result from either a bad request (your first case) or a
> malformed configuration file.  This fits with the callback nature of
> how the config file is parsed by builtin tools.  The exit code from
> "git config" with a missing key is enough for the consumer to make
> this decision.
>

A well-behaved, user-friendly program, when detects an error tells the
user what went wrong.
How can otherwise the user tell a corrupted configuration file from a
missing key?

Of course, is is possible to provide a git-config that simply returns
0 when it has got the key and 1 when it does not, without issuing any
error message, but the current one is not like that, it is a middle
way solution.

-Angelo
