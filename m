Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D78F641
	for <git@vger.kernel.org>; Sat, 13 Apr 2024 00:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712966856; cv=none; b=WeGzrkoORxDnyFQXr3bFiZynKpq7VBkazVDJAL9qfNsCu+OLV57HZYO5v21ZKf2kVn59F22u371pWErfbdb9+m6nHHmRYYDg5p2y259LiL8y5xD7uz7aOqQTPBMxHnzUOXJCEYfHeT6xjPPhbextpSBNDvVqPYgZsNIWEz9wWKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712966856; c=relaxed/simple;
	bh=rdU3zIIqoB8327ft3T8iF/+kZBxtWvbHIk47V3/kakI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fw0NySl5PqWnRJoKa6GEnAqkqpJ1/d8WwGK+B61DNPCSTbsld36Z/VW7i8mHjY3xLOM0sSzcSPqsfuMfmgp2kAChNL1JklxLIFl4F+voS7Dp86dqmWaWG5a3orwa1ptszY98jGPM5+a+f5RHCj/H1POo2/cGt0an87ZCrt98nLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kx1MIScv; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kx1MIScv"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a7d6bc81c6so1097473eaf.2
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 17:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712966854; x=1713571654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDS2CYBBlCs1zujSYVmwHFcrITpYE+wNtfJC7VnL2MU=;
        b=Kx1MIScvduUn5QAqRndCeDK1SBajK1kvDDixmy9JMp3/ZzcLvPO++f6oVXnot2MvUE
         tY3wPgV2ePJfcx6iHR6LHqAkils8hbaS/cQkLZE+PT3MuNoqYhn258tdVhD0lHhVet+h
         uHWySmXYKXVMz87ZLDlg0MqkrbwBB9PnkKfKAp1aojxTzeHdWNxKxcfEICa6r7svmjJ9
         tyLcUiD3pfPiip2RMw1akP8ph08Iqw3BCqORUIn++uovBOaQ8xzUAf+6vLwWXSva8RuC
         UVsSzRcSL4foX6VYMFj6GKiYLZ5ptJm5kPGYAOE6mcbYyVf/MD9Tay8iKkqO6XyeecP7
         jiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712966854; x=1713571654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDS2CYBBlCs1zujSYVmwHFcrITpYE+wNtfJC7VnL2MU=;
        b=uV9c29gvP6ca3ymLVe3Ljfk46unZ2612FQ5IhY6LAZntX+8QJuxoMw8HQjmM9zD9Zh
         h1TvDTV00Sn32IFvC/h5mOVSfn6wMsJcQG4LgQVHyGbAlWCtxkeEYwlv23LCj55AgAjb
         iJEXoELQvTBGOGAgIeALRzjfBLe3++UaLFLVO7jAXYPxiv/4xXYTVuygurNaT9hhzzve
         hi/KiAJ9Nd3W0gPJIzOhz6XMUH13pTB/769SBZd/9Ru3b2PMOaZr6Kjb8o60co2fBQzn
         rly3W1Rhh2Wv2xMFrPYPmmy1slNoKQBWn9XcwxFSWXHpT1KhNsbMJ3r0SmzMbEfba4ZR
         ESSw==
X-Forwarded-Encrypted: i=1; AJvYcCVhI4AupLbsiSxSgT/j9vZ1YT4Qme59zLz+tu/q/YruZBYTWcrMXup9ZNHH47BLeNbnKmSp7lCKAV078O34aW8l1f3i
X-Gm-Message-State: AOJu0YzTQYyxvgjt5++CoAjVD0c5GHc/A9T2Gp9EBRBZcdsPmFNM8gL2
	XXQcVCpBklv/94RFMMTOQBQRRU018JXpHk2GO2aZlP8tzRjinEezLca04Iv2hf/9hke+4/A/XEF
	d3VsV7ewqW7ixr6Ksy2QcH254tGw=
X-Google-Smtp-Source: AGHT+IEFZqto4o2wRcK8IKMwWHSLrMzTU2QF03zsdvIpCOOKuKp557I8aG6oDkItSqLv6447wB22R8vGdKPVBWDYHEo=
X-Received: by 2002:a05:6820:986:b0:5aa:3c6a:c5f3 with SMTP id
 cg6-20020a056820098600b005aa3c6ac5f3mr4318117oob.9.1712966854512; Fri, 12 Apr
 2024 17:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409000546.3628898-1-jacob.e.keller@intel.com>
 <xmqqpluz2tau.fsf@gitster.g> <CA+P7+xooa08Y-D8CXDGK7_aZ5c2b9iXM6+rFS5qNLyZaG0Kh3A@mail.gmail.com>
 <xmqqedbcqw84.fsf@gitster.g> <5a25d75c-cc27-49d9-a49d-39f657fd17f4@intel.com> <xmqqfrvrr3q7.fsf@gitster.g>
In-Reply-To: <xmqqfrvrr3q7.fsf@gitster.g>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Fri, 12 Apr 2024 17:07:23 -0700
Message-ID: <CA+P7+xqkTHrBy0adVC3Wmn6aqgGkdZyk7BdHPKsowBCyKWg11w@mail.gmail.com>
Subject: Re: [PATCH] mailsplit add option to include sanitized subject in filename
To: Junio C Hamano <gitster@pobox.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 2:25=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
> >> THe next level would be to still assume that you stop at the same
> >> place (i.e. you do not support patches from multiple series in the
> >> same mailbox), but use the number-santized-subject format.  This
> >> would be a bit more involved, but I think all you need to update on
> >> the "am" side is where the am_run() assigns the message file to the
> >> local variable "mail".  You know the temporary directory where you
> >> told "mailsplit" to create these individual messages, so you should
> >> be able to "opendir/readdir/closedir" and create a list of numbered
> >> files in the directory very early in "git am".  Knowing msgnum(state)
> >> at that point in the loop, it should be trivial to change the code
> >> that currently assumes the 4-th file is named "0004" to check for
> >> the file whose name begins with "0004-".
> >
> > Yea, we pretty much just have to get the git-am process to work with th=
e
> > new names. I can look at using opendir/readdir here instead.
>
> Not "here", but probably just after you called "mailsplit" and saw
> it return.  After that nobody should be adding more split mail
> messages to the directory, so you do it once to grab all filenames.
>
> > Ya I don't care much about multiple series. I care more about making it
> > handle scrambled series better than it does now. I download series off
> > of lore.kernel.org (public-inbox based) and those seem to routinely hav=
e
> > series out-of-order. I suspect this is because it bases them on arrival
> > date and sometimes certain mailers get it out of order when sending.
>
> Yeah, and that is why I said it would be a better use of the
> engineering resource to fix it at the source.  Such a fix will
> benefit folks with existing versions of "git am", not needing to
> wait for your improved version.
>
> Thanks.

I went and talked to the public-inbox folks, and discovered that there
is a known problem and solution, with a utility called b4 intended for
downloading mbox files from the public-inbox

https://b4.docs.kernel.org/

Thought I'd mention that here if anyone else reading this thread was
curious about an ultimate solution.

b4 will find patches in the series, sort them, remove the replies and
can do some other common cleanup operations including things like
applying tags from other messages on the list.
