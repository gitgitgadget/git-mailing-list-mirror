From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH 0/2] CHERRY_HEAD
Date: Tue, 15 Feb 2011 23:30:24 +0100
Message-ID: <AANLkTin+mdE0wcahNmWWwOD5dZHfmeox=g9rX3h-rk28@mail.gmail.com>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
	<AANLkTik2NM+mxKgZy_9dCwydz+An4sFM_a4U9mdrJBq3@mail.gmail.com>
	<7vk4h1lzjj.fsf@alter.siamese.dyndns.org>
	<AANLkTin-9g9Ux=_oKBMuB+Yp-bOtBCTjqMWU7ENctXdM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 23:30:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpTPj-0000a0-EK
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 23:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756279Ab1BOWa0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 17:30:26 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57277 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755534Ab1BOWaZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 17:30:25 -0500
Received: by fxm20 with SMTP id 20so709320fxm.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 14:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PAa25ggr9r5Fdg3BKr76gIVfAOwG7s2pX2ea+7kXDHE=;
        b=PwAopa4SpiFyu9edg5BtP2OR3zIDx79wJo3ynKu839dkmDRnIkzvBbqWVLFnuaouAz
         r8bIhgqYmM50DcLF63CFqW/Hs4qT0KSK8wh+uJ6RdnmbxzUNLaqwCyTOJ6Z3XW+VfHKU
         eYBaBrCEwp+itPZ4VWu4YFEQ4KzbptajgKZXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=b1/Ya1XyEH38AVjY26lgo5idGSSrOi1nATy3rVeq3VJM3JuXfBc9dULkLRC+mBL1Gw
         UYmRyazBDLAoXjNG3DkaqgsApPuoRrrGOkSnQ1Bbk6CQuLMUUL3ea+73SSZiDYcG9zEa
         t9x0EV8DAw6h+pfDJJ60Cu3n2StpDRgYFj8NU=
Received: by 10.223.113.73 with SMTP id z9mr2144613fap.41.1297809024210; Tue,
 15 Feb 2011 14:30:24 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Tue, 15 Feb 2011 14:30:24 -0800 (PST)
In-Reply-To: <AANLkTin-9g9Ux=_oKBMuB+Yp-bOtBCTjqMWU7ENctXdM@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166889>

On Tue, Feb 15, 2011 at 23:13, Jay Soffian <jaysoffian@gmail.com> wrote=
:
> On Tue, Feb 15, 2011 at 5:10 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> I've read this over, haven't run it, but I really like the idea. It
>>> sucks that you have to save away the commit sha1 somwhere after a
>>> failed cherry-pick to use it again. It should just behave like `git
>>> rebase --continue`, which this implements.
>>
>> I don't understand. =C2=A0What do you think rebase does to be able t=
o continue?
>> Doesn't it have to save the commit object name away somewhere?
>
> I took it to mean that the behavior after a conflict should be 'add'
> followed by 'cherry-pick --continue', not 'add' followed by 'commit'.
> Not that I disagree, but that's a lot more work, see my reply to =C3=86=
var
> just before this.

I just meant that when git-rebase conflicts it remembers the author
information when you do --continue without you having to do `git
commit -c sha1-that-failed` or something.

This patch adds a similar thing to cherry-pick, which I like. It's a
minor UI issue that's annoyed me in the past.
