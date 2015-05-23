From: Bastien Traverse <bt@esrevart.net>
Subject: Re: [RESOLVED NOTABUG] "git commit --date" format parsing
Date: Sun, 24 May 2015 01:24:03 +0200
Message-ID: <55610C13.4090802@esrevart.net>
References: <555F2CBD.8050501@esrevart.net> <20150522220610.GA21848@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 24 01:24:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwIm5-0001ik-C9
	for gcvg-git-2@plane.gmane.org; Sun, 24 May 2015 01:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174AbbEWXYI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 May 2015 19:24:08 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:36989 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbbEWXYG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 19:24:06 -0400
Received: from [IPv6:2001:41d0:fc06:e100:6236:ddff:fe94:4666] (unknown [IPv6:2001:41d0:fc06:e100:6236:ddff:fe94:4666])
	(Authenticated sender: bastien@esrevart.net)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 8F23C172074;
	Sun, 24 May 2015 01:24:04 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150522220610.GA21848@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269822>

Le 23/05/2015 00:06, Jeff King a =C3=A9crit :
> OK, this is weird. When I tried to reproduce, I couldn't. But I had
> typed in the date string myself while reading your email in another
> window.  And though I was sure that I had typed it correctly, just to=
 be
> double-plus-sure I copied and pasted your string. And it failed!
>=20
> The date string in your email looks like this (using cut and paste):
>=20
>   $ echo 2015-05-21T16=E2=88=B631+02:00 | xxd
>   00000000: 3230 3135 2d30 352d 3231 5431 36e2 88b6  2015-05-21T16...
>   00000010: 3331 2b30 323a 3030 0a                   31+02:00.
>=20
> Your "colon" is actually UTF-8 for code point 	. So git's
> date parser does not recognize it, and punts to approxidate(), which
> does all manner of crazy guessing trying to figure out what you meant=
=2E

Okay, this is crazy. Now I can't reproduce it myself either: I just
repeated the procedure and date parsing works as expected. The only
difference with my last email is that I upgraded and rebooted my system
(there was a kernel update for 4.0.4 on Arch... Among other things). I
guess that would have reset my keyboard layout, but I swear I tested it
multiple times over a few days before posting here.

Anyway, thanks for your insight I would have never figured this myself.
I'll be wary of silent unicode character substitution :)

Just for the record:
$ localectl
   System Locale: LANG=3Dfr_FR.UTF8
       VC Keymap: fr
      X11 Layout: fr
     X11 Variant: oss

And I am using the default monospace font in gnome-terminal and gedit.
Pretty basic stuff, really.

Thanks again,
Bastien
