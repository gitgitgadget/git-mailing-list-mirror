From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] completion: suppress zsh's special 'words' variable
Date: Tue, 10 May 2011 14:43:50 +0300
Message-ID: <BANLkTi=C26rtgvx+kYpE0YUrwUFrEquphA@mail.gmail.com>
References: <BANLkTikkhryMa69DSx4EAYjw+aar4icKcQ@mail.gmail.com>
	<1304979299-6496-1-git-send-email-felipe.contreras@gmail.com>
	<20110510025529.GA26619@elie>
	<20110510025916.GB26619@elie>
	<20110510031708.GD26619@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 13:43:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJlM4-0001XH-DZ
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 13:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754434Ab1EJLnw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2011 07:43:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48665 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869Ab1EJLnv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2011 07:43:51 -0400
Received: by fxm17 with SMTP id 17so4237306fxm.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 04:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5yl8ca+tJiPYfmE8u4vlhilrtxAOaodxKmq3iA15cCI=;
        b=uG+LkzwAJNvbhD9L78J8PULen8YNsf73A/F7jNmJNeigYSMzrPPu0zuH+awe+zXant
         oN0ywnLi3qSHeBXIrTsipZ4y1Rt4KX6T4swrxhqMGKsxLRXl4usSEIE3ysr3CaBiUDwn
         N9HX+tiFF4RR6Rhh/4Ux50N5va1d5sIubT5hg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PSpkFdTXRrERTxPKiMHx2YO/jsGCeHes2XEQP3dy0YkDgKeIqH96mvjhuCQk3knMGT
         AzZEd+P6yssYMoZNFIbyZGoG5d9Gij/R7VyF4s5N6Lurkl2Gt+SFteTiTuK+WdrG1yVc
         yQ5WkhEh7H9IByXyt6nMmoNl4W0RYNjOolveY=
Received: by 10.223.87.215 with SMTP id x23mr1234190fal.32.1305027830075; Tue,
 10 May 2011 04:43:50 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Tue, 10 May 2011 04:43:50 -0700 (PDT)
In-Reply-To: <20110510031708.GD26619@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173327>

On Tue, May 10, 2011 at 6:17 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Jonathan Nieder wrote:
>
>> =C2=A0contrib/completion/git-completion.bash | =C2=A0 =C2=A02 ++
>> =C2=A01 files changed, 2 insertions(+), 0 deletions(-)
>
> I forgot to list changes since v4:
>
> =C2=A0- new commit message
> =C2=A0- removed comment I considered unclear --- probably the followi=
ng
> =C2=A0 should be squashed in, though, to prevent someone from seeing =
the
> =C2=A0 seemingly redundant "typeset -h words" and removing it, not
> =C2=A0 realizing it is needed for compatibility with old zsh versions=
=2E
>
> -- >8 --
> From: Felipe Contreras <felipe.contreras@gmail.com>
> Subject: completion: add a comment to explain what "typeset -h words"=
 is for
>
> In current zsh master, bashcompinit hides the 'words' special variabl=
e
> already, so our own "typeset -h words" in _git and _gitk might seem
> redundant. =C2=A0Add a comment to explain that it is there for
> compatibility with old zsh versions.
>
> [jn: based on the original comment by Felipe Contreras]
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> =C2=A0contrib/completion/git-completion.bash | =C2=A0 =C2=A08 +++++++=
+
> =C2=A01 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index da586e5..b80830e 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2608,6 +2608,10 @@ _git ()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if [[ -n ${ZSH_VERSION-} ]]; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0emulate -L bas=
h
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0setopt KSH_TYP=
ESET
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Suppress the "wo=
rds" special variable from zsh.

That is not accurate. This is hiding the special meaning of the
'words' variable, only locally. "Suppress" denotes that the special
meaning of 'words' is gone forever, even on outer layers of the call
stack.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Only zsh version=
s <=3D 4.3.11 need this --- in later
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # versions, bashco=
mpinit takes care of it.

That can be explained in shorter form:

# Workaround for versions < 4.3.12

The word workaround denotes that there's a bug, and by limiting where
the workaround is needed, it's obvious where proper fix is.

All this can be explained in this sentence:

# workaround zsh's bug which leaves 'words' as a special variable in
versions < 4.3.12

What is the need to change that?

--=20
=46elipe Contreras
