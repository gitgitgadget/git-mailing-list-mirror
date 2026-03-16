Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9B0346E7E
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 05:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773639897; cv=pass; b=uAX/cDCPcqGEDPU1BPVfrOoxdvybnKUa4pP6priENHkR58p0b0SFpNLQpkR955dF+AhRil/ZDosfz0XIHlumG7StKHVrnpfmo5L6UDDoaJ4UTzXtsx7Gr1+OflbCT4gJaO3WhZdK43mLqLyVRQo2QzgxKdOcgAWj16aozOu+nxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773639897; c=relaxed/simple;
	bh=9qe7EBgxYPUHfoc+lrSzce47Lt//DQD/hhj6xJfWVuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uyU2gexAGKVqe80h/KrBEmC3ki2bbkQg0Tl6HasZbiliTn2pNlaHA+GFP1bbJOTBxx1PQnCabk9wcdPgi6Jet+UBGXzssrKjJhOeZ+0gZNnBklGI/pz5SflWoJ54r7iy5CYTsXWdlzmxqaodXuVrG6SOdQk8xyoWzbyzq/8YuYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIvW2p7g; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIvW2p7g"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1274204434bso3219798c88.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 22:44:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773639895; cv=none;
        d=google.com; s=arc-20240605;
        b=V2/Y183L88PdyECMbP6DHbDOS2fgN22JjS3PCXQjeGlQNLHjMcCqY87yQQAh7tFZWA
         Hv/hdpfSE2/B73uWxrCBJyW1CpISdoVkAOPGmnW0bm7klTd9dLEjSojlUldVevHQeXQo
         9mx/d+cIHDkgeSxGkmzPGbttm5CWFilN/BXvsGKsV8eQ4/KiU1c4XfnDmrNcZnKqJ4yx
         2RvFejCPWhJJ9G9fxrEdPcL8k3IJim4pFCUxyl/B169aLeDUxYwqHvS5Kqk7CrmW+nAC
         9/nUOhx2j62pQL2e4QB18YBH5epNH/IA5Ar7WHqTyHYdBijLcroful/GcRFu+MmPN1PN
         fvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fh1Cscn8t1FAfMntBMXFgqlAYEoNPPkpqlVz1HkTtek=;
        fh=2egB7gLK4z5yUFRX5mOzLxNSJ/RUD+AFAnpovuj3LNk=;
        b=coZh/x1VjuJtW9+MpO/4hzv8Qo8c3KiBc9VDNq2eodaH2jZ4a8UKQvT7FomyyHHD03
         5WCE2PQj6OeoqKdwbMVLJwW5XcUHM6ljBKTSs20E64RV/mtrwBdLv2tSBG8XdC1qUv74
         UH1KUyB6GQU0obUsu7XLTnNJ9iX9VbLPvWu7Wk3XC35SXwMg14CLKkO/qH5kP/oq4cwS
         zhB2npZDQMH42gKXZOAy9cbupUVJz8lYoUyewq1Xg5prTfMB6tNBFlhilHc/HgdS9D8g
         eTSn9BdIuql4q/hIuiFpfvY1/PG9KCrA/BJj2ciZRwmdvlGZID35z1+1QgO/baqUuK3W
         pTbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773639895; x=1774244695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fh1Cscn8t1FAfMntBMXFgqlAYEoNPPkpqlVz1HkTtek=;
        b=UIvW2p7gukfS4W3hKV5v3eQQgvyhpg8QFIvCgEkaB1ucuFlEHL/MCnVIq2EH7GPLCk
         usYluo7jcpT8ygX4pWrW2pQDOsspyoKGywjLghgmO0DeVsQ2hnIK+B6aJBveiowOSjEw
         JwSOBP5nhSdi3Lznxe4qZWoFY0dAlIJdWxLN1vV+p39yr63gyDvBnQacuZkOaGerS/eZ
         ekE/0MNQYNj7tfdz0pDxUF6/T5R+8LJsYSGFfA4pSA/yUNo8e2oS8+AMQWkBEpt4N+F5
         DVFPmLzRuy9fdLK6TEcWOXcc1GyVJGz7n0h/G0iPsOJ+Et0ciILSnHDYn0IYdTwBmMBl
         6B/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773639895; x=1774244695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fh1Cscn8t1FAfMntBMXFgqlAYEoNPPkpqlVz1HkTtek=;
        b=iq6BHrmS/Nya6RQX7Wfuwg+pzfA5KLPzuilN9ZYcd0XtZZvUBQuMNeAHNmfJUBEaTR
         D/knfNSNmUBV451Cy3OdstU0b3SHhUnFu48F0IGEgcbFvjU//gufJ0NG3Lmk3H/danCy
         8l70Ohaq90ktI7GkDurO6TfpXgPXYJGdq7UbAh0NYHZQDPs6CnHdgrY+n3TNBi2FkHky
         bd/Dd3q72cBaiRai1+RSb3YuCOZuBfc6Nvfah505zuug/yyhHxxB5LZAGYgCoO3QHWI/
         AN4F29aYAzvXKOdttDjTJO+yxDTmrE3QzNJq55EWBxq02fcLeaDmK2pqQVBa6AMhM8FY
         uW/A==
X-Forwarded-Encrypted: i=1; AJvYcCW6tESQcZydp851XR+IeGX49FzfNC2d5U4nDwQc30NzM1dDPdLbL7El5ZkxPmKLcRvUP1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxesEqxzrUopBZ2dzFVoD6/17ZWaWgKQ3gauAL+YgdKAKGBW7o9
	/n49J6TQjEJUWw95TI/+ItCOrzrArmC6BPcRjWR1JAXJ8PyAcOzetJ+eDC+TDuQT0Tl8UFze4zm
	6xvsE7NV+Nnsb01yScMyJyN7gv5p9IRw=
X-Gm-Gg: ATEYQzzA1WXaxmA8JI74R3vd2fYF2rbmV+oHSM8wO87PWGtaaDcX0nwrgfRFp+zYyH4
	Zw2vq8B3Pj8pF00WfvkZnS/EUlVZOLVUQf35CkipDtTAsJLGHuKKUuaMJDPm2BeuAirD4DQd1Qs
	eL+GVXJfzsUidOmDW7TcccnQr8G9Dy9och4atEbl1upsc8SZmekZgEitxR9XWj3h42kjuslvDch
	RIsS1z9bf/a+bFTr9oO8HvAxZ2cPU87jav2S4cIBuhXnH5ssluseTNEauIt9ufITnIWtqji6oi3
	nodYK9/BmzXgOCBpQyQ1fRWVAK3pLvOx9hPfVXN3+y2WDyJP5MYM2vNvvMM2ibI6bUGW2HFsBaW
	RvNe61es=
X-Received: by 2002:a05:7022:660c:b0:123:3c24:b15 with SMTP id
 a92af1059eb24-128ecc241fdmr5250686c88.19.1773639895212; Sun, 15 Mar 2026
 22:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com>
 <cover.1773497547.git.worldhello.net@gmail.com> <0c00f09918d94995b4f990679d598adcab0d6f2d.1773497547.git.worldhello.net@gmail.com>
 <87220e93-8159-4a92-9c3f-b3f9fa34ba4e@kdbg.org> <xmqqzf49rs2g.fsf@gitster.g>
In-Reply-To: <xmqqzf49rs2g.fsf@gitster.g>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Mon, 16 Mar 2026 13:44:43 +0800
X-Gm-Features: AaiRm52vToByWXuzKjWWus_KRfEYDrv3uEmBeGNy99EjDQzDKXKs0su8X-UpBzs
Message-ID: <CANYiYbH2o15x0=pZHuPk0Hf0qDNFWsvOpYE65O+yBMFspKBevw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] l10n: add .gitattributes to simplify location filtering
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, Alexander Shopov <ash@kambanaria.org>, 
	Mikel Forcada <mikel.forcada@gmail.com>, Ralf Thielow <ralf.thielow@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Dimitriy Ryazantcev <DJm00n@mail.ru>, 
	Peter Krefting <peter@softwolves.pp.se>, Emir SARI <bitigchi@me.com>, Arkadii Yakovets <ark@cho.red>, 
	=?UTF-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>, 
	Teng Long <dyroneteng@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>, 
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 12:11=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Johannes Sixt <j6t@kdbg.org> writes:
>
> >> +# Languages that strip both filenames and line numbers
> >> +bg.po       filter=3Dgettext-no-file-no-location
> >> +de.po       filter=3Dgettext-no-file-no-location
> >> +#es.po      filter=3Dgettext-no-file-no-location
> >> +fr.po       filter=3Dgettext-no-file-no-location
> >> +#ga.po      filter=3Dgettext-no-file-no-location
> >> +#ru.po      filter=3Dgettext-no-file-no-location
> >> +sv.po       filter=3Dgettext-no-file-no-location
> >> +tr.po       filter=3Dgettext-no-file-no-location
> >> +uk.po       filter=3Dgettext-no-file-no-location
> >> +vi.po       filter=3Dgettext-no-file-no-location
> >> +
> >> +# Languages that preserve filenames but strip line numbers
> >> +#ca.po      filter=3Dgettext-no-location
> >> +id.po       filter=3Dgettext-no-location
> >> +zh_CN.po    filter=3Dgettext-no-location
> >> +zh_TW.po    filter=3Dgettext-no-location
> >
> > How settled is the use of these two different filters (and names) in th=
e
> > community of translators? I am asking because I'm about to align the
> > translation workflow in the Gitk repository with that in the Git
> > repository. I need to know which of the two variants of filter names I
> > should ask translators to use.
>
> I too am curious.
>
> I would imagine that the translation target langugae has nothing to
> do with the choice, and it would be mere personal preference---in
> which case it would be better if people can converge on a single
> convention fast and stick to it.  After all, even if the current
> French translators happen to prefer no-file no-location, for
> example, existing translators would graduate the project and new
> ones would come in, and their preference would change over time.
>
> At least comments like "Languages that strip" is misleading, if this
> is just "personal preferences of l10n groups of various languages".

Will fix as below:

-------- >8 --------
# Default: Strip the whole location comments for all .po files
*.po filter=3Dgettext-no-location

# Legacy, unmaintained PO files: filter disabled to avoid index vs
# working-tree mismatch (these files still have location comments).
el.po -filter
is.po -filter
it.po -filter
ko.po -filter
pl.po -filter
pt_PT.po -filter

# These files use gettext-no-line-number (keep filenames, strip line
# numbers). The choice is per l10n team preference. Requires gettext 0.20+.
# The only benefit is locating source files from location comments when
# the .po file is not updated from the POT via make po-update.
ca.po filter=3Dgettext-no-line-number
id.po filter=3Dgettext-no-line-number
zh_CN.po filter=3Dgettext-no-line-number
zh_TW.po filter=3Dgettext-no-line-number
