From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] repack: rewrite the shell script in C.
Date: Wed, 21 Aug 2013 14:47:52 +0200
Message-ID: <5214B6F8.6030102@googlemail.com>
References: <5213EF74.7020408@googlemail.com> <1377038334-15799-1-git-send-email-stefanbeller@googlemail.com> <vpqhaeje8e0.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA094BCCEBD8E30D82EEABA41"
Cc: git@vger.kernel.org, mfick@codeaurora.org, apelisse@gmail.com,
	pclouds@gmail.com, iveqy@iveqy.com, gitster@pobox.com,
	mackyle@gmail.com, j6t@kdbg.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 21 14:47:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VC7pM-0001OX-5U
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 14:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633Ab3HUMrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 08:47:52 -0400
Received: from mail-ee0-f48.google.com ([74.125.83.48]:46593 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab3HUMrv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 08:47:51 -0400
Received: by mail-ee0-f48.google.com with SMTP id l10so208946eei.7
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 05:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=4EOtih/doZRty73LRlPB0TLuIa+CyLWyJea3TUbcSpo=;
        b=aL2gHEj6mCeTf3Y+td718xOVkUKnstUIl+ixzDLG84kIzleFCqz5v7FHiKj+mp4Gph
         aRjFqiKEgRWuydAF9UruwyqJB8GG8enKWfemqF0l3NrS1DDraJ1DftcBSKZmW4fd5exb
         k3eabhfgaitydELEJgPhyvNfxs8U2XK5qUZnHqK6at7G70TTfV+1psWlaimzzkCEEUtX
         G/cl//eWLyS7TmX3gzg1g5pQicNuIG2ZdXAj2MTUo6HTZ+466ax2QaI7h4rnPeGd93kn
         2zxKp5D+G/O07PLh61gBTU8A5h/+AEc0LL3mc3jSJlnkJVrCLLjh7lfH9PKkWAIwe094
         RHQg==
X-Received: by 10.14.176.8 with SMTP id a8mr10366330eem.12.1377089270606;
        Wed, 21 Aug 2013 05:47:50 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id r48sm9554185eev.14.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 21 Aug 2013 05:47:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <vpqhaeje8e0.fsf@anie.imag.fr>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232698>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA094BCCEBD8E30D82EEABA41
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/21/2013 10:49 AM, Matthieu Moy wrote:
>> +	if (start_command(&cmd))
>> > +		return 1;
> A warning message would be welcome in addition to returning 1.
>=20

Johannes Sixt proposes to retain the return value of
the sub process, which I'd agree on.
However why do we need a warning message here?

I'd expect the pack-objects to bring up the warning as
the stderr is untouched in the command invocation.
And we already passed either --quiet or not, so pack-objects
should know how to behave on its own.
Also it is a builtin command, so we do not need to check
if it is found or not, so I'd strongly rely on the error
and warning reporting from the underlying process, no?

Thanks,
Stefan



--------------enigA094BCCEBD8E30D82EEABA41
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSFLb5AAoJEJQCPTzLflhqzhoQAOoC88/vPRC6JMp+v3/YIAiz
SeFL29jUtjwzzI9GQHJt+DCoYmDOaFzecL0neHUdDEFUPGP0bSCJEA2ehexGCrPw
zDb0zFJGN0B4xaW29/GG49+NMstNFDOg9KuHUrQW6CUmzJ216rpHtceOqF65L4SW
mb9hI+xvbQ+3sTORuYHi3F6fyHkZuOwRo30XEJf9YqW2YlSycOdTWKT/vnkGq7ch
px/4jkQyBZHPxRmIphREaIoXxLd+2oiCTnuhT1mEe0ct2HTJlmwGWp1YRq4XeIhQ
5Jybj0fHUo7tk40JRiZRR2MWZF/6XUELghxjmIImbnlVcu2+YAsJeP2ZTml1DSBT
Ac/BysgKNkV7QZO7+4UlX/svDTfOF+EWb+dF8rm6dm3L69sYI4LKq/egzlXl7yrm
ubzS4SCrVeRwujmNFZFfGok4JZj2LI+mSt19H9B4TASW5zuWeoEr25fiBgwwLxSC
hNed4zTZ0+LaIMFfwEvIiZwL4EZVSfZt/2ijS5lgG3H7XYfr0Yt0W7eBwX7896g5
mmw+0sicK2UfwZKiGZ2l8SoZrEr1MEOr0tIJZYA4Z0EbQCJVgSGn/cDz5VtUS+72
3HQ4fmuLJoRQ1U8OlucVorziBnoqzk5G9uBZW6683lQhJQ/EpnHfpzxRRdLHArWm
ZHUfvXHzQ0uipV1SC9af
=qS9F
-----END PGP SIGNATURE-----

--------------enigA094BCCEBD8E30D82EEABA41--
