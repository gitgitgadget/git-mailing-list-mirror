From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Do not install shell libraries executable
Date: Sun, 31 Jan 2010 15:00:52 -0600
Message-ID: <20100131210052.GA4435@progeny.tock>
References: <20100129102518.GA5875@coredump.intra.peff.net>
 <20100129103723.GC6025@coredump.intra.peff.net>
 <20100129145025.GA22703@progeny.tock>
 <7vhbq2g3a9.fsf@alter.siamese.dyndns.org>
 <20100131083459.GA18561@progeny.tock>
 <7vy6jecb0y.fsf@alter.siamese.dyndns.org>
 <20100131200028.GA4045@progeny.tock>
 <7vockaca5w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 22:01:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbgv9-0004qN-3N
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 22:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169Ab0AaVA5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jan 2010 16:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753980Ab0AaVA5
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 16:00:57 -0500
Received: from mail-iw0-f173.google.com ([209.85.223.173]:48949 "EHLO
	mail-iw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148Ab0AaVA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 16:00:56 -0500
Received: by iwn3 with SMTP id 3so3727318iwn.23
        for <git@vger.kernel.org>; Sun, 31 Jan 2010 13:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ASt27lrgvlXm3J3Z3uetjbK+2LkFbAX++bBmBCiYM2Y=;
        b=rGDj2jvqlUz2z+yXmSjUpyzuklKPSPisIYCvXDliyS04aj3jwdLNiiL6nyn+j2HyYR
         yVf9rXKO8OHcXhpFY/TqnLZKqqnYHvTMvnhIEIh3xPEj+LA+SJKKf7SWHeObTQAN8s/j
         trmIGcYchxf4NbVXcYY5Azdtwiug3QDHnJDqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=GKdF8Je9hgayFyDXGlWzQy/KwUJE7lXKw4js8YiWh66ZU34TZjSic+KI8Gpw8Jp0p7
         q8P7yti/NmhllWdcOHiOA4wdXu/m8raRNteGUWZY06YvS28qGJkDAMrQO6dvCqmS57/n
         LF0ZoCs7UmOhR1pnY7FOC9JdrjkDyofJlPI9Q=
Received: by 10.231.170.14 with SMTP id b14mr1617409ibz.26.1264971655633;
        Sun, 31 Jan 2010 13:00:55 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm4720170iwn.3.2010.01.31.13.00.54
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Jan 2010 13:00:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vockaca5w.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138560>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Junio C Hamano wrote:
>>
>>> How much would it hurt the distro packagers, if we don't take this =
patch
>>> before 1.7.0?  If this would help a lot, let's give it a bit higher
>>> priority and make sure 1.7.0 ships with (a corrected version of) it=
;
>>> otherwise I'd say we should not merge this before 1.7.0.
>>
>> Given that Peff=E2=80=99s fix is in, I don=E2=80=99t think it is nee=
ded at all.  So I
>> would say, better to let it wait.
>
> I was referring to this from your original:
>=20
>     It was also confusing dpkg-shlibdeps, so I recently came up with
>     this fix.  Both fixes seem like good changes to me, and both
>     could be applied.  Your fix has the virtue of being shorter,
>     hence safer.
>=20
> Is Jeff's mergetool-lib change enough to address this issue as well?

I just checked; looks like I was confusing a few issues.

 - dpkg-shlibdeps does not like to be fed scripts, period.  That
   has nothing to do with this.

 - debian/rules in the git-core package feeds every file in
   /usr/bin and gitexecdir that doesn=E2=80=99t start with #! to 'strip=
'.
   Jeff's change helps that; my fix has nothing to do with it.

 - some other tool must have been happier with these files not
   being executable, but I cannot reproduce this or find it now.

I wrote that patch late at night, and unfortunately, I cannot justify i=
t
to myself now.  With Jeff=E2=80=99s change applied, there is no obvious=
 breakage
that it fixes.  If a problem comes up again, I will let you know.

Embarrassed,
Jonathan
