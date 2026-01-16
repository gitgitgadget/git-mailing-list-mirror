Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9441A1C84B8
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602772; cv=none; b=TR7VF3ruaKxLXJD8XblakE0iMTIc4vlAhb09nF/nJPXiEeGujbZYAHVX4uLL8eSzedip/7w8GJPOzz7r/mz88ttOo4wMKl1j4+OFH6ZX16cNB91IYXSFYZW8Vj/e20XpFXybks3dQax2joNP29+I1SUdhXEtd6E9Md+97dLnXYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602772; c=relaxed/simple;
	bh=M69RqstoMOX1xnCRrnmi9aQo/PJOGNll/t8EBUwkcZg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bBJqJ34xxdaZkVMGhHMsxq74/tswbiF24Kb1mnEgato2axdD6VtxQIeDYnPNwgSitJDqMpP1tfBdpT75S8l366sfvQhiINHQU+tAhG15+Bu/5tJ859egHTOyls6STYnA+WfcqGg9VcLo90v18HXTLYi092HKef6QBZKA+psu0qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=FhHdhKPl; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="FhHdhKPl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1768602757; x=1769207557;
	i=johannes.schindelin@gmx.de;
	bh=BwicPnn6Nk4PF9ri6fxlByEBtfkap5uGO3M8A5eWEjk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FhHdhKPliB3dgO/F2xNF8Hae/GVuxN/yNPym7dzFDJVNQqKXfk7uK0bJfCbKUx4T
	 yOEMBdAbmbVWPDuczxsayIwD6QMBhzH8cyT/cjf0TkhDJcQT/hEKeN+umPk5wk+5y
	 psS4U28LkpplxXo6hwgG5wWaqMOsqXzOSRKdrshqHQ5XPmFMNxL6uuoHxBFGJEFUi
	 WiKbhtGtFmtFZT68c9bgvzv9WmLo2ALsJTT4SZ1y3cZkkFuyAxhapXIYE4B5qVwnZ
	 rUYv3pgM8nxHoi0fJPl9oV5TAtNmCPKoPuUcSp+kcNv1ABjwfm0WZ+LSVkVPNvYIU
	 xVddd/lkhi5nhEj6ag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.21]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFbW0-1valRb0DfS-009RYq; Fri, 16
 Jan 2026 23:32:37 +0100
Date: Fri, 16 Jan 2026 23:32:34 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Andreas Schwab <schwab@linux-m68k.org>, 
    Ondrej Pohorelsky <opohorel@redhat.com>, Patrick Steinhardt <ps@pks.im>, 
    Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/5] Sanitize sideband channel messages
In-Reply-To: <pull.1853.v3.git.1768602373.gitgitgadget@gmail.com>
Message-ID: <fc58c8ea-88d0-d86c-30e6-0ab9fceb23cc@gmx.de>
References: <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com> <pull.1853.v3.git.1768602373.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pjvBolzmEdEbAhBXQuxryqOXN689G3fLqKNZQJ+Spubn/PDA5Ta
 3a58HfaqX5xxnXWpic/VtSekuyLuXWGLJHFKFFfoN6dm1Kghr2FctPLz1hEOnrC5s4YhyBM
 S14wh3RO+fUI++F6dx6galtkrJ0RmBEhUgwAzYlgxQRlusKUPzlxdebjpNxulpnmrW/122l
 jpRpsYeKrnczgvpZG0qQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:r1MQo2cDTQA=;1w8IFsOqYCOjUWxDLcKHRIulCNe
 Px2lSadjXgySzx7/q8WyRJLJDaeqpeWeD5lMyEAam5PTWBE6MvlZQVWG0vvVdKPPnxOoMSSS1
 8wTzVEHiKY75F1cWcvYwfAqd8JEEM9j2v6YONU4XrWCUJHE18dSi8Vn3ytf/19pjOEaoF+ISG
 lss/CyMZWtDvTLxK6ao4q4pX0Z8tr4MGHUr784slorQq+RSeY9OWsRGJqYz53OwnElnkBBxv6
 T4xch4XSN/6Eoe3G0Yv7Kvv9TNJEzPrMkS7xyrAfZ+y1CymrX/QUFNlr+oWMMZbi6N+mHaQhM
 tLC3Vpu4Ir/izj1GUfAD+fdNlIySBTQGsbDDDF3uMqMFBVFiD/izQ3qQorQKU+vQT0sXSe004
 p88qKr4aZRZcZeiRvgE45NlFEptD0Fb0FedMdAuBeSTq+E9saL1bY98Ux92M/HNN/0inkWW4T
 t9+0iqTA6y2crPqumbGBF1jmHWaNJr7Q2q6o8gSyDmnIcfUMmRa6CcDNZAcGs0+qnPULn8XJo
 TEInMa6MKRHb/UfKJvXwO1L6PVhhygTXJxSxGk9JTsfIE9B9dBN94nKWV24Sq5xT4FjxbBCPc
 BdRDoWC7I27gxQU9HPsbS6J7OWBkeJFpYEtkTJGSxf5We/uz5L9kG511MnqJ2SdNpnEzzJAZW
 RyvVpa7FyeIHFtps7KczYo7tjp40R30UhJ5T4pE/+KPDUxUG5LRP6MLgV50gtss1uj134C3Np
 /ZG9YMQIY9oo8qi6apg8gaz8xkGcc0kztQpFQGu64b/jRIknTdp60gvb8RejHGMUDyGgvzn0C
 go3Lzi6HzahJykHx3hrksQsqxBpxMbvq+CT9FoKGn7N0fCpud/x56L3iMPETiu90eij7fw6+G
 KFJitpLCiQfoGJW3bCpXblgJt0PFm434tUtfx/oIOiKvTDathKwpqJxbntfEAm/1s5TCDg0E1
 eMUmsbcFEstgXmVp2YIGEcJMKTULSHHjWuItYTNIL9hmfe4/yJIpuAhyFXXute8S9V3E/yVE4
 CpnBhr0sEquwF36pTUkJnjUDwOmmIfup/HSNtHQkMhVYg0USgMxMTcDESBSwrs61yuo4ABmX2
 6djWO3uCW+0dqamFnFwBUDSJYSDkwjjzuwKPZc0ykTv8Hk/6JzWD3p+WTPqbQV/JiU21WYVqp
 eMmlrtsw7E+L9v7lqO4GFz7/TcNfeeYdvZeZqTF/O11Y9Z7prRlDo9VpTVJ30qxnNQHPVBrkb
 WiBmB6n4K5ySSfoSY7+rQklsw9dIwun4QBWovlITZNylXS6YMYD67STj4WZr5/webEQK90dHy
 UUaLHyyTw5E8d6AUJIQxK6LE2xIlIX2O132IIA6Bnlgc05C7AymrH2JVeaxaYtLFzh2CAe7+u
 eOUFFt+DhqMWm1mXjoxIR3ewYhyIWt2pWg8qme9wdUQA8VVsbp6D/xBBBCaR2dGT0Wos346uW
 UmAUJCohX/jbm0Eorlei79nNDkAWiDCa9gXnDjz+BMrJY0HhS2LFU25+R3bGhD4ARAWtqYrBz
 0aVc09k5h1TsnGUQKcwEPnFNQD+joGCDP1nYXfcyqtGNOkXDJMbhUmWPqXAVQN9tE1Lk4OLNx
 IeosXfTZNzrqPumRp7rFstH/dPjHag5DanB9BGbZ260rEFctXuQ6pGMJs2QUAIwElMrc0Q5b4
 EBKVKBVuSFjh/QfM3It49kfn5uowh3bDol67QOnfk7JPU8xgfKRGmC8GQ8AmAJoTuFM/D4M42
 AQX1PLldCAd9gV7A5txsuw3Xw5HDk5JuQ4LE21S953OCoWo11QZmVCuNFi7D1GKx1cDo1WvV4
 MYNXJWtjvkCG0dfAEQ6NWCLWMxj1EzeJBSEt8spEVd2vkT2Wv1Zyf17Mn1lRqeYU+Dvq4AgTY
 FXB9851NY47dIUSVP+6BLyNKSGDQFRs5uOUsKyfpyUrpqx/Rb284LopyXg2UXfD/gTYiO/A/i
 VSwxmggYttF7lUC57jFMXUZXq38R13m8hhffxdkhtV7uhZBMtaO0ryY02B4oASWF4CWQnuIuz
 Pu9upk44OrpkXXHOVVeHTuJdtZjCQLb7iBBnbV2vivJRh5tmfuFhlhHsBjc3uDIvhqmTkPQSG
 QxaxR3YiKV4guO4GDEDFMDfnhTYYyeiHYew+IMB4Dwa1eOwsd/MAb8wgunJ+dJ42OqEY0+TFw
 3p84+s7BqjtInkHQM5weSPRSpBRr+X0I32lKhmwn9o3zCGxMVTPXA4VZv4ApzZF//D26I/Xvj
 S6oqRjeYh7MOiTPrnyEbolbNuFfBni4/QLlwb03N1GW02veBfP+ojdJdJpssHVOynYjZe+7y9
 Vw/p9zUidU19/fe6+0HKJlHWkCtdL7Ws/4YrNmsvcEjWNsN2t4sM6faAoG3o3dCR4132qqLLX
 4m4rRGy86mcvBPCQT51UvguWPi8KMaVaLCp/hakIQrl7iLLLIkVXbDamtA8KThdN0Tbvaq9Lt
 eoXFpamynqEIzZjXnULX2bysibJvbE5w9fv7mwNh7BhwKXQ2jcr2aP3oz3YAoKbR545eRaAXF
 oHzT+8ox0jpUIM4Whfgpl7y20F0Maqc8ZgXEddy9BrVRzHPFJFFQqvx57uURItHd0tpNodxy/
 D8L8JZdBIMJMM30N544Kb019bo6L/ZBMy5vHS6069L2IBn9NabDK9yKA+ukGua9ESRAeCWkBd
 q7944s1Aonm1i5ni7tbP2k9+pM60tOwJu+cvLtbGO3sWLrtCRnDWJ7W1zZdY1MZBW7EhdnFf1
 EWocsJahiCNDHtQQEmeVKYrPsQK9nOPLP6egUZxELjtFl/MgN7EzZjBvvEqP3ytl7MJo/Ku2M
 /ZZmrf/pqeuhhBIfz4f5EzNJLt4HsCWZ01lT8ChWEg3+oNqyxrS2ouPraR4I4mJ0QgiVnGShM
 0uxni0sIb8Y8mMDUGriWoBTKTMFZ+amnaLEwqWX2rdOzK5Bz+4D7960C7lkDoHgqOwwF51l7x
 duv5rIpAuoUQ7ndUezObZyZcKQoRfPTcFC9VpBjqY+LBkSk8aGXqMH8LZReqrB5RqqlcUad/z
 iWQIXqw1EDAtFzts3C890pvGtTogul/DHyArV9NVVSU2k35kwZYq3PP02f8AWFnSV0lW5yk50
 jV33SGBTsIBKTEYdFhEZobvC2xGv+3dLqiAhAEbh8P70jH6WBo2LIfV+Iu2wAClG4csTPlEwC
 9ASpj80SNqmVDf3ho3buS4A0KpiMA3G1JqD8stY4mzlFSjrTuI57ZbGEZsyFhpQNmxLcEU7i6
 WdMDWuV+VqwH+Egmt2XVfgv7lzGBHANs94vH6AUEakNIVa4BtgFKdhhbKkzv+LQnPU9dm/YbR
 dehEm6y3xBV7CcOrbnJ1kUCgootbubAZvuHrM4RXKuWmeczyVP+ewe3jdhP79xeHmxTjMokI2
 MGxzNW9BdcoT8RRHJcy44srzOifZJBjCloNtPQHySBXWInFn/bCp6SxBwh6f1GNdMpoNlnueJ
 2+Ot8eJ6DCNuBEwNBBJVqSMr8KwsFBF+jQogmOqW0oEm/iY35GK+Ir/lCLUeMGkqh4YyS9y3R
 s0Z7gpSLrcwXPnqU/JH/kqJF/ID2+BZUmBtMtcBwdHalk0xF4/tp9z45siXeGVErGR8KOxhe4
 XBh0y5OKBPlWFhvhxN+XVvB655SLxFd3QXqj85HvvUqxLBkqQBPOTtPBt/ESXmp1+u5sZveiW
 NynnWchL7s0PTLfuya6Bl/4aSHdR5UwvsLJHe8t/ELUZwoQK8DnpKl2EQjQR5RsAQy28ZGMV1
 9n/JVfSZCd33xbauuEmt2lgdVBt6OLDDB8KcbdtqaZsM7qPnK/vcVJFiz7htXFPn0hH3DnYp6
 nlMgivWCn/QqbOPL0ZmzB/4PMm+iC5X3dHGLi6iZ2cZwBiVsVuBb+FrPc7vQrBMhbZGEVX+Kb
 2BWp/uI2LRrl1/Gf7XYLcyYDj36OyH2wUDCKYM8RcpITgoh9lMYVqkBqb32CQbvFWq0K7j6CL
 z6wi7r4wLrcmH3nzG2D3+FCrHHSenEmaznSRkjJuLuttJZfyovWzVDO03SG3OrUZ4kcB/lru1
 0BnG1qCLQED7Mx74c1q4bvDH4pty9+mmC6mliIpbr5SxZSn0Y3uwJmTor81yaCSxS1LDAmGFs
 u2tNcHq+BKZBIURjSx9QN2eX65IRyPiVe7LyZfqMehCtwlMp608gbrDnMsv30RHt9GK+dg192
 p55xYtwWhX23HC0OzFbXTX0HWpeE7UVW3bflBDcW2jSzIzZFOcj/1piHQCirIaVCnkr8Jw0Qn
 xQPRB/lG+JVz7zT+H+OcbLOYtCqSa2amAK1FLtgGXGQfInmmiQI6G4FUJdaoNKOcVRsz1J8Ky
 hLyPmF79HFzp1g8KE7SkdCIckok4iKl764+2ImjzbK+auufCBaAkstCv3yG0WIFuzNQU+JP/r
 EBhuB6gBFvHr7rTtLgMY/rBvR13EUuyZ9JUmlnSrbww/si1BvUIXThQuMsDSyhdb9EAENYSVU
 +sT5or4GU8w7XUhbZHORCc8Dg3WTDzFfO66mrosQWAGXf2L+yGvdjTSnVA0jVIRs1//2kcnw7
 +HfyKI8ku5RF7i52QyaQhrXFGNC7kJwK1Fnp1vs/OCF4WTKkSqrygyWB60oRwQsXUPwFUhl/7
 QrLADicRdY77HRJGZAZcKaiUCjds9bZFHd6/vO4q3jDa8EFyJBFTKylPZLW1l+xohL5b2GG22
 YU9Cv4nH47htYBDAGMRU2p1o+YRDE5a3HVx+cwlgSn6u8+uh+y236aasxGD0XH9sI7EjfVAnZ
 rqYuX9tUmP+u3CAjfaAh+wfEyzzlWwfBeAOMYO9MyueRcVS0PSpX0fIXFT2fWJfSqHGooyPJK
 MtWYtbHOEkO8Ut76WEgevPtLI+gDvWtO0NUcn4R7t6CKEbIyIEuE6lLIye52l2ylZUsSr5nfU
 JREQDeCDmuG+gziC2eynYlkkkoAgYb8OXsg0nXT+uhlASIq2I0XQSUFw4zoQ45eXq5IpDNwrm
 hrmWU3SOC+NiLOJtlddhy9aGje5OrkABEGqhHgFzr3HIR+wO0iRcgXB3uG9CnsUjDseRRNgFO
 i07wyj28NJM9dPtbEIMLS2f0p5tz0YkUdrLLUw9D82+pMCO5Pw1FcVc4uV0vrXq+Yc2uS0tnb
 eamx770zakbrIAB8j0HYr/7iEKzEk882OtySHBrEyO6ALWH7MHZLqKgQvCjw1xAaEyfbWlIvL
 HGNEJoD5QqjBgv66JDtqRVQIzZiUb0ictuU3Df/qXWMHZHJlwyw==
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 16 Jan 2026, Johannes Schindelin via GitGitGadget wrote:

> Note: This series applies cleanly on v2.47.3. Integrating this into newe=
r
> versions is a bit cumbersome; I pushed a version of the branch as rebase=
d to
> v2.53.0-rc0 here:
> https://github.com/dscho/git/tree/refs/heads/sanitize-sideband-2.53.0-rc=
0

Here is the range-diff:

1:  e6b71af0cad =3D 1:  757c859add0 sideband: mask control characters
2:  8f64d658447 ! 2:  28c9fa7e205 sideband: introduce an "escape hatch" to=
 allow control characters
    @@ Commit message
         Suggested-by: brian m. carlson <sandals@crustytoothpaste.net>
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    =20
    - ## Documentation/config.txt ##
    -@@ Documentation/config.txt: include::config/sequencer.txt[]
    + ## Documentation/config.adoc ##
    +@@ Documentation/config.adoc: include::config/sequencer.adoc[]
     =20
    - include::config/showbranch.txt[]
    + include::config/showbranch.adoc[]
     =20
    -+include::config/sideband.txt[]
    ++include::config/sideband.adoc[]
     +
    - include::config/sparse.txt[]
    + include::config/sparse.adoc[]
     =20
    - include::config/splitindex.txt[]
    + include::config/splitindex.adoc[]
    =20
    - ## Documentation/config/sideband.txt (new) ##
    + ## Documentation/config/sideband.adoc (new) ##
     @@
     +sideband.allowControlCharacters::
     +	By default, control characters that are delivered via the sideband
    @@ sideband.c: static struct keyword_entry keywords[] =3D {
     +static int allow_control_characters;
     +
      /* Returns a color setting (GIT_COLOR_NEVER, etc). */
    - static int use_sideband_colors(void)
    + static enum git_colorbool use_sideband_colors(void)
      {
    -@@ sideband.c: static int use_sideband_colors(void)
    - 	if (use_sideband_colors_cached >=3D 0)
    +@@ sideband.c: static enum git_colorbool use_sideband_colors(void)
    + 	if (use_sideband_colors_cached !=3D GIT_COLOR_UNKNOWN)
      		return use_sideband_colors_cached;
     =20
    -+	git_config_get_bool("sideband.allowcontrolcharacters",
    ++	repo_config_get_bool(the_repository, "sideband.allowcontrolcharacte=
rs",
     +			    &allow_control_characters);
     +
    - 	if (!git_config_get_string_tmp(key, &value))
    + 	if (!repo_config_get_string_tmp(the_repository, key, &value))
      		use_sideband_colors_cached =3D git_config_colorbool(key, value);
    - 	else if (!git_config_get_string_tmp("color.ui", &value))
    + 	else if (!repo_config_get_string_tmp(the_repository, "color.ui", &v=
alue))
     @@ sideband.c: void list_config_color_sideband_slots(struct string_li=
st *list, const char *pref
     =20
      static void strbuf_add_sanitized(struct strbuf *dest, const char *sr=
c, int n)
3:  44838acaccc ! 3:  58a4f78783b sideband: do allow ANSI color sequences =
by default
    @@ Commit message
    =20
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    =20
    - ## Documentation/config/sideband.txt ##
    + ## Documentation/config/sideband.adoc ##
     @@
      sideband.allowControlCharacters::
      	By default, control characters that are delivered via the sideband
    @@ sideband.c: static struct keyword_entry keywords[] =3D {
     +} allow_control_characters =3D ALLOW_ANSI_COLOR_SEQUENCES;
     =20
      /* Returns a color setting (GIT_COLOR_NEVER, etc). */
    - static int use_sideband_colors(void)
    -@@ sideband.c: static int use_sideband_colors(void)
    - 	if (use_sideband_colors_cached >=3D 0)
    + static enum git_colorbool use_sideband_colors(void)
    +@@ sideband.c: static enum git_colorbool use_sideband_colors(void)
    + 	if (use_sideband_colors_cached !=3D GIT_COLOR_UNKNOWN)
      		return use_sideband_colors_cached;
     =20
    --	git_config_get_bool("sideband.allowcontrolcharacters",
    +-	repo_config_get_bool(the_repository, "sideband.allowcontrolcharacte=
rs",
     -			    &allow_control_characters);
    -+	switch (git_config_get_maybe_bool("sideband.allowcontrolcharacters"=
, &i)) {
    ++	switch (repo_config_get_maybe_bool(the_repository, "sideband.allowc=
ontrolcharacters", &i)) {
     +	case 0: /* Boolean value */
     +		allow_control_characters =3D i ? ALLOW_ALL_CONTROL_CHARACTERS :
     +			ALLOW_NO_CONTROL_CHARACTERS;
     +		break;
     +	case -1: /* non-Boolean value */
    -+		if (git_config_get_string_tmp("sideband.allowcontrolcharacters",
    ++		if (repo_config_get_string_tmp(the_repository, "sideband.allowcont=
rolcharacters",
     +					      &value))
     +			; /* huh? `get_maybe_bool()` returned -1 */
     +		else if (!strcmp(value, "default"))
    @@ sideband.c: static int use_sideband_colors(void)
     +		break; /* not configured */
     +	}
     =20
    - 	if (!git_config_get_string_tmp(key, &value))
    + 	if (!repo_config_get_string_tmp(the_repository, key, &value))
      		use_sideband_colors_cached =3D git_config_colorbool(key, value);
     @@ sideband.c: void list_config_color_sideband_slots(struct string_li=
st *list, const char *pref
      		list_config_item(list, prefix, keywords[i].keyword);
4:  cc578465b9c ! 4:  24708d83075 sideband: add options to allow more cont=
rol sequences to be passed through
    @@ Commit message
    =20
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    =20
    - ## Documentation/config/sideband.txt ##
    -@@ Documentation/config/sideband.txt: sideband.allowControlCharacters=
::
    + ## Documentation/config/sideband.adoc ##
    +@@ Documentation/config/sideband.adoc: sideband.allowControlCharacter=
s::
      	By default, control characters that are delivered via the sideband
      	are masked, except ANSI color sequences. This prevents potentially
      	unwanted ANSI escape sequences from being sent to the terminal. Use
    @@ sideband.c: static struct keyword_entry keywords[] =3D {
     +}
     =20
      /* Returns a color setting (GIT_COLOR_NEVER, etc). */
    - static int use_sideband_colors(void)
    -@@ sideband.c: static int use_sideband_colors(void)
    - 		if (git_config_get_string_tmp("sideband.allowcontrolcharacters",
    + static enum git_colorbool use_sideband_colors(void)
    +@@ sideband.c: static enum git_colorbool use_sideband_colors(void)
    + 		if (repo_config_get_string_tmp(the_repository, "sideband.allowcont=
rolcharacters",
      					      &value))
      			; /* huh? `get_maybe_bool()` returned -1 */
     -		else if (!strcmp(value, "default"))
5:  f2eb0a758ce ! 5:  4db96901d02 sideband: offer to configure sanitizing =
on a per-URL basis
    @@ Commit message
         Suggested-by: Junio Hamano <gitster@pobox.com>
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    =20
    - ## Documentation/config/sideband.txt ##
    -@@ Documentation/config/sideband.txt: sideband.allowControlCharacters=
::
    + ## Documentation/config/sideband.adoc ##
    +@@ Documentation/config/sideband.adoc: sideband.allowControlCharacter=
s::
      	`true`::
      		Allow all control characters to be sent to the terminal.
      --
    @@ sideband.c: static void parse_allow_control_characters(const char *=
value)
     +	config.collect_fn =3D sideband_config_callback;
     +
     +	normalized_url =3D url_normalize(url, &config.url);
    -+	git_config(urlmatch_config_entry, &config);
    ++	repo_config(the_repository, urlmatch_config_entry, &config);
     +	free(normalized_url);
     +	string_list_clear(&config.vars, 1);
     +	urlmatch_config_release(&config);
      }
     =20
      /* Returns a color setting (GIT_COLOR_NEVER, etc). */
    -@@ sideband.c: static int use_sideband_colors(void)
    - 	if (use_sideband_colors_cached >=3D 0)
    +@@ sideband.c: static enum git_colorbool use_sideband_colors(void)
    + 	if (use_sideband_colors_cached !=3D GIT_COLOR_UNKNOWN)
      		return use_sideband_colors_cached;
     =20
    --	switch (git_config_get_maybe_bool("sideband.allowcontrolcharacters"=
, &i)) {
    +-	switch (repo_config_get_maybe_bool(the_repository, "sideband.allowc=
ontrolcharacters", &i)) {
     -	case 0: /* Boolean value */
     -		allow_control_characters =3D i ? ALLOW_ALL_CONTROL_CHARACTERS :
     -			ALLOW_NO_CONTROL_CHARACTERS;
     -		break;
     -	case -1: /* non-Boolean value */
    --		if (git_config_get_string_tmp("sideband.allowcontrolcharacters",
    +-		if (repo_config_get_string_tmp(the_repository, "sideband.allowcont=
rolcharacters",
     -					      &value))
     -			; /* huh? `get_maybe_bool()` returned -1 */
     -		else
    @@ sideband.c: static int use_sideband_colors(void)
     -	default:
     -		break; /* not configured */
     +	if (allow_control_characters =3D=3D ALLOW_CONTROL_SEQUENCES_UNSET) =
{
    -+		if (!git_config_get_value("sideband.allowcontrolcharacters", &valu=
e))
    ++		if (!repo_config_get_value(the_repository, "sideband.allowcontrolc=
haracters", &value))
     +			sideband_allow_control_characters_config("sideband.allowcontrolch=
aracters", value);
     +
     +		if (allow_control_characters =3D=3D ALLOW_CONTROL_SEQUENCES_UNSET)
     +			allow_control_characters =3D ALLOW_DEFAULT_ANSI_SEQUENCES;
      	}
     =20
    - 	if (!git_config_get_string_tmp(key, &value))
    + 	if (!repo_config_get_string_tmp(the_repository, key, &value))
    =20
      ## sideband.h ##
     @@ sideband.h: int demultiplex_sideband(const char *me, int status,
    @@ transport.c
      #include "bundle-uri.h"
     +#include "sideband.h"
     =20
    - static int transport_use_color =3D -1;
    + static enum git_colorbool transport_use_color =3D GIT_COLOR_UNKNOWN;
      static char transport_colors[][COLOR_MAXLEN] =3D {
     @@ transport.c: struct transport *transport_get(struct remote *remote=
, const char *url)
     =20
    - 	ret->hash_algo =3D &hash_algos[GIT_HASH_SHA1];
    + 	ret->hash_algo =3D &hash_algos[GIT_HASH_SHA1_LEGACY];
     =20
     +	sideband_apply_url_config(ret->url);
     +

Ciao,
Johannes
