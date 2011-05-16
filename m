From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v3] Add log.abbrevCommit config variable
Date: Mon, 16 May 2011 03:18:21 -0400
Message-ID: <BANLkTimCUU=CNiVnka79n=OKki0wQQtQCA@mail.gmail.com>
References: <BANLkTi=og+e6JW8t+sCvkFJUnR=SrFtWGg@mail.gmail.com>
 <1305413341-56450-1-git-send-email-jaysoffian@gmail.com> <7vei3zoab9.fsf@alter.siamese.dyndns.org>
 <BANLkTi=iFgJ12=_amoxT8x+hNMEhQtOVBg@mail.gmail.com> <20110516070047.GA26270@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 09:18:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLs4u-0004vK-5d
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 09:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234Ab1EPHSw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 May 2011 03:18:52 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43494 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204Ab1EPHSv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2011 03:18:51 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so1990558pzk.19
        for <git@vger.kernel.org>; Mon, 16 May 2011 00:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=hAG1rAiqTPJiSRQCLR1xKF+E4xO2HGbIbCXu7lT08Gk=;
        b=wLTEpWOZ7cOjBHONNZ4Jl0SJbpkr8t24Eyp4ySVwEbJKD1earaW1PzNLKa5tG8Mi/e
         1r92MTXNr6OhxTsPbjBgE1/Rn5KpbDZbp6rjHmeozJvfCrTlSD9yh0ykBYEq11OXV7hQ
         Ukgm6A8XxbvGNDcSr2eIp4rUF8fU/BWgZ0h1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wnx8nM5nlgIxB9m7t5gOt6N0LLScdKgBZhfiC4bzR1qyAyGLg9QxYGJz0QYUJxEN93
         fnPFioOKdFbYc4oSPnWcivxjgQWG1D77cPK05LrxV6onrJ0fJTrY1g3E3PucXitAfTCl
         Tf2sBIzJmDQ8fZXcQYTnHr8wGfjQ8GX7h8Ujw=
Received: by 10.142.247.7 with SMTP id u7mr2753781wfh.255.1305530331102; Mon,
 16 May 2011 00:18:51 -0700 (PDT)
Received: by 10.142.174.16 with HTTP; Mon, 16 May 2011 00:18:21 -0700 (PDT)
In-Reply-To: <20110516070047.GA26270@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173714>

On Mon, May 16, 2011 at 3:00 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> I suppose part of what Junio is saying is that by the time the commit=
s
> referenced above were written, git had already broken some scripts
> (including gitk) and those changes were part of a desparate attempt t=
o
> contain the damage. =C2=A0So they are not a great example to look to =
for
> the sort of smooth transition it is possible to set up proactively.

Well, then why wasn't the change simply reverted?

> For example, maybe (after fixing the scripts we already know about,
> such as tig) we could add the log.abbrevcommit variable right away bu=
t
> advertise it as experimental:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0*Warning* This option is experimental and =
will break your
> =C2=A0 =C2=A0 =C2=A0 =C2=A0scripts. =C2=A0It is only provided to give=
 script authors a
> =C2=A0 =C2=A0 =C2=A0 =C2=A0chance to test this functionality and fix =
their scripts
> =C2=A0 =C2=A0 =C2=A0 =C2=A0before the feature is advertised in earnes=
t.
>
> One transition plan could look like this:
>
> =C2=A01. In the release notes to v1.7.6, mention that there is a chan=
ge
> =C2=A0 =C2=A0on the horizon that would break people's scripts and enc=
ourage
> =C2=A0 =C2=A0script authors to switch to "rev-list | diff-tree -s --s=
tdin"
> =C2=A0 =C2=A0if their scripts depend on the details of "git log" form=
at
> =C2=A0 =C2=A0(in particular, if their scripts do not work correctly a=
fter
> =C2=A0 =C2=A0s/log/log --abbrev-commit/). =C2=A0Introduce the log.abb=
revcommit
> =C2=A0 =C2=A0variable to help people test, guarded by a compile-time
> =C2=A0 =C2=A0option and disabled by default.
>
> =C2=A02. In v1.7.7, introduce the log.abbrevcommit variable, advertis=
ed
> =C2=A0 =C2=A0as "This will break your system --- don't use it unless =
you
> =C2=A0 =C2=A0are trying to find such breakage and fix it".
>
> =C2=A03. In v1.8.0, introduce the variable in earnest and recommend
> =C2=A0 =C2=A0that people use it.
>
> I think step 1 is going too far --- it should be possible to give
> users rope like this without worrying that they are going to be
> irresponsible about it.
>
> Now, returning to "log --pretty=3Draw". =C2=A0Is it plumbing or not? =
=C2=A0It
> would be nice to advertise whichever way it is decided (I guess it is
> de facto plumbing) in the "git log" reference documentation and to
> follow that decision in cases like this one.

To my mind, we call "--pretty=3Draw" de-facto plumbing and keep the
change as is. Though perhaps, there is a cleaner implementation if we
say that --pretty=3Draw is indeed plumbing.

> Thanks for some food for thought.

And here I thought this was a simple one. :-(

j.
