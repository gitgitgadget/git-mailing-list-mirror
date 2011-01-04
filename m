From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: False positives in git diff-index
Date: Tue, 04 Jan 2011 06:08:19 -0800 (PST)
Message-ID: <m339p8dap4.fsf@localhost.localdomain>
References: <AANLkTimLW+J_rmRsqUQJO-9Gzn7aK0ZHkd1-s=Wg4Vbi@mail.gmail.com>
	<AANLkTinDSCPz-oukxzn24hj94d9WpzZ8_64TBHeNTmoG@mail.gmail.com>
	<AANLkTi=Po7zA1YG-VdN6cZEV+ZF3GYNM9W9CLVXFaE5Z@mail.gmail.com>
	<AANLkTinfbyve-k8xBzDb1sTcXhJGvL_B+auuA8BQSUy2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=macintosh
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zenaan Harkness <zen@freedbms.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 15:08:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pa7Yr-00066L-Eo
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 15:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456Ab1ADOIX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jan 2011 09:08:23 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53206 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab1ADOIX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jan 2011 09:08:23 -0500
Received: by wwa36 with SMTP id 36so15195349wwa.1
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 06:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=JMDklE/kirTpZGrqxviJ7q/mDJp+UHDhztdJDuV2Wj4=;
        b=mxZiCd098MZ2azK5E8TCbALxv6cQaiAQ0XAtU1gjbzN4BgHYllwtZJ/dG4NxfCNdCC
         pxsTHvt1KfWSCy7MS4TUGlexbwyYCrTwvYKuNhK6ie2futrPcc9xfxIoclt9b7xefIzL
         pA7HtN+gfn5O3eNORv7KBidSOgSWt64i0JPpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=fEBoAyM4P63wRzi7q/SBlapSaL0ByNsw0jtXvIWz7rhn8FUiYy50+yOLc1HU4jXfVn
         3oxsAMyS6xpV2uUHvZh/bQwKdPrIUSM2LylcaS5P88NZY6nbGcFQfdLiQ3yy43RmCOEu
         iRSJ3NgcaLO0zrj85fnG8ocMTYrRRWVU7HO8A=
Received: by 10.216.188.67 with SMTP id z45mr9021223wem.7.1294150101720;
        Tue, 04 Jan 2011 06:08:21 -0800 (PST)
Received: from localhost.localdomain (abvw52.neoplus.adsl.tpnet.pl [83.8.220.52])
        by mx.google.com with ESMTPS id t5sm10544913wes.33.2011.01.04.06.08.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Jan 2011 06:08:19 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p04E7goF017971;
	Tue, 4 Jan 2011 15:07:52 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p04E7KqD017966;
	Tue, 4 Jan 2011 15:07:20 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTinfbyve-k8xBzDb1sTcXhJGvL_B+auuA8BQSUy2@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164493>

Alexander Gladysh <agladysh@gmail.com> writes:

> On Tue, Jan 4, 2011 at 14:47, Zenaan Harkness <zen@freedbms.net> wrot=
e:
> > On Tue, Jan 4, 2011 at 20:45, Alexander Gladysh <agladysh@gmail.com=
> wrote:

> > > Nobody is interested?
>=20
> > Your problem set appears that you have a rather gnarly corner case
> > issue, arising from your custom build processes. Although git reall=
y
> > is amazing, I believe you may well be pushing git to its technologi=
cal
> > limits.
>=20
> Committing few megabytes of data several times per second is
> technological limits? I do not believe so.

Well, at least it is not what version control system is about; git is
designed towards manual and not automatic commits, and version control
of source code.

> > So your problem could be quite hard to debug, whilst being distinct=
ly
> > difficult to ascertain the root causes.

> 1. I found a reproducible case for a hard to catch bug in Git. (This
> is a bug in Git, not in my build process.) This bug in its
> intermittent form annoyed me for quite some time =D1 several months a=
t
> least =D1 and is likely to annoy other users. (I'm not *that* unique!=
)

But it is reproductible to you: from what I understand you didn't find
some minimal example to reproduce this issue without need for access
your proprietary build process.

AG> Unfortunately I can not share it or create a minimal example ? the
AG> case is triggered by a custom complicated automated build process o=
n a
AG> private repository.

> 3. I'm willing to help Git developers with catching this bug for
> mutual benefit =D1 I will get rid of annoying issue and make my
> deployment code more robust. Git will, well, be a bit more robust as
> well.

To debug it, if you cannot do it yourself, you would have to find git
developer who is both knowledgeable about fairly deep part of git
code, and can work with remote debugging with you at remote.


P.S. Somewhere in the depths of git maling list archive (it didn't
unfortunately made it to "Interfaces, Frontends and tools" page on git
wiki) there is tool/script for anonymizing git repository, to allow
debugging of bugs which occurs in some repositories that cannot be
made public.  Perhaps something similar could be done for your build
process (you need to reproduce only stat + git part)?

--=20
Jakub Narebski
Poland
ShadeHawk on #git
