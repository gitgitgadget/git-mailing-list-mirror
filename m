From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: ab/i18n (What's cooking in git.git (Feb 2011, #05; Wed, 23))
Date: Thu, 24 Feb 2011 11:38:54 +0100
Message-ID: <AANLkTikfqmPKA0T4Q-ac0CXzqmCEp0cWNskODEjmACW_@mail.gmail.com>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
	<20110223234828.GA7286@elie>
	<7vd3mi44gx.fsf@alter.siamese.dyndns.org>
	<AANLkTinY4pt5DLokKkuCNnC1yi7nQBHcZv722x9CKvCh@mail.gmail.com>
	<20110224031414.GC7970@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 11:39:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsYbH-0003ay-CF
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 11:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477Ab1BXKi4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 05:38:56 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51468 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629Ab1BXKiz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 05:38:55 -0500
Received: by fxm17 with SMTP id 17so390941fxm.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 02:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=a7bhNuZeCW8vne4ciPOFaAVc7jlepvdSiPNxKEAK8YU=;
        b=xuQqfYAToPKY7rc3B49KJHl2NWkBsnwpojSc1tugn53ncm5qCprXVTBZ3bzd46W3Fe
         PjF/mKp+Gzd4aNEGRfa6w+OG+d/TbDgjN/qIHCUewHOZltilbFsU0oxgbg+N/Zc/wvPB
         YYLS1xnZNKIC/qTnleogyySagzxzWQp6loq8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sWai5pBpSnJADTiCfPR4MzG+zulOHbqpVngfvMKeKb87Kjk7uaShsTilVJ/bRP7rDR
         F5AkQd8t/rD9Hs7zswPn8RS5Mi0+3Q3yAz5driMyK3B7Mz0rByEWiLKfR0KZTWmNs66L
         lAzbRpL6wgKL3It4Mt/uKroeX9FmPjCg18jvI=
Received: by 10.223.72.14 with SMTP id k14mr821033faj.45.1298543934128; Thu,
 24 Feb 2011 02:38:54 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Thu, 24 Feb 2011 02:38:54 -0800 (PST)
In-Reply-To: <20110224031414.GC7970@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167795>

On Thu, Feb 24, 2011 at 04:14, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Anyway, to be blunt I really don't see the point of fiddling around
>> with this bit so much. Whether it's a `"GETTEXT POISON"` constant or
>> `rot13(msgid)` the same tests will fail.
>
> Because with rot13 you can decode the message and find the problemati=
c
> code?
>
>> If someone else wants to do the work I don't care. I just think
>> there's more important things to worry about.
>
> I already wrote a patch. =C2=A0I imagine you don't intend it this way=
, but
> I keep on hearing "we shouldn't do what you've already done. =C2=A0It=
's too
> much trouble. =C2=A0You wasted your time."

I don't mean it that way at all, I just mean that as a comment to
*this* particular patch series I don't think it's something we have to
worry about.

I.e. if you look at this in context we have a 170 gettext patch series
to trickle in gradually. Right now we have 70 pending with only the C
translations. Hopefully we can fast-track this to have around 150 of
those in in the next month or so.

What I want to focus on is getting this right for users of Git, and I
think it's already good enough for that purpose. I'm not worried about
an embedded debug testing mode that to my knowledge only you and I
have used so far.

If it has some changes for improvement I think they can be dealt with
later, doing it at this point means more code to review. Right now the
C code in the series is around 10 lines, doing something like the
rot13 implementation would at least triple that, making in not leak
memory (and hence have automated tools complain) would be even more
code.

Again, don't get me wrong. I really appreciate your work. I just don't
think this is something we need to worry about now.
