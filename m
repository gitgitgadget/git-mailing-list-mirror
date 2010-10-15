From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Stable ab/i18n branch
Date: Fri, 15 Oct 2010 05:16:32 +0000
Message-ID: <AANLkTim0a7J5L1dtZNYTG7strEhjitZein5CVQayZFRh@mail.gmail.com>
References: <7v39s9fkk1.fsf@alter.siamese.dyndns.org>
	<AANLkTimr73DUBBwdj9MXOQQ=O-vmyyEZpgwdHmRsGG_-@mail.gmail.com>
	<20101014200027.GA18813@burratino>
	<AANLkTim-2V_XtWVLFbWS_A-0rFNmuDvtR58aanxKL-O2@mail.gmail.com>
	<20101014205413.GD28958@burratino>
	<AANLkTi=LEzQu5_EyJ_ncRmsHfufG=AnEv9+eTQuqh5W7@mail.gmail.com>
	<20101015000749.GD29494@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 07:16:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6cep-00031t-7X
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 07:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260Ab0JOFQe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Oct 2010 01:16:34 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40025 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab0JOFQd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Oct 2010 01:16:33 -0400
Received: by fxm4 with SMTP id 4so217102fxm.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 22:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3BetTlUVV/ywumJIQqxs4qUIekcQc8vOLudzslDfroU=;
        b=ss21a8EPy6tWr4wB4juTAhgYyiJeDKdxNn9ue+7fjslm784LGLkfQQccl4SqYWD0Xg
         jw+8lXzFJWVzKLXKLBlrZ+lRp276fR8vnRT4jojvLqMRQOKKE8MMyuu9ba5GYjCrQ/jb
         TveO5+8Flz/TEoP2jRn+qXr5HD3eE3ds8dsfY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=H50Wh+ZjXKPF3eNYAhFOjI8nD4QAvJsLzT8mMbgRl7d7QFIbCC7WVZB7rWbXONnA4V
         OB3zyzZrakjLhgJGdU7u9z/JBVsBNogAAMJDu3SyioxFEPXywNELBKgaHde/+QPQmVuD
         MtFACOzb62WcDjjppmSVyoLTvUhQaCdPyKbKo=
Received: by 10.103.124.14 with SMTP id b14mr85538mun.8.1287119792447; Thu, 14
 Oct 2010 22:16:32 -0700 (PDT)
Received: by 10.223.119.17 with HTTP; Thu, 14 Oct 2010 22:16:32 -0700 (PDT)
In-Reply-To: <20101015000749.GD29494@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159091>

On Fri, Oct 15, 2010 at 00:07, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> While that's not a perfect solution I think it's the best we're goin=
g
>> to get for the time being. I'm pretty convinced that if I tried to
>> make git itself LC_CTYPE-safe as part of this already huge series it=
'd
>> never get merged. Having messages with question marks from strerror(=
)
>> on certain platforms is an OK compromise in my opinion.
>
> The question marks[1] are what I was referring to. =C2=A0Consider thi=
s from
> the point of view of someone working on the Debian package: would
> users consider that an appropriate or positive change for squeeze+1?
> (Hint: not if it doesn't come with some benefit in their locale, no.)

No benefit? The benefit is that the program they previously either
didn't understand or understood poorly is now talking to them in their
native language. That's a pretty big benefit.

The tradeoff is that a small subset of the messages which include
strerror() output will show non-ASCII characters as question marks on
GNU systems.

Don't get me wrong. I think it's a bug that we need to fix. I just
think it's a relatively minor annoyance, not a showstopper. With it
the feature *mostly* just works, and the things that don't can be
documented by the Debian maintainer and others as a known bug.

> I suspect making git work with other LC_CTYPE would not actually be
> too hard[2]. =C2=A0Such fixes are useful for futureproofing and incre=
ased
> sanity anyway --- they do not have to be part of the l10n branch imho=
=2E

It's something we want yes, but not something I have time for these
days. So unless someone else is interested in helping audit all that
code, providing a printf() fallback on glibc etc. it'll block the i18n
series.

=46or something I at least think is a relatively minor issue that
doesn't warrant throwing the baby out with the bathwater.
