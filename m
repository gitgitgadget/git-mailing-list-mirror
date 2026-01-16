Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041732FDC4D
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768591810; cv=none; b=Q74jmdfSU5loVfobYB5PnUKNXbkEHeH6XDOGX3CiaPdhU8tx4jSOtVH+A7ALoLB/386juh9udv3shjTNP8HybUZnMizH7b6nhhVLEj98ZQMp1woE8ofwHEdgBNvtwkmDe++9eDuJjlEJlBRoiRKuS/uW4j/QLmHA2rwLrw/0uyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768591810; c=relaxed/simple;
	bh=4XZBvshzS1J651Tq4LY6GqIt7mD0D2Qokoe/vZWFyTY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hnrfNqsnfKu04t9jqehP1Jtp5cG2+OGxqAeE9CFxlCHVWXTlgjXg0sBekKubzNPMxzkUwynYW6i8Np+ChVgAQ7KHihDpEbEQrOfCUMwrlv3GoP3BOu8p8ipNtxiaPjccBI5LHelQAhfPdHRJ3I7jXGeHvc+cT34CQ0U7nleHSBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=U7D7/IFz; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="U7D7/IFz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1768591801; x=1769196601;
	i=johannes.schindelin@gmx.de;
	bh=S2KEbkAdA5V25eWuMOdss6/YrXoTNHWOnqK6MDjDQpQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=U7D7/IFz2wCGZMWLb5X9BaNFoS42ObLcEKuVi5YkKEcwaqIFADMH6ub0o7YPFwjb
	 pz2sEBxoWrLklUbMScHwCIk+i97PnE6p9D2HjWlSZzrjhk7Q77/w+1fv6DHAxMvXT
	 E20eyDr+dls+T+tcjLzbtzM0fut/rGlzjFBvJTBhj0CVJbEsve5oruZgwqgZwM/mO
	 W3KSj+cH9p7zaPUvhBXMF+fTD1zU3rDomHJupjXznw1oxBVapkYn8915NDJ3bYAjl
	 3V/iApsqH/W65xma82AX6+O7hC7HHXM6Eq9ll9Ent9qkt2F64rVEVAhtJlysKe4+h
	 I3plbydsEZlXJHkwGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.21]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZktj-1vLkQ33FQ7-00Qtwm; Fri, 16
 Jan 2026 20:30:00 +0100
Date: Fri, 16 Jan 2026 20:29:58 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Andreas Schwab <schwab@linux-m68k.org>, 
    Ondrej Pohorelsky <opohorel@redhat.com>
Subject: Re: [PATCH v2 1/4] sideband: mask control characters
In-Reply-To: <aWD2s5RyhxYSLmfc@pks.im>
Message-ID: <f3891ea0-56f0-b6ff-afac-e06fc143ecc5@gmx.de>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com> <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com> <8d7047655933592939dd1395f5b1ead595cee4ee.1765981422.git.gitgitgadget@gmail.com> <aWD2s5RyhxYSLmfc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:56f5meKKogXKLZGVROZ4F1b7LP4eoVxhuhi9dMw8tiw4QrMh2d6
 SEf6U8iO9EU7jQGFSZ1Q9oMhWQskkv56TXTgaBZRvqX63ti3ktR3VWZZ7KqPYHphx/Kmovb
 vj3N4HwgaRbt9d/52381SUcFIuQrRZtbnWps8Gtoowgh49HkiU8RHliwJMVH5Rg28vj7MVr
 JnXL+4mluKZlpvJm6Q26g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wKfmR/AV+00=;csv2itwQOh6EczUhz5aghSckf4c
 3s5+u3hDZV/80xi3m1FiGqUgh4Y5GEZ/+MqurA2E3AS2qtJJCDBDZHcOIMr/U3B9vt2LjIpaT
 bv7veEu0mRBzh2hVn5JeJD4iIjyQP6QkSC9erqvXjucX8svyrIufWgSEA/2LXhLpR/IBQUQkU
 DpnFJ2Dzp5pivKgrHWkF6f6+uPYJe8tnJMIDISbBXfhIZ5wmFjafzVR1bYCWX9kyybu+cBHzh
 d6y2Nm5vSZKwBO57OkYaUvmlHQDaTNadLASKexsYxvUTtWP6gmCo7dez3Tta39Fc2YwvPa0M/
 MLss59/3/6zhD+z4piHH+WD+NrS+BO+q9CYxiyuEhKB3ws5T8vd6C4ZMZ1lMkzGjtt1gEK8gd
 4PB6yK/bmkq7ErFXVPl/DxY5VjsFZ0I/Wvt1VKFK78gHDSghdqeLWdBagCoFk5dEyZWutgc3W
 IexgpvDsv89oxSBpLnvTtQTPjXP8BTSXv0GWddmS0UD3T90muSQbZXYdzJBSyTlNv26gexiB/
 1ud1H5e+fTwqGF3DuZkrqNssco1Q+rTs53Q0gK/LFcjnUT380ScWUn+Lj4kXCiXSE1+8GKeLb
 zAp386Lm4n7NVg4BvfpLWeiH8/SweQTvLJxYCI0NrzZ+k+GuyK94uZ13okrlIZiAMHDSygSkr
 8CJ1EkQhebcI1+OTaguQzI36iYKbp5A2UMHnsmxFesMiIxQcVn7dhNJV5FsJTXU54TOdYk14S
 5qkE94aD6ZQA3dLXeX71/BD+0zgElpEus5HA16F/5uPCXBAeEHpUAj90Z2zR3/DSXFvwY1YV8
 YgTcm5YI6Zu8foiEQm9gS367KBZFYkbezxIlhHvGaN3pwj241socObwadwo41FeBjyC3JrmI3
 KGECu9s5dw0pyUeCR1RVCBAw+fuBCLPKZoIRs80AJ0I3mlc0mT2JFX3jydSuC7MwEIfveENVo
 EEfjsYJoYX5GnBH1w1gieeGG4qjEgTZIrrVFrlLPG8Bao8uCHAtsTTpRhFP4Kxm6LSTLLGsKc
 OG5Q4mVub6DT0+qQG04IWXzIFJtgkR/NCbz61vSqaksVVC000leTiSK+G0bxM6VpeFN9olMVY
 UDQXALwDetPuk6E+klGUVmTeMrxPbzJBC4+UrPdi0v96GnXZ4pRKosKPCmcsP1/efQBjyxo5Y
 zO9ZDgTbVEmSQ+JuRHxCHOH2WtMV8+ZvRleipGIvw8nLbVxNJNwgNUFLJm/zzf3bv2SuoKeI6
 6EWlZwOSLvvsa6o7SvUVI//SLLYi3CnMzYb6wXZ1RynO0BTC3C8LkjExG0+lDbnSW1kg+Zuf2
 kCHOdf1qS0xwQ394P8Wsc0mYFs22ulgDyBUqEAdFTQYi2NatRdCYWrlBiqYANNKt6UwpxdaTX
 zfx1VE8dL+Kz9+uwPwp7GjkRATA2fIlhljxDTqtqeFitjUSuA+6WgZlTWJpvDNZ4mBg0/5OEL
 hdQzktvrNvV+N35leBZm44O3PILCxm8LBp7pVXo7KySc+UlBvS3/QvMGrC9QXiVaNcvLwXO5Z
 5O25Dg4ZVqQ9z9Ry2j7S6MNisVhIAnBPforx+WiVF/+ijy3Un6FjzJNDHPN2/HY9nAnDvwWA6
 tA8zi4xCp0Ud0l7BUCwBXqpnERe3JC8R+yErvvQA2nj/8KfYQBcAzEnWjN2KxBxo92sTxlLMS
 gJ5MlLfEnKokAgSOk1oZwzBhJgBhaIz9IBBIVnd9afOqQ3X2b10D67jF7UwU7RlhehD12+Bnp
 HLsHobFb78ikmwu1ACh2bxMFg0sKql1i8zNki2ezRlnBGjQwZQ5zBwkSAUl1JBkPnVRPu+TIg
 6zENmi9g8ORcqe4Om2RkGm0biLoU3WeB8dvJq8FnyLDwh1mCrP00rcnKISadXYJt3bPznDpdm
 IeqtvazfRJknmo6s2K4dUIaA+Tp22EuvUDBAHCVpoPHBNGVqUU8wMnomvA4Azhf90VZGpSHtq
 PP2k7QeD6Iq1ESQfBB5T4Fd51zCjZo4KfSseyyha/EtVn2t305pyHBI6Z1RwQhEyucHBcusbA
 WSa5nTK5+HZgzgU5+Y03pffYURJ750B0iMxqRrrIRwQrYIoGYiealop2bgy8KWcgnMKEM1TY4
 1dGRjxNKZZFuo1qSMtuEgjdon3s0vF5PNLZduorbnZbSGQlFp11b6M/bV3UTd9mkg6MTUWZ3n
 ZkfU6hEJq/CuA0nttsnj8nhvrVNQhRWOeCad3SQ1Rt6FEYIdYrC7JMBxyqSHMd3HPIOFi9+a/
 NMWr4LkdpVOhI3XXu6fFjh4zsQgD9n+XDtHWP+9F/mdsE2L3gxBHXvw+KL9YfJqFIKKrTLGiT
 gBv+yWEwN1F9sq7NrzEAUN500peTk91lFD4wHlDBB6X5NFHd86okR2FKPECkwpgpKNjczolGP
 0JQytwS1RGxMDxzEADqRlpT0ZjSW/2VUS88zoUY78EEFFilik3IIIHs/EYeZF+GbAWF588+DR
 pt0rQfc7ilu6qV9CMaYk1fFgV7r7cxbQNit6XmQNaQmia0LdXNT9QpPYfTaZD1cP37Ag9fH39
 Wt5GIC9JQ2yPh6wXuRBA9Mp4e/1I/X5iVG39EFfquSZ0BzpJasj0MQY53Kppaas5i+EF6Hcve
 5jiyyEQsY3iaH9xHowfgOghHuGBQK8Bo9VAuKnutvzYGXQd75qcmUpluyokWJri2VGakzL1/b
 kjf7ZCV3HsyWJ+0y4V5TXSNHx/Hz549FbK3SF/h1zQZ8aruAe6EtsWKQcxE08SMBEylcMXs11
 z9SbE1i2O2XZWzh1FFB1NJIDm/td2+6p1GwdZQdgu6dKyQMVyVV+dt6b2wTiEeP2iVgF2ksCx
 a6OLvmKEctur9I2x17e8nBUp81EDXcxB4WlUCBAjdxGgCrxEstgWbTm7sPkWPdTI3cC7Houle
 IxMqaOAhJYTpMrVOp8RlsL4yRHBxwq4yMg8+zOVQdRhuYO43+sp1fN+n/cxCfRh4ILunigW5d
 Jnmb02sz58HVLNnUxWYO77G9q4PVdsjMqziPLIZq6v6g0wP7YhHp+Y6lg0NNL5xtk/UtsjGlZ
 0zkegN9Q/1qD3XUgznpmDhPFQOJFy8dODIsRTjJc7HZA9NZda89Cz1w0j1e5CQUpm5JeNp+mw
 Y9Tc6+examPPTGYtwjtCzgVSk90BdgoAJbyRbR9vKnp2vOaZQl9X6RDWLfGmRe+EuERZevxlU
 13Z43wc337ZIys9bE/UFwJ9w/p34tYDBXvKGtLI848inMjrD7PSbG3/MYXMJyh14+iFXR8IEo
 FtbJ+TNah0TylLb0ttSNHZANb83DqnW+ZlBTgzoauRrdhqTX35nrSlo73qYuvvzH5cNrgW/Vl
 /ogN5D3LLc2BXB8D05WHUkNvjWtIdo57AGz43zdFgj5AdFJFuv1BMSLHEVIF9Z7qE5YN7vRhy
 cHR/M+TmZQ5YhiBNfPXPnjhqEpj/oqj+RWeYj52jqVyFItxAu1Q4vojN6dHmhSrR70nUCJoCH
 fi5o8BaaEt5M5o8xb8q9Wtim6/npJULPC6m4k0dOaIoWbuYzM8dpnzwxUvct02FvJJVuEAODj
 zgahGGv9K//v46NMzLXPsINdnzLpyNX2OmllBl5Nkk21YWoKGP3s1hRNlpcJWWukeWAtK99It
 Ao64K5RVvAwsIgijrt96a13n9MUZiF5HCxkKXW0hPfvl/hTGtDmXPizzJS8PhxoitcmrovVal
 8M9JLoZT/e4COoW2FBXS7LuuivsLYCqB/fRTxPOSAa9pabfRZvKNg49JUp6/YRkyQJUYqc9wX
 uPnUJ21+xqp1wkWdWbkNL80OaS0q1gtzsNtZ9Oy67jWyPIx9/y/uF0CdzcOKnRR511GN9MDh3
 H3DrgtyqUnVPaoRc13dXcIFkFV0FdZLhqdKfKifCveoLjC8fmS+rUNj1WkU59kRPaJvUsQdNC
 o1Q9+9upFoC+ANfictAe2cjj752bvvIiGhvkH5NYDsIxCowpfhaPWLuF+ahEv2C/ah/HtXL5u
 QTWwOLIejeJjY5l0SkvNabBI7E+wbBzLppARsRNYvUoygy8xwzl7EZ7j8qCMC0CNHi6gzYhbb
 0Ghh8n9+jklxZ0z3+GdGcenNW5d4yjb1O+Qn36BYARrnFPyo/aXJ9gvnXUB5VX8UUfufIWBLo
 023KV306AKnM0iDEeaTKkdb8ghQfc9nbhs0RMLmo+yeddEfDN4vCw8IqBfDCZKyN/PRm2UFWT
 B8Dltj2qRrONiju9d2FgApSNS/qH1lrx7j5AUFFqu5pLHgEUwnFPCdUcOiXA3WULyFpEvOLyS
 G121ScUSKQMCMbe+KHz4AFGzuY22NGy2+RRLFE7iLyuWWxGOCu8V/5yu/gEOmIDTNkzBX9WP4
 ptObYczAXxkxCE3xu8NK3tch0O0qdMhChW8NqgvkeIlJW0OblIgsfSqXbHHRZ2Bb4/03Z1xYs
 Zk9+KFZFyojHmB8N3BgSVsaeSRPOc3Er6r0RI1YyBS/dbknGWoKTLjXKJmnCBad8TLf6HXx04
 s8nPWtBa8KUA2VmE/qhJA+o14MK7hu07w/hIxELG0HA/DomY30QDoeEdPe9hshdl9ahciCCbS
 cJQOUxblh1eUJXBER4sPu7bJXlNqb5ZnUxsSPYm0sTAqppS0ybI5NqlnIUavIawvWnjD7PzbO
 TdbwQsHLgEy79pNoFEbD5tmtE0k4MsWaq2ZYj4CB1858YEqXbBLRPTgH0r+dZvo0uHHA677n9
 ysW3p8hsATTr9oOfbPaTNq6q7F2uPYkNbvoczgJThwUONczm2XXQK8kSpyvRJt1xECHObXB1z
 9mtYnwMqJxfI6NlZhbRV6+DBtkHN6B4fN+n8RATh3vZSnCjG/xZULf1vu/2TG3OX2d202woWM
 Z3TslCEr5Jsz7AZ4f6wTmPentE4xAOE7MPhYpz0wToDmrlhSCTXIvJ2+XT/0sBlYr4L7PJOIR
 YttJEM6ViVeZvSHgq3AWOM1sJ3THhJ1+G8D8Lo1DKCtWZ9/jEDtI4GEFjLUQEV8QjrfCN2cjM
 YU2q9fl5JHYfLbpBjSf/Z7XCdZOLr74HCk5x6ev2VlkiC1qK6iKVUB5DZufDs6MHWJqoq22Iv
 g2Rk+uAU+dFy3txp126jd5mJTOpMT2Q+7jKyxfumoMj/jXSM+ezvu5nyWd+wfdbbC3g5ESQ+M
 9JsnIq9GuKfaleFfxuT0QvskXAe+404VW1gKh1v+K2Ysp4+5G6JBTr/KxgHL/mEnBNHvpsj5l
 LRoLY/4k=
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Fri, 9 Jan 2026, Patrick Steinhardt wrote:

> On Wed, Dec 17, 2025 at 02:23:39PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > The output of `git clone` is a vital component for understanding what
> > has happened when things go wrong. However, these logs are partially
> > under the control of the remote server (via the "sideband", which
> > typically contains what the remote `git pack-objects` process sends to
> > `stderr`), and is currently not sanitized by Git.
> >=20
> > This makes Git susceptible to ANSI escape sequence injection (see
> > CWE-150, https://cwe.mitre.org/data/definitions/150.html), which allow=
s
> > attackers to corrupt terminal state, to hide information, and even to
> > insert characters into the input buffer (i.e. as if the user had typed
> > those characters).
> >=20
> > To plug this vulnerability, disallow any control character in the
> > sideband, replacing them instead with the common `^<letter/symbol>`
> > (e.g. `^[` for `\x1b`, `^A` for `\x01`).
> >=20
> > There is likely a need for more fine-grained controls instead of using=
 a
> > "heavy hammer" like this, which will be introduced subsequently.
>=20
> Most notably color codes, I assume.

Precisely.

> > diff --git a/sideband.c b/sideband.c
> > index 02805573fa..fc1805dcf8 100644
> > --- a/sideband.c
> > +++ b/sideband.c
> > @@ -65,6 +65,19 @@ void list_config_color_sideband_slots(struct string=
_list *list, const char *pref
> >  		list_config_item(list, prefix, keywords[i].keyword);
> >  }
> > =20
> > +static void strbuf_add_sanitized(struct strbuf *dest, const char *src=
, int n)
>=20
> Shouldn't `n` be of type `size_t`? I guess the answer is "maybe", as
> `maybe_colorize_sideband()` also accepts `int n` with a big comment
> explaining why that's okay. Ultimately, the reason is that we accept
> pkt-lines, so every line is limited to at most 64kB anyway.

Exactly. I did not want to use a different data type for the parameter
that is essentially just passed through.

> > +{
> > +	strbuf_grow(dest, n);
> > +	for (; n && *src; src++, n--) {
> > +		if (!iscntrl(*src) || *src =3D=3D '\t' || *src =3D=3D '\n')
> > +			strbuf_addch(dest, *src);
> > +		else {
>=20
> Tiny nit, not worth addressing on its own: the if branch should also
> have curly braces.

Will address in the next iteration.

Ciao,
Johannes
