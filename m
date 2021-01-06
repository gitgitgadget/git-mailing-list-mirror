Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4988AC433E6
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 15:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0534523121
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 15:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbhAFPWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 10:22:12 -0500
Received: from mail.aerusso.net ([104.225.219.13]:44342 "EHLO mail.aerusso.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbhAFPWM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 10:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aerusso.net; s=default;
        t=1609946490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jiTrACMNTw/lWUXxXW/u6Vaor3rPez104fcXoAFwC7E=;
        b=oi+uruX/gh0FT7CY93AkwvDHHZO7ZoVr6mxz5O3vwrsdjN5SOpKbgBi4cK3wUok/NdE+Vj
        6HcT9kADRFCLzIu/FAhl7V4LQ7/uy0A2TPr32Oz7zpFivcKeF+8St292GDGpkR+9qPHBjl
        qPC94Ma3PlcFeSV6KEIUPhC4blsknL6HWeJGBKMImr5gAan/wGQq2WaRXDJp521co63P+1
        /tm/JBeKbX/mr63ycbFTev6Mp17MfyEd3BCL6ptT38P7+fnRfvkXO1QMpzR1Sy2RaiEqCG
        Hu6GeLuK5DOqf+uFU7tbZWG6lVfFYaGVFZ5GpAvLqeCa9vl89Qu9YLtmfM3Dxw==
To:     Junio C Hamano <gitster@pobox.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org
References: <6dc37f6b-1afd-544d-126e-2be9422571c6@aerusso.net>
 <X/K1BgP8tpsgNe2x@Abhishek-Arch> <xmqq1reywt7x.fsf@gitster.c.googlers.com>
From:   Antonio Russo <aerusso@aerusso.net>
Subject: Re: [PATCH] t6016: move to lib-log-graph.sh framework
Message-ID: <d01e2830-d579-67c6-1076-ed44cff27ad7@aerusso.net>
Date:   Wed, 6 Jan 2021 08:21:01 -0700
MIME-Version: 1.0
In-Reply-To: <xmqq1reywt7x.fsf@gitster.c.googlers.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zrcRujoOWrAYHqENTqKtykq8wpKFLee7K"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zrcRujoOWrAYHqENTqKtykq8wpKFLee7K
Content-Type: multipart/mixed; boundary="Ny6jtghqh0o3kFwUky6WiovxPm6eK1aVj";
 protected-headers="v1"
From: Antonio Russo <aerusso@aerusso.net>
To: Junio C Hamano <gitster@pobox.com>,
 Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc: git@vger.kernel.org
Message-ID: <d01e2830-d579-67c6-1076-ed44cff27ad7@aerusso.net>
Subject: Re: [PATCH] t6016: move to lib-log-graph.sh framework
References: <6dc37f6b-1afd-544d-126e-2be9422571c6@aerusso.net>
 <X/K1BgP8tpsgNe2x@Abhishek-Arch> <xmqq1reywt7x.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1reywt7x.fsf@gitster.c.googlers.com>

--Ny6jtghqh0o3kFwUky6WiovxPm6eK1aVj
Content-Type: multipart/mixed;
 boundary="------------1D8B30DE96696C99BA748E17"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------1D8B30DE96696C99BA748E17
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/5/21 10:05 PM, Junio C Hamano wrote:
> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
>=20
>> On Sun, Jan 03, 2021 at 07:30:35PM -0700, Antonio Russo wrote:
>>> t6016 manually reconstructs git log --graph output by using the repor=
ted
>>> commit hashes from `git rev-parse`.  Each tag is converted into an
>>> environment variable manually, and then `echo`-ed to an expected outp=
ut
>>> file, which is in turn compared to the actual output.
>>>
>>> The expected output is difficult to read and write, because, e.g.,
>>> each line of output must be prefaced with echo, quoted, and properly
>>> escaped.  Additionally, the test is sensitive to trailing whitespace,=

>>> which may potentially be removed from graph log output in the future.=

>>>
>>> In order to reduce duplication, ease troubleshooting of failed tests =
by
>>> improving readability, and ease the addition of more tests to this fi=
le,
>>> port the operations to `lib-log-graph.sh`, which is already used in
>>> several other tests, e.g., t4215.  Give all merges a simple commit
>>> message, and use a common `check_graph` macro taking a heredoc of the=

>>> expected output which does not required extensive escaping.
>>>
>>
>> Glad to see others using `lib-log-graph.sh` as well!
>>
>> The changes look alright to me but maybe you could have split the two
>> changes into two different commits: Using tags directly instead of
>> environment variables and using `check_graph` instead of manually
>> `echo`-ing to an expected output and comparing with the actual output.=

>=20
> Perhaps.  Also I am wondering if the tests still need to create tags
> after this change---isn't the output all matched by the commit title
> now?

You are correct that the A4 and A6 tags can be removed without affecting
the output.  In fact, A4 is basically immediately deleted (in the second =
test).
I can remove that, if we want to stop testing the tag deletion logic here=
=2E
I suppose that is sufficiently validated elsewhere in the test suite.

There's a (weak IMO) argument to keep the A6 tag, since it might in princ=
iple
affect the output at later stages, since it is not deleted and calls are =
made
with --simplify-by-decoration.  Of course, it isn't needed in order to be=

displayed, so we're only testing that that the merge commit A6 shows up w=
hen
it *has* a tag, and --simplify-by-decoration is used.  That failure mode
certainly seems perverse!

My guiding principle when I made this patch was to be as minimally invasi=
ve
as possible, while allowing modifications to this file to be pleasant---w=
hich
I must admit is my ulterior motive.

I can certainly remove these "extraneous" tags if desired.

Best,
Antonio


> That is ...
>=20
>>>  . ./test-lib.sh
>>> +. "$TEST_DIRECTORY"/lib-log-graph.sh
>>> +
>>> +check_graph () {
>>> +	cat >expect &&
>>> +	lib_test_cmp_graph --format=3D%s "$@"
>>> +}
>=20
> ... this only shows the title, and ...
>=20
>>> -	git merge B C &&
>>> +	git merge B C -m A4 &&
>=20
> ... that is why we need to have the title here.
>=20
>>>  	git tag A4 &&
>=20
> Now, does this A4 used anywhere?
>=20
>>> -	# Store commit names in variables for later use
>>> -	A1=3D$(git rev-parse --verify A1) &&
>>> -	A2=3D$(git rev-parse --verify A2) &&
>>> -	A3=3D$(git rev-parse --verify A3) &&
>>> -	A4=3D$(git rev-parse --verify A4) &&
>=20
> It certainly used to be needed here, but ...
>>> +	check_graph --all <<-\EOF
>>> +	* A7
>>> +	*   A6
>>> +	|\
>>> +	| * C4
>>> +	| * C3
>>> +	* | A5
>>> +	| |
>>> +	|  \
>>> +	*-. | A4
>=20
> ... not anymore in the new version.
>=20
>>> +	|\ \|
>>> +	| | * C2
>>> +	| | * C1
>>> +	| * | B2
>>> +	| * | B1
>>> +	* | | A3
>>> +	| |/
>>> +	|/|
>>> +	* | A2
>>> +	|/
>>> +	* A1
>>> +	EOF
>>> +'
>>> =20

--------------1D8B30DE96696C99BA748E17
Content-Type: application/pgp-keys;
 name="OpenPGP_0xB01C53D5DED4A4EE.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="OpenPGP_0xB01C53D5DED4A4EE.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBFb6FmsBEADRB9Z75jF5AnsW2P193ARRp/Xiw5lEgqvGf8+iMvMiGwAEOR7xo0L0g3HPL=
wBm
i8Nq4NC0AVGhorHQxGmpJ5BizcZEuI50ksrmzk1x5SzM5YBGIhmUwP5F9CygSd/Sub838buLh=
ya0
ig2DzvcrSyHIdvN1kSAMkgIOXecSwKZze5hgb3SXEFE/tEFpuSCeBF9eq7sCcOyw15UBdKpg/=
dKJ
2nY4Olq62WwCYoBQAryO9YIETLiMCeIZapsTlGk0Wu8u+pBwhSwelb+gi65NQPN5R3K2li3tK=
zmQ
a5ebi4CbgguQZTdxZDSAjZYerOJqKzvjbJP3MNQmg3Ez9TyoiC1/gA47H9+4Nlyg/5gcQ755f=
oSH
Kx1xr2CWqJu3M3IxNVcGoklyhac5A08v2dSZGxkJYeZ8rlwHOiz8xNb96xxq2NzfwPfN8DumW=
b2c
hPW5mk8q4/3RIWtiMrOG18ghFo72FMvlib23nYn2BWstBiEevJOWdBhCCMacy080OMM3Wz1GT=
q6R
n0ByZttzMb8TQxTPSaLeFxR9EAcRNFbyTNsCs6J+kVw9PeqeUj2MjXb0uUskFLQnUg/2bmc/D=
2b/
povbG+u03Ez5tdy47nl7lwwCXpRnLEps+zcpTxKrV5fGFEMjcfYcBqGk2hlDW0/pq/clLPa2r=
qYy
CJi7jd4hsz+QGQARAQABzSZBbnRvbmlvIFJ1c3NvIDxhZXJ1c3NvQGFsdW1uaS5jbXUuZWR1P=
sLB
jgQTAQoAOAIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBBgZXXh4V3y8ii3NhbAcU9Xe1=
KTu
BQJfZsOuAAoJELAcU9Xe1KTuIAUP/30zd/uS6bu7zghna7vWN7h7dtkguU9ga+20h6mzSdXVA=
FWz
z06d782/s2AvyDB+O+PFy7hqUlD5e0nJ2mHLPFJy3Ix3RQ9/YgvMzgxQRgHGl0gb2xK+6pZM/=
E0u
G4SkGczapDLY3jHL1/lygELpjLSej2lEwXS0OGRjnbukP3Pe+Uf0tc/F0WxI8mi5TbOuUgKWu=
D0q
MlbX9BISD1LNi6ZyeQ3jb8BlcDbv/Zlynlz2AujWsYw6+lbiBgfiDwcgo0ZhkSENiw1LUCUet=
B/b
YdieWN8HaCtpNGrPQxxDScM0TJqyEdcUFQNUBxLygVncwAf3qeKX6LFtAelPFKkqUOKLzOcSy=
G4A
2Z081EUgc6wTlUoC1I9EP2eajniBKot33x1Bq4wBlVNW5Is4MALfSNQ9iEEr/X3JBoCAvdgXh=
JjE
ZabfXHRNyygm8b7/vSSQu38YACcX1NnvqZDO9spSDd1y3EXKNeayQFf5wjVJrt1KVx00YyzFi=
A4y
wP5xvHIVKQM9pjt2z5wOtt/J4cqCx+JNjCZbz8TEWgjALd//hFsY3IC5I+MvmpJrnmEHCb/f6=
XXx
BZsBTnxYU4X/3f1hNq4DFvZzAbJmVrZR1o63aCy27TaM9g/4YYUk/iO5oEBVYIQm4qDIA1ClI=
Hl3
+3Dzc0tVXpFoERjFc+VZS5auW1p1zSlBbnRvbmlvIFJ1c3NvIDxhZXJ1c3NvQGFudG9uaW9lc=
nVz
c28uY29tPsLBjgQTAQoAOAIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBBgZXXh4V3y8i=
i3N
hbAcU9Xe1KTuBQJfZsOjAAoJELAcU9Xe1KTuw0kP/2KWpsaaw0M582stnmhFsqrgp7cWnZpmI=
w/N
JWQjPtGpxazGWCUdBbEtyp0bFz4zYlyJjbY4htWvmwJy5cgdyFOGcNLfHmWGJGQWzKezoDwyw=
Yec
8NDaFXKJyuC0/COsQ8SA7F9qct85vQEWz14lyWBOPrrSDqF+tkIeuoW8Y+DZyvfcuTlfWS2dA=
heV
6dnNJ0EPMCFikJTPcwx4+jXRCJvdq+pGyHXhT6HoHT8SWI0tagcI6RAqy/kRDprwJHmEuYmgS=
F57
fOIQziMIAMEdB8w01fhsAwPK53jwHq8/OdiuNTVlHxVvfogsDbywqh1lKs6PN5o/sKYZx5CAl=
c7G
KH69bOSw8K72AuXkSve74xsCE75NTqLKWfF50h0/J3bXDwZDO7UOG3xHlMspyGwi2dOd9zyC1=
cVx
ElbB0ObF0akwL0vYUU0wsT43IO8KyY7tzMnqkPfJ9bThjzvlXrWfbFlZTjO0uJcRFN+bmFVSs=
nUk
mn/sdJSHdYbKjBW8eUMpwGNgyFtK7cW3KC7TIKfRRE+lXw0mMz4COgeC4LTM5tzbHaMYtW1DO=
ows
4G2UypxpjLzzdKTyn5cg+zSL0kP+BaMrh32X0uNl0Wg6sRT9/EaToCvd4Hs+97Ac9G2kCSHBe=
odG
IcdIO+DqOgU4OxdsxiSx61WF8yURyrnN795zQ3LFzTBBbnRvbmlvIEVucmljbyBSdXNzbyA8Y=
W50
b25pby5lLnJ1c3NvQGdtYWlsLmNvbT7CwY4EEwEKADgCGwMFCwkIBwMFFQoJCAsFFgIDAQACH=
gEC
F4AWIQQYGV14eFd8vIotzYWwHFPV3tSk7gUCX2bDYQAKCRCwHFPV3tSk7mJaD/9lm/sQKU+Zd=
573
CtMO00+esqGO3WLrkJTLzP4t5BNqkD6ovq0G59W9cF0CvkzCf1GKugEPx6xxtiLXr+thKfh8f=
eJL
5W7ZG9XdUm1Kl+9eDJTDRLozyemE4eei5cBcDCYI1ZhQ0DSECZ+/BX0K40cquAQdo9WVKxGag=
WTz
kY4Vxjx6w8qGPbpe5xvXvwS2dQVx2LZbYnRofnOSK+yS7C0lS1PoYgxcMwuBo7tKeRUpF1hmf=
7/Q
R2cbBv2l2coWqXWiyA8vTJi+yx08TTIvnBHVWWAo5vA7eaTpw37/oNSYK3AEy7McR1BSLIs9T=
xaN
gQRntcN3MUTU8oLlzS9lon3Z2NCXMtSMYmQmqEEFp18Ho4K0gyUFvm1hZ991n6uHIUrjmjBZj=
WM6
YtEhZMw6+a92DptedUdHdgloEnAJ/nkAjUuqiUEhWSKT+ZWpIt8ILGYY92T3ZG3qiFKIP3z9n=
cJW
AIJwtlEfyiFFPTPV7i6kbj07TkThWqiYIc0T+kiyWXJqfUoy+6VjTuKgv5THeCVHh4O0juDmR=
L0R
ryqnFVBrTWEJE7zRQMP1hHf+1AaR6ahRXybCupckNALDtRKsCgUrs4w16fLWC50dNQq6raERQ=
8L4
YN7XMFAtQYwMxMsC5xRaTt2q+XGYO47PqG8WkWukaOOVAE8T3PK+kLWy3Xgtgs0qQW50b25pb=
yBF
bnJpY28gUnVzc28gPGFlcnVzc29AYWVydXNzby5uZXQ+wsGRBBMBCgA7AhsDBQsJCAcDBRUKC=
QgL
BRYCAwEAAh4BAheAFiEEGBldeHhXfLyKLc2FsBxT1d7UpO4FAl9mw68CGQEACgkQsBxT1d7Up=
O4+
xw//RfRL4tURiNR4TofSd4bRDfYjFN9AeEiiZRT2vMJZ89CizWs4OMk6soFmeE1Q/8vX9Iimp=
xaJ
aYnWODSXPlwWAgUQdkty9es4EIwdYnJYpJYeZYzY9HVwA+WtorrTGt4K6m7CsK7T/Lkt++d7q=
WYU
vspwY5mg9fKGOCp225TtZLrK0oOJPbnczmJbl50hX9loNx7rzWHyVSU8arhQoE9Tebh8IEaFt=
fet
7BSvcS8i1Y6DOJPpu5mitnbeqqUaSmfJQE3uX1Ryv0DJUT6tuJBjSYK2Zap5sFF5ykH7ozP2U=
3Sg
wrcDI1pXLMtHFefyo+awyvKtiyLYQcwZIrHbcobCt0Lx0L9z98Qj+hHR6vH54UaQpQSC8077/=
eL9
uxG5R+nwDgH0RuX9+3W/D4tHH26nEitWSGkNk7ylMijLMHKr+iFIDbZ93gCTFRN6xRZEucnc0=
PxT
IPcOYCFH0fP5+oHwyOqx4aPeqmIqAdw1He4wcD8QtkScVpZPd17VhwVjxVAICGEKsdGIimem8=
i4g
6ebgyr9rB6nKAQAZzHngbp/2/u9vsRz/dQK/ndgVJk50KwLm3sbb5c7O4AstuGFE1yM0caIsg=
xXG
eIXw2j0sLWifQfg7L5upCLc5MfWkF3iJPjUYkd9pKtnQZpYZcNYwg9KVGC/223VkPZhBySkHp=
V8d
9j/OwU0EVvoWawEQAK+bomcvdKX5Pzj2BKwyrnD9nkWhoQGRp4246Wa9SOD4x1qPnwKbO2qOi=
U7U
pTI6SM/f5j7ckJ65LLSLDqlEF+R0xaVRL59+mdEdKADMEyTQaizO9FCcB4PNnlKcAYQ1Txt8N=
68e
usTNlrmwCxE45YfjVt7mILWigIowLPBBuAP4VrN6NE6D6+KDErYlQQzaIYT0OlFk8D2v81/uj=
dfl
uklS4f+q6eJnhnitQPnAm8FrQ1Jj9gfXZr1RrD6W4rBT7y8ZO70BsHMpXc8Yl6lITHnwy9Zb8=
E0B
bOTzCfZeTnp6VjZMPsn2UY47dXsnyH/D740GU5r88YC4pJwe97c8FOZfVye7A5CvrPwLWRG2h=
yEf
S46sy4kcPlD/p9HJBr9X1RdNxR40Pazzf45oNEfo5v6oyNffihDGofZOSlNRjNUo3JWwtiVUs=
toI
yi5EiAwa5LB9zHvidmB80mMphLqVYfUhlvwcYppNbomqUV0LuwUAO/zCgahgvTzPW6V+WKVuT=
Gz4
flzDcSlWEizZIoSTtdZNO+X6MRRkwHBMOEd817pnGgxFFV9rTK7FPzSMmJTOKDEfTID+qkkRB=
98m
nYjvPNgjPxe/13zrXEjDzhH7LvFL3ox++YKXiQ5S0t9pynFEOVC92XPojlRYh+Uuu8hQ+IM7x=
9D+
tzHt7WWYSaMwVYLXABEBAAHCwXwEGAEKACYCGwwWIQQYGV14eFd8vIotzYWwHFPV3tSk7gUCX=
lLD
wgUJCxsUVwAKCRCwHFPV3tSk7lYqEACtxHF8KIQpSnReVFJ/YAsm3JmNWciqXfb2wZMpEQK4j=
gw0
6fSvoEWKv8KANd6wXnbT+TAZNyMQ/SkFDoKZ89GD1VBDzqluwy/RYkcSoWHe7uGiuuHu0ToSg=
r3k
GDRkIOPCv+yNJC0tsL24Olew8IXRgPJBOY+Wc3k65J4eszBrm2ixcE8+BjFsf1pa2qj2ZW8Ct=
Aml
ynpi+hBJrqUIFBHz1K7d5hEiNwjskgsvxtGJv0bnfdTQ9ONqVXuh9A+VXDyllcgHeiyQ/u6Tl=
UDt
vzWboT78qhs9UUNZcdZvTtAYgwPfcsb70V2I0rlJvFo2/+a7eWV/CqJ3bA4CMvHlnNLCEFf4h=
We0
ZqHE59TczgEUzlhBshuHgS/U4D+T5RMSS6ey0wafVJtcOdj9ezFFk5F3X9vJ6ZDTdeS8CWDya=
8Ky
7gMzlWrjo9+5FKiy1K22yDnEt1Ct2/KxP85+CVdazgsYk3otdwWszupB7jiQ+w3i7fbhOV3Y7=
OdH
YkUUhulai3jNVHd/7yVNQSSGZk5Emm2y6/c49FNBDhj4fUjPere0pPOwnBwNm7pk8bE7quxRs=
MiP
E+Lf8b83XKkLqhQLvRfswHdyZidFCaqA9qn4YFzV3q5hnOHcIXkO1iWf28G67Dl6XJ8rFpXHr=
8aL
5S03zaOF/qS9KMHMPiF2cKQ4Cl8Gkc7BTQRW+hqiARAA1QPWbPZPoVGshKS7ZlEHSPmDUlV7/=
yT6
AH1SAWDfG4SqSQJO6ecQV0BdOqLUaLd63gxWoEm+96RV3kJ9NF1opVEntru5727RMVy+xnsUM=
7+2
XHAAXLui4W7KK4Z7Abv5Lm2mIiZL/xnWm+mLV1RQQabjltXUG0XouNDRDEPkEQ41nLQIjkcgr=
I4d
co9fhE5PtucHVMAsr/KL6Si9+c0QcLr/bA/gQaVAlomC3j72mf1KoSH/ig5wPP8cVqyfBS3IE=
oYl
3w9d5nEM3ThbHIXO764+5hvxjEAsQa5mNg2fEl2fV91FuDIRNzgsMnv6mCi+Ux3Awt0J2tBCB=
LSE
rgTD08pP667UcZx/OVM9th7rFBcdohVJFFxwx5BD3ePbhAvmymvOLI0lPmAG9m+ceXaBCe3S6=
5AQ
BcRbK+l9lCXP3FgRuj1S34kYRZtowmAsrKoTZMm4dBQ3g3fdZnJexjyFoYbKcPang7iQftrZm=
TBS
OE7b1xhS4fIGtbVto5UPxSz9v2IlCmSmma/21Kv0NecaC83cRHW/Olyt4ycYdfTWLzX0/BCcq=
AYN
2fPIigSw/KY++ox4LUJqsmZECwxNGSse7ouQeiBnsFWwKSgukjNJlTFsWDw+G7zzbwLOV7Cej=
CHb
LOIHJqqhLVRWzlxStrZbYcueBiQD1+CD9gjQPSa82l0AEQEAAcLDmwQYAQoAJgIbAhYhBBgZX=
Xh4
V3y8ii3NhbAcU9Xe1KTuBQJeUsPCBQkLGxAgAinBXSAEGQEKAAYFAlb6GqIACgkQzDJOVTjS7=
oal
xA//Q5/Iu5RgFcri5ujak9u1JomlC3hf9nAyzWfmIbQONX2LzhMKaLbjG7ji0PXNrp0qQ5gW/=
Tyo
Bh8jfPIZBcZPE5cQ421A/msE3SsjGmpA1ptEDOD47oY/Riwry0Oxfr6jJqjOVSzP+uL2Uqp8K=
5gh
0BJqhIjEUJ5zFuRTqTDAOOF08mRoh87DaIy6ZmyqsAJO+fiuBlTVc2TC24igOx+9m8ZqujKzz=
lfc
e3vr15HJ8QbIx9ZP8+8sNAtWUGyl8kGdTMzTLX4rtbMJpCGqYcC5gmcE8+ynHZ+Cdr7rMjAew=
sa9
UcEtxF41nl+cOe2UnOJUSy6i2CjAIasubFNOqGvke0r89hVFSuOqr7XLUOMhS88BQ4Atny5rN=
NEB
4aAy3ej6qnVCP0kBviQ6kExAlgq0xXsMbi2GtMvrGhBx19NHx4DtWqsfrMAzzIOP3LB6QMGkN=
8qE
exAQauwvubPPCE6Xx7wC8qqWyJOHpq8nujfJdw4pNA7G5aW8u2Dp8xiY4oeJ3zJf0mT+2CTFE=
Ii9
lkEH/kmezSDAI1s9QVPPWCTVK+XasB2kAgcDRNsUFoyL4R3uhYSHfD03tx42c+ix7bmoQAt6Y=
87N
3GEwIuiHROtnbQ8aGyvmlVIozBsPCGAm4nzFP/9SLR6iPptuS/Jhaey3jyTOdTEKl8B50Leyg=
oeX
GmMJELAcU9Xe1KTuWXgP/0pHDcA9owJTxOEMc/KJlmvfU2w8BVasGUHfeLMp8vG5za7pQPmE2=
PVZ
78VlrDT4n/Tj7SFOfr1XwOTeD9HBCRBNputyrsyGKlhmRk8OECyg/nlx9pdPPARY9u30RoHJt=
k0e
+95PmgBY8MFdd2BuZccuOa+WZ5+2LHV0RUcKlbDGmPHEqhLjVMBnbRc8/RfPQwUxf1wwBYu2w=
ln6
TVb2k4z3n9jqKVnK1/VYVEvyWOV5OVoz7UpMHXWw3sdnrhJgQuhmKNVTSA4Pc2PLer8St1DRV=
/hL
2WFgfHU/ZLrTah/piHUAji04mp4urjJ8Y0dSHshZ2mEzO8rok4U4JZbuDE2NY+HO/4R4s6Ego=
Dyb
C/HOulJm3/fhhJJDbEZOFO+yvNDXzKDaXLZz2JUP0666zXY8gg9yOx+OvZQvUR6W6vnIUij2h=
iAg
BzDnBysdgKoviq6uj52u71Els6Auwqko6iWp/7d28PQHrBduv9gp6WX0XETSwWJJC5JqYtFhS=
5fM
+NC3LGlroZQHqns0fv6NnV3XLZxJTHoKtRQ75KFGYlWBbxMjFC/BIdqY5sFWFIjxLzByNvj6q=
85I
7wtxpOoBHXT1RbWUtR7rK03UVmLKcplltwokGRzSLMFfVsIytCpiYrkhYKuYq018zqqNn9ciM=
3sH
htRcAuFflcChHg0tzRV9
=3Db7Ih
-----END PGP PUBLIC KEY BLOCK-----

--------------1D8B30DE96696C99BA748E17--

--Ny6jtghqh0o3kFwUky6WiovxPm6eK1aVj--

--zrcRujoOWrAYHqENTqKtykq8wpKFLee7K
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEewYezZ63MYOOiJcszDJOVTjS7oYFAl/11V4ACgkQzDJOVTjS
7oZEeA/+Ii1Y+6nB/aI5D1tVENwZDW3g8EAuYPfZDBWQdB35e52yDOF0ylEAhso3
7pd8K8+LCU+l9O4rKQUAteZP4ZaoosKnfvhTREFFNJ1KGJv9mM1muzH0pv7YBh4u
v03tLKIZR0j8CXEifsm917wGCaw0YWYwlUbhAV5GKY1KYQu6NRMbhZy+FyyEU4+p
LBr9UAoh8EOnSppsqIjwz56pfdREjCDaQOdp3DH2TKnJ/e6UylJexIa0+SYN3yGO
pB3kmFZntfSL474ticek0o8QewP8mxYl5+oeMxGzOZe0iY5gHV+lUpKk1c102t9d
99LafcrYHlOpLVUNUhmPhNmAvGcmsFgEfFZqMyZoUzYMfjMaJ1tfjQjQyWrT6b/k
PvlyWRbU9lXSqadSQEGiRKZ7CJD3xVNJGEh51A2jcoTvkfUP20sbBV0AjUYP6g1K
O+0iLNMOI0bj1QBeFLwVd0SSCIPRgXFu6Zm/evUA1UrOghwvlrk/PQA+fnrtGXd1
v/FCXjgw2Y27YtuoFHOwVDSg8qNVH4h4f7bHzLwSZDtznBP7vwqlmuNxOn0bQqJZ
1rOQLWY1jy93PD2P1aWAZHTAW7iosOleMkifw8cusPW/Jlz2byQgpHiyMY3WU9SX
7IIGECu60/41IZmgdP5GHTpUm5mfQNAs8BrXQ4PmQ2p36WXr5xY=
=XSDH
-----END PGP SIGNATURE-----

--zrcRujoOWrAYHqENTqKtykq8wpKFLee7K--
