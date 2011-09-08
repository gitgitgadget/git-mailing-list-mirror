From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] send-mail: Add option to sleep between sending each email.
Date: Thu, 8 Sep 2011 14:58:56 +0530
Message-ID: <CALkWK0nuLHpG9xqAAVL4T21N-31m7=A3_amp7Mf0Sw9jobYDRg@mail.gmail.com>
References: <1315428191-9769-1-git-send-email-gf@unixsol.org>
 <CALkWK0kH+pD6ymtt9oWLhT0Bftp4EvtrwTtNVw6mjX0aObb-BQ@mail.gmail.com> <vpq7h5jtngj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Georgi Chorbadzhiyski <gf@unixsol.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 08 11:29:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1avD-0006ny-0W
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 11:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531Ab1IHJ3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 05:29:18 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43741 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932511Ab1IHJ3R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 05:29:17 -0400
Received: by wyh22 with SMTP id 22so456149wyh.19
        for <git@vger.kernel.org>; Thu, 08 Sep 2011 02:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nrAm9gInfgjBNo38enNaTbb0iw9iceoZsUudWn4in64=;
        b=akNFglPA0HllQ1RqXjOu4Z3KdKqpxA6h+B1zyanQ9+6U4c95MRLoiSejE4qlORYGL2
         mDuyjMbstBv/pKD4dFXZpfEEw7aQcq5mJRmYivgNc29z5Oq99VByRwJSjdnkOYV5Zf1+
         y0W44P0wCl+ZPei9+lH9s+RhO8vGpSmZkBAOg=
Received: by 10.216.167.5 with SMTP id h5mr469942wel.96.1315474156168; Thu, 08
 Sep 2011 02:29:16 -0700 (PDT)
Received: by 10.216.51.135 with HTTP; Thu, 8 Sep 2011 02:28:56 -0700 (PDT)
In-Reply-To: <vpq7h5jtngj.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180958>

Hi Matthieu and Georgi,

Matthieu Moy writes:
> There have been discussion (and IIRC a patch) proposing this already in
> the past. One advantage of sleeping a bit between each email is that it
> increase the chances for the receiver to receive the emails in the right
> order.

Ah, it looks like I missed the earlier discussion/ patch- sorry.  Yes,
I've also wondered what to do about the order in which patches appear
in reply to the cover letter- I was of the opinion that it was a minor
inconvenience that we have to put up with that until SMTP servers
learn to fix these things.  Slowing things down a little bit for now
until they catch up is probably a good idea.

Georgi Chorbadzhiyski writes:
> See for example this: http://mailman.videolan.org/pipermail/dvblast-devel/2011-August/thread.html
> The thread named: [dvblast-devel] [PATCH 0/4] Post git migration changes
> See how 1,3,4/4 are not detected to be part of the thread even when
> all headers are set correctly by git-send-email.

This is a far more serious problem.  For this, I was toying with the
idea of special cover-letter handling in git-send-email.  My idea was
that it should essentially send the cover letter, wait for a second
and then send all the other emails concurrently.  Sure, slowing the
entire process down would work too, but it's not so elegant.

Thanks.

-- Ram
