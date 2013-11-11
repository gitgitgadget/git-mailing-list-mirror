From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: git rm / format-patch / am fails on my file: patch does not apply
Date: Mon, 11 Nov 2013 20:15:12 +0100
Message-ID: <52812CC0.5050805@googlemail.com>
References: <CAD3a31XPKsnuNE+szw7xgvaDrcxhKZ2jTDHKzTwdwtnCwFb_0w@mail.gmail.com> <xmqqhabilpzx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="53IoKBOaldfFTB225gmmdlh2FVo4aixWt"
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>,
	Ken Tanzer <ken.tanzer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 20:15:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfwxS-0007ow-Gl
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 20:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235Ab3KKTP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 14:15:28 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63947 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520Ab3KKTPW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 14:15:22 -0500
Received: by mail-ee0-f46.google.com with SMTP id b57so2667804eek.5
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 11:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=WGvBc3bc3pf/u30x1P1RqzkRTFiQDABqWXtOiKGlpdo=;
        b=FA2hzJHxr6tiCjAiQwr84ukc0Vv1meDIZfuAgk04vwB+4kT9p35UdDQglQIkrIKqKS
         mTMsHaTzP51W2L2iMwBpLn0BPkf6VBq1o+lJtJxT4p1j9ntuCD9PuXB3rN/7e0il2sfh
         UmUBv3Uzc8Cp4MlDGJur7WuoTAIAeBqJlBI3CnEz0DnigkJ1hpvHQvSDJOlxLW7YSln9
         D3k708Gk+puO0ZeKXdDyk8EoOsvqvUqT/AJ7lHF5ccBxWbe2kV7fHqFdbCOO0WrQJHz2
         lV7aB7sarmwEjz3rx3wus7WY7tvR1wqv2Cg4YVaTO7FAp8MT3/Gretm0a+6FykIqmrVn
         1tQg==
X-Received: by 10.14.22.73 with SMTP id s49mr92662ees.99.1384197320821;
        Mon, 11 Nov 2013 11:15:20 -0800 (PST)
Received: from [192.168.1.9] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id a51sm27836035eeh.8.2013.11.11.11.15.19
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Nov 2013 11:15:19 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqhabilpzx.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237635>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--53IoKBOaldfFTB225gmmdlh2FVo4aixWt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11.11.2013 20:04, Junio C Hamano wrote:
> Ken Tanzer <ken.tanzer@gmail.com> writes:
>=20
>> ASCII text, with very long lines, with CRLF, CR, LF line terminators
>=20
> I am not very much surprised if such a file misbehaves, because the
> "format-patch | am" pipeline is designed to be used on patches that
> can be transferred in plain-text e-mail safely.  Long lines should
> probably be OK, but mixed CRLF, CR and LF may be problematic.
>=20
> Having said that...
>=20
>> I've confirmed with the following test case on three machines, so it
>> seems reproducible:
>>
>> mkdir temp_test_case
>> cd temp_test_case
>> git init
>> # my file.  Sorry--couldn't find a saner link!
>> wget -O jquery-ui-1.8.custom.min.js
>> http://sourceforge.net/p/agency/code/ci/9358ea4dbe8e1540ec0b8bebfc7770=
f1bf8be0ec/tree/jquery-ui-1.8.custom.min.js?format=3Draw
>> git add jquery-ui-1.8.custom.min.js
>> git commit -m 'Adding jquery-ui'
>> git rm jquery-ui-1.8.custom.min.js
>> git commit -m 'Removing jquery-ui'
>> git format-patch HEAD~1
>> git reset --hard HEAD~1
>> git am 0001*
>=20
> ... this does not break at all for me.
> --

Here it breaks, though it doesn't break when using
	 git am --ignore-whitespace 0001*

I do have this global config
	core.safecrlf=3Dwarn
regarding line endings.

I was using 1.8.5.rc1.17.g0ecd94d

Trying to understand the problem,
Stefan


--53IoKBOaldfFTB225gmmdlh2FVo4aixWt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSgSzGAAoJEJQCPTzLflhqshQQANMfm+ud1VddfgYqduWTPnN/
4khlMeK2fewKnIgt3fZvZKhViKKvLevZQ9i+FG24BIAUGaju7twrxp7tsrCVlgfR
+CakVkD+0aaVi3LtQmYhj2oY+bRURG0Vt81Edn7j/eYXaZ8EKtiQbxYNAAY+bQWC
Na2M6Rr4DIsOEXb3Lw+Q29ftCay5ZphgfTJtwy6Pe0ru/TeWwnBsIPP3dC1KbPyF
ii2LN2bLzleuZF/5Lv5o+9txP9h3ZhqbKWIDmNsR+6SPMPkSYyK2wc9y/nV6Yv4e
Jroi42h8SJyMGnn1jH42L+8Kx3oUSlJ/SYNG8CEjUHIhvzlWfn9Vf12imbkwyJHB
7E3D6+xQ26Y8fhQJcT87/aTpkjFdyNYltzrbpGGDwNOkyJ9LyLGGBdXjyp8UsjO/
ZbAEcO/W+6DnOEmI33RIFxNeo6CFJmSuC2BYCcTtWasFV/R3Ni/iwbtpa8svfJ+s
hJloHIDrWKNNaPQzEQu6WQDVGb32WW31hz5ACsAir/FhtBoYzTIis8G+DjyyJzB9
Ne2i2qu3OKyee+3z/vfBchmOln+DM8fpZ8yMFUbY/Y5jTHYH74t9NPNWJDPzvSGG
6sClqoSzP/KhSnAhR/YOdgK88kK1IJmH59aMKJlP7F44caFQN3P5BpTvi5JQfyRs
V1SFCUJdozWzWv23XAhh
=OqG9
-----END PGP SIGNATURE-----

--53IoKBOaldfFTB225gmmdlh2FVo4aixWt--
