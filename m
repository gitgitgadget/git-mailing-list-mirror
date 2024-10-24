Received: from sonic318-28.consmr.mail.bf2.yahoo.com (sonic318-28.consmr.mail.bf2.yahoo.com [74.6.135.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C981D63C9
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.135.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729772812; cv=none; b=FdO6/NItO1DC7VsDlqkZAU/XN5xRNtz6FtWjuxblACTcPFGwDcYdtgeLG8M8ql4Whs3BDEiSBfhL+lvdu9ipOLLM9AVS8uT9UwpWIhRgv9L6PXaY7tDFuwUSjiUh7H56+JFAJc+WPtIrLBZMSpx77DiBlFM03gU2pafxcCYAE3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729772812; c=relaxed/simple;
	bh=Q2CdjybicLhoRwDP9h8Zx/+TOtsm4qDqk45yzpfwNjo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=S/ODiB8MpTOZDMUx6uyVE9VJ5ltvrTr3D0cz0HuzY4zJQrl0OzWrSGKjUThqk9erF2qlQ6AVC9yC930LadJXda/GXup/rRk+tUWLgaJndV0yG8YHGvNt7Jauq/Z+r5X+DvDPCOyTopUIySOtdhgYmmdFeSMF9zeBJ6k4snprUPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Mt4EmS0M; arc=none smtp.client-ip=74.6.135.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Mt4EmS0M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729772809; bh=Q2CdjybicLhoRwDP9h8Zx/+TOtsm4qDqk45yzpfwNjo=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=Mt4EmS0M+D0xK8beEefK3o2n8rdmYrwI7XR5foPcXcIvJvjefIGMm4H7jUSm68H9H1O16sgD7GUESozs4CKYgfqVqaUV5LEFbT3yF2318UfQ9hDxHTRv1uRq4gf7Gd46z8gnAgjUPuSEQReBG5NwuRW6ljqKRHTtGf9ltCufs8rVzs70W6yigOOktXbhfOe2WFdWvKUNwLMzRTQBCS/HgiNSBWlJvwZpW6lwFR15XkhC4WWzBeXIJOi8kcrmlXBA0l6priTLDG3UQB+rnmnX9eL6aptnN5jxd5zTM5pgklP8RkE+j3REDczSvXjb6Z7SoR2sPvRBd1x6laXsRQT1jg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729772809; bh=cu/GBfY9lvfP1d1uA7DWTIj+YX5lGZmaJwH/+C2Cto3=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=qod4zHPpJpNIRVtFvweQUQtxfg8+x4dAAYbzA1wBstuxmXQKRnK/d+4XCUGVYciLUejDdT47OsWiI/CfgSQEszkWCGjATKY+IQQS6bgIdPPLf9GdanXu9d6v9eIrL+NHOMLvhBwnzx+SCt8ZWOKjG/ieMbRSQjaKN2ph2mkXvrsO02uq+4UIr9l4HO7qyJfRXa/V26eU1qVAjflA2uMKLuhSjLcgu3OjMRhTzC4po/ZYImAd45fMuPfyS4w0pK6CnV79fDgiATBBk4R7HoTB/vR+OMT6yPyb5bVwOgJhReYCSRsShtI1kwtxtdx/KMt3IMyaSVjk3lLE9KKS4s9PAA==
X-YMail-OSG: Usn4SGMVM1nJ7RtU3PE1LUkN6cS.CTfT7.XvONgUpoH9eybdO4AN2BvEG83JJ7v
 Wpm2RN55Mi7T2cKdX37Jsodcqkd.ZcqezWGB7ZUCykwcpCt_A2wjn4lpC8OXgGNCpHTq7onuzXCy
 yP32gNpy1SCb_j0xVxu640Ydo7Ya4o93gwXhAMkArGRXpZ6SJ0Jg9EXq0AyovxXEobS7Rd9Ce6sm
 UiWebI1IL5tEVJNwqC10wtNQYvROoDSKL5_nys0OWgOJ9WpYJ2713HkKAHlcxm5zjqhidR8ID6qi
 Ualsl5r0HNkNqFt2UaKDo8WQdEJ9vsznyV_CJZY2EEDeiZ8SFO6b540Buxqzv_sC_18RrvhqA2Pa
 K17DgJORj3OUWy8saU8118VMVDpWrCjbde39.jFwGf51JvzarTjX_btOn.CwskHZfGteXp2TO0Fr
 NM4Bsnj3brE7Z5rCwfSoyv4eiX6TOR51J9WylASGdccSsPc2OsLgJFLSqZD8XkKxP8yxAR3DreZ5
 wp.nmwE0i9BhENaAVVJGT_MN_V5rntZMU3DiJTcK9ufZL5QOOPphSMStERVjUDtCc27NkArtHCir
 uVP_AV9ZpzgiYC3iYwQZdxwEEcz8cnEWwEjvGDI_l0RIjab_.qwfCsxruPMuXnt1O8wVN9o6MrPx
 FvSoJZd3UezX_c1a5AIwQwYJpiLK2HYR1RPNooEgC997u6qeb.PuvfEJLV7.q8SVIRZmJbPjVxlj
 NMrUCB6vEFq0pvqWx7dzijYNY3KyapgN_Odi24bCu_UOZ6zU5JHF.uuW9o02r_YtOmmiPb0Ho6Jv
 rBaAbkXXt5LCtVAvFHhOXxWNTEJFMBrQopQbRsi8HiudgGfHpBhc.PSSioB1v99es2TXKcNhluM2
 WO5vLpbhpBIKzKrMj7RIgEYtPq0lmniTMd7GkPWPj6QfrPH8Vr6wOswjQW5OXeyoLIGi3djjnenJ
 fH_sfDa1cCiQ0R_2H5r48rv6E3CU7PGytix_uHkkwGlEdtyv9HJJXCofSkMn8NKAMEJtfni.U8Ym
 jHK73a47gzN_WADucRuAzDDSBgHw756X41tEI2pf16dV_n.rnnnxe33ugwISe_ZoJT3zGv256O98
 kyZuU8bIzMmL.GlIIsVr8RaMhZuGOyqEK7d0teV9w0AJaY0BtBpuBntDjCpNSgt6X22sxjIiLYux
 Yka99beD_yu6wyjRczgC8RVbsU83Ll8JmVwEuRLXc1Q66QCwaPh8nJau5BKXsc7gpzGX0D4vERFn
 .2zUMJd7_PURenMUNKdcMYy4sKYmXda_DmYVfZ22R4_5vD1tknLC12_yUbhgARveGEHYTtFjt9l8
 BiqdsVamKWipZ432b2T.GOpTI6o_cdWjNTxfv5c9CPV5TTq6f9EY1a52USgBxmSFRBhtVqiDK5Qe
 XZa3GV8KvkdadX6TynV0IwaNL7NYWDBVgDiJAt6gpZ2c47.TRsjBLZoXNpjloDpxpxwMjdnIZIhY
 gF..YkbWFJP0FG0vE6PBzmk0Dm0r.TzOrMVKtngvc7yuWA76dq8P_aTiGuPAhtV4SQOz.XvXya9R
 jhdmWRj4X.WmlCVQA97KeTfxC1vRMB7GjdhGMaRiVGey4qIN1nFsbj6gnVzMbFDOHDmjN7oDnwNj
 2E2nlYFka1z_F9M6hNyU39c.sWzZR3gtmM7oCYFtG8mq_q4fs2TedbgJHmRdZxnVlZ1jRg7pJYT7
 iESwpPh6gByWHhp5Nuz4l8QNUpWFygJzBvfN9EW88lVWh0ek0obbMa1hpYpygSKTjg_VFDSu5gkw
 E3_iYtmNWwyiZhBP5tFNWrhY80L.S.Mvh7bn8K0b5uJNsxfc7YWMSsm.Ectmfxnlbb9m9.dlCVbq
 onkMtWVyHU7Wue4A.iU0Jg8Uy262iWnxc71.aBUukBzeUoi8cLLrCAuXODXWTu37VIIOtHFlyR.M
 aOvSiGE58kTHEJVg.ID7_aUYv8repNOwbl_SojBpAPt3Jli5bd.JToHNOoewaNAzbpF.twJcu_bN
 nBQbpLdRBGw4BwtZNkWHfpaXeLPPA3UHgCXgWL5Wpj26qm6U8HuwPJpr0U4QxrBQa7Qg4OOJZYIu
 p6_sRPahbKsXSjlDbKfe8weiTlmMGhlPEfzu.afO0kiITgGlXUYd9.t80VfQfSK0GCAS4P3IW6UL
 7Fj3THu5_9C17Y1E49twftpOyA6yfn6ghTJA6fYPX8YFztklQZ8oyNyuqJfwo.DE_4bOUPjKx_1T
 kB0r5XhEqbE8mIOlS9BkQQ5RnLGHv3dG8SWSZkjcES9z69Sh1oGDiVVibFAZQ
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: c2deaa48-6935-4db0-b9e6-7d413f7eab71
Received: from sonic.gate.mail.ne1.yahoo.com by sonic318.consmr.mail.bf2.yahoo.com with HTTP; Thu, 24 Oct 2024 12:26:49 +0000
Date: Thu, 24 Oct 2024 11:46:20 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: Taylor Blau <me@ttaylorr.com>, 
	=?UTF-8?Q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <1101848017.3146876.1729770380522@mail.yahoo.com>
In-Reply-To: <D53YJ81WH001.2KRT4KHARKLC4@cepl.eu>
References: <D52FCQ2F409N.1S5Q8XRAX5YU7@cepl.eu> <ZxfKbsapf3MAUmcy@nand.local> <D53YJ81WH001.2KRT4KHARKLC4@cepl.eu>
Subject: Re: bash prompt evaporates in subdirectories
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22806 YMailNorrin

 > On Tue Oct 22, 2024 at 5:53 PM CEST, Taylor Blau wrote:
> > Are you using the prompt from contrib/completion/git-prompt.sh? If so, =
I
> > CC'd a couple of folks who have worked recently on that script.
> >
> > I assume they may find it helpful to know a little more about your
> > setup, including possibly if you have a bisection where the prompt
> > stopped working for you when in sub-directories.
>
> Unfortunately, I have recently switched from fish (where
> everything works right), so I don=E2=80=99t know when exactly the break h=
appened.
>
> Using openSUSE/MicroOS-based system with all the work done in
> distrobox containers (with openSUSE/Tumbleweed inside).
>
> Not sure, what else I can say, or how to better debug.

You can help by providing the following:

- What is the "innermost" distro where this happens? Thumbleweed?
=C2=A0 which version?

- Which git version do you have installed? How did you install it?

- How did you install the git-prompt support?

- Which shell do you use? (bash? zsh? something else?)

- How is the (git) prompt set in your shell startup file? (~/.bashrc,
=C2=A0 or ~/.profile, etc). If you don't know exactly, then can you please
=C2=A0 attach your shell startup files?

- Can you provide a sample repository to clone which reproduces the
=C2=A0 issue? for instance, you can pick a small repo from github.

- What are the steps to reproduce the issue? is it enough to "cd"
=C2=A0 into an existing sub-dir at the git dir? or is it only broken
=C2=A0 when creating an unrelated sub-dir and "cd" into it? better yet,
=C2=A0 provide a 1:... 2:... 3:... steps which reproduce the issue for
=C2=A0 you, and which others can try to follow.

I tried the following:

1. Download the latest Thumbleweed snapshot and boot in a VM:
=C2=A0=C2=A0 https://download.opensuse.org/tumbleweed/iso/openSUSE-Tumblewe=
ed-XFCE-Live-x86_64-Snapshot20241022-Media.iso

2. In a terminal (default shell is bash 5.2.37(1)):
=C2=A0=C2=A0 sudo zypper install git=C2=A0 # 2.47.0-1.1
=C2=A0=C2=A0 sudo zypper install bash-git-prompt

3. The above does NOT install git-prompt.sh which is maintained
=C2=A0=C2=A0 together with git at the contrib dir. In its README.md:
=C2=A0 =C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0 This prompt is a port of the "Informative git prom=
pt for zsh"
=C2=A0=C2=A0=C2=A0=C2=A0 which you can find https://github.com/olivierverdi=
er/zsh-git-prompt

=C2=A0=C2=A0=C2=A0 so I did not try to set it up. If you have an issue with=
 that
=C2=A0=C2=A0=C2=A0 package then you should report it to the package maintai=
ner.

4.=C2=A0 Download git-prompt.sh from the git contrib dir:
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 curl -o ~/git-prompt.sh https://raw.githubus=
ercontent.com/git/git/refs/tags/v2.47.0/contrib/completion/git-prompt.sh
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chmod +x ~/git-prompt.sh

5. Add the following lines at the end of ~/.bashrc :
=C2=A0 =C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0 . ~/git-prompt.sh
=C2=A0=C2=A0=C2=A0=C2=A0 PS1=3D'\w$(__git_ps1)\n\$ '

6. Start a new bash shell or new terminal.

7. Clone a sample repo (/shameless plug) and "cd" into it:
=C2=A0=C2=A0=C2=A0=C2=A0 git clone https://github.com/avih/shlolcat
=C2=A0=C2=A0=C2=A0=C2=A0 cd shlolcat=C2=A0 # the prompt correctly includes =
"(master)"

9. "cd" into a subdir:
=C2=A0=C2=A0=C2=A0=C2=A0 cd c-lolcat=C2=A0 # the prompt still correctly inc=
ludes "(master)"

9. Create an arbitrary additional sub-dir and "cd" into it:
=C2=A0=C2=A0=C2=A0=C2=A0 mkdir xxx
=C2=A0=C2=A0=C2=A0=C2=A0 cd xxx=C2=A0 # the prompt still correctly includes=
 "(master)"


So I can't reproduce such issue with git-prompt.sh which is part
of the "git" repo at contrib/completion/git-prompt.sh .

Cheers,
avih
=C2=A0=C2=A0=C2=A0=C2=A0
