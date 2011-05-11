From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: git rebase --interactive commits order
Date: Wed, 11 May 2011 20:45:56 +0200
Message-ID: <BANLkTikMo_VLMc2zxezgX_mjCaB8C2LgBw@mail.gmail.com>
References: <BANLkTimX2tupqV464+Re8u06TT+qRmqPuw@mail.gmail.com>
 <BANLkTi=PyBfMxCbWNfJEXEP6-MphdeE+_Q@mail.gmail.com> <m2d3jr1mev.fsf@Spindle.sehlabs.com>
 <BANLkTim1e=+yoyxd1AAThVYMZ_X3nfz=7Q@mail.gmail.com> <BANLkTinRcigdQv2GJN6L+nF3X2+F-5Lf5w@mail.gmail.com>
 <7vwrhygmrp.fsf@alter.siamese.dyndns.org> <BANLkTikV_TSEE1cgr=EOhuD0f8KP2vh-tA@mail.gmail.com>
 <7v39klgng7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 20:46:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKEQa-0001Hq-5v
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 20:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016Ab1EKSq1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2011 14:46:27 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60875 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364Ab1EKSq0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2011 14:46:26 -0400
Received: by qwk3 with SMTP id 3so406735qwk.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 11:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=nusLmiuW0Y8t2+YsYE8M6cifAU7JrLpaJP0aEu3butQ=;
        b=CKV/VozlzEfV5WYkPT8KYmmuB9m7nmA31KPTOWGNytfrQggqzIefcOyUFS9Dmxfxh0
         4fo55YmhsYK+scn2Ricr+DFV+PWMcy11I9a3lx+iOtkBma+LHeWXbPNcZ2qSv4Fas45N
         v/kLjF7lnD9h8RU6Hp5ceIPQUsNdvcAg9FJm8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=PZDjWRpNsbdvOMCKcFVcfQzRz+78uijBQ6YnH89HaArlt72S6J4/bzzc6ZisZN2FDH
         xe5SKc2m35xM3kxaI2iWQQMHJNPWeEsbQW0oUNx49psQjFcPtB/JPFm62U0elpJtUsjp
         ssfJcaUbaGPdVj/AONVP72BMSUi30BCqjKdIU=
Received: by 10.224.178.202 with SMTP id bn10mr8308967qab.325.1305139586168;
 Wed, 11 May 2011 11:46:26 -0700 (PDT)
Received: by 10.229.234.15 with HTTP; Wed, 11 May 2011 11:45:56 -0700 (PDT)
In-Reply-To: <7v39klgng7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173421>

> You start 'rebase' (without --reverse); it stops with conflict. =A0No=
w what
> should happen when you say 'rebase --reverse --continue' now? =A0Does=
 it
> error out because you are not allowed to change your mind once you
> started?

I had a long answer explaining it all but Richard beat me to it, and
his answer is pretty much exactly what I meant. Rebase wouldn't even
change, only the order of which stuffs are displayed in the editor.

> I am not saying that these small details cannot be worked out. I am s=
aying
> that you would need to spend a lot of effort to take care of the deta=
ils
> to avoid making it confusing to the users. =A0And I am also saying th=
at it
> is not even worth wasting the brainpower spent discussing these in th=
is
> thread, if the only "benefit" resulting from it is to add an option t=
hat
> allows some people to have an ordered list of things to do "First I d=
o
> this and then I do that" that has to be read backwards. Why spend ext=
ra
> effort only to introduce something confusing?

Well for us it's the current way that is confusing (and probably for a
lot of other users too, especially new ones). It's what we suggest
that would (imho) make it non-confusing... I'd very much like the
"benefit" from this discussion to be a change of default in how rebase
-i display commits, but as for some people having it reversed seems to
be a strong no-go, it seems the only rational thing we can do is offer
a --reverse option so the people used to the current way are happy.

If even adding an option is asking for too much, then we might resort
to EDITOR tricks and whatnot. You made me realise I could write a vim
script that offers the fonctionality I need without even touching git,
but it'd work for me only. I fail to see the problem with adding an
option which would simplify the life of many people and isn't invasive
for the others.

Philippe
