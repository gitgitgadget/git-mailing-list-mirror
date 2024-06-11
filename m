Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D903748A
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 01:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718070420; cv=none; b=mtRpBPz3eAwg8SHhQA9peXaySq29KKSnRHcCOTdT1s85N3MGa6DY0WntsJlNXi9ONeSV4d2P9lSyepq2gy3QSp+kluVa3LaHc7NTNPG1+3DpHHM3i3Mtz91d5MKsgToTYZ4GxBgxTUU9QOppZ5v1EujK8M0sfG/iSgIl7xz1n3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718070420; c=relaxed/simple;
	bh=oCkZ5/Wb2qqliEDN05g6W4dIUKlgMsT3I7vi70JEQZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciUJhakhsFnIRrYia0y3e50GcGvvscSO0ITE77KDC8KmiNJv56Ez1SyOEjczE23NlKYmYeZWmHCA7ftC5Dy8CeIqFatveYK73hkYLbG6LGjqerMuNsVilsOhmtqnKvvp42PJnotdSZY95nz2lROuJNCe+vtjMj7vBRcRJ7d/aSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWEulTBz; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWEulTBz"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57c7681ccf3so2456515a12.2
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 18:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718070417; x=1718675217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3CHk9/k9UlbSzDqdl2FCS897EukR0/iricUmvavxJY=;
        b=cWEulTBzuP2UBFaoVC/sjgcrfiTzX71PjXXk9PxlcBf4yvJLPdaJkiR1alH/wGThi+
         zDrgh/je8WEK4+ioaApQQ7EWc4wpg+r56gKYN6czTnh9qlRqQ/CWfSdufkWjiDrd0BFF
         tFQSvb0Mm1Mzzq2OhxpFtzLTxu2LsCsc8FlMvDLqFRS9hVF6rGqVxtniBl3on9Wo8i1R
         MnSBK3h8G3IgiRkKhRdAHIr4hS3u85rqDEvQYhi1diATSTPXRy+RpzODmHD0U4P8GxEK
         PW01mIqdmDenUMo/2s4SJYE4dKtJDiBtxNfLFaXDBuFiAqUgrqJlm/xLhD2pZAppOgeU
         5nmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718070417; x=1718675217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3CHk9/k9UlbSzDqdl2FCS897EukR0/iricUmvavxJY=;
        b=plags4ezMK2Si5wCt56WmBUSjTnJeTu0jcFgfuf5COXwqSkclHM2ZpG4hRwJLyl3+j
         is/es4fgjtpvTgMOJCWXEDtd+WTJJ4Vj4rw/m+OAhM1f+py0nlSGx6Sgadxvj0JqpATg
         XwVCArkn21CXbfAk33ye44Vx/I9SN+7ZJqaHVvPCxBn5ZwcitlzPSLx1rymvJ9ndQAjH
         PJw1/dsQYxp+EoUP2dFHpXIV8vXMyYwghB/szpryE7tGL11VOrxutETBTmBjKZGBErxm
         Tm5jg1gdlyFUswXb+cfgSXzMUbD80KYqI3nTdxgjytMREfKY82mxAGCk70IXRasgEjlN
         4nFg==
X-Forwarded-Encrypted: i=1; AJvYcCWNyCV2X/7BbyidQN0r3Qerh3aayKFSNGJdh5vg2CVuiVoCWd63x2lHpF7q79StW5X3B6GkTBV2W47Vd23Ug94mhmub
X-Gm-Message-State: AOJu0YwBWMzfG9A6tdn3BgLDo1UuHV7/vI4DxLDzjsNOBEu/h7oGWBvM
	FI9deQChNpEPA/OO1ffCe7XQC5YOIUA8xjHAjSwQ/NmM4Z+NowSM+j636eIRJhyZLPYm1/p9lBg
	xauqP9zR47oM0gtvq8ceuO8Pku8c=
X-Google-Smtp-Source: AGHT+IG4Tf0v4VGfe1TyrF8rB5yjYj+Scb8b4p3Wuu3587Ra/SVuvW1ttthDqSaKxLSK4F496NEEbqTvAg7+uSenS9w=
X-Received: by 2002:a50:d58b:0:b0:57c:621e:b7ee with SMTP id
 4fb4d7f45d1cf-57c621eb89cmr5205704a12.34.1718070417161; Mon, 10 Jun 2024
 18:46:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ae862adb-1475-48e9-bd50-0c07dc42a520@rawbw.com>
 <xmqqwmmw1sev.fsf@gitster.g> <4ed426e4-beb6-45ed-b493-1e19c7c0511b@rawbw.com>
 <xmqqikygzdgk.fsf@gitster.g> <e8feffd0-ba6d-4aae-8c80-3d6482896b08@rawbw.com>
 <0ee501dabb91$aa2340a0$fe69c1e0$@nexbridge.com> <8fdc76e2-3de2-4312-956c-2662336fa54d@rawbw.com>
 <0eef01dabb9d$70c99690$525cc3b0$@nexbridge.com> <b8f8fa08-e4a0-4755-99f0-9311b05945dd@rawbw.com>
In-Reply-To: <b8f8fa08-e4a0-4755-99f0-9311b05945dd@rawbw.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Mon, 10 Jun 2024 18:46:45 -0700
Message-ID: <CAPx1GveJ-ckaoxqTQ9-jpRGw8p0SO0+xxL4vErW1tv3tE83=Kw@mail.gmail.com>
Subject: Re: [BUG] "git clean -df ." silently doesn't delete folders with
 stale .nfs* files
To: Yuri <yuri@rawbw.com>
Cc: rsbecker@nexbridge.com, Junio C Hamano <gitster@pobox.com>, 
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 6:22=E2=80=AFPM Yuri <yuri@rawbw.com> wrote:
> No, *only* the .nfsXXXX file exists in the xx directory when git runs.

In the case you showed, yes. However, there are *at least* two
*different* problem cases, one of which gives Git no warning that
something weird is going on.

The way "NFS silly renames" work is this:

 * an NFS client tells an NFS server to do operations, and this
   is (nominally) stateless;

 * if an NFS client tells the server to remove a file, the server
   attempts to remove the file;

 * but for POSIX-style operation, if a client knows that some file
   is *open* and that *same client* intends to remove the file,
   the client *must not* send a removal request.  Instead, the
   client sends a "rename" request, renaming the original file
   to ".nfs<unique-id>".  When the client's last user of the file
   closes its last file descriptor, the client *then* sends the
   final remove for the renamed file.

So, the scenarios we must consider are these:

 1. Nobody has the file open anywhere.  The client will send a
    removal request and the server will obey or not depending on
    permissions.

 2. The server itself has the file open, but no client does.  The
    client will send a removal request and the server (assuming it
    is itself a POSIX system) will unlink the open file, really
    deleting the file later on final close.

 3. The server does not have the file open, but some client does.
    This could be a *different* client, in which case your Git
    process will result in a removal request, which will operate
    as in cases 1 and 2 above.  Or this could be *your* client, in
    which case your Git process will cause your client OS to send
    a "silly rename" if it has not already done so, *or* will cause
    your client *not* to send a removal request.

So, the main problem cases are case 3, where your own client is
the one that has the file open.  This causes your OS to *convert*
an unlink() call into a rename() call for a "silly rename", in
effect, *if* your OS has not yet done a silly rename.  But if your
OS has *already done* a "silly rename", your OS knows that the
".nfs<unique-id>" name is its own preserved name.

If the silly-rename operation has already occurred, your OS has
the option of making the unlink(".nfs<unique-id>") operation fail,
or ignoring it entirely.  If not, however, your OS has only one
option: to convert the unlink() to a silly rename and *report
success*.

That last case will definitely fool Git, which sees a successful
result of its unlink() call.  The other case -- the one where the
silly rename has already occurred -- will either report a failure
to unlink the silly-name ".nfs<unique-id>" file, which Git could
detect at that point, or will report success, lying to Git.

In both cases, of course, the directory will be non-empty at
the end of the series of unlink() calls, and the attempt to remove
the directory will fail with ENOTEMPTY.  Presumably Git should
detect this and warn, but there's nothing else Git can do here.

Anyway, that's the OS view of this mess. I leave the work on
Git itself to others. :-)

Chris
