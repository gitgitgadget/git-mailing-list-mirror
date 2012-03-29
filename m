From: Ivan Heffner <iheffner@gmail.com>
Subject: Re: [PATCH] git-commit doc: say -t requires editing commit message
Date: Thu, 29 Mar 2012 11:09:48 -0700
Message-ID: <CAF_oF=xGHdbkYw-ytvcZvJnqZ_jdckUCBiuUDzkqGDk=66+yMQ@mail.gmail.com>
References: <1333043876-19966-1-git-send-email-haircut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Adam Monsen <haircut@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 20:10:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDJnK-0006nl-LZ
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 20:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759193Ab2C2SJ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Mar 2012 14:09:56 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45723 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759507Ab2C2SJs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Mar 2012 14:09:48 -0400
Received: by iagz16 with SMTP id z16so3332251iag.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 11:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=PZw7NLjWDVWpSiUmBFhJ120ntx/ILMv5eV+B/wx2/Fk=;
        b=yOHWHloRIDdpvo3/Xi7+ESRwT/hA3VWQQwESXg6OoXId08TO/m0GZIXfWNIOt3voKk
         iODV4SRihyLB7RpbQQZZ/Ln5CbulxQ2SDb2W0Jn3gs4gjW6lyWqnD4anmRCKFBPiB1FW
         Ls7Vb2ZwAMrn/d6DBWN1D5vq+v3wAe9HchgUOvZduVzQQxuG1NBjKsiNLOhpdCVmGyt1
         2bVrt9cyUm4mBiupSg6Wo5aZeXo48B4McSmb4EWdI/Iw8BGCN6HWU97b2Xf3mJ+Si6oU
         MhTu1kDLkcO4LpYCa0d1HJxrxyGk5+Ckcbai7omGXcnbNN7QmJIH6ZT2g905+xaaP0D/
         lvSQ==
Received: by 10.43.52.74 with SMTP id vl10mr20713761icb.55.1333044588258; Thu,
 29 Mar 2012 11:09:48 -0700 (PDT)
Received: by 10.231.3.74 with HTTP; Thu, 29 Mar 2012 11:09:48 -0700 (PDT)
In-Reply-To: <1333043876-19966-1-git-send-email-haircut@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194282>

I'd suggest being much more verbose about what's going on and why.

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
index 5cc84a1..e842916 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -133,10 +133,12 @@ OPTIONS
 -t <file>::
 --template=3D<file>::
        Use the contents of the given file as the initial version
-       of the commit message. The editor is invoked and you can
-       make subsequent changes. If a message is specified using
-       the `-m` or `-F` options, this option has no effect. This
-       overrides the `commit.template` configuration variable.
+       of the commit message. The editor is invoked so you can
+       make changes. If a message is specified using the `-m` or `-F`
+       options, this option has no effect. This overrides the
+       `commit.template` configuration variable. If the message is
+       unchanged, the message is considered to be empty and the commit=
 is
+       aborted

 -s::
 --signoff::
--
1.7.6.553.g917d7.dirty

On Thu, Mar 29, 2012 at 10:57 AM, Adam Monsen <haircut@gmail.com> wrote=
:
>
> Make it clear that, when using a commit template, the message *must* =
be
> changed or the commit will be aborted "due to empty commit message".
>
> Signed-off-by: Adam Monsen <haircut@gmail.com>
> ---
>
> I found it confusing that the commit template itself, even if
> non-empty, must be edited. Hopefully this clears that up a bit.
>
> =C2=A0Documentation/git-commit.txt | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.=
txt
> index 5cc84a1..44947ab 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -133,7 +133,7 @@ OPTIONS
> =C2=A0-t <file>::
> =C2=A0--template=3D<file>::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Use the contents of the given file as the =
initial version
> - =C2=A0 =C2=A0 =C2=A0 of the commit message. The editor is invoked a=
nd you can
> + =C2=A0 =C2=A0 =C2=A0 of the commit message. The editor is invoked a=
nd you must
> =C2=A0 =C2=A0 =C2=A0 =C2=A0make subsequent changes. If a message is s=
pecified using
> =C2=A0 =C2=A0 =C2=A0 =C2=A0the `-m` or `-F` options, this option has =
no effect. This
> =C2=A0 =C2=A0 =C2=A0 =C2=A0overrides the `commit.template` configurat=
ion variable.
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
