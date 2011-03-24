From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/1] gitweb: javascript ability to adjust time based on timezone
Date: Thu, 24 Mar 2011 21:19:30 +0100
Message-ID: <201103242119.40214.jnareb@gmail.com>
References: <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost> <1300925335-3212-2-git-send-email-warthog9@eaglescrag.net> <AANLkTincAcVQQtH+T9+K7tyBd0P5S=8YxXpsfrQ=68gE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	git@vger.kernel.org, Junio Hamano <gitster@pobox.com>
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 21:20:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2r1J-0007sm-IB
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 21:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934176Ab1CXUU3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2011 16:20:29 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38217 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934147Ab1CXUUW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 16:20:22 -0400
Received: by fxm17 with SMTP id 17so399773fxm.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 13:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=UHnCeU3dzAql+uQiEe6Q6WQdpU1MdflrSbGmXN3Qm24=;
        b=M5Y8D0hR5xa5wQ3w+G8oTbjSqEsRlPQtSHZbHbNlmvHozlJjBUwMQRhPSs4GztxYTf
         g2Fgu2MpI92DT7uQqIxo7jvES3lCX6kxQogHgJxXyHFI5MUGLTkXFGzJiqN/fosf6/1S
         TRwuaqIC5wgxaRSYxfS5WQsS+VW6Kxyyr+B80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LSJk2i6aOG7XzPXWcXIUCxdyxeHE+nGC0DjDlC5q4yq8kq2hfWqLFmmxAUAgJ7UitX
         hErPhlWCILZftfbvJJ99ISuw24WiDk7jDQ+3fIpmD3JNb7K+pKgzqgNnJA0BUlbJgAqg
         uoIDLnjppktlNWindzLnDNnlCtEBTbSIxgp5U=
Received: by 10.223.57.5 with SMTP id a5mr1586813fah.90.1300997990927;
        Thu, 24 Mar 2011 13:19:50 -0700 (PDT)
Received: from [192.168.1.13] (abwk172.neoplus.adsl.tpnet.pl [83.8.234.172])
        by mx.google.com with ESMTPS id n7sm123970fam.35.2011.03.24.13.19.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2011 13:19:48 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTincAcVQQtH+T9+K7tyBd0P5S=8YxXpsfrQ=68gE@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169941>

On Thu, 24 Mar 2011, Kevin Cernekee wrote:
> On Wed, Mar 23, 2011 at 5:08 PM, John 'Warthog9' Hawley
> <warthog9@eaglescrag.net> wrote:

> > This patch takes the same basic goal, display the appropriate times
> > in a given timezone, and implements it in Javascript. =A0This requi=
res
> > adding / using a new class, dtcommit, which is based on the
> > dtstart/dtend microformats. =A0Appropriate commit dates are wrapped=
 in
> > a span with this class, and a title of the time in ISO8601 format.
>=20
> John,
>=20
> Thanks for coding this up.  I tested it on a couple of different
> browsers and wanted to share my observations with you.

I wonder if there is any site that allows to check JavaScript for
compatibility with different browsers...

>=20
> First, the easy stuff:
>=20
> 1) "git am" complains about whitespace violations

It would be more helpful if you wrote here what are those whitespace
violations.

>=20
> 2) HH:MM:SS times need zero padding; otherwise you see:
>=20
> Tue, 8 Mar 2011 20:29:9 -0700

There is even padLeft function in gitweb.js ready to be (re)used...

[...]=20
> 4) IE6 does not seem to like ISO 8601 format:
>=20
> x =3D new Date("2011-03-09T03:29:09Z");
>=20
> This sets all fields to NaN.  I suspect that getTime() values
> (milliseconds since 1970-01-01) are more portable.

Do you mean using epoch in title attribute, or fallback to parsing
ISO 8601 UTC format with regexps?

> I have attached a trivial patch for these four items; it applies on
> top of your original submission.

It would be much, much easier to review your patch if you either
put it inline at the end of your email, separating it from the rest
of email with e.g. "-- >8 --" separator (so called 'scissors'),
or at least using 'text/plain' as mimetype, '8bit' and not 'base64'
encoding, and perhaps 'disposition=3Dinline' rather than=20
'disposition=3Dattachement'.

[...]
> 6) Most U.S. timezones honor daylight savings, so they could be
> something like -0700 for part of the year, and -0800 for the rest of
> the year.  Picking the "local" option would automatically adjust for
> this, but DST limits the usefulness of permanently storing a fixed TZ
> offset in the cookie.

Dealing with DST (zoneinfo library) is simply too hard for JavaScript=20
IMHO.  What we could do is to store "local" in cookie, not a fixed TZ
offset (or perhaps store both as to not recalculate it).


> 8) The " + " popup menu is a little quirky.  On FF 3.6 it partially
> collapses after selecting a value from the dropdown.  On IE6 it shows
> "Error in parsing value for 'display'" and does not render.  On Opera
> 11 it seemed to work OK.
>=20
> Firefox breakage: http://img217.imageshack.us/f/firefoxa.png/
>=20
> I'm wondering if there might be a better place on the page to put the
> TZ selection.  It isn't immediately obvious to the user what the extr=
a
> " + " does, and it seems to cause some issues.

Hmmm... perhaps a 'config' page?

--=20
Jakub Narebski
Poland
