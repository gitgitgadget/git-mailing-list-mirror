From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH v2] compat: Fix read() of 2GB and more on Mac OS X
Date: Mon, 19 Aug 2013 10:25:59 +0200
Message-ID: <5211D697.7020107@googlemail.com>
References: <1376743205-12618-1-git-send-email-prohaska@zib.de> <1376894300-28929-1-git-send-email-prohaska@zib.de> <5211D544.8080706@kdbg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA70FD7D36B8217E898EBC091"
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1cw==?= =?UTF-8?B?ZW4=?= 
	<tboegi@web.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Aug 19 10:26:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBKmt-0000zW-6z
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 10:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097Ab3HSI0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 04:26:03 -0400
Received: from mail-ea0-f174.google.com ([209.85.215.174]:54539 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab3HSI0A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 04:26:00 -0400
Received: by mail-ea0-f174.google.com with SMTP id z15so2108298ead.19
        for <git@vger.kernel.org>; Mon, 19 Aug 2013 01:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=4OIbtn6iB2JFxumK0SO7CA5qUMdn7GThGtrMBr/Sqs0=;
        b=sUC1t+1YcHiGVdOJ0L8Ef8OD2Kqv9BvQh5wOfbrkeGhz+tpyagJFqBg/fV7b4fNmeP
         EQ4uVUlMY8//pOSiiNhTcYvRfeP0UNJ7WyeHqx2+INai77lWkcgQjDpy21zKjWdKWXmb
         JZimOBkfRt+KHUXE+QSkVsEnWEiJxyr0E8/wPYriWzmuxmiya5yzN8mzKIWM7X98vnJd
         uvr/Hgz4eTffR7IwUj1mifsj50zmsuvrw0Ymlv1loJFLRVXfEFcWR0Q+5NW5cHBaLDKT
         9X+ZYNFv6JUC9O/gbD9Ipyp1QXdwRsiuq4JWy3uyZsjHAKrLobN1Ozgpnr4LyETsGzHE
         mfTA==
X-Received: by 10.14.115.133 with SMTP id e5mr21088168eeh.27.1376900759738;
        Mon, 19 Aug 2013 01:25:59 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id d8sm15619153eeh.8.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 19 Aug 2013 01:25:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <5211D544.8080706@kdbg.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232538>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA70FD7D36B8217E898EBC091
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/19/2013 10:20 AM, Johannes Sixt wrote:
> Am 19.08.2013 08:38, schrieb Steffen Prohaska:
>> +test_expect_success EXPENSIVE 'filter large file' '
>> +    git config filter.largefile.smudge cat &&
>> +    git config filter.largefile.clean cat &&
>> +    for i in $(test_seq 1 2048); do printf "%1048576d" 1; done >2GB &=
&
>=20
> Shouldn't you count to 2049 to get a file that is over 2GB?

Would it be possible to offload the looping from shell to a real
program? So for example
	truncate -s 2049M <filename>
should do the job. That would create a file reading all bytes as zeros=09
being larger as 2G. If truncate is not available, what about dd?

Stefan


--------------enigA70FD7D36B8217E898EBC091
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSEdacAAoJEJQCPTzLflhqB7MP/iEb1hjFZOLd/SmocFkUi8+W
Q/KLlYKdUKBI0A01kWCJcsSpJW1MO3iB0gR8PN33+H5uVx0jnBjKBOz2L1Np3It9
zX2jhjFYrhu+3wjm1uq5qxCvyBs0icLp2pUXVtQAu4CWWSweQd9vJUiEjKyu6lGL
9v22aLUo2qrfccVybAf5xRrzxnvLvfFTh+qyJRSPwjzz4PJHkb2LOcAH8bYdx5zv
vo4atKz+CMym6frN7S16xu1UT6MrlpciuXpIAC9kF/rwRerTr6RpZxwGYmkH/7bq
ZuxxuPHYiiDAxvGB23wOnqeS8M1FeSRvgfRTbOpDLG7cuPq1qyI1ebV4P3c9sEGq
onTVcEGrRX0robg3QaDRzsiJwwgpHH7MgbwAN1fVN8ZEqO+WYfSv4yds/MrNu3UY
HqFFQkk2MYmfnEk5M9Crc26NfnfEhYsvMOTy3VhkuVM09+2wUXtnI8UbX/9WtJij
2ciSigI3xn6jdJEQLCC+TtFH5zVNmAwSKtQ/UyLOM5rv1t+ME5iTuoGuehrd6Iis
CaOnOxrWfe5W1VVchONuyAjfPuiVos0JgBNe0LEcmVNb4SWtH3gpUn4UWk9vCrLQ
fOfw1+dD84dQOZmxt8zu8Y5y6/BtwRvJXF7dyLgBuKWec6zBIR7JyT472dJKqdkl
Smjrl2lcudfkcmlvuacX
=BzXy
-----END PGP SIGNATURE-----

--------------enigA70FD7D36B8217E898EBC091--
