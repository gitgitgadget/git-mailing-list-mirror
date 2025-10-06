Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3B022F76F
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771241; cv=none; b=l1HAR1HJiaa6bNjvZHMk7Qk0I3YS0aI+IIKzmvPUgGjJcPTsUk+SCjettPafsNxJdjDOhSGcNg8QaemPRYbNLyN0J9EvfDnrPIUFRU8vPzyPXcW+PQQ7qo49tXHRtqrJOuV6Xai0FIflz+ji4Dp0Ju70Z4kPWPRi0U551mG2cto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771241; c=relaxed/simple;
	bh=ALP3oFiACvJ5fJFla83LNH0D+73WdB65gPnpTzLIeb8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tLzyNZizmPMmMFJiZ7O1mYtfMdnUkrC3VUnnmIyY4TJI1uaudMGvwtLsuuW8iBLKVZyRLMWwmuz7wqgwyXnLaZmP9Qv+CYbpUF9kSdvbTWHeN0JhMYR55mSuZOWVmgtOhZQ33w/Fhkf7PSMAsQs3MToiK3Wr9o/OCAgZH3rS+hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=bKbQ6q4r; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="bKbQ6q4r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759771231; x=1760376031; i=l.s.r@web.de;
	bh=sKPcWb49jjCaq+iQQ+sbf5UFEdmnNdxLI7tZDPfJdsY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bKbQ6q4rqTt5k29ECuV6aHtMj9ld2RXH2tW1nEYzF+4PEoenWpw7eI9KWspF213K
	 yVv3epPlI25oAhcMdswRgIuxEI1WvFoxwoJzw8YLugyv5mN3IgD+SG2Nb8kMrpXge
	 7/Ej8lAcs0cmTZnQ2H8FnZPmZdnp9ex713yKizHH3wJZBBPpIEEx9iTViKNaFeW8H
	 fGyAOv6dD2HRJu1H4EL6MWw9e2xmnDc7pOXwMejQpd5mp8tyc19G+LDrUXE5G5LvO
	 Q5VLuVEn6xn+xM76Z6wAEcNDJHUXoTBDIKs2MbmhKfmhURXnneLjTLSUKE5e8IAEQ
	 VHxSq+QK263E+eEEvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.16.132]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6JxT-1uCHck3Bn7-00upP1; Mon, 06
 Oct 2025 19:20:31 +0200
Message-ID: <6603453d-e2d3-423b-acff-c9cfe1fbbf82@web.de>
Date: Mon, 6 Oct 2025 19:20:31 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 2/6] add-patch: document that option J rolls over
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Cc: "Windl, Ulrich" <u.windl@ukr.de>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
 <fe8e8097-2b05-4dd2-a754-f59e4ba5f95a@web.de>
Content-Language: en-US
In-Reply-To: <fe8e8097-2b05-4dd2-a754-f59e4ba5f95a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PUnyZLXVl7020S/fvACjEECNfoaxoDa1/5jRL3fmIXvjQ+/GiFQ
 XDfTpPil4CUk4PkuMukMUo9se03SgeSFvzHrS9lellIz9rEaY5aFzsdMzngKfAjIsIbxoJE
 Y6hQEntG8GKQsh0lMcMo2Wfu3vrd1ap/8VUFHJYZ3nEW/T3b0uePr8iZMEss5zlLrAdGZc4
 ArJNEBL40YcHTR5pNLyAw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nIObAizv2F8=;FUoH8FQ6v7aqeVWwPt7xUmYCpQ3
 uAjeT0DuPs09X3gnD7KHja9JpdPMoiQT2Ht2SxopqaAH5gIZQWGUtAT2qGxEQijdfqNwcFFed
 e7KrwwPzIguKEn7GZPZy4cveQX0e8TiJtDW+alRcYMwNa8VhOwwt4wM52rWoBAROl9AiVwqG4
 6ps9FqbkZg+ixdTA5/ICMi4LjuvKUQNXLawORSSXS3Dbm5AcPPHzC57cLNvPl730b4OPDGyYA
 UPBvdc5wrWStb4rMA7I45ydnN61PC4cAcEtMWObtlU1Os2KPcLP16ZqOoVX08PA/DpeGb8dtR
 Af0QiETu+7sZ/IsSi8yL0KQO72ndOYiQ7O/mnaAczT3Nk4OeMW7UOe/XX9iRa6Y+5V+n0ryqd
 cajbENvTqSSbWG6udUR2XWhqyo4d0OZ+C0ZN2e+DGJjTGD6OGVegu/VYWeEtWHIsSYGQyDhBt
 76QKzV+R63fiqqDyX2EMlT187fsMlCIDG6G42/Iqzvg58G1i1CZ358CMoTNBdDjvXL15nf5Bb
 kwwA+eZLWHt6djxT0nY+hQOhQxuqCO7ezIXJ/2SxrukMdh0tE7os9puIb/XT6ttoBLVhGUg6k
 ADFsuPFQWK+TK9L7CmCHOBiWyjzD833jcnNE7TAztIehp+EL4ngEwLaBcrmjukXqLXkTIuOkj
 kcCqXWYCLcy4tUzeQUfuUZj9vPDteA8jNvR5G+qBcll9tvHbZ8FIfrW3wW9K9QXeLCA/QU9WX
 k/WCYL++QXxENBNBQx3Ku44QObml/NuXTZF7Koy84ZLAeiE0nqbzn75VoTb1IliTEwb4z9DlN
 /hkATlywme6/cpULiAuX57oaiRQOhndhquQ+XU0WNJr+vAI3pTD/ixUfmHbHSfZvvKbBd/1ON
 aFiTkH+MYkLh7SKJpFFPqbgxE5Ug1GCwmrpBBqV2U3jSKdZiBQIDqoRDvHiqOeqTOCWzJ9Wok
 +kP6sMI8YL0oGZRMhN/7CnakTxBubPuPoah7mNiRGC5Y0TtdeZFtQ4my/3jOa5l+VXyXv8otr
 moBwsxtIdkTSvgwDwyVqD6mLbor1+52bnlG/Fq3ZVKIcyeUtDyqDNCwP3QIOhtCQyGJ9HuR1d
 u5beoUoWpeENOv9/LXM+DD+4mC4zzEYqT0nz8PT2GyfQ4o0NCpxwpue3TR/Zt40VVfuA8jcRW
 2mL5Sy8m9LSD1G9aR65JiztYIHNKmU2wNYHJHXGGgPBWlM3gYZZ0fBajWcviMU/l8SiRp0nSg
 F07DADgsK19cfMqqMCwvrRtAQPGoGZFHpCISVQYge+oNGX8ed2VoYcYX005ReANgkTervqvzG
 b8f8qAJ5HiUuGxmzJpI2Lq4DQ1pE17X9nh+NjhiDLY/d1SJm7hykb4/Hu96CAXGjqva2UdBj/
 Jp42rqIlLgfji62/KHiCPwLjCMPQzbC5nhqg+7ZqXDvCmIIVe5fe7wjFRPvWzJqbwlm0O3Ap8
 xZvZ/Ctva8G4lwG/27kGYIXgDJsi4depGLjZ99/Y4UHso/gvXubiPgLPXle3ITBW8Go54255/
 VtMCuAlqJNiEiP0mLvGzgysqC1jyS3LLZmSXNWOLG2jZKc6t5KcNtxyRYQgZf32xurEWVOy7i
 ZvxOcKOPf/8q47JjAqpUkAXR76RZvc8dn2Idf9V7kXoLjvMbXowmeW626B05nUkE4I/7vLhUG
 yUSLnyCFQcO4uEgr+kw2jiqQxBheBXUaoN+XuTrsmVAwLe3jrPY5q3W7i3rsfRC5ZXmE5tA+D
 gxcgBwrK1DZYoBQt23X2eG1PhMwfWpLaO9XTR34o2U986nuyvN1pYA/yrLti70rvwPwyb1lfc
 6yTAPpjTYQ6ZC9RvNkGxKitczxnHqrU7sWCmT0xDyRiREiRImX0xgq1QyfQWcff3HkqZKiI73
 SouTakueyKp3ycDMhm417MUmuUdhMjA7bR5ctvFwjIkpc6e5pbq37ZVbhHQMDe7hvDaydum/g
 VF86aG88wTUzPj1xR6BPTMMLNoQ13Dd89wK6LU0vwaERq8/gQ13agbtXTuC32PGOyLHhY9uhx
 YGO2/QOGeTIWjU6J8BNHTpR+Ch3jmbhfnTDQSyrSSQENbQgNuwHumYAAJVVWbvu7X5Jpw5D5e
 Wo2bzXeb2GJd98Qnpa/ytBnQhpFVBF1zLvfesWLADJbTpUNT1vfQSEsLg655VzvsryYZhzdNJ
 Fa057bfMqYMDfP4m0gch/wEf09cf3mRDJlND4Q2SQKC0p4CcqWpOAQf9Wza3xr0yAraMCCjnp
 u0N5axCSfnml74Yi8QGBy8cpFFoNJeYqVf34wKL+DtgSCzgAJjgekTEEcuLadoG+K+rdm1Zc+
 JxRlFZTBefRSCeGdn7biEE+aqzMEjr8qqJ/BmZTAX4MVGKRoWACEqPPDh+fd2Tn2Lgl1PL2xL
 aNmf4msb/vDXPq64+8/v+xVAKiMGeazU1FmM4ZNZYwwI06OofOd7hhYUV2NusK4XiMVSGGpT5
 ECm132KKEmbXoh79rfEbah8T0uzdKS1VZaJuSghKQsOQI9ueOMA9Mp1VGipZx5s+1bhXqIdg4
 DbCoxEzwRCoqkfqS7Jwj68K2MHjkNB9W9RZadD2Ptc2kwWiNbMhOebfM8HRhvAUjo//bZnFoU
 MPu8gL6lXesFHezrpjZnRgdL0kW+8jM1m/qg57S4VXITW4a96E1kl0bVbpQuXEXB8WvJXawhO
 CNVrTmc5KynVjPLcaS10thoS+E4YMN9MTYPEXkNjGtK/5yyumD1NaverGO8OwOSm10y5at3Yf
 VS/Zz7bNJcvRnGqCA0oPwfrhoJHOIEYQ8t+Gs9s7bdsnC3IbqqziCWAtsds6VtdaYMd8gtLFW
 cb5HrBNFCKbD/Nyr1ugVZRQWp4TELEspOl2eqVlZ1+882Opq06X0h1vXl6fy82tZzAqx8kLW+
 2nsOAftDWKVkYKjxHCmjfcUNL6ZL9i3JvzQ8zmqMZ5hnNXwhi0HdBZ1h8ApcLu30ZEByDoK+2
 UxV8KU2RItkj4iq5Lxx57y0py4+F1FoFEal1S00jYhnbo9/rXR05T6ixsERAbmXHlidt2+Zq2
 f7TOoljBL0B7TiJAm//DNykQ9SRWNLKl0nL0CJKUKBAlnxAqRPvcNNbBpGwfQome++O0JlrhY
 E8hk4FuM9oDggQrxFKVq8iNl+zpj7OjiuwopdT/uBVjUiftXoITOCUELgEAgUdQCHt6lseKr/
 p9LpSaiaHTwc6+KhQuiUuHC2MjjcdLzNQLItqV5+eF0PRud9WgRBRnaXPT87Kr0Ujx+xoAqVd
 3/iXDkp5qI5FR0xyNjdjSo7H5Ca8TjIq8VldIkN7+FWtJ1wlvJGb/LvO2EEiavBBf07jbOIff
 LsIqeuN+aCmbAbaNErKI2TIHknduh1TnvsI70zEStXVPT39R2RDLq07Ln2IXgpCMTftdWZYbs
 4n75tzP50LzXyOukABeBgmw023w3DCbtbEgmk1yfh0oyfdOFIQmfmFWPFkAXNSMe17iQLkF2c
 eaU+HQnFGG0aA7G3cEsrW8ViPCGx90dd0Y5vnoVVssteqAgb4dv0hmfUygCiY9JhJCZUg+c9X
 GI4O2KI9iA1VZrV02o8OEf8DsPJaetsT/3PZGxoAonrNvpmC0y3wytCIWIF8RKT0ClmkZMD8p
 wV9m9E477aJ5F7P7gF56xiJ+qk9ndSG6/Gl9q5p9wL1GnoefdO5cYdC51B3O206VB5kQbmdj8
 ScC3LpcU6jU/8ytJbPTv10ohz1GSDwnjA7hfo7NSDkbuw7U0VoPPycD/YsxX6ZxdIF0MVDbBY
 SoYmO+po83BXZ5skw9jM5xupBQ3pDbxZ7/jqBB9pezoF80kyKpPf7/duom21oGYR5G+5WYwmX
 hB3IZidGJCN+DNBBhwNuMSvg73F5DFmYX7V09dVNT+QWp72sEzlTt2W+cVdj6JwX7IZ0ATA1C
 HhQ6o0r2vYv6t1wjnTh1qXC8AGbNBtJQOH775dcpwcP4Z4oZBg607Itw5K5R3CGxf7VqTpQUZ
 WN5miYqnVRw3RIxArBBe8oxCGoO65pmlpJ03u5DwCBqPwQ2Eks+TuC/UV98/Lik1MA5npsPOG
 f7XFCWDYu6IWEJYSvf28prfIKn5FDIbpCiV1OCEKsSGTXWaJ91Mih2edWzrXD9QJyqf7YE2Q1
 ajusdtb0gPPTkRE2ELKiYiIEgn12J7gGpMmFxf7Sn0Tr1UNyAu4qfiyD7M+DjOgyM5xSTFNgJ
 tk8Nj3TF6mYtWhgDjegsfjsYwpArbhIqBwnjfkzf5jjDazc75Q24Yj/YHRnv8yaxTWw1MxOt0
 pyO0gF3vXUaTUKvihewkMA7zNbukL4lYfA3syZpV5JWcRrtRitND6JTKN1pnHPXBdUW3T2+jD
 lHAS3J86CoOd77BV6e/XtJXmRluD4BoH4tH7xMit7nRC2One1I8oe+/9gMXMdO62jnebByOL0
 kj7C6dQfelTECzhUDddRjPJUTBlzjoFwxkGQKUW1ykvmVtaMa0JVbYnlkNwiGeM6WtPJQoGan
 k522ATQXG1Pl3F48P+nKB3nBGJLrPKRByaJG2lpDSiGjdTijjjFOfwY/KWLIfOZh48AMGQr4Z
 lp6pUByINFJdOoEA2g8gUuN/nNOuOvw4NDvgj+neRET3QdK+yyBjKBbsH8RednExWnsb+daJ9
 GftvzI4QNGK4uzNF+xWiQFqK1JbROS+O9Q2NryOMRGOiDkzAV78LZrekyEnZWe3VSATO80fS6
 D5TVmoFgtRT4rr1uDmW6rCXt2V+NnZOcsGtQVF+FG70amHjkjtzRi42j7yvXD9oSc+t+duWs8
 6ifzosLg5jdowUp8oFGGGKsiMX8ktrd3ZA9g1AVaSUzkJAQszGVjqWGhxjKMtS/u4sUK5a/k3
 cAXJloAaIfaW+vMKFL0mZf52FS5H6TJYcAdo4AxiFJD720hBwIRYZZiXt6hyuFhtkbIdCqFaR
 tY2E1XgLR0ElRCNiLJZiE+mafr+xY2XtwWkOJ27H4sAgW2TjHDNKC37zK+1Cb38xi+cjQLQu5
 jeBfRCxaTdtLOGaIUYTE4QffdSjt4AQN+Uon2Pr01FTsvhjZHuo1uNRK7rc65CEepvsYBfHE9
 /wHUIc8l8KiFGj27EIQb0zDz3HSXgFrd8YPsv6cSSUIdCEC0ovGXZ26WjHXOTvcL01kUA==

The variable "permitted" is not reset after moving to a different hunk,
so it only accumulates permission and doesn't necessarily reflect those
of the current hunk.  This may be a bug, but is actually useful with the
option J, which can be used at the last hunk to roll over to the first
hunk.  Make this particular behavior official.

Also adjust the error message, as it will only be shown if there's just
a single hunk.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-add.adoc |  2 +-
 add-patch.c                |  6 +++---
 t/t3701-add-interactive.sh | 18 ++++++++++++++----
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 3266ccf105..5c05a3a7f9 100644
=2D-- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -343,7 +343,7 @@ patch::
        g - select a hunk to go to
        / - search for a hunk matching the given regex
        j - go to the next undecided hunk
-       J - go to the next hunk
+       J - go to the next hunk, roll over at the bottom
        k - go to the previous undecided hunk
        K - go to the previous hunk
        s - split the current hunk into smaller hunks
diff --git a/add-patch.c b/add-patch.c
index 912266a3f8..1f466ec9c0 100644
=2D-- a/add-patch.c
+++ b/add-patch.c
@@ -1398,7 +1398,7 @@ static size_t display_hunks(struct add_p_state *s,
=20
 static const char help_patch_remainder[] =3D
 N_("j - go to the next undecided hunk\n"
-   "J - go to the next hunk\n"
+   "J - go to the next hunk, roll over at the bottom\n"
    "k - go to the previous undecided hunk\n"
    "K - go to the previous hunk\n"
    "g - select a hunk to go to\n"
@@ -1493,7 +1493,7 @@ static int patch_update_file(struct add_p_state *s,
 				permitted |=3D ALLOW_GOTO_NEXT_UNDECIDED_HUNK;
 				strbuf_addstr(&s->buf, ",j");
 			}
-			if (hunk_index + 1 < file_diff->hunk_nr) {
+			if (file_diff->hunk_nr > 1) {
 				permitted |=3D ALLOW_GOTO_NEXT_HUNK;
 				strbuf_addstr(&s->buf, ",J");
 			}
@@ -1584,7 +1584,7 @@ static int patch_update_file(struct add_p_state *s,
 			if (permitted & ALLOW_GOTO_NEXT_HUNK)
 				hunk_index++;
 			else
-				err(s, _("No next hunk"));
+				err(s, _("No other hunk"));
 		} else if (s->answer.buf[0] =3D=3D 'k') {
 			if (permitted & ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK)
 				hunk_index =3D undecided_previous;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index d9fe289a7a..d5d2e120ab 100755
=2D-- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -334,7 +334,7 @@ test_expect_success 'different prompts for mode change=
/deleted' '
 	cat >expect <<-\EOF &&
 	(1/1) Stage deletion [y,n,q,a,d,p,?]?
 	(1/2) Stage mode change [y,n,q,a,d,j,J,g,/,p,?]?
-	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]?
+	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,?]?
 	EOF
 	test_cmp expect actual.filtered
 '
@@ -521,7 +521,7 @@ test_expect_success 'split hunk setup' '
 test_expect_success 'goto hunk 1 with "g 1"' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
-	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? + 1:  -1,2 +1,3          =
+15
+	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,?]? + 1:  -1,2 +1,3        =
  +15
 	_ 2:  -2,4 +3,8          +21
 	go to which hunk? @@ -1,2 +1,3 @@
 	_10
@@ -550,7 +550,7 @@ test_expect_success 'goto hunk 1 with "g1"' '
 test_expect_success 'navigate to hunk via regex /pattern' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
-	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? @@ -1,2 +1,3 @@
+	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,?]? @@ -1,2 +1,3 @@
 	_10
 	+15
 	_20
@@ -805,7 +805,7 @@ test_expect_success 'colors can be overridden' '
 	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET><MAGENTA=
>@@ -3 +3,2 @@<RESET>
 	<CYAN> more-context<RESET>
 	<BLUE>+<RESET><BLUE>another-one<RESET>
-	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? <RESET><MAGENTA>@=
@ -1,3 +1,3 @@<RESET>
+	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,?]? <RESET><MAGENTA=
>@@ -1,3 +1,3 @@<RESET>
 	<CYAN> context<RESET>
 	<BOLD>-old<RESET>
 	<BLUE>+new<RESET>
@@ -1354,4 +1354,14 @@ do
 	'
 done
=20
+test_expect_success 'option J rolls over' '
+	test_write_lines a b c d e f g h i >file &&
+	git add file &&
+	test_write_lines X b c d e f g h X >file &&
+	test_write_lines J J q | git add -p >out &&
+	test_write_lines 1 2 1 >expect &&
+	sed -n -e "s-/.*--" -e "s/^(//p" <out >actual &&
+	test_cmp expect actual
+'
+
 test_done
=2D-=20
2.51.0
