From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
Subject: Re: Handle HTTP error 511 Network Authentication Required (standard
 secure proxy authentification/captive portal detection)
Date: Mon, 20 Feb 2012 20:51:11 +0100
Message-ID: <12ec87a8c95ca12c22f05e1ec961d326.squirrel@arekh.dyndns.org>
References: <4b8f33ba4c870528a82ab85d6dad68bd.squirrel@arekh.dyndns.org>
    <20120220010617.GB4140@sigill.intra.peff.net>
    <9cd657a3c4960a8c496515a03bbf623e.squirrel@arekh.dyndns.org>
    <20120220135639.GA5131@sigill.intra.peff.net>
    <e1d3ddd965eb32717163aaa87fa71e17.squirrel@arekh.dyndns.org>
    <20120220154452.GA27456@sigill.intra.peff.net>
    <cb81840f853a1d43a7da03ea24c86445.squirrel@arekh.dyndns.org>
    <20120220191500.GA29228@sigill.intra.peff.net>
    <72fbd4155349723da1c3c503c1c9c620.squirrel@arekh.dyndns.org>
    <20120220193006.GA30904@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>,
	git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 20:51:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzZGe-00066D-Gp
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 20:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362Ab2BTTvT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Feb 2012 14:51:19 -0500
Received: from smtpout1.laposte.net ([193.253.67.226]:8821 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535Ab2BTTvS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 14:51:18 -0500
Received: from arekh.dyndns.org ([88.174.226.208])
	by mwinf8501-out with ME
	id cKrD1i0044WQcrc03KrDKj; Mon, 20 Feb 2012 20:51:13 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by arekh.dyndns.org (Postfix) with ESMTP id DD6687674;
	Mon, 20 Feb 2012 20:51:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at arekh.dyndns.org
Received: from arekh.dyndns.org ([127.0.0.1])
	by localhost (arekh.okg [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P9Z-bxXd8+vO; Mon, 20 Feb 2012 20:51:11 +0100 (CET)
Received: from arekh.dyndns.org (localhost.localdomain [127.0.0.1])
	by arekh.dyndns.org (Postfix) with ESMTP;
	Mon, 20 Feb 2012 20:51:10 +0100 (CET)
Received: from 192.168.0.4
        (SquirrelMail authenticated user nim)
        by arekh.dyndns.org with HTTP;
        Mon, 20 Feb 2012 20:51:11 +0100
In-Reply-To: <20120220193006.GA30904@sigill.intra.peff.net>
User-Agent: SquirrelMail/1.4.22-4.fc17
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191092>


Le Lun 20 f=C3=A9vrier 2012 20:30, Jeff King a =C3=A9crit :
> On Mon, Feb 20, 2012 at 08:24:15PM +0100, Nicolas Mailhot wrote:
>
>> > I think a good first step would be improving the error message for=
 a
>> > 511, then. Unfortunately, it seems from the rfc draft you sent tha=
t
>> > callers are expected to parse the link out of the HTML given in th=
e body
>> > of the response. It seems silly that there is not a Location field
>> > associated with a 511, similar to redirects.
>>
>> The URL is not lost in the HTML text, it's in the url meta field
>>
>> <meta http-equiv=3D"refresh"
>>        content=3D"0; url=3Dhttps://login.example.net/">
>
> Sorry, but
>
>   1. That is in the HTML in the body of the response (by body I don't
>      mean the HTML <body>, but the body of the http request).
>
>   2. I don't see anything in the rfc indicating that there must be a
>      meta tag in the response. They use it in the example of the rfc,
>      but they also have human-readable text with an <a> link.  Do we =
yet
>      know what will be common among captive portals?
>
> You said you have a non-hypothetical case. Can you show us the respon=
se?

Not yet because it's currently non-standard custom redirection mess we'=
re
repurposing to follow the ietf spec (got tired of being accused of runn=
ing a
crap non-standard proxy by users, so now it's ll be a crap standard pro=
xy)

The proxy response is totally configurable (a so there's no reason we w=
on't
follow the new spec to the letter


--=20
Nicolas Mailhot
