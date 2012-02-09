From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Silly Question About Timing
Date: Thu, 9 Feb 2012 13:48:25 -0800
Message-ID: <CAE1pOi14LW6ayNiRd2KogKZn2zLMbRsTS1kkMFgFBtx5J=yFNA@mail.gmail.com>
References: <CAE1pOi1+FQNoPZ_P-fmFx-YhnUYzMQT=6zh3s-OyT71vcDm=wQ@mail.gmail.com>
	<201202092116.q19LGnTY024797@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Thu Feb 09 22:48:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvbqx-00015g-9b
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 22:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758251Ab2BIVs0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 16:48:26 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43310 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754271Ab2BIVs0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2012 16:48:26 -0500
Received: by ghrr11 with SMTP id r11so1183824ghr.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 13:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=iUU0DwbwvnQXNMuPd7RoaDJKehPUbXM4KeE0T2Y6NCo=;
        b=nROVo3n+twX+/cfzn+gAHfsTYMZcFGlnsl79wZLXkTP70AidLredjdzGSiEaFF1gbs
         TfA4cfT4cCgbGnZ90fgrurdXCw8T4bn6ukU4ymO1umvOYqGLVnVDW23D6xSQwhTEifJi
         s8DoWLJArZp1zsOi6e6KHbRVHjOOR38e5wyuY=
Received: by 10.236.145.193 with SMTP id p41mr5210539yhj.124.1328824105803;
 Thu, 09 Feb 2012 13:48:25 -0800 (PST)
Received: by 10.236.73.130 with HTTP; Thu, 9 Feb 2012 13:48:25 -0800 (PST)
In-Reply-To: <201202092116.q19LGnTY024797@no.baka.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190328>

On 9 February 2012 13:16, Seth Robertson <in-gitvger@baka.org> wrote:
>
> In message <CAE1pOi1+FQNoPZ_P-fmFx-YhnUYzMQT=3D6zh3s-OyT71vcDm=3DwQ@m=
ail.gmail.com>, Hilco Wijbenga writes:
>
> =C2=A0 =C2=A0I've noticed that entering a Git controlled project dire=
ctory takes
> =C2=A0 =C2=A0quite some time so I wanted to measure exactly how much =
(it's the
> =C2=A0 =C2=A0prompt I'm using that's taking the time, I suspect). I f=
irst tried (a
> =C2=A0 =C2=A0bit naive, I admit :-) )
>
> =C2=A0 =C2=A0time cd my-project
>
> Your confusion is because you are measuring the wrong thing. =C2=A0I'=
m
> assuming, here, that you have a shell prompt which is giving you all
> sorts of status about the git repository. =C2=A0The "cd" operation is
> instantaneous, it is the shell attempting to compute the new prompt
> which is slow.

Yes, exactly.

> Exactly how your shell does this is shell dependent, but you might
> want to look at your setting of $PROMPT_COMMAND. =C2=A0Then you can t=
est it
> by running something like:
>
> time sh -c "cd git-directory; $PROMPT_COMMAND"

I tried that and it's still instantaneous.

The culprit is

export PS1=3D'\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \W$(__git_ps1 "
(%s)")\$\[\033[00m\] '

but I can't get that to run. Simply running

echo $PS1

doesn't work and I have been unable to get the __git_ps1 part to do any=
thing.
