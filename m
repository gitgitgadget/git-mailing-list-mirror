Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B91156228
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913056; cv=none; b=Q9MlmDwqfvAqBEQIz0litccrvGTWb8Ru47v0EC+vuROWJAR+sGPlOMIoB3fq8AeUY50nEpOMK/XsGMRAgBO46njaZPf4pGsvAB/nuc2y2c3OKYgcU5WUcgfE+dp9D82/TnIdCmqYIsaJR/CyHoub/d3vKDEjxZRnl3wROzMK7m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913056; c=relaxed/simple;
	bh=B451bwtHCVP8sdTpRgkWTHdCSoseKDcG58v+NcP+KA8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pXCjD/tP1eehpXVfeQ4mSYahPTNFq+14REO78w281Gmnd6DLOIUJJEcVUfnYP8rSrmVR3pRdKW7MxeqEouilo8p4oWJHOpRzzBV/9/08SPjN0ISjwrLxVjUo38wU22gui0rnoeqa4afMhkSsbKAyWLP9hnXtZ/XTHH6owzyJUQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=DQfgwTjN; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="DQfgwTjN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719913034; x=1720517834;
	i=johannes.schindelin@gmx.de;
	bh=TCTNOc8G6mCO+yeBhtYXl0oyC6K8LDIbEHswbZ+tQXc=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DQfgwTjN0WipTRP0g+xl+sXRjJBiKIiMC0HrKFsZTU/YPM2zZUBX+zldFN884Fxy
	 yuu60Ztqg/tqvR8YWBRolGhOa9Qpq2A8yq8gld36e0UqavtY9o1UzMUAwaVQgmft/
	 qMfG63M554M2N7O8VRWS7AnmoXDdmGhvkLV9itcl1iluQvbV2wxl0YfV0mAojfYDj
	 yFQ4gbFqhF228d9Ldws8LB5nMyCWv8x/vqw6KvxIqmvqFQKcPTyoeUiCSOrLquDJc
	 aOgxngXwdrSp2UbHKkUhtczqGANvt3natUImeOA8dqvKWGI48nu0r72I3rX5MMYYm
	 TywNUvn1e1soMWWekQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.58]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlT2-1ryd8G1L9i-00i8Ie; Tue, 02
 Jul 2024 11:37:14 +0200
Date: Tue, 2 Jul 2024 11:37:13 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Arver <linusa@google.com>
cc: Junio C Hamano <gitster@pobox.com>, 
    Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
    Christian Couder <chriscool@tuxfamily.org>, 
    Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
    "Randall S. Becker" <rsbecker@nexbridge.com>, 
    Christian Couder <christian.couder@gmail.com>, 
    Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 0/5] Unify trailer formatting functions
In-Reply-To: <owly4jd741ph.fsf@fine.c.googlers.com>
Message-ID: <efdda91a-1118-ea54-d28f-dd6fa6df67c5@gmx.de>
References: <pull.1694.git.1710485706.gitgitgadget@gmail.com> <xmqqjzm3qumx.fsf@gitster.g> <owly4jd741ph.fsf@fine.c.googlers.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ee8nFiLv9fBNbZEVIbyRvkDsbQQtG7EdWupnywTxLy0yRnwIiZJ
 06izcPZ/kQB7zkrOuG0RGFtlhq61aNdfmmwJDJzsV8tzRp1+1HymoCbSXkqIwZsV8OW4fdB
 F/sFfl4Zw++pzdx+w/Wfe8HmJmzUemJIVmSqBzBWUncK8rSFU4Wc48cNUKi3JW90Qr34AJP
 F7miuY/EPnKksv1ro4Xgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tFlze7+KMwY=;HxPtEDJmlsvO2FlLG7t6xTSAco9
 xFGU1LymCjsNVlrXRxPk/Au1IAgBaU7mDaMH1d6iTuc8YXdJe4NicF16NeOZTlLAbIG7KT0GW
 LDkQtrgDRBmoJZdnH8AFaSqZN/KRKDGzDAmcmA1zAMAFUIsmDyHpRs8o3vg8XdEIN2yXV9AGC
 IFgnXIm7EFeMdRWQSyhCUAz+cVeR6uKHpQ0l80Bo3nRQ1DKW349Yl17aGGoqjK2qTpeHu+Npn
 4TqNNvHAiKWch9idF+PJ4Mf86A+B3cRjk22AhkDCGsG+b0cnowNZQaDZZxDx/6WqN6x94IjhX
 bCs9bkNx4fhZSwrEHiERqq3WAq8dvcq/OkZYEPM6zzCm1xM2TCDg5KU0wnFVVi16zclGx/tRP
 Y6X0hXGAbckYJZIKq8MbfcpwbFViGwH5ENJdK5H6v3Frq4axOhwf56pxPnvi7Kwz9LiV2Mx/B
 ThjhmaNRfpsRvXvkHkAhwRwanNe3yh1kWKHOxRIBLCJ45W11vAXlH1RqrFMmi/jetGck/ccWM
 tK8JDvkwWWUNRcXHjtggpDC6dIWyfnT7eoafV4HSNfuqHI+CXhBcWIYlE1e6c2L41gHZbo8ms
 OV6+qN93dwBrBkMeLrDAH4zNIYhOVhYvIF7W38512QA8TmlIZeHm1m9GCPALK+eE/5ZeVtg6u
 3vUsG5rNT69+jJn9p45XW2DAk7VD4xmdAknt0kA3ucGDQXviLMSVdalN56vgdwMS3RLfVe/b6
 oa9p3ACNHVOAS0oXE3mbqKYNZxvhSGdrMPRXrtP1gESDAFwgnn/JZPGmoKJOeQCMoP8BtbwgB
 y2GOI1pM/Kj9spSsH2vQGeKwKXfIuBIJx9/Zo9qaACxkk=
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 15 Mar 2024, Linus Arver wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > Not about the series, but about the way it was sent.
> >
> > The messages in this series have exactly the same kind of breakages
> > in the recipient names/addresses we recently saw:
> >
> >     https://lore.kernel.org/git/xmqqh6hkxox6.fsf@gitster.g/
> >
> > Human-readable names with a SP inside [square bracket] pair
> > appended, and one of the addresses had that square bracket applied
> > inside <angle bracket> pair and breaking MTAs (I manually fixed
> > khaugsbakk's address before sending this response, so replying to
> > this messages should be OK).
>
> UGH, I'm so sorry about that.
>
> > What are you and Aryan's pull.1675.v3 did differently from other
> > series sent via GGG to trigger this, I have to wonder?
>
> I realize now that it's because I copy/pasted the "Cc: ..." lines in the=
 PR
> description from
> https://github.com/gitgitgadget/git/pull/1632#issue-2068188239, such
> that when I pasted those in for the PR description for this series at
> https://github.com/gitgitgadget/git/pull/1694#issue-2187804953, it
> carried over the email addresses as Markdown-formatted hyperlinks.
> Currently it reads
>
>     Cc: Christian Couder [chriscool@tuxfamily.org](mailto:chriscool@tuxf=
amily.org)
>     Cc: Junio C Hamano [gitster@pobox.com](mailto:gitster@pobox.com)
>     Cc: Emily Shaffer [nasamuffin@google.com](mailto:nasamuffin@google.c=
om)
>     cc: Josh Steadmon [steadmon@google.com](mailto:steadmon@google.com)
>     cc: Randall S. Becker [rsbecker@nexbridge.com](mailto:rsbecker@nexbr=
idge.com)
>     cc: Christian Couder [christian.couder@gmail.com](mailto:christian.c=
ouder@gmail.com)
>     cc: "Kristoffer Haugsbakk" [code@khaugsbakk.name](mailto:code@khaugs=
bakk.name)
>     cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
>
> when I click on "edit", where the last line must be from your manual fix
> which GGG picked up. I've cleaned up the PR description manually now,
> and for this message I'm also attempting to clean up those square
> brackets.

I would love to let myself be nerdsniped into working on this, alas,
I cannot afford that before I learn the trick to stretch time.

So I did the next-best thing and jotted down pointers for any volunteer
who wants to work on this:
https://github.com/gitgitgadget/gitgitgadget/issues/1645#issuecomment-2202=
545542

Ciao,
Johannes
