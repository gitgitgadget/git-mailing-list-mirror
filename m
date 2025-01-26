Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95053C6BA
	for <git@vger.kernel.org>; Sun, 26 Jan 2025 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737934859; cv=none; b=AAfyowPGF3db8HmMnxcyGHCRYl20p+M9FXoYUgozExLkxDQDohfXPTjSKU5k9N6r90DJs5nk/XN8NWOgZLaJuE4njsPWrOeoDidobFlrLLNB5+E+9xjhSzuCOJVtIeTcDg286ZlJV/kIzwZNrmGo3st+gZnKpEaSDOlmUByMorQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737934859; c=relaxed/simple;
	bh=iaaRAefEdibboayThq17FSdMCzZe4zz5igxwMhoFvL8=;
	h=MIME-version:Content-type:Date:Message-id:From:Subject:Cc:To:
	 References:In-reply-to; b=Vfg7F+XpzRcTpEwpakn4jbeuhyAUMHWipTlfABy3Mh8ImoxnFYOrgu/ZVWEjc3mqA8EIbTcPTxY2Hls1LYMiU1+AK3qluqQljY7e39GniX5W3PjmwOQVBKkkPgceI9gStMotiGDt/R8uckNqdmzZut8srg+gctKh8ZkaRY38kAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=Q/BdvhFF; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="Q/BdvhFF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=sQOpT+U40HV1l6lXoZJXXC2zu/zcZSbOAT1GB+pZcTM=;
 b=Q/BdvhFFi6oKxpH/1WPtNxGSvLX1DheKmBikkrBtrKAdIOaIHWpIPNNDAfLPbH6/gy6yDm0rJIWT
   eP1iohdJ+Y2CLdSaY0C1qlHK6E7h9QW2DqHpCEkjdckFzhyzdg04L56na8rmGdjU/eZaPQUUuE5l
   yePkqP0uvcCOHP9Tf7f6qqQ4dtbPmvj0fvCPkX/qhMHE+6Bd2DsKjF9f8sHF6TPA2Os/9joJP8/A
   Uc/iMbonpcl5XuR33SC0fISKa+NaSa7LwiePM4hYZCr4iSdIEbrVyIWlU4JP/MP8/MSErQeeynF/
   rMJc5ifqaRU1NYf/rxuYWXNrHNboWO0Z2Z+WfA==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SQP00FH0YVP4X50@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sun, 26 Jan 2025 23:35:49 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Mon, 27 Jan 2025 00:35:20 +0100
Message-id: <D7CEDCJ0KKYL.YS0EWVFCN72X@ferdinandy.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: Git 2.48. Changed behavior of the git fetch
Cc: <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
To: "Danila Manturov" <danila.manturov@jetbrains.com>
References:
 <CAM6buW5KSDGHD7txroqVa0TN_Ou_eV-LocMy06cPy0ZGDQmY9A@mail.gmail.com>
 <D6ZXVILR1D36.3W0QVQCVE1P2J@ferdinandy.com>
 <CAM6buW6NbdZ6wLGP6LWePiA7n0At=jxxqtBEUv0fTY6mOdTmyw@mail.gmail.com>
 <D705W1554XJ9.30SRYLNGNOX4@ferdinandy.com>
 <CAM6buW77CeuKfr3b4SUbYyFaU1OTvRsYBjPBE05YMzJo36bGdw@mail.gmail.com>
 <D706LPHBPUL4.3LN27T1UG1FI2@ferdinandy.com>
 <CAM6buW4UiCs9pFeH0cxxdhLHCSNO9wLVz9_p4Y0u8LaGWy--ng@mail.gmail.com>
 <D712LKI48ZUD.2UK8FX0YZBEYM@ferdinandy.com>
 <CAM6buW4e4c_3BgPo_GU64Fvi7XGcP7tuxdaap1LypyFCOZvZEw@mail.gmail.com>
In-reply-to:
 <CAM6buW4e4c_3BgPo_GU64Fvi7XGcP7tuxdaap1LypyFCOZvZEw@mail.gmail.com>
Reporting-Meta:
 AAEkiWhq0EG1gZapZIWHali/NrpvDCS0vNlxOU3a7Tf5LPoVXBLXBcYNTg0r3k9M
 EDtRlbVeeKotJOPpDrhG/Upjc5/tf5L3fDo7TWKxy4boT5x/ICH39cSIIlHGdI/B
 o4Di3kFGTD6t66AQYtiClBhFQ+6Nvy4lA9VhFIrY+ON14dn4jzd9b8pMhs8jN70i
 pnW81PA7Py9zUQIoKugbkcHNSVpHt7mB6rVVeOW5iDLdC5Cvf53SMNyQkwy4jsu/
 fUCZeqIP1cY4w6FJ+bsijKMa17i1e5APAKh5ag50X8VR33WvKBsdmilQN6S5R4Pc
 vN6RUU7ftRW9CjbK5NnH1P2UCCtwfP46ewr3Dnq37YfQ8PvPMiDEXKr+TMtXJTmq
 aYUtaZYFOHXx1OSEDA0gMOgPXmi8xXoYyDaOojZqZxbDcWZXBlGTg1ICCZw0UKqv
 e+8rKq8Cy0CDTuFyfZ/949kZ+9PHo8vVZwDIyDUjRdwGkRuJ3z+PZi9a


On Tue Jan 21, 2025 at 18:26, Danila Manturov <danila.manturov@jetbrains.co=
m> wrote:
> Hello. I have done some experiments. For some reason, it works
> correctly with JSch. With native ssh/https it doesn't work
>
> On Mon, Jan 13, 2025 at 5:03=E2=80=AFPM Bence Ferdinandy <bence@ferdinand=
y.com> wrote:
>>
>>
>> On Mon Jan 13, 2025 at 15:14, Danila Manturov <danila.manturov@jetbrains=
.com> wrote:
>> > According to our CI, the first commit where the bug occurs is
>> > 5f212684abb66c9604e745a2296af8c4bb99961c
>>
>> That makes sense, what is more interesting is why the fix Junio wrote la=
ter
>> doesn't work in this case ... I didn't have time to dig yet.
>>
>>

I looked up the original thread leading to 6c915c3f85 (fetch: do not ask fo=
r
HEAD unnecessarily, 2024-12-06) by Junio, which fixed a similar issue (see
https://lore.kernel.org/git/444kgiknevb3kwtypjjc2glryaav27t5fafgyzqq5257w7o=
4pf@4fngcyfmvfcp/T/#u).

Originally Josh there suggested just changing the order of adding tags late=
r to
the prefixes should solve the issue. I don't think we ever actually figured=
 out
why the order of the prefixes should matter, and Junio's patch solved that
particular problem by just not asking for HEAD in that case, but it seems t=
hat
the current problem can also be solved by swapping the order of tags and HE=
AD.

This seems like a band-aid again, and I still don't get why the order matte=
rs,
but I can turn this into a patch if needed:

diff --git a/builtin/fetch.c b/builtin/fetch.c
index fe2b26c74a..7147f06395 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1768,6 +1768,11 @@ static int do_fetch(struct transport *transport,
 		}
 	}
=20
+	if (uses_remote_tracking(transport, rs)) {
+		must_list_refs =3D 1;
+		strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
+	}
+
 	if (tags =3D=3D TAGS_SET || tags =3D=3D TAGS_DEFAULT) {
 		must_list_refs =3D 1;
 		if (transport_ls_refs_options.ref_prefixes.nr)
@@ -1775,10 +1780,6 @@ static int do_fetch(struct transport *transport,
 				    "refs/tags/");
 	}
=20
-	if (uses_remote_tracking(transport, rs)) {
-		must_list_refs =3D 1;
-		strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
-	}
=20
 	if (must_list_refs) {
 		trace2_region_enter("fetch", "remote_refs", the_repository);




