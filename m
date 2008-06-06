From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Fri, 6 Jun 2008 09:42:58 +0100
Message-ID: <e2b179460806060142y7edc92e4y7cbad6b3cfad1eac@mail.gmail.com>
References: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git mailing list" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	mbp@sourcefrog.net
To: "Cedric Vivier" <cedricv@neonux.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 10:44:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4XY8-00088F-T2
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 10:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688AbYFFInA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 04:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753256AbYFFInA
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 04:43:00 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:23185 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbYFFIm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 04:42:58 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1361920rvb.1
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 01:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kCFCdGjsaLoLTg8pe/OVBf83jaCywCpddaOoXp81vhE=;
        b=sa3oItGZ46/4ld8Q2/7pzf4/LyOCt2XvbOKIcOJklZO22uPqJzZTG2fIm7Enwf/mVL
         zMSXsr2fVMLekNydhyvLDoOjrxs077VDB7dMirGd1PVv5IuIGJ5Z2s0h3bv/t/AtW2xH
         /hWepPz4OyRKBpC0fDre374iDjOH2o9baN4d8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=UduW5ucbJRXs/fzuU4TL+NvBVrXq84AQXJ/HzO4wF3HZ/mGEHwjfgqDuLkFg/psSnd
         ylrZoHL8/pB/08yfOyCLzbpTVOtjaaVPMq7oBiUHf8hiaMMO8oqfjf/cyhyfLzbNMQDs
         HYq8B1jPwGx6v/aloBtTY+2gSqgltjr7L+Eqk=
Received: by 10.141.122.20 with SMTP id z20mr1516180rvm.293.1212741778233;
        Fri, 06 Jun 2008 01:42:58 -0700 (PDT)
Received: by 10.141.19.11 with HTTP; Fri, 6 Jun 2008 01:42:58 -0700 (PDT)
In-Reply-To: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84039>

2008/6/5 Cedric Vivier <cedricv@neonux.com>:
>
> This small patch makes git display list of branches in natural order.
> This way, when you name your branches against, for instance, a bug number from
> some bug-tracking tool, the list will show up in a natural/human/logical order.

[Included as part of patch:]

> +
> +  strnatcmp.c -- Perform 'natural order' comparisons of strings in C.
> +  Copyright (C) 2000, 2004 by Martin Pool <mbp sourcefrog net>
> +
> +  This software is provided 'as-is', without any express or implied
> +  warranty.  In no event will the authors be held liable for any damages
> +  arising from the use of this software.
> +
> +  Permission is granted to anyone to use this software for any purpose,
> +  including commercial applications, and to alter it and redistribute it
> +  freely, subject to the following restrictions:
> +
> +  1. The origin of this software must not be misrepresented; you must not
> +     claim that you wrote the original software. If you use this software
> +     in a product, an acknowledgment in the product documentation would be
> +     appreciated but is not required.
> +  2. Altered source versions must be plainly marked as such, and must not be
> +     misrepresented as being the original software.
> +  3. This notice may not be removed or altered from any source distribution.

2008/6/5 Junio C Hamano <gitster@pobox.com>:
> Perhaps, as long as we somehow mark clearly the new files added with this
> patch as "borrowed code" and not part of git proper...
>...
>
> What the big license notice comment at the top says sounded Ok to me as
> well.

IANAL, but I'm not 100% sure clauses 2a or 3 are strictly GPL
compatible (especially as "altered from" is unlikely to be interpreted
in only one way).

Perhaps we can ask the original author (cc'd) if he is prepared to
license it under GPL2?

I also think the license policy for inclusion in git should be spelt
out in the documentation, i.e. GPL (2+), GPL2 only, GPL2 compatible
etc. SubmittingPatches touches on this area, but only in terms of the
DCoO.  README merely states "Git is an Open Source project covered by
the GNU General Public License."

Some c files state GPL v2 only, others v2 with the "any later version" wording.

I had the same issue when the replacement qsort() implementations came up.

As to the patch, I like the intent, but for consistency should it not
also apply to tags?

Mike
