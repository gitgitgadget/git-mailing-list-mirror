Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3713433ADB3
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 09:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782121078; cv=pass; b=k6ATKwMBmfwYQipgc26rSVV3wEYZKpr7+0m1VQnfkdlNlyNNAVKhoSvPFQKVXmmXI3LGuoy4VH5n3/Obh973+j4yyt/Tz26RW1oNx/h/T2HbpuGffPLBFgAHu6G1Z3Fb7e/IKzkHlU3GRgeiRvfHw+WPZzgOAJvBGm/nbKYa/yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782121078; c=relaxed/simple;
	bh=e/Xek81biStUsSK9pBKx+bnOzQw80kapubBhNimP3XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPoClbGXRJ6Q9vSQQ6P1rim7pGbx6y48HaumYSQNbV4cltx/wllHbJHM9weisVwjxezBn6VBROXHhZdlJt3GsrI0u8Xu5tYii0fpz2PimRglZioCqP7s/JeXKx9uE1NDRSqG4m4lvBsc0X0HCpQP8e/uRhAaJ66xQgzMH1CjYn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oyc/N0av; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oyc/N0av"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-922ade88d0aso187492785a.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 02:37:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782121076; cv=none;
        d=google.com; s=arc-20240605;
        b=Su1w5+7SqoNtKzp0FJqtbfbjGbAzGzcWfQCN3e1Oh75voo0k3S1tlrdFnx6xgDfniG
         k4e8OFnMz/a4ptPIW0laGUipNuV/JsgYcYsokUGXuqxzlMovzfNaDsuU2MPkCpdfwBwM
         +QJeze6iGkoG2O/54F39O5Or+TQ1Ytv36L1JpNnEhopbsAq6a7+ds/GLSQvpnya142E/
         dKQcW2Qqh/P9js2xbM6xAK9gEceGpjv75AtgIRrXxF1Oi6ugIwTpL0BqajUOyOBcrqGo
         rxPmLYK5Swp4yX6BFaOg41bhA+8Fxk+WzbLkRxakkJAdeI1wgc0RR9+ll6aF0tDQoPWZ
         21qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e/Xek81biStUsSK9pBKx+bnOzQw80kapubBhNimP3XI=;
        fh=K/1g0xYVstt6ToxpvSV6XC/kUrMhcb4SmpvaWl0VJ5E=;
        b=iSFZF7KKzpYIaICWJ+c2o+xxkfUw+y6wlGbDGOx8rZOSUNnzvgJjLrgGA+LbXCGcq/
         5sBgeyViIClHrCx2muV0Yd+rAFpFKE3WMBxUbEGzPr6noiWSrpefhdcbcjW1v+pU2EXQ
         wslljwnC6Xp6ExoEvqijL50LxDCmiWggHqzwK3hFLWR+wVQd6tkTvjXxYW9mcJO1XKCD
         bEksu9nMOf61sOkDajGN3wzfiqWGwjTFdta6FLmxdjNIQe9iJIvH+7EJrBPkKypWSTPv
         2PcA/pdnUUHhdfcXoZ/IsT/2NM0cgPNg3+jCJ6k9m9g4zUV/A2Rlh1ji8caovvogOIbi
         GX4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782121076; x=1782725876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/Xek81biStUsSK9pBKx+bnOzQw80kapubBhNimP3XI=;
        b=Oyc/N0avd6To5Y4QH7bGERoSddR3eDLaUsrBZPo0XWZq3YURb7ghN3Hs2Imxy7Y2F+
         eL+CynOFY59wG6d8titkYVNgy6JcjdOCMEUtqM52YZa9nVmfVXTeQLAiAX9bTuiby6xW
         XmVk+e0eZFJfaBduBl5foVuMz88zmG/EQcbC2hsPG9RNIz20enL4FaLJMVVt8zEbVNcJ
         mXXnkEYc3rSMbUwICGpdn7Q39BKdqlpmKvSEfCEQjieiGKcw0lGACUamfH2Ar+oPcyMk
         GTK36xnkgK0MMHyboJgJrDdkZrXEdv5+0mXXNIotuvxcjWMFFpQPxkn6nF1tBsuJnWq5
         XZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782121076; x=1782725876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e/Xek81biStUsSK9pBKx+bnOzQw80kapubBhNimP3XI=;
        b=B8DSnIAOgiME50YRVaCMg59iLMGLtWPWaabcGyTwEzI3lDDUZRruN1bhnjtqj+1Yfy
         XCuejaHsdnwW54mcLPq1hvQ4kN6fk+WLvvgm/dX2cLBdWQGQYpE/ukbPkPdBdBAY+ckf
         HFCNqmYRbYyAaSpKKkr3r+Pgk4lHkbwYNOb6vZU63oJ6JPDvCuRp3MaFK82XM8y2O4Ua
         V2j5NWHDYZlT1lvNHbg/mowdGsdrFdBSYk/QohkejlN4fjknkBa0c79sqtDGLwIxE4lA
         /5KJ7yDuHtNGo2R7tBk2A2xBnaj4v33QO9A/H/GarpExKG722l9IPFtlhbnDX6jY1F0B
         FEpA==
X-Forwarded-Encrypted: i=1; AFNElJ/3g5uVp3LSYF4ZvGjXTxfg4PxKvohA8CYoyXVXNLp7y3XhXk/B9M6wjitAaQ+Tmlug+4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNJtFdZ3m/O8oOrfWXELXwloCF/f1cIU70+snse1HtFMPVLcpk
	0iqVdm7HTynJEMBHQzS01oBF/q+e5iTvtSzrN+MXIwemICO6DMeOua50j/qcUI7eat0Zhq/3xP3
	Qyy0IURi8XbYpKtLuA5L0f9mnW/D8KjAt+G9VzBk=
X-Gm-Gg: AfdE7ckurh4rAGRWSPCzs79nKeXq/oaGQvAPny8t88a2lTQkkZzWQTHkzuFo06+8TWA
	Lg0KWAGEqROof+gL8zpHzH8shEvXyCgPT60QelHdbSINtRIeXlAVgHlE1A7Zjt1GPoGDBFj132A
	I2pYeIh6HQ6vjIDM4oZCMKi9Jdka7+x1imNoWJEm5eln6zc8keckXkTCnGjkKrC9+XPiuzii4fp
	iaEfaYRVc7H7NXJWdQuqVU/rDRWgp8RnINvgnUCkdXd2+IwYd9DaxMpm/8/YLmEo/v2+i/L
X-Received: by 2002:a05:620a:258c:b0:915:6c4b:eb60 with SMTP id
 af79cd13be357-92091397887mr2165371085a.29.1782121076255; Mon, 22 Jun 2026
 02:37:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
 <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com> <9924373da0a0598cabe4f08f3bc4200833679171.1780999917.git.gitgitgadget@gmail.com>
 <78b6dfdd-df61-4c44-96eb-b527cb26243c@gmail.com> <CAHwyqnUsjpCHfS=eBphmkdDGYpQZ_LQUJi1mjrxV8ZXi+w4yhg@mail.gmail.com>
 <37f2a483-c8bf-4c24-84de-c6233cc20b25@gmail.com> <xmqqcxxnsufl.fsf@gitster.g>
 <42ffcb36-7fff-4948-9b8d-2c54eb626e66@gmail.com> <xmqqh5mymt8i.fsf@gitster.g>
 <xmqq33yimsdp.fsf@gitster.g> <CAHwyqnWt59h2HO5EJbFswYr7QEA7oNZKdBt_vTk5axNbWFZbpA@mail.gmail.com>
 <CAHwyqnVce7NKft9AEyCUnR=S_y1ygiXjhf-qmJqmi-tuUXcw=g@mail.gmail.com>
 <31172867-5577-4c1e-b8b6-425ef9fe44e1@gmail.com> <a3bd3514-dab4-49b6-a210-bc7b8ddd701d@gmail.com>
In-Reply-To: <a3bd3514-dab4-49b6-a210-bc7b8ddd701d@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 22 Jun 2026 11:37:18 +0200
X-Gm-Features: AVVi8CdENN6_XR5lBChdk3kTXJrSPgfMcJWY9TaT7W_MQuX1ZjuRKZCEfa5EbYQ
Message-ID: <CAHwyqnVQwK1w9ap1-e=ii4a-BVOZ=oQtCdkTxB=TJF30kNaZoQ@mail.gmail.com>
Subject: Re: [PATCH v14 4/6] branch: add --prune-merged <branch>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi! I implemented this in v17.


Harald

On Mon, Jun 22, 2026 at 11:28=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
>
> On 22/06/2026 10:09, Phillip Wood wrote:
> > Hi Harald
> >
> > On 21/06/2026 19:46, Harald Nordgren wrote:
> >> Looking into this more and attempting to implement the logic for
> >> re-assigning the upstream, it becomes quite a lot of code.
>
> Having re-read you previous message I'm coming round to the idea of
> clearing the upstream of branches that have been merged but cannot be
> deleted because they are the upstream of an unmerged branch. Is that
> easier than reassigning the upstream?
>
> Thanks
>
> Phillip
>
> >> Maybe an easier way forward now is to avoid deleting these cases. We
> >> can always add the re-assigning logic later on without breaking
> >> backward compatibility.
> >
> > Not deleting the branch is certainly safest and should be fairly easy t=
o
> > implement. Adding an option to reassign the upstream later sounds fine
> > to me.
> >
> > Thanks
> >
> > Phillip
> >
>
