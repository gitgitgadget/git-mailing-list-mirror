From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/13] Use "git merge" instead of "git pull ."
Date: Sat, 24 Aug 2013 21:19:12 -0700
Message-ID: <20130825041912.GD2882@elie.Belkin>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
 <694030462.1090937.1377329263413.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, wking@tremily.us
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Aug 25 06:19:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDRnQ-0002Sk-RA
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 06:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755679Ab3HYETU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 00:19:20 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35213 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088Ab3HYETU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 00:19:20 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so2145773pab.6
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 21:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/35HtCMYiQPZxwVTEFVV9vAeSuvHIylATGZxYnCxKzo=;
        b=oeeg3TYanm/OcQ3Iy2t+dKeieO3uHzHaTMlhdhYwJk7t6BRPMN569lRECLqCLOy7QD
         0/LT5cMBF8Xnwp72fvIRQF2FnLAi0cCO4apfAoq8PrR+zvP6cA6BENbwZA0zaX5BAMk1
         3QINl8n0rctGyj0udooFEcOTb+AvrOY/sThiLnKco17lo3qFjfFnqVb15O52ACv97RKb
         zhvoz8ngUiSEd3nNl7y9rdo6STcJtD1wIbbPLkLRjnft1xeMtm8d8UaSKflBSasyVhK9
         6E2TWEum8g87A+OQj6a07CkLrshMqtp2meFpi1B2NjNri+62FwpR1VzqZbZ2ccQlDWE0
         jj2Q==
X-Received: by 10.68.211.194 with SMTP id ne2mr8319268pbc.40.1377404359849;
        Sat, 24 Aug 2013 21:19:19 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id py4sm9502230pbb.33.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 21:19:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <694030462.1090937.1377329263413.JavaMail.ngmail@webmail08.arcor-online.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232911>

Thomas Ackermann wrote:
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1784,17 +1784,6 @@ repository that you pulled from.
>  <<fast-forwards,fast-forward>>; instead, your branch will just be
>  updated to point to the latest commit from the upstream branch.)
>  
> -The `git pull` command can also be given `.` as the "remote" repository,
> -in which case it just merges in a branch from the current repository; so
> -the commands
> -
> --------------------------------------------------
> -$ git pull . branch
> -$ git merge branch
> --------------------------------------------------
> -
> -are roughly equivalent.  The former is actually very commonly used.
> -

I wonder if it would make sense to say they simply *are* equivalent.
I.e., what differences are there between those two commands, and could
"git pull" be tweaked to eliminate them?

I agree that the historical "The former is actually very commonly
used" ought to go.  It wouldn't too relevant for someone learning to
use git even if it were still true. ;-)

[...]
> @@ -2259,7 +2248,7 @@ When you are happy with the state of this change, you can pull it into the
>  "test" branch in preparation to make it public:
>  
>  -------------------------------------------------
> -$ git checkout test && git pull . speed-up-spinlocks
> +$ git checkout test && git merge speed-up-spinlocks
>  -------------------------------------------------

Yes.

Hope that helps,
Jonathan
