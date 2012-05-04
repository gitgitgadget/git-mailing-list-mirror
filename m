From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Newbie grief
Date: Fri, 4 May 2012 22:03:18 +0200
Message-ID: <CAMP44s2w9B0Jvcn44R5_-ptC=x+5=OgGF0n0SkH+t0JjomXsGA@mail.gmail.com>
References: <4F9F128C.5020304@palm.com>
	<201204302331.q3UNVo7o032303@no.baka.org>
	<4F9F28F5.2020403@palm.com>
	<201205010137.q411bxaU002449@no.baka.org>
	<4F9F52B9.9060508@palm.com>
	<08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>
	<4FA2D8EA.7030809@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>,
	Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Fri May 04 22:03:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQOir-0002s3-4P
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 22:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739Ab2EDUDU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 16:03:20 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:39631 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334Ab2EDUDU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2012 16:03:20 -0400
Received: by werb10 with SMTP id b10so144765wer.19
        for <git@vger.kernel.org>; Fri, 04 May 2012 13:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=CAmAKmlTs0raRORnvQvshTBMVbGCs5TmEzLDkBgsjKI=;
        b=kLaAJTC59KycIHD1h9RO8BmjgqYQEkYI/rKVeEuIa3COEpKuJUdrbBl4q9Xabk0Pps
         LWzhnsPtTecoalu9gigL9vpENU9B6ckIo4VgyGiR3qbUDnQ3mL+38wW8EmxtpSyrEe1w
         ZOY3QQyXSx7V1fKxOHS2dSTiSNBCwFNjgiD8Dy97Ftm0A5eqzFJFHDMmEbayT9wnYAfW
         MWWkenyAl7WaDJ2+W+rSY/5ppLtUuZ0tIfo0IcUe/mGKAvqIfurPsblj+KZFFOQhcNuV
         7WixyDhi/QF5vXzK7z39ADs7UnGMJ/h3SYlUWWjaSj255L2HXa8zdDs+X5XBnpkyB3F6
         AEGw==
Received: by 10.180.24.66 with SMTP id s2mr6215385wif.7.1336161798890; Fri, 04
 May 2012 13:03:18 -0700 (PDT)
Received: by 10.216.124.197 with HTTP; Fri, 4 May 2012 13:03:18 -0700 (PDT)
In-Reply-To: <4FA2D8EA.7030809@palm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197071>

On Thu, May 3, 2012 at 9:13 PM, Rich Pixley <rich.pixley@palm.com> wrot=
e:

> This is probably what I'm going to end up using.
>
> Just for comparison, here's a similar process in hg.
>
> Cache server:
>
> =C2=A0$ hg clone $uri_for_central_repo

% git clone $uri_for_central_repo

> Machine A:
>
> =C2=A0$ hg clone $uri_for_cache_repo

% git clone $uri_for_cache_repo

> =C2=A0$ # ...do some work...
> =C2=A0$ hg push

% git push

> Machine B:
>
> =C2=A0$ hg clone $uri_for_cache_repo

% git clone $uri_for_cache_repo

> =C2=A0$ # ...do some work...
> =C2=A0$ hg push # assume this collides

% git push

> =C2=A0pushing to $uri_for_cache_repo
> =C2=A0searching for changes
> =C2=A0abort: push creates new remote head 6d2eb0a6a278!
> =C2=A0(you should pull and merge or use push -f to force)
> =C2=A0$ hg push -f # the pull and merge case parallels git, so let's =
use push -f.

This is stupid, why make everybody else's life difficult? Let's merge h=
ere.

% git pull
% git push

> Any repo:
>
> =C2=A0$ hg pull # pulls in all changes including the dual heads

% git pull

> =C2=A0$ hg merge # collapses the dual heads
> =C2=A0$ hg commit # commits the merge
> =C2=A0$ hg push

No need for this, the guy that diverged did this (Machine B).

Plus, what happens if 3 other machines do this? You you have 3 merges,
2 would conflict, and then you would have useless recursive merges, or
some people would have to revert. Why bother N people, when one guy
can do it at the origin (Machine B)?

> Machine A:
>
> =C2=A0$ hg pull # pulls in all changes so far
> =C2=A0$ hg up

% git pull

> =C2=A0$ #... do some work ...
> =C2=A0$ hg push

% git push

> Machine B
>
> =C2=A0$ hg pull
> =C2=A0$ hg up

% git pull

> =C2=A0$ # ... do some work ...
> =C2=A0$ hg push

% git push

> Any repo:
>
> =C2=A0$ hg pull $uri_to_central_repo
> =C2=A0$ hg merge

% git pull $uri_to_central_repo

> =C2=A0$ hg push $uri_to_central_repo

% git push $uri_to_central_repo

> =C2=A0$ hg push # default is cache repo

% git push

> Machine B:
>
> =C2=A0$ hg pull

% git pull

> Some Conclusions:
>
> * the work flows are similar.
>
> * the hg commands are simpler and have the defaults that we want, pri=
marily
> because no extra branches are required.

Wrong.

> * the hg error messages are straightforward, clear, and don't require=
 any
> deep knowledge of the source code control system or it's limitations.=
 =C2=A0(I
> still don't understand what the git message on collision is saying.)

Whatever. I don't care what the error message for a merge conflict
actually says, all I need to know is that there was a conflict.

> * hg has more options about how to handle the collisions or the merge=
s.
> =C2=A0While git can mimic some of those options, doing so requires a =
priori
> knowledge that isn't stored in the source code control system and the=
refor
> requires a human exchange which is optional with hg.

WTF? git handles collisions just fine.

Actually the git version has less commands. And if configured properly
you don't need to specify URLs.

Cheers.

--=20
=46elipe Contreras
