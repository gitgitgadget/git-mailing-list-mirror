From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [RFC] Malicously tampering git metadata?
Date: Thu, 17 Dec 2015 20:06:36 -0500
Message-ID: <20151218010635.GA16508@LykOS>
References: <20151216032639.GA1901@LykOS>
 <CAGZ79kZNim0wp2fYKv2+6t+CaqqzjTThsm_KoAv1D_8OsD0qTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 02:06:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9jVM-0007Qz-6b
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 02:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933549AbbLRBGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 20:06:40 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:32957 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933306AbbLRBGj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 20:06:39 -0500
Received: by mail-qk0-f170.google.com with SMTP id k189so106215424qkc.0
        for <git@vger.kernel.org>; Thu, 17 Dec 2015 17:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to;
        bh=smSDOJpCh2t+Iob1uwzhPUVjhFjioke9LUdJU34Ve3A=;
        b=d1jM6XLJ4lwZ8/fWii+pDhfL3r5xMN59vCDTB1vIPsQKF9z41lqPhobKrFEjF1S1q3
         Mym3djWdzIIhe6T219g3W2WMURnRAxrll1Mz6PoGeW1kkIxj6Aj2nbr/6Ja3HQdY4P1j
         VuTVICl0NzEhD2QkursV/CB5BXMkgyCQ6Mm3N6quNkArIQeUJwT7J1GkOhCnGV67chPC
         rTRvuFhcvWgScbpDaBS9jUeiQz8z5ydnkRMZMB5vFCH8+18dyK4Dx46SLHbLhLt2q/Eh
         TUFdGZfL5AceV87AWosy8AQl4obFt4UBnqB9Crwc/pINIjrR5nUTB4H47rTMzQ5OwqNV
         JQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to;
        bh=smSDOJpCh2t+Iob1uwzhPUVjhFjioke9LUdJU34Ve3A=;
        b=J9X0el7c3LvmjMSx0ddsjNX5CCS75yLDBB4wfZDdGTYipyrPdsJfaZOz+vSlZPMeE0
         hY4IMtPLa0IBuoduIbGhJcAFfQIRPKH+ivcYJioWY3euruK3gP1rUGmsDZsI8ylxE5UR
         VpKx+4OQtXT3qMIhzIBqvpDPThVaLa5BZl6K5e6pgms5MwFKbJp9jSyltIni5lF2xy0V
         19dukAMhlh4n/SNjP0+1nrlWgVxnZjno+ktRquygjsUbpdWHMAdHGaiUzOZiJhFkmkPy
         2OsHkSvUpJnCOSuVFeQWyiDzZW3N7JdkNkzWoKy2MV2cs4t0+5cX+G75dGcnPKrJ7pf5
         6m4w==
X-Gm-Message-State: ALoCoQkv+Hp3BvuJXcgTwpKwyZ5GuyuQ1sb8nDOh8Is7feL7o9p1yIDiq0xagKpGO5OL2I95Rgm6ZPHXlrwXbP1iGkBvogcQKQ==
X-Received: by 10.55.73.69 with SMTP id w66mr1134186qka.39.1450400798852;
        Thu, 17 Dec 2015 17:06:38 -0800 (PST)
Received: from LykOS (NYUFWA-WLESSAUTHCLIENTS-13.NATPOOL.NYU.EDU. [216.165.95.2])
        by smtp.gmail.com with ESMTPSA id e184sm5802493qkb.40.2015.12.17.17.06.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Dec 2015 17:06:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79kZNim0wp2fYKv2+6t+CaqqzjTThsm_KoAv1D_8OsD0qTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282690>

Hi Stefan, thanks for the insight. 

> This is what push certificates ought to solve.
> The server records all pushes and its signed certificates of pushes
> and by the difference of the
> refs (either in packed refs or as a loose ref) to the push certificate
> this tampering of
> the server can be detected.

Is there any specification about push certificates? I would like to read
about them, but I don't seem to find documentation anywhere. Are they a
part of git's specification?

> 
> The push certs can however not be obtained via Git itself (they are
> just stored on the
> server for now for later inspection or similar), because to be really
> sure the client would
> need to learn about these push certificates out of band.

I was thinking that an in-band solution could be integrated as long as
we assume a compromise would result in an complete (unreconcilable)
fork attack; fork attacks aren't subtle and could be detected easily.

> 
> The model there would be:
> * A vulnerable piece of software exists.
> * It get's fixed (and the fix is pushed with a signed push)
> * the MITM server doesn't show the fix (show the code from before fix) nor
>   the push certificate thereof
> * client still pulls vulnerable code

Yes, this is a possible attack vector. However, a server could also
present a branch pointer as different (e.g., point an experimental
branch to an unsigned v1.1 tag). This has other implications, as the
code is pushed/pulled from upstream, it just goes somewhere different.

> 
> This model shows the distribution of push certs via the server itself may not be
> optimal.

Yes, it might not be optimal, but it could provide protection against
the attack I just described, for more complex attacks might not be so
subtle. Adding to this, developers likely coordinate their efforts
through other means (sic), so the lack of a push certificate (withheld
by a server) could raise some yellow flags.

We've made a proof of concept of such tool (in-bandh push certificates),
and would like to share the basic design of it here. However, it follows
our threat model: a compromised server that can't introduce malicious
code (thanks to commit signing), but can modify branch pointers and
other unsigned metadata to alter the repository's state.

> 
> Thanks for researching on Git,

Thanks for working in such a great tool :)
-Santiago

> Stefan
