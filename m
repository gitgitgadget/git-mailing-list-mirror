From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Mon, 02 Aug 2010 14:48:32 -0700 (PDT)
Message-ID: <m3hbjcptyr.fsf@localhost.localdomain>
References: <i372v0$3np$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Joel C. Salomon" <joelcsalomon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 23:48:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og2sC-0006kd-Od
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 23:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527Ab0HBVsf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 17:48:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59221 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab0HBVse convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 17:48:34 -0400
Received: by fxm14 with SMTP id 14so1806942fxm.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 14:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=u1lSFXsQuu6NIz7L2aFG6hFhO2ZnJepEnK4EwlGxPjk=;
        b=XbP77UNuDowdzdLtQgXQsLkToApYU/hV7fsiOr6lWANkDVwZZeHnB1NHIiIhRisgVr
         0m3E/ZD2p/KGGrkRvErFAFJiPLIhfBViLeaWLwQcLyY4oqVMRyiDndE+oxsv+MaHoHYL
         1JYuVJslPFcPu6YqvQd7T254hmF2GmPftnzFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=UuGmP/gZAqz/w2cKdWGjRa01MR11cTZiG6SRGE/CgE7ZI3MlmOUfTOL7x/DXyOGMiS
         pDBlL53h77rq7q2LgZQVKH1+29GXa748bgbwFxU1FNdw5XfSK380s5a7gkpUj/GnxxUG
         8mNu0U/RIq61rVJ34KXo7ayzcd/fVYpwU4Zck=
Received: by 10.223.106.202 with SMTP id y10mr6518455fao.2.1280785713414;
        Mon, 02 Aug 2010 14:48:33 -0700 (PDT)
Received: from localhost.localdomain (abws244.neoplus.adsl.tpnet.pl [83.8.242.244])
        by mx.google.com with ESMTPS id q17sm2196957faa.45.2010.08.02.14.48.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Aug 2010 14:48:32 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o72Lm8Jw021549;
	Mon, 2 Aug 2010 23:48:18 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o72Llv5d021542;
	Mon, 2 Aug 2010 23:47:57 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <i372v0$3np$1@dough.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152466>

"Joel C. Salomon" <joelcsalomon@gmail.com> writes:

> I'd figured to play with Git in an unusual way: to create a repositor=
y
> for the U.S. Constitution where amendments are presented as patches.
> E.g., instead of the First Amendment being placed at the end (as is
> usual) I'm putting it in Article 1, Section 9 (Limitations of Congres=
s).
>  Proposed amendments get branches, which get merged in later.
>=20
> But I'm trying to get the dates right, and I'm missing something.  Fo=
r
> example, I made the initial commit with the line
>=20
> 	$ git commit --author=3D"The Philadelphia Convention <>" \
> 	 --date=3D"Mon, 17 Sep 1787 12:00:00 EST"
>=20
> but that's not actually setting the commit date to 1787.
>=20
> Am I doing something wrong, or is Git (quite reasonably) unable to
> accept commit dates that far in the past?

Git encodes author and commit (and tagger) time using Unix epoch
(POSIX epoch) plus timezone.  As Shawn and =C6var wrote on 32-bit
systems time_t can cover a range of about 136 years in total around
January 1, 1970, which means that the maximum representable time on
32-bit system is 2038-01-19 (the year 2038 problem), but what is more
important to you is that minimum representable time is 1901-12-13.
1787 is too old for 32-bit time_t.

The headers inside commit (and tag) objects are stored in text form,
so they are not limited to 32-bit value.  You would have to use system
that has 64-bit time_t, or patch git.

64-bit time_t would be enough for everyone (sic!).

References:
-----------
http://en.wikipedia.org/wiki/Unix_epoch
--=20
Jakub Narebski
Poland
ShadeHawk on #git
