From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: Re: Weird behavior of shell variables in git aliases
Date: Tue, 22 Mar 2011 23:22:04 +0100
Message-ID: <AANLkTinvP1TvhNBsN+Y3wyhzg+qampa6J=3NMfwr76a=@mail.gmail.com>
References: <d9c38309-c433-476c-bba3-f2c5b7e94a89@k15g2000prk.googlegroups.com>
	<20110321215310.GA2122@sigill.intra.peff.net>
	<7v8vw8nmh2.fsf@alter.siamese.dyndns.org>
	<7v4o6wnlxm.fsf@alter.siamese.dyndns.org>
	<20110322111844.GA32446@sigill.intra.peff.net>
	<20110322132820.GA14559@sigill.intra.peff.net>
	<AANLkTin3fXkGaC5cTVny5adU=FusQV0WAcPHLUEeEzLi@mail.gmail.com>
	<20110322134358.GA19064@sigill.intra.peff.net>
	<7vfwqfkphn.fsf@alter.siamese.dyndns.org>
	<20110322183201.GA22534@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 22 23:22:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q29xt-00018p-3n
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 23:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089Ab1CVWWH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 18:22:07 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47279 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658Ab1CVWWG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2011 18:22:06 -0400
Received: by bwz15 with SMTP id 15so6244858bwz.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 15:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ynMoUfA8YepQZGYXuTGyoVmXrZJeEyoLxBVspPdFpsQ=;
        b=u1ocVtm54rKDWgbBWUM/pkh8lmkjTI/CxbdA92aHXNWGvWsyv44PV6M+1eCK0gWNxO
         S6iID803/JXQFKu/6e/hiwTe+Bp/vcyoSyrG2s78xJbvsPlxp723Q4LeyYqAnSLJWFCe
         m6n9SWWTMMmAIWGg+1YLUW5hLigjuBMluQnUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C6NtnQ4pE4RQOG+0HgugZ4ivRJyvBS90zrA9zJx3uUzqmEnBX6sQbcHb2Qtcf65Y6P
         mHb5WUvnaMKVhymgFdy17LvZ0+HpEbEqH7iDeD1gi6mvqYQvQZ3FMxGxgfQYvqK2P1HJ
         6siD2k2aKgUH/++flUiQ2JcAwMu76z2GxJmwQ=
Received: by 10.204.166.66 with SMTP id l2mr5404954bky.6.1300832524227; Tue,
 22 Mar 2011 15:22:04 -0700 (PDT)
Received: by 10.204.114.207 with HTTP; Tue, 22 Mar 2011 15:22:04 -0700 (PDT)
In-Reply-To: <20110322183201.GA22534@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169784>

On 22 March 2011 19:32, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 22, 2011 at 10:57:08AM -0700, Junio C Hamano wrote:
>> is no longer true; nobody sane would expect that if you made them re=
alize
>> that "simply appended" already. =A0Just dropping that sentence would=
 make
>> the resulting text flow much better.
>
> Agreed, your version is better.

Good points...

>> I personally think the former "sh -c <str> -" is the more traditiona=
l and
>> well understood form (iow, an idiom) for people who breathe shells.
>
> Yeah, that is probably true. One advantage of the function idiom is t=
hat
> it doesn't happen inside single-quotes, so it's one less layer of
> quoting to deal with. And of course it saves a shell invocation. So I
> think mentioning both is reasonable.

As one of those shell-breathing people I prefer the function-style for
its lack of quotes:

git config alias.foo =3D !foo () { echo $# args: $1, $2 and $3; }; foo

Whlie we're at it, is "sh -c ... -" and "sh -c ... --" equally
portable, I wonder?

>> > +----------------------
>> > +alias.foo =3D !echo $# args: $1, $2 and $3
>> > +----------------------
>>
>> While I totally agree with the formatting advice you gave here, we m=
ay
>> want to avoid this notation; neither "git config alias.foo =3D !echo=
 ..."
>> nor writing "alias.foo =3D ..." =A0in .git/config file would work.
>
> Yeah, I didn't even think about that, but you are right.

Good point, I was wondering about that but decided to take my clue
from existing examples of the same notation...

Right, I'll sleep() on it and cook a patch tomorow, attempting to take
all of the above into account...

--=20
/Lasse
