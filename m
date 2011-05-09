From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH for maint] git-completion: fix zsh support
Date: Mon, 9 May 2011 16:51:55 +0300
Message-ID: <BANLkTi=gNO6YyWKhTSX0=irEme-9vwyH2Q@mail.gmail.com>
References: <20110505185907.GD1377@goldbirke>
	<1304625144-5206-1-git-send-email-felipe.contreras@gmail.com>
	<20110505232503.GA7507@elie>
	<BANLkTikk1wfaC4Aic4iyJZXbZ5kkuEDxaA@mail.gmail.com>
	<20110506095920.GA1635@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 15:52:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJQsU-00035Z-MV
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 15:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525Ab1EINv5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 09:51:57 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53509 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802Ab1EINv4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 09:51:56 -0400
Received: by fxm17 with SMTP id 17so3600006fxm.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 06:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6LFVgdffTjxqACUHTHpKLf3y7cP3LO/LGj667D1pJOA=;
        b=Uy3+T1AHRNcqLn+v2Gk/9oXb5VCj9t+Bk8RLJ/XDDX/bK//vsfMSOLC9YRUUCGx130
         3/fHk+uJIU6isUwYYDGeRPoiHn15Sg0EgyJliMS5uyrxieKqV/f0to+2m6cAuqVQAU+W
         abHdjeL8qeCTiHL6rF/VKtR6CKwzxQogVIUx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XFGZQaW6ev1Ty72Uz4KqCpIkedrqCrI7xlHLBSPFOQXVAEeQ0f3B8aEs87Cm9ynXn9
         bSGnorDeNYtbVGbySHSn7/vlzMLz3zBCQyFumzVj5X5IZ92PDP95qa1e854kWBHC2JwA
         wY2W9Q0REeCxcGMbKLlLzXnrXhTLE3Ft88CAg=
Received: by 10.223.95.198 with SMTP id e6mr3792071fan.13.1304949115261; Mon,
 09 May 2011 06:51:55 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Mon, 9 May 2011 06:51:55 -0700 (PDT)
In-Reply-To: <20110506095920.GA1635@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173233>

On Fri, May 6, 2011 at 12:59 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:
>
>> No, the scope remains local.
>
> Is this local in the sense of typeset used in ksh functions declared
> as "function f" or local in the sense of typeset used in ksh function=
s
> declared as "f ()"? =C2=A0If the latter, I think you misunderstood me=
 --- I
> never meant to suggest otherwise.

I'm sorry, I don't know what you mean.

By "local" I mean that all the layers bellow in the call stack will
use a separate "words" variable than the layers above.

>> In fact, if you follow the link I posted, that's precisely the fix t=
he
>> zsh guys were pushing for. And the it is already merged:
>> http://zsh.git.sourceforge.net/git/gitweb.cgi?p=3Dzsh/zsh;a=3Dcommit=
diff;h=3De880604f029088f32fb1ecc39213d720ae526aaa
>
> Now this changes things (since it amounts to a guarantee that the
> bash completion emulation has already extracted all it needs from
> $words before calling a completion function). =C2=A0What happens if s=
omeone
> calls "compgen -F" after words is hidden?

I fail to see an example of that. Why don't you try?

>> Well, it's hosted on debian.org, and I haven't seen it used anywhere
>> else. I just don't know how else to identify that project.
>
> Here you go: http://pkgs.fedoraproject.org/gitweb/?p=3Dbash-completio=
n.git;a=3Dtree

That's just packaging:
URL:            http://bash-completion.alioth.debian.org/

http://pkgs.fedoraproject.org/gitweb/?p=3Dbash-completion.git;a=3Dblob;=
f=3Dbash-completion.spec;h=3D855462dd092a50959d9576f6bc02c01332dd63a2;h=
b=3DHEAD#l12

>> I think the simplest fix is the one I'm proposing
>
> I'm happy with it as long as the zsh people are committed to making
> sure it continues to work (which it sounds like they are, luckily).
> I suppose it is intended to obsolete the third patch from G=C3=A1bor'=
s
> series? =C2=A0Could you provide an explanation for the commit log,
> something to the effect that
>
> =C2=A0- the words array has special meaning
> =C2=A0- that produces such-and-such puzzling symptoms
> =C2=A0- zsh 4.3.12 (?) will fix it by using "typeset -h" to hide it w=
hen
> =C2=A0 running completion functions designed for bash
> =C2=A0- we can make the same fix to work correctly with earlier versi=
ons of
> =C2=A0 zsh, and that's what this patch does
>
> ?

I thought that's what I explained more or less. I will add the missing
point and the new developments on the commit message and resend.

Cheers.

--=20
=46elipe Contreras
