From: Hin-Tak Leung <hintak.leung@gmail.com>
Subject: Re: git-svn dcommit losing/detaching head when commit message empty
Date: Thu, 24 Feb 2011 02:37:17 +0000
Message-ID: <AANLkTi=Dk4VDkzE=j=CCbkb6dUAQRKHT9xT6Oefn+Ujd@mail.gmail.com>
References: <AANLkTi=A-UG2aOcwwNbjoBK4pYDtKp=0nFmcwrgVv0f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 03:37:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsR57-0004ur-4S
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 03:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775Ab1BXChT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 21:37:19 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:50678 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088Ab1BXChS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 21:37:18 -0500
Received: by yib19 with SMTP id 19so53828yib.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 18:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=loukd3RuJtXjYktqI9tjLRXAWMZzEcYc4EeaIB06G4E=;
        b=jh//t+pRGKAyRANt4onI1PFsUfwSVXBXe0h9IXkTlP7uUlCBkfw+ZcDdsKYHJDRYY2
         6pYWVh++ILSb3NVbeHK6XwbFfvDrz+HHyWDmHgksDTbPfKb3WO+4txWk52bFWlCAiPqe
         YVNY1T+L837y8/Ml8+u50EfyqnBT+d3rgnYjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=wlYEO41VhGYAd9qKwTtvyQ0okBzbiN/d5/6IzHr6RoHCAPg/UTjK4yEiZoqXNTKAvq
         STXCRndmZNlSuC1AS0e6p8vti1eBuUwuhhUSVmCsjCJtltL3ztRwX7/4H5Kg7kfROmFW
         Y1JHgKAOd+RQvvxAaSlsTk7IiS0udOfBdTMrc=
Received: by 10.147.67.25 with SMTP id u25mr458540yak.31.1298515037953; Wed,
 23 Feb 2011 18:37:17 -0800 (PST)
Received: by 10.146.187.22 with HTTP; Wed, 23 Feb 2011 18:37:17 -0800 (PST)
In-Reply-To: <AANLkTi=A-UG2aOcwwNbjoBK4pYDtKp=0nFmcwrgVv0f8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167768>

On Thu, Feb 24, 2011 at 1:27 AM, Hin-Tak Leung <hintak.leung@gmail.com> wrote:
...
> After I fixed that and continue as I intended, then there is another
> bomb-out, when git-svn complains about a git commit message of mine
> (with minor edit):
> -------------
> Running
> perl -pi -e 's(sometag="original")(sometag="replacement")' directory/*
> -------------
> being empty. On hind-sight, it is probably not a good idea to have
> perl regular expression code within a commit message (git-svn itself
> being in perl), but complaining about a non-empty commit message (and
> seem to be a valid one, no strange utf8/chinese characters, etc) being
> empty seems to be a bug.

Just adding to this part: it appears that git-svn doesn't like the
first-line of the commit message being just one word (in this case,
"Running"). I have just done one where the commit message was a single
word "renaming" (it would be obvious which file I was renaming, so I
thought there is no need to say more), which also caused git-svn
dcommit to complain about it being empty.

Many thanks for git-svn - as I wrote below, I wouldn't use anything
else these days.

> Hope this helps. BTW, git-svn is a great tool, and thanks a lot for
> that - I wouldn't use anything else (including the "authentic" svn
> client) to interact with svn repositories these days.
>
> Hin-Tak
>
