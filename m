From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 5/7] worktree.c: add clear_worktree()
Date: Sun, 22 May 2016 15:58:45 +0700
Message-ID: <CACsJy8Dkfm91g9ez2PYXHjPevPcQaeEXTPteEQgFExYt6SVd5A@mail.gmail.com>
References: <20160510141416.GA22672@lanh> <20160510141553.22967-1-pclouds@gmail.com>
 <20160510141553.22967-5-pclouds@gmail.com> <CAPig+cS-tb_hD3k2XsTioJrkzaB3FxSnrxM6JMq5-og1ADnoRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun May 22 10:59:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4PEM-0003sK-Lq
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 10:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbcEVI7R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 04:59:17 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:33723 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbcEVI7Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2016 04:59:16 -0400
Received: by mail-io0-f177.google.com with SMTP id t40so83760253ioi.0
        for <git@vger.kernel.org>; Sun, 22 May 2016 01:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uAwJrXCoQ+V9gpnAcLWnR/3MQRxCcaBjVFF18ziK84g=;
        b=ZU5mhzeB8OR86GyTyF9bY4MqBjyGrEmc6rSr/KDUa9leYJzdMLX7w3RGdpFt9T7mlG
         v6pQQnQr5CLz0gog0BVfygqEAfAhVO4d0h/ldPFtsKlpRUX07eCL/EISyFDTok2FkrDm
         GWmmC2Y0p6nUz01e9nCoOrmf4Z+ZBeMgpq6EBA1SrKh7ssLOGy20OQ05ZEJ+ufkDR0A/
         CqakseQs+I4gz6yotHxRDIrzXowED7xv+xrVMsZfk8Y+63PUAfpyQ8EXADsWs/xC33kD
         lp5+KsFjMQ+iAcDBVWYp651zm+VssIyiLDIiOtFljYbr0SluYoCmZuJge1+dJ/VHKX8M
         uyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uAwJrXCoQ+V9gpnAcLWnR/3MQRxCcaBjVFF18ziK84g=;
        b=WicUA04LfMSnE85i8bWdQ/4cB1/3Xg8w790G2QdSBjR4vWDtvW7rLwnTRNF4CrVoDM
         lc/g2OhYbsHwr1sLYxabHMjdTY/We1rs3lK0VKYuOvPH8TfRMhCfCdKwy49PlFfD6+tq
         rWrmqVGRc+NQBUMSby3qOTZRaX7NL7kETO3peWuuSad2WLq4CNz2hqRwfW75RONJ2/eT
         +WvJef9ChxOCsdl+PZinRZx/t4fSMwhYpTklslWN7Gd07vuNw7zYojbSekLoSZXhzYSJ
         KOu0QNw/TiYLHPiUEWNjMFJTffStSXgD5lhQk9uJ5duWgXqgLCBPi0aG5khCoZdXPcqU
         +HWA==
X-Gm-Message-State: AOPr4FXCETfkA0oXNz8a8FjZX36yuzrjW8v5VKtl73I1Upc6gccGhWTyIbNe1DfzC7CLmCrpzZeefOACDawtTA==
X-Received: by 10.107.22.131 with SMTP id 125mr8294518iow.128.1463907555139;
 Sun, 22 May 2016 01:59:15 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Sun, 22 May 2016 01:58:45 -0700 (PDT)
In-Reply-To: <CAPig+cS-tb_hD3k2XsTioJrkzaB3FxSnrxM6JMq5-og1ADnoRg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295259>

On Wed, May 11, 2016 at 1:36 PM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Tue, May 10, 2016 at 10:15 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy
> <pclouds@gmail.com> wrote:
>> The use case is keep some worktree and discard the rest of the workt=
ree
>> list.
>
> So, you're saying that rather than a client freeing the entire
> worktree list like this:
>
>     free_worktrees(worktrees);
>
> it might instead want to keep some element ('n') and free all others
> plus the list itself, like this:
>
>     struct worktree *keep =3D worktrees[n];
>     struct worktree **p =3D worktrees;
>     for (; *p; p++)
>         if (*p !=3D keep)
>             clear_worktree(*p);
>     free(worktrees);
>
> Is that correct?
>
> If so, then doesn't this require the client to have far too intimate
> knowledge of the internals of free_worktrees(). Or, was your idea tha=
t
> the client would simply leak the 'worktrees' array after freeing the
> unwanted elements?

I looked back in my trees to see why I needed it in the first place.
It turns out my explanation was a lie. I needed it for refactoring
builtin/worktree.c:add_worktree(), where I initialized struct worktree
separately, not from get_worktrees() [1]. Because it's not clear of
the exact use case for this commit, and because that commit I
mentioned may take even longer time to be here (it adds "git worktree
move --repository", a lot more complex operation than a "git worktree
move"), I'll take this commit out of the series for now.

[1] https://github.com/pclouds/git/commit/528d81ce5609b5fbbe1ba193389f7=
aeecc83d992

> In either case, a cleaner approach might be to provide a function for
> copying a worktree element. Perhaps:
>
>     struct worktree *copy_worktree(const struct worktree *);
>
> or something?
--=20
Duy
