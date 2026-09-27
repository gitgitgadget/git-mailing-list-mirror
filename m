Received: from mail-dl2-f36.google.com (mail-dl2-f36.google.com [74.125.229.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0022C3BADAA
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 08:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790496273; cv=pass; b=D7Cf+jirZRPcqdecHkZU1zbx69zSHW3OZvvHCHfjaCVlEYBpUXdMrjw94Ba7FmpquGFUqNf5jTYYunRwmyLvktVIhLkW/+gw6NcbFatWvukM7C3PrYuuULM0uYWxae3DrUkv336bw70uyxikVbsjN71yYb7iWZclRDO5pYmlVIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790496273; c=relaxed/simple;
	bh=o6/3z1wsfohwVc+PB/wTrZCnBw4vf3/xQ8Kl1Gx1aAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJERc6vbV/EyVMvwxdwBS/9i8dWP2zkY3MDNRleRYXFVqVkqI0rGGL/f2G8lKgY+OHJ/XA3/ESFB3MvstNIMhjFEHuhlUl8izzjQK9lWyZmFgLJhnkj64XNT981T2vPujaHvAvHGuDnNYmftdgdKekjcCMqPVCTX1Qoe4xWa64E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qb1imq7x; arc=pass smtp.client-ip=74.125.229.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb1imq7x"
Received: by mail-dl2-f36.google.com with SMTP id a92af1059eb24-14373bcc010so1844874c88.1
        for <git@vger.kernel.org>; Sun, 27 Sep 2026 01:04:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790496271; cv=none;
        d=google.com; s=arc-20260327;
        b=LCTuuDDN5ren7L4acj5vupV6oXcIaB8UehHxbT+YANiuho/EEGAFbuLtujaLswKzAZ
         d6gyIoS1ahonpr69D0FmiUGXIQ9NYoV4iMm5L8GtqYav0aFsUoU+mLMYCZxjvL2Z2Sg2
         J692xm8pDN688Sqs1rCU26XEIj3Ov7YGdG/lgIiKY0WEwU4YMurclAN9KiPGJOJ+fBbH
         81JuP6uALnxKOSn6wCNc0XDfn5SY5czPEbCfDdsTbYobSPdlQuKmXzRc7G84lD9mlD1H
         lli0fb6Z1cFBNTMlf1e54wf/M279kcXgWSYcgJE7CbFDOlRUSGgA1YBUtnMxsQRLY8Vs
         xHEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o6/3z1wsfohwVc+PB/wTrZCnBw4vf3/xQ8Kl1Gx1aAs=;
        fh=Z/MuuIU22dLg5C/mS8GT7Tih5GoCwW4m56fgicEkPuk=;
        b=bxztnmpqfbtWOs88gtxCz92sjZzuTINz1dRoMsHE0l0t1P6T3FIlORle9BycPmVKeb
         mIN7skd6+cgGpYPRV2phHqTwRvtnsCZVzrRINzMr4aOQaYcF/m7s5HDisRjRthBwruDa
         vFDIjMSa6UVtrJfpbcVaa7zJSGmD6hlIJit6fcl7mDXCDIRyTWPVrz2N2WVbUXxhtrh5
         OBzTnaJTgV2LEXLU+AlxeKRV7ZZpQgWQKSlcoHN8arYyqylvlPpdxs4w/oVJ+oM2AxVH
         eirOF0aFuTbe7jc8as4gcMVmv8p5NwOuxhsEnQsNxhyFLUI9//IuhmifVrIpZH4R732w
         bZ9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790496271; x=1791101071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o6/3z1wsfohwVc+PB/wTrZCnBw4vf3/xQ8Kl1Gx1aAs=;
        b=Qb1imq7xkQRWj6OD53CwDSAQwOvV0p1V+JlqhgwxsrEBdiT4sdW36Vp5jlPw21Hm9/
         Ic9Qo2/2gO4eEFAeqkvGUmIQsASOiDE5pIX99NPxd8kiUlOdMnn2jNeXrLh0KOC0/XZO
         1eTyDYks7JGldxNMdcs6atiRwbMulKvKdjOhxIz6+mezeqQI2lfhPkU7tAxqsWbSsw2w
         NL9bcrcirK28WcYFUurwByAzKGxbhxJOAN/Zbq/dNrpZfOrPJOeu1HpJQ4LYFEvqfndW
         aU05Clycm53GtNfJiGcLE04YjKG8F29ZLf0Pl7ilH5bUNbH3RAqfcUFTWFBq4vqnNEzD
         MMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790496271; x=1791101071;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o6/3z1wsfohwVc+PB/wTrZCnBw4vf3/xQ8Kl1Gx1aAs=;
        b=J9Qq6ZhAeghzJUfym5aFSDdg67IJuTODJwdGIy8/yb1WkvRllToETDbtduBJE6pbpo
         3E0h8DfDNByKYboZ8xNq8ToaK3e+Bd8ZzmJxyrzsiDTHb7RFIPsZyM+C0+5jKoXabmO9
         cAa260dEpQGLIWeM7a4AfyVEqVk0fWaIe+Y56quQx34wS6mf1I7BoJZqQP82eh95jaBw
         CaqREAXKkWWZA5qpYniI0JlDW51pzBW8I2vMSOzU8/Rp2e7CqhMYpqD7JYOFS+ltcgLg
         ii4sr3wLAfIaasghDsc2pdp7f2txXQyWqddp9CJxouGWgf85AxA4HmuQI60u7Tnh4o2a
         M7Tw==
X-Forwarded-Encrypted: i=1; AKwUvBzAEdPwi5VTgioGjeWjCI3Ql5QqWHORBIXKfPswxfmASuKV962Gjsh4Fu+IkRIOX+NGL3o=@vger.kernel.org
X-Gm-Message-State: AFuF++nADLiXfoVB6RC2+4B3U5ctiwNQlpQ6VYLhk6ZC5N+eoNCcQBR5
	cR4IVdCsxWwsXep55wu1MCxZt6CZTMx8atun+MYg2AObyGkmX1nh81cXN8Pe2JuXvx3NxcCrvJT
	vf8nbNlfkt1280k1ecYhfw0ISWw8OWf8=
X-Gm-Gg: AYBFou0DNUPio2Dum3BI39wTcbiGKBtxBQm446jxjXghonXn4410nMZMMk8mHF6WIo7
	x1HPS/dx4DiYIck9J4OOLZORc2gl9j06Ne7Echd+fFpoZxOGaNkuEnrRK/yvl3yndpU4sY7VASJ
	I8ZJuq7vW9bZzLGz5I0HcF1pUgXT9IwUBef+FxuFmg+MismibpYH7rhGh9KAiQo9l0+bZl/hhcg
	tfB8Is8Lv92+3U03Mii1ugelOG8PfZAqTXH71CJRWKklF29yDbqORqUIWBT2wB3wg4l6SfIarNR
	b9zZeohWc8okmHl9pkpJy9d0hTw1C6odHx9j8WqAqD+P1T512vpDmw0VfAjtl9vhrIgfGEFQA2r
	2JybIHtQd+xZTEsuO0RvDWAzhotwlkAS6bN+R86bE4/9J/oradW4AM/Y=
X-Received: by 2002:a05:7022:f502:b0:141:aa71:6f4c with SMTP id
 a92af1059eb24-146ce1a9aacmr5287015c88.10.1790496270946; Sun, 27 Sep 2026
 01:04:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-pks-rebase-conflict-bug-v1-1-3d3ccf5022bc@pks.im>
 <c12d2ac3-5263-4301-aa64-a311a343dd40@gmail.com> <24cc4bcc-1d26-46f5-a502-ba673713f4f0@gmail.com>
 <xmqqik3vc1pc.fsf@gitster.g> <CABPp-BENMwiHh=y_RtfY3Y+uyjRvbpPSTRE9sCGvOtpeeMgapw@mail.gmail.com>
 <6ff9d1ac-ff06-439c-bb0a-ce57742e8ff9@kdbg.org>
In-Reply-To: <6ff9d1ac-ff06-439c-bb0a-ce57742e8ff9@kdbg.org>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Sun, 27 Sep 2026 16:04:19 +0800
X-Gm-Features: AclHuK9Z-8UyyE8XSVq3aWQQbq2FIoOxO78_ptRddWuZVucC8ssHi6YS9wCN72M
Message-ID: <CANYiYbF0yD-6CrhzZ3H83ZkynuMOdi1h5z20uLzwqNtQQG0ydA@mail.gmail.com>
Subject: Re: [PATCH REGRESSION] builtin/rebase: allow user to amend committed
 conflicts again
To: Johannes Sixt <j6t@kdbg.org>
Cc: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Alexander Shopov <ash@kambanaria.org>, Mikel Forcada <mikel.forcada@gmail.com>, 
	Ralf Thielow <ralf.thielow@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	=?UTF-8?Q?Aindri=C3=BA_Mac_Giolla_Eoin?= <aindriu80@gmail.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Daniel Pereira <danielmaraboo@gmail.com>, 
	Dimitriy Ryazantcev <DJm00n@mail.ru>, Peter Krefting <peter@softwolves.pp.se>, Emir SARI <bitigchi@me.com>, 
	Arkadii Yakovets <ark@cho.red>, =?UTF-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>, 
	=?UTF-8?B?5L6d5LqR?= <lilydjwg@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>, 
	=?UTF-8?Q?St=C3=A9fan_Driaan_Turvey?= <stefanturvey1912@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 2:10=E2=80=AFPM Johannes Sixt <j6t@kdbg.org> wrote:
>
> [Cc: Jiang Xin]
>
> Am 23.09.26 um 19:49 schrieb Elijah Newren:
> > Yeah, reverting and retrying after the release probably makes sense
> > given how close we are to 2.56.
>
> The reverted series (0f8e75abebff) re-introduced one translatable string
> ("You are in the middle of a rebase -- cannot amend."), which tranlators
> may have removed from *.po files by now.

Thanks for the heads-up. I noticed the revert commit upstream. I will
rebase all l10n commits onto the new upstream branch to prevent the
reverted commits from being reintroduced, and will try to restore the
reverted l10n entries.

>
> -- Hannes
>
