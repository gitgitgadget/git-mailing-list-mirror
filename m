From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] commit -c/-C/--amend: reset timestamp and authorship to 
	committer with --reset-author
Date: Wed, 4 Nov 2009 00:55:56 -0200
Message-ID: <55bacdd30911031855k6b38557bte14c858775d39da6@mail.gmail.com>
References: <1257282551-9999-1-git-send-email-erick.mattos@gmail.com> 
	<20091104073822.6117@nanako3.lavabit.com> <55bacdd30911031551k1bfd3151t940864e4793f5a37@mail.gmail.com> 
	<7v639rnkvt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 03:56:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5W2o-00023h-Gy
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 03:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753797AbZKDC4M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Nov 2009 21:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753792AbZKDC4M
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 21:56:12 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:36430 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680AbZKDC4L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2009 21:56:11 -0500
Received: by gxk26 with SMTP id 26so4237668gxk.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 18:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=KgsnlLydw+WReyFzPOlnyVweb2EJK43djnAn+Bl+Ogc=;
        b=PaIy6c6TeNPIZBhk5WbBGEj4hA86nyp30J3lYfZt8exsqJSk72yLXzKA2r7p+Vqu3W
         55qIsBvCyqDUOM5bY+3sMLdcVrs/mj4v2mgRrz7VoSRT1PsEg27ck4KlCrPoDC1X3w8U
         AkR/etUV1FoaCsVJ1QmjujzVOQHQw2qm75uKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DSfSbmW6NU+rIfDzAjirGD3iI0+VB+9bg6FYKMHriRvu6sRgIOZuyXdD3FZTyny0kW
         Ao2fx37wJ4gT8gtT3PpotDIo6fC68yHyiG3tTFYhdsbtstiD9HK9fnSYU8O38iGCLZwY
         nR0CISHSKCkYYOh6V4V1OoYIxn/S5tWT478XM=
Received: by 10.151.92.9 with SMTP id u9mr1647698ybl.158.1257303376265; Tue, 
	03 Nov 2009 18:56:16 -0800 (PST)
In-Reply-To: <7v639rnkvt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132028>

2009/11/3 Junio C Hamano <gitster@pobox.com>:
> Erick Mattos <erick.mattos@gmail.com> writes:
>
>> ... I had already sent another patch with the
>> suggestions he made in a previous email.
>
> That happens in real life with people working in different timezones.

6 hours between you and me!

>> The new option only touches on getting new author or copying the
>> original so that is why I made the first check in whole and the othe=
rs
>> only by author. =C2=A0If people think that this operation is so unce=
rtain,
>> then everything should be compared: parent, author and message on al=
l
>> tests.
>
> You probably have misunderstood why we write tests; it is not about m=
aking
> sure _your_ implementation is Ok. =C2=A0If that were the case, using =
knowledge
> of implementation details to short-circuit the tests would perfectly =
be
> acceptable.
>
> We write tests so that long after you get bored and stop visiting the=
 git
> project mailing-list, if somebody _else_ changes the program and its
> behaviour gets changed in a way _you_ did not expect, such a mistake =
can
> be caught, even if you are not monitoring the mailing list to activel=
y
> catch such a bad change to go into the system. =C2=A0So we prefer to =
test both
> sides of the coin without saying "this option only affects this codep=
ath
> (currently) so it never can break this part, it is not worth checking=
 this
> and that (right now)" when it is not too much trouble. =C2=A0It is a =
win in the
> long run.

I really did not get the reason before the other guy argued...  :-S

> In any case, I like --reset-author better than --mine. =C2=A0I didn't=
 think of
> diamond-mine, though ;-)
>

So that's it!  Diamond...  me neither!  :-D

I am going to send you another patch in a few minutes.  I hope this
time will be almost there.

Regards
