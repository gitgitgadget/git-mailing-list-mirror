Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792444507;
	b=4Tcu506vSsWz4dZ2lKUN86ddJdC7kP0mSh6oyBkZ339CQ2UAW4ChjVkCmUC2u2i4YJrd
	 QcmSWJbOqBcpvF24qxbFlc2qbE+lxYyxIX5Eg95lGRQXClWdgckNuLAq7/lWqGZCyISZZ
	 JqGR2d0/VDWbqSV24mdcp531oTj5hmVPW+i9EKYMzU3LykNENwrlUHQcGod2EsMpM8Q7s
	 LrKyGvAabpC23iz9ZveK+LW4ffsuV9CfjjvLl2RUoyv4yH8N7UWqSZppxfmxbnD+o+yjp
	 Rs7H38r2uzpGef4tRzIhLFNDds5kenSg8sYae0GLSfhxbr4QPU7eRRL3LdhAVrKJuaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444507;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8YlCq0DyLu3niY6Y97dw0tmbbTUFVqJcAYtUzoyP6/4=;
	b=DQv+kQW5ig25r6fuoJ/IgE+47/7QGMUXOh1MGQ6/BS15sZ8WQtY/lYSkYhPrA0DozhZv
	 oWXJwRVhnWR9icqMUR6Q/yaZ31JQO86PG9zchDxtFZ8LNbsAkL5f/s2RIk/HRA8wC4AEx
	 ZIVob12SUPY+9TRF+zgaqKttm0JeeSbjk/eM8wl/DK31a2RypS8fTSllb9v3oK2HShite
	 zfl4RwNHgGrKjz7/k8iNXqVkQYQ6TmI/J3Tj1JUV7anR13IcsItH7tQZPjpJ0Z7clZcGe
	 uLWEdTUJ6vkkwhzI4UpDThKwlyRJbMz0rwf1b0oyu1k1Pq5dyblKWjVJLG65M1DZDrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ExQw3RQL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBC2606A31F
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 21:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BBC2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ExQw3RQL
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso1531433a12.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 14:15:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792444506; cv=none;
        d=google.com; s=arc-20260327;
        b=TKRnSpLLAETlABGtf4CxjCY68qFPZGRqckr2IPxrUUDwXmSeJN7pmJ2UQvqIAH8/r+
         KlYorkAKrZTV1hd5E6xn1WX56YC4pYahA2+/uoQMNIQQRxymJuzGpd/JDnpE1/aH62as
         aUms/16porO7Xkn1ay2F2RwVqQe3AgpMaiMmiFWco+Rqm+Tn20HirCOqlrC3i3e51S/t
         CVC+Ia85dp6dnLGaFw9FlIczLTg4NHoFm6QH5ZK1IbeRtVbUWtV+svggfGsddI6+hk3G
         UoiKHCqQ8JUm9PGSeZK1IrXp+K64G0DXpKb3Piwuz0CXKF/fX1nCyE0b2l0fJiwTz2mG
         ZhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8YlCq0DyLu3niY6Y97dw0tmbbTUFVqJcAYtUzoyP6/4=;
        fh=YbY8NHlhod5gtTwcZMl8kOBjX6w4l+9txBP66HjWYv8=;
        b=fMFThhIEy20yPHXzl/pfRllMFBant2B+KkxW/LJsW7qJ176yh8ZULj8or6bucYtgoB
         dL2xJwkHUSwKaKCrK0H6s0ZYy8IXTETorOo4MCelXErBg5IUleRhuZ75Ei0SDUqn5NXi
         LJQgo5JL31soPpPbxGX3Zg6usJch8PxjXjttKE3xSxcuzis44oGKxvItLfMlQP62Hz+T
         DbGQX+/6Ypg0Gjs8BDofabm5QHD186OdUjbEgSgWmFWTlKG5LDLffhaexDPsFB4lxgui
         nI5By7GS/fvs8Kd4u4aUX+zdml4+UpCkUri2rydxjPnB7SZShD8eajhZsvzcMi/HBjd8
         s3Gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792444506; x=1793049306; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8YlCq0DyLu3niY6Y97dw0tmbbTUFVqJcAYtUzoyP6/4=;
        b=ExQw3RQLJeSmybjcUe8rJXLHHRK9k0bzBRq2n2nj1izxkb79qtLdJox4mGdkJmPIeh
         HP31eBCZiTYp2RVxtlPfp0y5gwBWJhiybobXV1P9Y39Lj8yZokFqnTFUuUnItlabs3AL
         sfyQmF4TiYD5b2mwVtZ/TD7D8vB/VMs8QVGYsGkIDZUHEs+tnhlh1Kn6mW4jhx4PcgZN
         D48jj47IkC1t7nE3HB83DjwxpbHO4oaQzGPZWMEpW5k1YffyMqsOLVqZhyRWDP0yzpsq
         hMvZXL4bbL3bsn2UG6NeM++3aXbRuOyAXZocLllmiMOtG/YNjSVX21oHR0m+nz+CJpwC
         en/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792444506; x=1793049306;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8YlCq0DyLu3niY6Y97dw0tmbbTUFVqJcAYtUzoyP6/4=;
        b=wxL3ladmeBMgRsvLhOHpL44tmLSUP0qNk3MgLe1UCZ68GTW1pMTuB6lx8gpGLeIgRH
         EhhkJxsTD1aIebTpRmVADCxer8+oc16ehzV3zcm+ignlbN7T9+8nb4o+OEuCqxKDDU4N
         wLGmtsTPP90BHtpCPmr3kzpcCHAHJY+nhHoMY3GkEiJiZtPA1Spg6OKRbnDlgRZ6RAJG
         OhOdUxt4f1jFesEC3ygvN6kQ4eIYCw0uADQpM5xZdq7x9yNpxwjysQJr00ZEedBU5lfe
         +EslDMpgHL4UGYnBMD+fxmzM19GAQaiPux9WEBdeJ6RcKKpUWImeTibQXdyndkqawMB2
         +oeA==
X-Forwarded-Encrypted: i=1; AKwUvBz3I1QfKkEd4RoxvPPxwuONlzcyzQFuTkWeXwQBshKQrr6aC2TcJODnCTyg9pv3Mafkkjw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIttrF2sZhsAQXPrnP0c0OFAkNqIy2eRJbuTFmsnJEQMIQijiha
	kvFV5TBp3SMxaP93AoxFj+2FZOwVeUF0+NePfxa6Lod10XUe9zKh0V75rauOqMDGJFISATLdIN9
	3fk4mK4DntccqZY4F4bcfieAeEv+zPzLslvLi
X-Gm-Gg: AYBFou0Ulok/9u0fP5JWgnMd69DKKW6kOWXtAfY23cZkwRqd2CfHptnSxeBokRzyucF
	96us9FPhRZobKgjUPQwmgFg2K5l0O/FezOwtGec5T6Gsx+vxHMLKtWd9d01os30J9YAUnkP63Wd
	yZeu+obf59JGKfV4CDXHBd08xBk23Bc5SsHPQasimWJSLp7CylfqtSIK5vnqZVjAH5gCd/hPtRX
	n7YUJBaZh4T6M2/fVh+w8q28QrtlgiDxknntyFg7eWfZ6BpF53y1gSRG1TU8lXCwqiAV3P0V+qy
	TxpLC2A/ttpplgxDpU67P35ZxTV8ky72QfpnVqXkgkssmDncr71Jgof3TTTVDpbGui8EGiiavSr
	c8G98axFi9eP6U+GtyAyDlipn6WIzubEGMvp6SocTMbduLF0swbx/mNnq+8/P+6VXZp6C7pl7ks
	02rxqrPLXjWxTRyafSDg==
X-Received: by 2002:a05:6a21:7318:b0:3e1:379d:f953 with SMTP id
 adf61e73a8af0-3e2260d4d29mr7789431637.57.1792444506298; Mon, 19 Oct 2026
 14:15:06 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <3a38b208-2640-46a9-b486-9be614d71480@app.fastmail.com>
 <F1D19B27-6BA9-456B-A43A-41D7B597F749@gmail.com> <ed7e07cb-af42-4e14-a576-0e0810b4b4d5@app.fastmail.com>
In-Reply-To: <ed7e07cb-af42-4e14-a576-0e0810b4b4d5@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 19 Oct 2026 17:14:53 -0400
X-Gm-Features: AclHuK-4R3xVSZdHqhS8dANAeDBpuB1xelj8JtpRPyJK4WOax1Svv3ByHU0EJsw
Message-ID: <CALnO6CA2kC3sE3FSvxmaQZdkvXHzFe78FPy_j6Z=uDpmht7y+g@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc: add new Git tutorial for beginners
To: Julia Evans <julia@jvns.ca>
Cc: Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 4:43=E2=80=AFPM Julia Evans <julia@jvns.ca> wrote:
>
> On Mon, Oct 19, 2026, at 12:49 PM, Ben Knoble wrote:
> >> Le 19 oct. 2026 =C3=A0 10:25, Julia Evans <julia@jvns.ca> a =C3=A9crit=
 :
> >
> > Acknowledging the original was a long email to begin with,
> >
> >>> On Wed, Oct 7, 2026, at 3:48 PM, D. Ben Knoble wrote:
> >>>> On Tue, Oct 6, 2026 at 3:37=E2=80=AFPM Julia Evans via GitGitGadget
> >>>> <gitgitgadget@gmail.com> wrote:
> >>>> +[[step_2]]
> >>>> +Step 2: Introduce yourself to Git
> >>>> +---------------------------------
> >>>> +
> >>>> +The first time you use Git on a computer, it's a good idea to tell =
Git
> >>>> +your name and public email address. If you don't, you'll get a lot =
of
> >>>> +warnings from Git. To do this, run:
> >>>> +
> >>>> +------------------------------------------------
> >>>> +$ git config --global user.name "Namey McName"
> >>>> +$ git config --global user.email you@example.com
> >>>> +------------------------------------------------
> >>>> +
> >>>> +The name and email is so that other people you're collaborating wit=
h can
> >>>> +know who made the changes. You can set them to anything you want.
> >>>> +
> >>>> +To check if the name and email have been set, you can run these
> >>>> +commands:
> >>>> +
> >>>> +------------------------------------------------
> >>>> +$ git config user.name
> >>>> +$ git config user.email
> >>>> +------------------------------------------------
> >>> Ought we recommend the newer forms (git config set, git config get)?
> >>> Or is the idea to remain compatible with older versions, such as the
> >>> 2.32 I happen to have in /usr/bin on unsupported macOS 12.7.6 from
> >>> very old (?) XCode?
> >
> > I think this got missed?
>
> It did! Because of the plain text emails it's tough for me to scan the >>=
 and >
> to see the replies (">>" and ">" look similar to me) so I missed them, I =
don't
> know if it's possible to set up my email system to make it easier.

No worries! I wonder if your client can color different nesting levels
differently? My iPhone's Mail.app does this and it's really handy.

> I didn't know about `git config set`, I put it on my list to think about.=
 I
> claimed at some point in this tutorial that it works on "any version abov=
e
> 2.0", which is a claim I didn't actually check yet, but I do think it's v=
aluable to
> support old versions and be explicit about which Git versions you can use=
 the
> tutorial with.

Sounds good. I prefer to teach folks the "set" version now, but we
both care about some kind of backwards compatibility here, so I'm
happy with whatever you decide.

> >>>> +
> >>>> +Set your default branch name to `main`, by running this command.
> >>>> +Git is going to change its default branch name to `main` soon, so t=
his
> >>>> +sets you up well for the future.
> >>>> +
> >>>> +------------------------------------------------
> >>>> +$ git config --global init.defaultBranch main
> >>>> +------------------------------------------------
> >>>> +
> >>>> +If there's no output, then it succeeded.
> >>>> +
> >>>> +Step 3: Create an empty folder and 2 files
> >>>> +------------------------------------------
> >>>> +
> >>>> +In your terminal, create an empty folder and change directories int=
o it.
> >>>> +Later on you could follow the same steps in this tutorial to take a=
n
> >>>> +existing project and start managing it with Git, but we're going to=
 use
> >>>> +an empty project so that everyone following this tutorial has the e=
xact
> >>>> +same files.
> >>>> +
> >>>> +For example, run these commands to make a folder called `myproject`
> >>>> +
> >>>> +------------------------------------------------
> >>>> +$ mkdir myproject
> >>>> +$ cd myproject
> >>>> +------------------------------------------------
> >>> I don't know, and I'll probably bias towards what you've already
> >>> written over asking for changes, but: does it make things any easier
> >>> to read and follow along with if we "git init myproject" instead?
> >>> Perhaps this version plants the seed that it's not too late to start
> >>> tracking any existing project, though, which is valuable :)
> >>> I wonder if you had some rationale for choosing this particular
> >>> sequence? Just curious, now.
> >
> > And so was this.
>
> I didn't see this one either :)
>
> I had no idea `git init myproject` existed! I do think it's nice to
> make it more obvious how you could start tracking an existing project.

One of today's lucky 10,000, then! :P

I'm more than happy with the mkdir && cd version, even if my fingers
prefer to type less (git init <dir>), so as before I'm happy with
whatever you settle on.

--=20
D. Ben Knoble
