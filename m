Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794214534;
	b=PRBnfqombxzIFpaWu9g6LzX+8iJpbWFtRkZjqKZegl+WitSfaxHTmVV70JQGZg4jEghz
	 +RqZZFsSSCir79Twmn9jzoDsTYkvAdXau+plMgNiOCYZGyCK6pJKxXQEb7fbCLlHvasIJ
	 dr0gMbkbfpkqLZImHGTcxgqn49+kdJb5I3irNN6tysLQpkpALLVxJKyZwfDPIQOWYgnam
	 8se7nFADNaIYXBHfxZEaZKdit8UT7MFpQvYBZRzKYcujNfTAmQlBxgwHR5zX3VYDmFbAP
	 Uz6tdzj7U8sJwRH9YDzyLyLGArufQS/LSJeR29OhBQdx0zRH0FXVyPU/WmTD2qVNcNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=aFjdLI1DksHDU4qVq4hhUvCgDMY/2+ADHwAT++xhooY=;
	b=hAZYaRiecTB5rW8nknvSVKXEvyY+NSb3TkuIgXQSzer0y6/34cnYsCtlA5My3ObGFL0G
	 u4sXwK2SMh1LSjr2UOztfdHvR5lnTeNYo9ibvNYhqiW9ztib15fvuOifdCPEz/lw2E8B5
	 S2edLLfx4v6P2lP8HfDSATsoShZL5f2Su8uvSgeLsiZ+cP2TWjmdzfitUGQ3ju5DMfy7k
	 ELrmwJXnNvShJDZPnqM1d5gODmAKQwGVpyoOJZ6sNql+wmnnBNORx4WShUKR5m1TOsLuD
	 0baFCOrSLnK9wEPIUo/OdCZxMBk1APO1cahbCZwOiTiCsPSgipTaxSFQjdpSHj4dPEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nkjCbSy3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4583F606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 08:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4583F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nkjCbSy3
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1931ff67a29so1685193c88.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 00:55:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794214533; cv=none;
        d=google.com; s=arc-20260327;
        b=KBnkRPaYXTt6bqNvXgbar1pkPZafOomlttEyqdFQzGPZnItliKWcAx60TxIrbjTsTj
         P8kRpjfUMJc6dp3lJg56pxbUIEr2MgmVxqT8C5HisJCudUnD3Gzb3L22tGosGezrvlG1
         TiRt22Z25Z2nKKDKJqvGHcRbncCX7JKK701hMH+R693wCzod0NluutaKp2jKZyffeOfh
         TRKP4VtjiE0VZH1yebFpW/B19wswj40FSTe52dT+TjiFxNc55x5z/76/B6zsQHp7hnGI
         JmPclKq9PX8v14E1obD2T1RMZiSVMGw/ejxkm+gZBDxHMFUpt9Tdi8TPLDmMlKmfLR9g
         AUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aFjdLI1DksHDU4qVq4hhUvCgDMY/2+ADHwAT++xhooY=;
        fh=tqPyQpPIq1RQBDzfA/60bNGiMx8BLjNhCLYgbYxFAtk=;
        b=N7wgF5s0bIS3E3NCgKli4UEevFjFxhe7WfklJjMy57hwmQ8jyqeUKkEwB50RBQsrz0
         sMzsHhOX4TorClagi9ZxqA9ASQ0TakQwqTux8SdQhktXxg3lkhyjdwfM1VSjep6dB0n9
         lhZA5i3ehNs1enayHMtDhZxF56RfOJhGYBc/5eWBmzN/1+cTQG7bfn+1q12uhvqx/HaP
         4nuv+Twiqb1u/PUqVECkSlEQ8ZLH3xvbibNhQFxSqWStf/eLWTZ2TqYyMsuAXzoOtmDY
         lsNuA2sUzyJgrpq6sPeHGEmvz4WOflC9dAsCVyvfB3Vjhab1r7wNhJ+HUPQ7ltIOHqRi
         fgIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794214533; x=1794819333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aFjdLI1DksHDU4qVq4hhUvCgDMY/2+ADHwAT++xhooY=;
        b=nkjCbSy3ZF+TeUw/WQSQL5E7NHYbuOJJu0FX1Z9Q8xyZoyF+o1bhS/6joSIMDqtaJa
         gs0VDHHabiQaIn5GtomCrQsloCYd+q/l7B29WMdqfvmwOZz/iHPgZZ3rC+IDPm17nt03
         lH9Ngx7agvF449ClDDxr0sMFGrAUTL3t2L3l/+r1sXS17TvtyUivSQZEztFwbjSfZJtF
         UXoct580V/kz9xWCjwB2YMmcuyumr1u6ZT8ab4FW3yCVBm5Tz5dUOaKO5zv6UeGugRie
         nGONzM81Djpmd4pZiiDA2UJk7NzEktDnmo+NpSSqwlfFtcBnjOLR0+nFjiVwrE0gLjId
         yFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794214533; x=1794819333;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aFjdLI1DksHDU4qVq4hhUvCgDMY/2+ADHwAT++xhooY=;
        b=P+JHRynzrnq8/4QtkG/GKJWx6kg9T+ujh5HdANCJRgubPdIssmtKJ1kFknm4QpH2Ri
         MAfhsGr46S3DJP1L+9JH1+9y7OM6XeOqPdblqVkQBRQnsQ4EMQWC1R9G8FwsA5LYkKpc
         mo5stmdPrUy+WvzWL26NpXTGvX9xBW5uh/ZHMM+Fdbbwqj1tCa4yNL4obmiHyFpevj33
         yaE4GFINH7LHy/QYsUk18qdFS4ebtMKA5FBACObm5ZY9JbpyD9+dNmdeLqDRoCZB/xh5
         IvXtHVh6gJOk5yAJETSyuDls1mtlNE7K5v/xItS5z1lGdtt0/G6PB2HMFeabCID3YWMU
         TlbA==
X-Forwarded-Encrypted: i=1; AL+hErE8uh4UhauMxndo1kTKf444fhxRoY2bnH0LpGC636+cD5EkQfNXrp8p4uIloCQOA9Foso0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EOuI/mPugALBdqpg3QjV0B3kig5MH8S51HVjWYk1eeb0xg90i
	hAoAKiHvFolB0g1CGfw8nT9fPgBdqQjZMLB5BpPbQR5qsvdzbW8PW2BYvL5/11h7EZQQDl6Q0hR
	CCmqtv/m8utwM0ztOkzHkwd9y263mKoE=
X-Gm-Gg: AYBFou0+cL7bRhabJLbToTyLMzzeOA+YpUSdQkWE4K6brHnhQeYoA9Qt78cpIOC6/9m
	ZOZPIoG26B3po9gHeoMJax5hVw8sufsJ5PWdueP32WpSPVxqQSJAbZDW2DIwkgka5dIp/QtTVit
	eO6pFaBI+yHhOn0S5p2VKa0dEdXmNDL+0ZLJioIezkLHMqhVMdGMsI+NxQvD5H+UOKW3P2c8Xvw
	PyfUX+ozdmMIn4RxpyyBAE3X6lMwgwyPpZzIqLm2JD/lzIwpbDAJTJk/eTNjACg462jDYJ/xOEu
	MEHyZM/ykljFzAHH59jjPkAU0bhk8xkoo9tOmJ4EOgUtrRmdiA7su2MwzMhDUyXZLp1taUqPeGk
	pN3e6qNA1hfEcxVxc8tRpq7gG0q/2oOPVplZYwoZ+vz7lkN04YIPL778fbe2mmM4BFVMPTaVpEK
	Cr3kRGndYATu5fzao1xtKo0cwBaxAIjGEsiCSy
X-Received: by 2002:a05:7022:296:20b0:1b2:649d:dc23 with SMTP id
 a92af1059eb24-1b39feff6d9mr5812446c88.35.1794214533161; Mon, 09 Nov 2026
 00:55:33 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2479.git.git.1793632435937.gitgitgadget@gmail.com>
 <xmqqmrrqg7uf.fsf@gitster.g> <e977b49f-8462-4b63-bdff-daee75994a36@delpeuch.eu>
In-Reply-To: <e977b49f-8462-4b63-bdff-daee75994a36@delpeuch.eu>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Mon, 9 Nov 2026 16:55:21 +0800
X-Gm-Features: AclHuK-PTfEXYz4xLNwYSbb4YRD48DJB9WsepBBy3qck50qsEp3a_yiu98hsNaM
Message-ID: <CANYiYbEkTaRPdCLO=kovcAkAoiTt=+Z6=OPhCu9Qi5F8UShe9A@mail.gmail.com>
Subject: Re: [PATCH] doc: document the current project governance
To: Antonin Delpeuch <antonin@delpeuch.eu>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 8:17=E2=80=AFPM Antonin Delpeuch <antonin@delpeuch.e=
u> wrote:
>
> Hi Junio,
>
> Thank you so much for your feedback!
>
> On 02/11/2026 23:57, Junio C Hamano wrote:
> > "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >> +This document describes the social structures in place in the Git pro=
ject. It intends to be neither prescriptive, nor express a judgment on the =
merit of those existing ways of working.
> > Can you line-wrap these?  Even though once .adoc is rendered into
> > .html or whatever presentation format, how the source document had
> > its words in it would not be visible, but a single long line that
> > has an entire paragraph is very hard to work with when we are
> > discussing the document in its source form.
> Sorry about that, will do when I re-roll this.
> >> +The Git project develops a free and open source distributed version
> >> +control system.  The scope of the project covers
> >> +https://git-scm.com/install/source[the git.git repository],
> >> +associated repositories hosted under the https://github.com/git[git
> >> +GitHub organization] and the <git@vger.kernel.org> mailing list.
> >> +Other spaces are considered external to the Git project for the
> >> +purposes of this document.
> > Do we want to also cover Discord and IRC chat channels?
> > (cf. https://git-scm.com/community)
>
> Happy to include those. Perhaps a dedicated section on communication
> channels would be more fitting then, as we could also document who
> moderates those spaces.
>
> Do you know who moderates the IRC channel and the Discord server? Is it
> also the PLC?
>
> >> +[NOTE]
> >> +=3D=3D=3D=3D
> >> +Not knowing exactly what is considered part of the Git project or a t=
hird-party project, I have left the following repositories and initiatives =
out of the scope of this document for now, but I am not sure about this cho=
ice:
> >> +
> >> +* https://github.com/git-for-windows/git[Git for Windows]
> > What do they call themselves?  A friendly fork?  https://gitforwindows.=
org/
> > might be a more official entry into their universe.  I dunno.
>
> Since they have their own governance
> (https://gitforwindows.org/governance-model.html), I would treat it as a
> separate project and keep it outside the scope of this document (despite
> the fact that the distinction looks a bit artificial to me as an outsider=
).
>
> >
> >> +=3D=3D=3D Project Leadership Committee
> >> +
> >> +The Project Leadership Committee (PLC) liaises between the project
> >> +and the Software Freedom Conservancy, Git's fiscal sponsor.
> > We are a "member project" of SFC, which acts as our "fiscal sponsor"
> > for us, providing non-profit administrative, financial and legal
> > infrastructure.
> Is this a comment, or text that you would like to see part of the
> document? I think it's a good idea to make the term "fiscal sponsor"
> more precise as you did, as it's a confusing term for many people (who
> might otherwise think that SFC funds the Git project).
> >
> >> +Those members are renewed by cooptation, after consultation with the
> >> +community. When doing so, the over-representation of an employer in
> >> +the PLC is
> >> +avoided.footnote:[https://lore.kernel.org/git/20180821020849.GA2527@s=
igill.intra.peff.net/[Re:
> >> +Git Project Leadership Committee], Jeff King, 20 Aug 2018]
> >> +
> >> +NOTE: Is there any existing process for leaving the PLC? (for
> >> +instance, if someone has become inactive in the project or is in
> >> +conflict with the rest of the project's leadership)
> > Nothing that I know of.
> Great, then I'll document that as such.
> >
> >> +=3D=3D=3D Security team
> >> +
> >> +The security team triages vulnerability reports sent to the project.
> >> +They do so on the private mailing list <git-security@googlegroups.com=
>.
> >> +This team also includes people operating widely used git hosting site=
s and packagers.footnote:[https://lore.kernel.org/git/xmqqbj9d3y9x.fsf@gits=
ter.g/[A note from the maintainer], Junio C Hamano, 1 Oct 2026]
> >> +
> >> +Is the list of subscribers to git-security public?
> > NTK as far as I know.
> >
> >> +How does one gain and lose access to this list?
> > By asking for an invitation.
> Thanks. I think it would be worth documenting who is able to add
> subscribers to this list. I am assuming you are, but are you the only one=
?
> >> +Does Johannnes Schindelin play a particular role in the security
> >> +team?
> >> +https://lore.kernel.org/git/5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.=
de/[He
> >> +seems to have the lead in triaging vulnerability reports], but I
> >> +can't really tell to what extent
> > Why don't you ask him yourself by CC'ing this patch ;-)
> Makes sense, thanks. Johannes, I would welcome insights as to whether
> security reports are triaged and acted on by you alone, or whether other
> people have responsibilities in this field.
> >
> >> +=3D=3D=3D Localization maintainer
> >> +
> >> +Jiang Xin coordinates the localization of Git by maintaining https://=
github.com/git-l10n/git-po[git-po].
> >> +
> >> +NOTE: How would their successor be appointed?
> > Not limited to this, but there is in general no "appointing"
> > process.  If there becomes an open seat that needs to be filled,
> > it will stay vacant until somebody volunteers.
>
> Makes sense. Here again, I should have asked my question differently:
> who is able to give the necessary permissions to a new localization
> maintainer? Are you an "Owner" of the https://github.com/git-l10n org?
>
> Or would you just stop pulling localization changes from this repository
> into your tree, and point it to another repository, where the new
> localization maintainer would have the necessary permissions?

When I created the git-l10n organization [1], I also added Junio as an
organization maintainer. Although having multiple owners helps avoid
the bus factor to some extent, rebuilding the l10n repository, setting
up the related GitHub Actions, and changing the repository URL are
quite easy.

1: https://lore.kernel.org/git/CANYiYbE5rcnD_VGJyL2CjS-R5E0pyNSd5TetvH849W6=
wC5JiAA@mail.gmail.com/

--
Jiang Xin
