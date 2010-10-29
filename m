From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Bugs in Gitosis
Date: Fri, 29 Oct 2010 16:22:58 +0530
Message-ID: <AANLkTi=a=oD=8jNQmmWA_gYTjnOQKJUM=w8uVdx+N43u@mail.gmail.com>
References: <AANLkTinzLL-Sk1cMd_3WNogmgvr=x4gEh7LuS8guNYgB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"Olsen, Alan R" <alan.r.olsen@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 29 12:53:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBma2-0006e7-4Q
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 12:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761125Ab0J2KxB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 06:53:01 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42903 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761246Ab0J2Kw7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Oct 2010 06:52:59 -0400
Received: by gwj21 with SMTP id 21so1852919gwj.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 03:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NIKuzljNbGXcQgqcfkvJILPGdmnuorojhlk5G87LJxY=;
        b=rHEA/+df0+G6Cr1gaequXwbzBwovXWbZO8lvN3DunqWcn03vmqFk9TXJ36evDeO4sM
         2DL2QLVBAzOb0XrCRY5fjLNxffXVB2CjBMRgdPYbjtwKnLmw9GBZ9q1tvEhbLBYSzmhZ
         3O/nG6Crgqb5qFn0+7EllM4K6GVafgSIYRW+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JUFoZ+9OwNC+VUZ5JJfzL3pN+ocra3g2J8ZsV/sJHWUQOt9/7XlRh8NwTXWC4Wh+te
         QkmX4Li+GgLegNysmcjA6kX01P7CICb8F6aYuAS8KAaYivOK3M6bPTQDpPSq0ySsRllA
         sstCUddfYB9dEwMsTVZiKHM1VCf/WgLKaYtmQ=
Received: by 10.90.3.39 with SMTP id 39mr4306788agc.131.1288349578989; Fri, 29
 Oct 2010 03:52:58 -0700 (PDT)
Received: by 10.90.70.7 with HTTP; Fri, 29 Oct 2010 03:52:58 -0700 (PDT)
In-Reply-To: <AANLkTinzLL-Sk1cMd_3WNogmgvr=x4gEh7LuS8guNYgB@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160327>

Hi Shawn,

On Fri, Oct 29, 2010 at 7:36 AM, Shawn Pearce <spearce@spearce.org> wro=
te:
> On Oct 28, 2010 5:02 PM, "Sitaram Chamarty" <sitaramc@gmail.com> wrot=
e:

>> can do. =C2=A0See
>> http://github.com/sitaramc/gitolite/blob/pu/contrib/gerrit.mkd
>> for a comparision
>
> There are a few inaccuracies in that document that I would like to co=
rrect.

well, updates I guess; I did update one part of it based on our IRC
conv, but if there's more I'll put those in too.

> For starters we now support regex patterns in branch access control r=
ules.

ok; will update.

> We also now allow $(username) in a pattern to mean the current user a=
nd thus
> permit per-developer branches.

Right; gitolite uses /USER/; it's only a syntax difference but I'll
mention it somewhere.

> We don't allow per-user access rules because in the corporate world i=
ts
> usually a bad idea to have only one user with a particular set of
> permissions. What happens when the user leaves the project or is hit =
by a
> bus? Of course this also applies to most open projects too... :-)

You do the same thing in either case, no?  Take out the old guy's name
from somewhere, put in the new guy's name?

But yeah, I'll amend this to say this is a subjective opinion :-)

> We also allow importing a user's groups from an organization's LDAP s=
erver.
> This can be useful when there are thousands of users on a single serv=
er and
> the org wants to continue using their existing access controls.

Except in gitolite it's not an import; it's more like "give me a
program that, given a userid, returns a list of groups he belongs to"
and gitolite calls that if it's specified.

> But after that, yes, that document is a good summary of the features =
that
> both tools offer... and I know many companies really do salivate over=
 the
> branch level read access rules. It is difficult to do for Git, but it=
 also
> can be useful to have everything in a single location.

Probably.  But where that restriction exists, I may have to show the
auditors that the restriction holds, and that's a lot easier to do
when they're in separate repos to begin with.

--=20
Sitaram
