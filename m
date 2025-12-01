Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E7030BB94
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764595549; cv=none; b=o3d9/2xKG81PTcS9uYIhhF0eOeTeZb3VCwuGbyW9na8hw5AzNoHbL65Kicl9ipY3eLH2BaBVTYNBN0FfGkiYfq8Oepen9jeh73W0HRfgWn8txb79bLOHt81mJTk366X8gR9CqIoHDEfdRVVaIvNUfSF6yoP5GAwUviTyJWZYV5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764595549; c=relaxed/simple;
	bh=9L1DrQEocEu84onTg2Rpy6paZ8LOIIMTlMOQ3t4wt+8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gEnHKExwdrSsXXhYZqHgA5ehsmldp1ihGDePfaaXVUv+H9PQ4hz89eVmn/DqtAXUyVER1ExiWJ6HzpRqpnJ543mLm3jf7+YMtR+AXUxMRox3tgUxRP3W9am8R+n8/JuDo8aPp20VE3PgRapK8O3XFM69vDEXFMH6gqN8dDfbLPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=EssL2qCZ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="EssL2qCZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764595541; x=1765200341;
	i=johannes.schindelin@gmx.de;
	bh=CstGpg7zu2uXOXFR47jW9TzJwbpyiCTNPGickbNMLJg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EssL2qCZaneJz9+rwmwCscQHzZg3okXfclN+T2Th6f5WKFnzokZPB8u8o1jmwNSW
	 fiyIzBS85Mw5fa/12Z3deR8qh0zlPBL8ikZmnD2YpQGzKyIQZO89Ck5rcJMa0S+kt
	 b/ngnpETGEgskkt0yxQ+mF511dV7BqvYgRqOmXn1mNkDjUdBBZqsuRoe7NX30ZvKz
	 SVL7yZOz7EzokXoigSe77WDEwPXezIvMKTsrN6P7DMh7V53KETIJWYfR3V9qHM0je
	 CnzyyeaoIuS/1A9rUPgzfzzfosOfrfrFklbboIR5TE3ChoO9CyC0lXolGT1VepvBm
	 RwZY8xyc+1ybLhoDgg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbRk3-1vweho2D9t-00jF1K; Mon, 01
 Dec 2025 14:25:41 +0100
Date: Mon, 1 Dec 2025 14:25:40 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 05/10] t0301: another fix for Windows compatibility
In-Reply-To: <xmqqikescar1.fsf@gitster.g>
Message-ID: <e355d80a-a0e9-7795-06cd-1b8acfa6c7c8@gmx.de>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com> <c59a5f24789cff55819caf92d828256f2291b3ff.1764440906.git.gitgitgadget@gmail.com> <xmqqikescar1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1RjPar4ys0pS/x3B7R6GIaGS/277oF1S/HV/LFuAi1LaUGYvVsR
 FPYOhnHfarAP7Js+pnC4vbt616sg/+XMez6ZvirNJqG8Hn6UQ751IrX7k+M4WP3K8ymtb/2
 MkkNPIpPkaw4eK2Egf8FHJemUZUiXYJol3dd8GKR4jQ5QcqCB/1qen+SiXrMYVg1q+rcZbX
 c/tmB74mT1ILIbembeFZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ktU+GVcSn70=;ZkwF063Tahlp/xvAjIR/Q9izK1c
 f0GJi4s8MPczOHsr9M5Vm6xK+JdSJXrMJ89yGmwSVWb0QQDr5cPytKDTKP4DSCb7oT4CVShoD
 Fzkx9Elhvy8OLrLFTytCXedPjxirBmrpAJYxSWSQsjFVw1IkjTpjB1CvWL8A7eXTgz5koRDgp
 Qp8Fk71UmyqA9z1s9spdAII7rUMjN91opx49xLcqd0pZ96qhOvZaFWEQ1VcZxBdTYhv9TLroX
 48LVA1CaXu8RXW+H5KUruaD7+Mv6pp2cu99K1F+ztqGxEejZvRiCVDO+goB0qVH2eZI7CRu8O
 RD7tvTkAA1o4CwBF3e00lks5r6zJiOGapqjdgcWYhSWZk/8fOlgsoTOgpf83QBDyIjsxChNCr
 O244hR82zNneogqxzwvCh6EVOQB1tc+/e4FE+za2+eZ27mwkrZrG6+60XIbQvHMJGI06NfNZK
 zzCwDZUuUAW0d/ZcpQjt2qczKTnb21D65Conm0iWxhuSmUATrC/l/fM7lypTf6IvjeY5Jdjn8
 m/CfIwKKiuOhNAWXmxZZI4ZzUekeHyHSwAbni76o8ZA5QYZYel4PrO/k5B75YbJGLcILZNuXn
 wE/Oj6duSJLCP6zC1FxljDJrVEhQG/Y7jcjbd4TlmR9KIya8zmAaaN7XLDVbVGiORGhNqNept
 x3FaAbVPtOxomrPCYrZue0KHdiMpIdQSMGHYaK8q/gflRQbWM2ZbgFYkbmIB2yCKIM091gLNG
 Ed4/wbJMX616awd84FzwnFyEJ/pM6lKgQA5uxcs6i1T8+9O6jJzrO/RXZfcqtYLRGdjgOUO4C
 Mf4cssp3WG+duRQpy5xMUx5/vvnWjWXvZWp9qEhZXh2ylVcrCDdaR2N7ojapXM0abPY4N4jSi
 pFyHLRI71cbPMwnJe+u5Mk6LBf/MK7GWFb9J0SAS4APkEkWkNfR9/oLMNc0zcR6uFfJMH6wLB
 0BCovNO2r60QRNVrQM3gyV7NHo3dZ6/+r9tZqLXLw61lI7MaDKE/Z8w4LNsWFVw2Labv8kZOF
 6C9Xu/Amt3GEAg68kC7kFoupVdeKUMrQ5Mv1VInJNg9IPuPT3jUoCPWo6bXdemP9eYqLL0oPi
 zZGFcZ+/pdgMRmd6T7BSLdTzoQC0S1xGnGEyROx+k2PEoT4H1TBNEdJ/Y+FWQKkwvDkUVAkdv
 tZY1DtpaBN48TtwIibmXnksdNCqDNQE627+5U8N4ByRBFoLTRPqPYDi4GRg+s4KhvzrrFXU+5
 FNQ6EZ/p6D/UFjOmd/FTTy9ekAUNqOl/mxDuavfkEYtUQpkzl05U0X7u4Xg63fz3mbNl0TqMV
 RxsFtD3kNIo9k4/w3mso/5k6RkcYnD54sVWnrupeUfYlwars2uBd2Z75G8mC5Gx8otU/S7Jzl
 4j9+OXMO3K93d75jV028ptc21UDmq6bfINa6S8oPuqYH3lNufRxb9PMneGaXuy91NDECf7meD
 Bw1KEvYrKxijtAMbRQ/scP5mmE7JN4Wu0UGq9q3LNbjpQ6VSE21YM/cjVuBWsLEl5KW8OWMFS
 ZjVuwGIxH2jCWICalVUxPaifgrUsssQvszUA0np8iWiy2r1sE5snRbYoTQzZfrz8VRPh51owc
 /olRw0DIp0peTXdJ/4VQqcYdsWDQqkCqb4egU2gwyVP/L6XTp6odEYCxi1ETkoynVSpBCNB3u
 MYkQW6xPjmPRrLH1D0DsOlnfoKmgIzD9sPLmyNp2/k0sPEEzIMEykhjkG+TyM04c5v82hJoSg
 uaU40Z/eaJQYbJ+kXKNgOul0F1RlRw1igcSYC7rXOqOt5Vkz0I65EBnM4sunnXfyXwpnyzmt/
 yQ10QKuDOT2wzoTG7ackNfQr1TO55JQaBfPfbzPI/+0XO5eujirrH2Qpp+i7xSlFNrcHOVQPw
 3sV1reFFdvItjcgmaJ/jL4tJre450oh1IrbeVN7qSOxxzCqYzI6sXdIeeZ1Lr3ItQVr3pMKKT
 2lPVFOpRCaFx0hC8hXQuuR5oYVmDl5w2fQnN8NJHoW375z2NUAd5Kw9mhcGlDJSG3rPZ8+atS
 AqCB+UlEuSXHZjUqVi2J/nMv8EML50XqTUNq6IeB41UgXEqCxtLj21/FaL+RZzFQfJ+bGrBGz
 CGc7P8DWvIe9BGiwO9BSWlNAb3xHqHfJT8/lqr8EJm1GObDc/Y0tgV0n4CIViCUHBIx2z6be8
 xahsmpbltnUvUWMHFL+n8bISTPwLM6sFGrYKE2GiJHEgVE74uFFMGAAcyklTokruMilg9MQAJ
 hPVHdvYgASOyZw6vbrEGruuJ5UoRBpe67KZseavv2yCX5TwVrzIokuEoOogNDCGbocwUM7lhO
 JKSc/8QtRypjE0cn+T/ieZiEFWskRUEgKXEOiNHej250nTdO0lwejIK0r83dQLAHrhcFZuxAS
 5zC2aSZ4UvKEY8C5N6QZAlQMT5hRqxinrWnsEMSCeNID+XHG04DTl+KCGjP0AR+V77zXYSsH4
 u3KAIO2AbvjtlK0CfZuGto7cJgDO9RrU5OcvBOhi5o999GArd6nM/LkG33C4K/kwwNbAe6qHs
 5jc+nxizoO0eLLJZk2FlkNisCbhwpTnFnmtDWkMR2OcJbYJua67cb5koN/b1m+0onvqJ5zhBo
 AACtL3L7sK2+ZC8YDCKz2gZdQq/66CGR4PQFlWfY50U33s5vKXDy03qBARo+UrfocKwejwsft
 84yQmKUoGkQKOEQw2UQW8zyPbM7FZrf613qUG5Iapy2m+GQnDcN6xk3N3OTqIMOd1TMHldZuW
 r9XSn/xybj3J5ElAUzLvjNG76i/XRHHqP6VVD4KtAhN5HkDFa09UbeAiZxtpauogwKMd3Eai7
 sDM7Jb7PD6+98fc8bqWvskTOScUqg4lozDTGznyYOzKsl4eePecMRiZR2L1aKWpe8ZSB9ehuC
 J82IYD25IwPvlQA2hk2kTu8Qo/7LpdL8HlSuOEwmVBBAyUMZwZpbTTtQLRwGx+KY7E0pFGgEZ
 pENw8TaXClnhNjqo2BCOdjgOLzXirtJuqnOTSmb5Ui2gXtnsNbCICNP7KG+81YfAFAgU4pBi4
 8w9kalTJWfXEPLJ2Jt74GygNddQgiCvsD91Nqeoa+XYEb6N2b2K0/UlIQqq4yTrkFZJAv35Y9
 161dggMzAtTouZRsAKvhqntc0+PX9JDQM7OTCc7FlnyyNJXyxVZaP5kogzOqnq6lofb+vP7or
 RXFCXWnQyeLdKJ2K5hjn7BVE9wrdDmJzXfxqE+wCFwbmAVri1gZfrMwU0dAyEGXmvqYcxDTXa
 lHYItQmt4KBhTVNe/4BR22BjIWqEDFVJ0H0LddxYSe1Af3Pup/63iFXKE0dDufomriBA35EGe
 b8cextejN2rxiSThUFu2jxZ1FPxniuFJ7cCvgf3/HcD9AJNp2XXyf/pyPhEjJn1WcJWp5Pn3b
 m6goFAg6itJLP9P8WERq7M318Rl4OCSf5YADB2tPyOMWCZuBTWHKLebndaHUiVAcA/4riwcz7
 NbpVHqLDbMcEt7/8VMJM2gmnFBm541Ndbthsr4y+IQOiGJqoa1c/8JiCUK2rD55mStXMkAp13
 diw7ck170mh6853yKdGlL13Vsn2MVij0rirP0dVCkSgZkbFXnsg5d8Fp4yzfA9kMHhkzTqMjz
 iG0xlwMLNdPY2KD7JVUFMnHEVExj/gtFWNfvdQBLAeezQLATWniB/TOCRmjyseHc90vxh3ATp
 dPmNTEKB0ixpPkpgqCtNeWojPP9hMyAAwgle7Nuuznx+fD6H1lamTdjH6diHWOkJHiuQJLzzA
 XhQtfvsZv+nu5iEhyNAS/a6sNThFm5sq9EIUtsuEIPqTbcSCoWGKNYyK7hf2PoGE+TOTIMih2
 CYeNJfGktgc9CZMb9XJjdE9r3w01L5m3VAN5LglmhC43rsnWDHk2+krbnzgz1TsEI374/FUqG
 zhCn35igAZ1R6tJXdygaYXICw0pWx3A9KeTfxQhC2p94j1o0RK8vOdS9beO4NLR0mJztZHOCj
 Q4ycfRDjF+Xo0Uqt4dcrb/EMMKde9xAeHsjnp4UMrmKoNciOx54oyHBXu0UJl1DG8ZPNGS+si
 9yeJ6lF9AseCjF8rHRC9pmukuWe1w9S05VqhN0NcqiWm5GuiZBFag12mO+rO/IUJIdHfoj3Hz
 iMNV4MGST9CJ0bmg24EdfZo7OYgs1p1SXWwUE9AhWsMR8b0qewU+hODeHrhC0CqvImnRBXCst
 j933KgTpxTiiyPQjpEy/5jY13S4UJ1X0eBOtVBjVBqvpV30nxSJs7fBRuASvkIg8SjDUJQdbp
 zmBHo/kB1FwtxCOHpYu57+P2WzShxHKGHDT1UT0lrk1vf/WfTdFbdnQ7088l3dTlpXlHKquwi
 Rh0PMDG2yIVtgV42C33ciMFFxmqPodi/JnTks5Hom9Q4aTX48+QuX3CPfMD+IzItnCknWpCPG
 LYACtNpGhvSreV8/bnM4Gm2ObMWkt9AVRRzNg0e0jLv7eLgldPdUoqyjxWBooRlVLyIbpNXvK
 ifT/z1YwnEOuRsuYQdMI/nYdmP4c4UF69X1lTp5dieTM1C9uw30NEdpLx4dFV10Fos4JYMLd4
 PY1YF49deRCuKGoxxIDmZ1MQFi/0E2+578xNsvDCAmwR4XoFyvjfB2daJjXqKNRjAMj4w2VJs
 VTq9A3+HX5sO1zPn8vpzTN4WIF9oePGriGQHQY49L7ml+XSFtpvp+8TRsS2csA9xoebd0tk7N
 i6rqFbmUDL52UHYM52YvIzcXU6AMVXWX6oNU52XM90T8ke+xjRdvKDjYcmnpe25wpSPv6o9jW
 vW5IgwL+qnJzeDVZm1lCwjegCywrvp5WiK9u8EEZMlha+zbS/ymd4TKC/UCsGrlHkDlQX/kw0
 DAtPbHuZ7J1HGXrffqhusTU/psbXFGA+U0J7BPPI7K0f5yatgJiyU/hkIfjdYkWHdUtD88/QD
 ZerqXdEf+V9YOMZUktAJzmv+MMJxcAQDFaTqcS7YXXmufZpXAxi5YdcEQYHx7vayJCFJsaaXd
 Xm6kHJXcxHMMdpKy+n78fnYsl4giM56cwyR5DqUfICZ2fWNOXbqAyL9dau737ojR356aiieeW
 2Hj0WZWqKwgK7tyJsSEnG3bqXm1dHdM5EYzXEiG95O+SboK7QAKvEuyyRNkaWAQO+uHaao9KX
 DrCLCK7NaIGc9bSio9ZFcMC0eEwNZ5Cme8KzYAyPna2R7pNgR5oRpjCqQ2pqE+eJWElOMcadH
 LjVPdnlc=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Sat, 29 Nov 2025, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>=20
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Just like 0fdcfa2f9f5 (t0301: fixes for windows compatibility,
> > 2021-09-14) explained, we should not call `mkdir -m<mode>` in the test
> > suite because that would fail on Windows (because Windows has a much
> > more powerful permission system that cannot be mapped into the simpler
> > user/group/other read/write/execute model).
>=20
> But in this case, we are emulating "mkdir -m 700" that is expressed
> in a very simpler world view of ugo=3Drwx with a much more powerful
> permission system, isn't it?  If something is more powerful, it
> should be easy/possible to emulate a simpler system, I would naively
> think.

It is probably outside the purview of this patch series to question why
Cygwin's `mkdir -m` doesn't emulate Unix semantics let alone to fix it. So
I'll bow out of that tangent.

> In any case, a more productive than rethinking the "can we express
> what mkdir -m <mode>, which is a construct in a simpler world, wants
> to do in terms of a much more powerful permission system?" would be
> to see if the test linter can be taught about this particular rule.

Seeing that this issue had to be fixed twice within the course of over 4
years, https://xkcd.com/1205/ applies.

Ciao,
Johannes

>=20
> It is easy to forget that there is a platform we care about whose
> testing environment that emulates POSIX does not like "mkdir -m
> 700", and it is a bit too much to burden developers to remember.
>=20
> > There was one forgotten instance of this which was hidden by a `SYMLIN=
K`
> > prerequisite. Currently, this prevents this test case from being
> > executed on Windows, but with the upcoming support for symbolic links,
> > it would become a problem.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/t0301-credential-cache.sh | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
> > index dc30289f75..6f7cfd9e33 100755
> > --- a/t/t0301-credential-cache.sh
> > +++ b/t/t0301-credential-cache.sh
> > @@ -123,7 +123,8 @@ test_expect_success SYMLINKS 'use user socket if u=
ser directory is a symlink to
> >  		rmdir \"\$HOME/dir/\" &&
> >  		rm \"\$HOME/.git-credential-cache\"
> >  	" &&
> > -	mkdir -p -m 700 "$HOME/dir/" &&
> > +	mkdir -p "$HOME/dir/" &&
> > +	chmod 700 "$HOME/dir/" &&
>=20
> That "mkdir -p -m 700" is a no-no while "mkdir -p" followed by
> "chmod 700" is OK is a bit puzzling, but I assume $HOME does exist
> in the testing envioronment, so this new sequence should be
> equivalent in the simpler permission system.  If it works fine on
> Windows, that is great.
>=20
> >  	ln -s "$HOME/dir" "$HOME/.git-credential-cache" &&
> >  	check approve cache <<-\EOF &&
> >  	protocol=3Dhttps
>=20
