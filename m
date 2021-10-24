Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19866C433FE
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 15:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 026B660F21
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 15:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhJXPkD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 11:40:03 -0400
Received: from mail.archlinux.org ([95.216.189.61]:56238 "EHLO
        mail.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbhJXPj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 11:39:57 -0400
Message-ID: <bf4d8ed5-f168-6e9a-fb27-df735ff28eb6@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635089855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=frzypMKwRVpVgcZ5iVmxJe8y2zvG8qBCgtlWq3Z8X68=;
        b=kNAoMG8XoJeLth6f4QIsDX52wU2w7/38EZBBak1OZg/VaMK0rHW1EzIEQ1B46ou0mdBake
        +Zf/EpGKPR5TjnKwCBqjdpYEoOEXT1sgmuRevxcIXgbSPBcAm+Jk+3LxoqLg4XD1AA7smP
        0d4rQ437EpBV9CD1uOeU7/2s8ByRu1DEtsFwx3XdPRABh6dWmSSaVEHfFNbbSOOnqT7TCt
        ew2sc0vFLZ2CKETRMlN4fdtl6KbJOOVL4PqH7PKE9V2uyuLzYNHFwQ8MEp1KWRiwvpmjYC
        Yk/baLwyJeaHtEIctuax2s+MY2PeyQplkNlGuELpKXh/y1GHrm9CSPF4tbwvqkoVaS4opB
        eJjha1bUaRm0CTaNEp2KHC7Ka+x4nj4ZfP/UrVSjkEYc3NSjgeZDI7WScmfvzMB5kDBrXQ
        Iqj5sHCKkXGqVvjuLpBY2YcqKUIicp6Eyq2lrKGqsmGIgVsPBMvEwBvewJpKVx6ku5gIQY
        sdtQCQSW2KDQcT7BfggCfidCEd6wmcJgPV/STl4lFCo3ZCTByx9SZ+uutuA7hlbPMIke5q
        z2yVjiEuM7/z2/RpPkAyRTqYme0OZXuraEKFNcEtHkuCESXhVFGVA96vfMWad5BNWdQHv1
        s8ps1lZJrcGflUTsIRglluABmWxMntRsp0BejX/B47K5zqkbw9WbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635089855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=frzypMKwRVpVgcZ5iVmxJe8y2zvG8qBCgtlWq3Z8X68=;
        b=NGbvxmapybHvPPaVyk/zhBH2wTaXglFyFQ+iqCSPaCsc+mAgYXmb8t6SnqOY+uA040RHQ+
        Ty/aXDemBCM0UtCw==
Date:   Sun, 24 Oct 2021 11:37:31 -0400
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] pretty.c: rename describe options variable to more
 descriptive name
Content-Language: en-US-large
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
 <20211024014256.3569322-2-eschwartz@archlinux.org>
 <xmqqv91n6o1u.fsf@gitster.g>
From:   Eli Schwartz <eschwartz@archlinux.org>
X-Clacks-Overhead: GNU Terry Pratchett
In-Reply-To: <xmqqv91n6o1u.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------w9QnitAOWAm0Z6V5nWTcYD0F"
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------w9QnitAOWAm0Z6V5nWTcYD0F
Content-Type: multipart/mixed; boundary="------------hLRJCEmqCW4ETACZG9PTWPRM";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@archlinux.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <bf4d8ed5-f168-6e9a-fb27-df735ff28eb6@archlinux.org>
Subject: Re: [PATCH 1/3] pretty.c: rename describe options variable to more
 descriptive name
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
 <20211024014256.3569322-2-eschwartz@archlinux.org>
 <xmqqv91n6o1u.fsf@gitster.g>
In-Reply-To: <xmqqv91n6o1u.fsf@gitster.g>

--------------hLRJCEmqCW4ETACZG9PTWPRM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/24/21 12:31 AM, Junio C Hamano wrote:
> Eli Schwartz <eschwartz@archlinux.org> writes:
>=20
>> It contains option arguments, not options. We would like to add option=

>> support here too.
>>
>> Signed-off-by: Eli Schwartz <eschwartz@archlinux.org>
>> ---
>>  pretty.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/pretty.c b/pretty.c
>> index 73b5ead509..9db2c65538 100644
>> --- a/pretty.c
>> +++ b/pretty.c
>> @@ -1216,7 +1216,7 @@ int format_set_trailers_options(struct process_t=
railer_options *opts,
>> =20
>>  static size_t parse_describe_args(const char *start, struct strvec *a=
rgs)
>>  {
>> -	const char *options[] =3D { "match", "exclude" };
>> +	const char *option_arguments[] =3D { "match", "exclude" };
>=20
> This renaming is more or less "Meh" without the other change in the
> series that may (or may not) be helped with this step, but because I
> haven't seen these later steps yet, I may sound too dismissive of
> the change in this step.
>=20
> Anyway, at least call that option_args[] to match the way the
> function calls itself, not option_arguments[] that is a mouthful for
> a mere implementation detail of local variable for a file-private
> helper function.


Right, the reason this change was submitted in its own patch was
essentially for the sole purpose of making the diff for the second patch
intuitive to read.

--=20
Eli Schwartz
Arch Linux Bug Wrangler and Trusted User

--------------hLRJCEmqCW4ETACZG9PTWPRM--

--------------w9QnitAOWAm0Z6V5nWTcYD0F
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmF1fbwACgkQzrFn77Vy
K9br0BAAllkcLcfi9va3Sru5dHf5vKMak5A1sr1qZu/qpqvpLzXqgE+3nhYwyK0k
V4ahXCBdKapkemJ8e7oyHFBtOdz/j+vKxwnp3WYhfaR5hs6T5o054HCByS4Jltcp
50R3MgkOAVNv/8cNRsY6MJZsZ/LD4NVsDjmLWq9mfIYdpmfdCfel4k1vKE9imSeD
E9y8+dbz0cEmL3YzQNaKVE2b48cFwjK3Io55RgElN72tMWgLCrKpJeqJCNze2Ob2
amqaFG0MN8oamSp3upFvE/lccW9fiH3Pqw2ERTTmlBpvRMaeNLEGeI04KL9F0QJJ
tXbyr4siTg6OspObC2MohcGLnJRqmaOJWoYrKvPJQexrmKMXLtuPkKnJfSK2RdiW
p6Fwhn5ynSF+7K+3MXka80ByMXfMpfrmclIp4XA7nv7hxf6UPGqmoJRcOeZgTprI
8sqOwCkt6NFJxtdfiI57+/j1LIrQzdTKov6OslJxZ8i6KNLYsy0yYSPwToADe5wL
tv1qvxWRfwaiq+fXhdZru2A5LggBUhQXPsMytoRi4/26sBSRmQ3UHq4PlagzzYZ3
qAigGYhqR3dFax65Zc9PMMaIbphoRARJdpUJGeqq+vT9c3KmtqEwQSjJMu7iDcXW
BusGfyirYohQfXXahqGdyVbqM/oCrcuw1u08KndpvtTIsnY66xA=
=AXqp
-----END PGP SIGNATURE-----

--------------w9QnitAOWAm0Z6V5nWTcYD0F--
