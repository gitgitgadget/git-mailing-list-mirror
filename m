From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Updating Files
Date: Thu, 10 Nov 2011 12:05:15 +1100
Message-ID: <CAH5451m=zdM_1CKSubLksm+YZxjybNFo-=q6HTUkXXTsqzae9g@mail.gmail.com>
References: <338A71EC3E356A47BF5279971E4EF72A04D860D7F6@WESMSG51.nordsoncorp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Brand, Greg" <greg.brand@nordsonasymtek.com>
X-From: git-owner@vger.kernel.org Thu Nov 10 02:05:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROJ5Q-0003uu-Cp
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 02:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756911Ab1KJBFi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Nov 2011 20:05:38 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52532 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405Ab1KJBFh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2011 20:05:37 -0500
Received: by faan17 with SMTP id n17so2243037faa.19
        for <git@vger.kernel.org>; Wed, 09 Nov 2011 17:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=OdLDHmSVgHyfm690cxnapZzP4saNYBoTFRzRC4BEvEo=;
        b=wPJh1Bnl44TpcyyVXXRB0fIcd6jst/vawc2pDVAZwh3jY5evUJmoTbNCZbL/qEDiZr
         AZDzYA85Y2Ay0pk8X4JcXex6al5crfYh0f5K+CjUUKnYKUOAh54coy5oon6+HEyvURBj
         GZ/Bn7u22UJpIjdJMJacxblUNSorRK7f+ybEA=
Received: by 10.152.109.48 with SMTP id hp16mr3153707lab.38.1320887136077;
 Wed, 09 Nov 2011 17:05:36 -0800 (PST)
Received: by 10.152.22.38 with HTTP; Wed, 9 Nov 2011 17:05:15 -0800 (PST)
In-Reply-To: <338A71EC3E356A47BF5279971E4EF72A04D860D7F6@WESMSG51.nordsoncorp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185181>

An oft heard recommendation when taking up git is to disregard any SCM
you might already know, to clear your mind from an pre-existing
expectations and to learn the tool with a blank slate, so to speak.
This is probably a good idea in your case.

A solid understanding of the core concepts git uses will really help
you - for example, it is very quick and easy to create branches in
git. A branch is just a reference to a snapshot of your files. So, you
can of course have a 'clean' copy and 'dirty' copy, but they would be
contained in different branches, not different files. Once you have
two branches you can easily compare them, merge them, steal from them
- whatever you want.

Other key ideas you may want to understand (in the blank slate sense)
include the index, the working directory and staging commits. I'm sure
others have their own ideas about what they key ideas are too.

If you haven't already, check out the pro-git book[1], it is very good
at explaining these things.

Regards,

Andrew Ardill

[1] http://progit.org/book/



On 10 November 2011 11:54, Brand, Greg <greg.brand@nordsonasymtek.com> =
wrote:
> Good Day,
>
> Let me begin by describing my SCM experience.
> I am an old school UNIX guy, and grew up with RCS.
> I have written many BASH and CSH scripts for RCS.
>
> Moving on, the next logical step was CVS.
> I've worked with (and administered) CVS for the last 12 years.
> I have also worked with SourceSafe (ugh), Perforce and ClearCase.
>
> I am an avid CVS proponent.
>
> I have Recently changed jobs, to a SourceSafe shop.
> We HAVE to move to something different.
>
> I've played with both Subversion and GIT.
> I REALLY like GIT, but have some questions.
>
>
> For my questions, I will use a CVS comparison sense this is what I'm =
most familiar with.
>
> - Updating a File:
> =C2=A0=C2=A0=C2=A0~ CVS's default behavior, is to try to merge change=
s from the repository into my local copy. Sometimes, this isn't desirab=
le.
> =C2=A0=C2=A0=C2=A0~ With CVS I can also choose to get a "clean" copy.=
 If the file I'm updating has been modified, CVS will create a backup o=
f the original file before updating to the clean version. The backup fi=
le is saved as a "hidden" file, with the format:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 .<filename>.revision
> =C2=A0=C2=A0 ~ Does GIT have the same, or similar options???=C2=A0 I =
understand with the distributed nature of GIT, there may be several way=
s to accomplish this. It is nice, though, to be able to get a clean ver=
sion without losing changes you may (or may not) want to keep.
>
>
> Thank you for your help.
> I am sure I will have more questions.
>
> Best Regards,
> Greg Brand
>
>
> _____________________________________________________________________=
________
> Scanned by IBM Email Security Management Services powered by MessageL=
abs. For more information please visit http://www.ers.ibm.com
>
> This email is intended only for the use of the party to which it is a=
ddressed and may contain information that is privileged, confidential, =
or protected by law. =C2=A0If you are not the intended recipient you ar=
e hereby notified that any dissemination, copying or distribution of th=
e email or its contents is strictly prohibited. =C2=A0If you have recei=
ved this message in error, please notify us immediately, by replying to=
 the message and deleting it from your computer.
>
> WARNING: Internet communications are not assured to be secure or clea=
r of inaccuracies as information could be intercepted, corrupted, lost,=
 destroyed, arrive late or incomplete, or contain viruses. =C2=A0Theref=
ore, we do not accept responsibility for any errors or omissions that a=
re present in this email, or any attachment, that have arisen as a resu=
lt of e-mail transmission.
> _____________________________________________________________________=
________
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
