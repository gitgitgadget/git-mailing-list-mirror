From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] add: don't complain when adding empty project root
Date: Tue, 24 Dec 2013 06:46:06 +0700
Message-ID: <CACsJy8A7j_ERqH_TDuKDdssaLFCvM5yVT4eUjTqkN_qW4iXuGA@mail.gmail.com>
References: <CAEcj5uWHpem+5os+3Mc_a42pk6f30i4UiV=LRPdXkoqiy1jQ_w@mail.gmail.com>
 <1387789361-29036-1-git-send-email-pclouds@gmail.com> <52B87759.2090901@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 24 00:46:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VvFCr-0000JC-OX
	for gcvg-git-2@plane.gmane.org; Tue, 24 Dec 2013 00:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758291Ab3LWXqi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Dec 2013 18:46:38 -0500
Received: from mail-qc0-f181.google.com ([209.85.216.181]:34330 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758262Ab3LWXqh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Dec 2013 18:46:37 -0500
Received: by mail-qc0-f181.google.com with SMTP id e9so5367472qcy.40
        for <git@vger.kernel.org>; Mon, 23 Dec 2013 15:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=pkfeup+357F+3x5tvMcH66yEgCBTO41zTXURnfs27lg=;
        b=sAb73KMLUsPCT7nKq7fHbE3q1+7nYSp33Qs1rG8KT10ULlKUBVsU+VkSF66LJut2cJ
         9vtMec4dm1E36vhFBz/VoUa6DTKVXkzJn1kGXifKvcjQyVMAuPt/X8lN0VnjfHahcPra
         uJoKEg+gW5Y5NJB3E3PrJCRSHDruC8ghcW5frGaaqOIHyR/Fjl79OYJ/qr8LpSMsHuHh
         6ssPZ+ptRPnfK5ZTkhnQ5eGP9jZLrIOFTUr2LllKNdd/i68OmswbUCGZv37bi+tBf2dk
         5TPLWYc/FfXDC3M7Q/7gBI/cHINW5KFNNLMol6QPSm4KUDNKJE4JtEL4K5v7SGbqQbNj
         mCpQ==
X-Received: by 10.224.151.145 with SMTP id c17mr47728387qaw.24.1387842396216;
 Mon, 23 Dec 2013 15:46:36 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Mon, 23 Dec 2013 15:46:06 -0800 (PST)
In-Reply-To: <52B87759.2090901@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239656>

On Tue, Dec 24, 2013 at 12:48 AM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
>> +test_expect_success 'git add -A on empty repo does not error out' '
>> +     git init empty && ( cd empty && git add -A . )
>> +'
>> +
>>  test_done
>>
> I am (a little bit) confused.
>
> This is what git does:
>  rm -rf test && mkdir test && cd test && git init && touch A && mkdir=
 D && cd D && touch B && git add . && git status
> Initialized empty Git repository in /Users/tb/test/test/.git/
> On branch master
>
> Initial commit
>
> Changes to be committed:
>   (use "git rm --cached <file>..." to unstage)
>
>         new file:   B
>
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>
>         ../A
> ----------------
> And the behaviour is in line with
> https://www.kernel.org/pub/software/scm/git/docs/git-add.html
>
> "." stands for the current directory somewhere in the worktree,
> not only the "project root".

Yes, except in this case "." is project root because current dir is. I
could have done "git add -A" (without the dot) like reported, but that
will be deprecated soon. Another way to make it clear about project
root is use "git add -A :/". I'll send an update if it makes it
clearer.

> -----------------
>
> Could it make sense to mention that replace
> [PATCH] add: don't complain when adding empty project root
> with
> [PATCH] add: don't complain when adding empty directory.

We don't complain about adding an empty directory before or after this =
patch.

>
> (and similar in the commit message)
> /Torsten
>



--=20
Duy
