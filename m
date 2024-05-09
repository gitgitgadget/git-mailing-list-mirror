Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B7A77108
	for <git@vger.kernel.org>; Thu,  9 May 2024 19:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715281532; cv=none; b=pA1Et6fM7GVkHAGBfy5m8y3T6DoPGevDni0es/1DB5BwAq3YCiNY7fIIdOwdxb/sz3lOaHuO4IIjiyCgfN4rTDWhMe5/m/S/HxFUSnX3b6VdTNTnGr4NVACx1ThYUthQoMwG464HpHWBzc1KCf/LFaTtYD8joN2WvEgGFwvf0zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715281532; c=relaxed/simple;
	bh=h7/VQTH+p7SR/nvlxLVbGRuf3S7pMwwPII5CQB7PBEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BzWdklZ9EubQ75QML1cyuzTAyK6zyCjtuT/sQC26P29LvJWCow6Rj8QMu6xs2XZuBGmMTj+w/7Y99k5SyiGwzGqzmGeCkralvZhzgUFnSVqwnAWjkw/6E4PZh9qanSwqOd1v/R8UnJT3ab/7lYci+EVU6h4aVicM2JmNSv8DY/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-792c34f891eso51739985a.1
        for <git@vger.kernel.org>; Thu, 09 May 2024 12:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715281529; x=1715886329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3Eox7uihykCIy5l9nMnrarvyIzDfludbS7dZKgdPe8=;
        b=WNyR5/pyR8S7tdOJUjrb78eY2E6undhYpGa0cqL3K7yTNfLQBwVNlRY3umgg3ylRe4
         IR0tCn5C7O70nBAQCI3U1/RL+wr6h2gi/F1TCW/SZimBOsBki34E+QjvhL9UDa+qd18F
         Vflw/Ap6spV9gkNjB95kk0RnMmnr+jeQhv9/MhFzAISZLmWyGT/7nloGFSObbGmd/5on
         Txj/JBx0Yc8tA90inCH9goSvDki4uKWoebMP7x9KMOPruR+uWydjDFRZKbji9mwTkrrG
         14osmA0IrWbT0pwpIVVB05wzak5x0GyNdxPcpeuKwuxpLe6kR2RN8EmaAPEgnh1HxpKU
         DFmA==
X-Gm-Message-State: AOJu0YyemC900q5miAZgA6Wc26CE+TM1YyGCHH9L4Dkikev+UDDIgyVg
	QMaIGXPwXttjlSTPm25ecg3SZ96Cjjn/cy+aulCfqkfobi9WHvtse42DAvRnY6Jq4Z23+miv/UB
	ZSoEhqoqSuPvQuL3bJEo8zh/R7p0=
X-Google-Smtp-Source: AGHT+IGu7UX29ENiM7a7ldfJmqc0dialXf6tsSm58F8tggaOBZ5TeD85o+Xd7TvwuiB+jIb1KCqWVW2RYLC3kIneXfQ=
X-Received: by 2002:a05:6214:4908:b0:6a0:b905:97b1 with SMTP id
 6a1803df08f44-6a16823f9b2mr3408716d6.51.1715281529700; Thu, 09 May 2024
 12:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <38A18180-3CC9-411B-B5D3-36C5C32B6EE9@gmail.com>
In-Reply-To: <38A18180-3CC9-411B-B5D3-36C5C32B6EE9@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 9 May 2024 15:05:14 -0400
Message-ID: <CAPig+cS1o5bqK2Ph1fFt2wi6QaOO2=83xwoqoTLifA6z3NssXA@mail.gmail.com>
Subject: Re: git-gui: Visualize * History does nothing on macOS
To: Ilya Kulakov <kulakov.ilya@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 2:17=E2=80=AFPM Ilya Kulakov <kulakov.ilya@gmail.com=
> wrote:
> Both "Visualize <branch>'s History" and "Visualize All Branch History" do=
 nothing on macOS. In the terminal it logs:
>
> Error in startup script: 58:103: execution error: Not authorized to send =
Apple events to System Events. (-1743)
> "if {[tk windowingsystem] eq "aqua"} {
>     exec osascript -e [format {
>         tell application "System Events"
>             set frontmost of processes ..."
>     (file "/opt/homebrew/bin/gitk" line 12321)

The above is reporting that the problem is in the `gitk` script...

> The relevant code at https://github.com/git/git/blob/0f3415f1f8478b05e64d=
b11eb8aaa2915e48fef6/git-gui/git-gui.sh#L271-L279 should not be fatal, beca=
use the permission to access "System Events" and arbitrarily manipulate win=
dows is optional.

... but the code you cited here is the git-gui script, which does not
experience the same problem because a `catch` block is wrapped around
the `exec osascript` invocation.

A patch to fix this problem in `gitk` was posted[1] in 2018 but never
got picked up since the `gitk` maintainer seems to have disappeared.
Considering that the patch is still relevant, perhaps it might make
sense for Junio to pick it up himself and apply it to the Git tree(?).

[1]: https://lore.kernel.org/git/20180724065120.7664-1-sunshine@sunshineco.=
com/
