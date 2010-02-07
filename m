From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Sun, 7 Feb 2010 12:14:19 +0100
Message-ID: <cb7bb73a1002070314t4f382d31k91423eac00a68715@mail.gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<cb7bb73a1002061458s5b2c1e7ere83111429473d11c@mail.gmail.com> 
	<201002070220.36897.jnareb@gmail.com> <201002070248.03855.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Feb 07 12:17:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ne58o-0007eV-P3
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 12:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754580Ab0BGLOl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2010 06:14:41 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:50820 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739Ab0BGLOk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2010 06:14:40 -0500
Received: by ewy28 with SMTP id 28so1507419ewy.28
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 03:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=RZUnVGVxmcUcmt7nsX/BE/f7OcTyILVvX+i9b3TzaCY=;
        b=uesGekU5/Rsso03ya7VCOXW+tluUQxQ4YXVofKKHqNEnIwIcdAr/skUP4rJOOmsdF/
         uWivxU93P/LvAxXdWgyYtka/C33PRKoAIsmNM2bX0ewuiPWhLZe93D5pUg+0OJ/ERtgW
         3oY6ANv5Ljofj2U5xcwYsd9egt6Im/6dTkRnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=kOjYWb+11Ul86Yh7G6MwoRtP32pcC2UY0yjbjwzCZxmb4xA4uxR5onSuc/Fxjkb/A3
         L7mzXgqFEye/kXK1YOGtkjEJXI3WK/X3SrbS0/kG4eSIJLoV75XePYPL/Q3oVozB2JE2
         SAww1+1CPWWhHVRU8A2ubIdidDsCwsYRwfboc=
Received: by 10.213.44.77 with SMTP id z13mr2689055ebe.56.1265541279114; Sun, 
	07 Feb 2010 03:14:39 -0800 (PST)
In-Reply-To: <201002070248.03855.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139233>

On Sun, Feb 7, 2010 at 2:48 AM, Johan Herland <johan@herland.net> wrote=
:
> On Sunday 07 February 2010, Jakub Narebski wrote:
>
>> Also, perhaps "git notes show" should acquire --batch / --batch-chec=
k
>> options, similar to git-cat-file's options of the same name?
>
> I'd much rather have support for ^{notes} (or similar) in the rev-par=
se
> machinery, so that you could look up deadbeef's notes by passing
> "deadbeef^{notes}" to 'git cat-file --batch'.

Maybe something like deadbeef@{notes[:namespace]}? The ability to
embed the notes namespace to use in the call is very useful to be able
to access all the notes with a single git call.

>> > If we have a guarantee that the fan-outs follow a 2/[2/...] scheme=
,
>> > the open2 approach might still be the best way to go, by just tryi=
ng
>> > not only namespace:xxxxx...xxx but also namespace:xx/xxxxx etc.
>> > Horrible, but could still be coalesced in a single call. It mgiht =
also
>> > be optimized to stop at the first successfull hit in a namespace.
>>
>> Nice trick! =A0It seems like quite a good idea... but it would absol=
utely
>> require using 'git cat-file --batch' rather than one git-show per tr=
y.
>
> Still, I'd still much rather use the notes.c code itself for doing th=
is
> since it should always be the fastest (not to mention future-proof) w=
ay of
> making lookups in the notes tree.

I agree with you on this, btw. As I mentioned in the other message,
these would just be workarounds for the current lack of support of
these features in core. I'd probably try and have a go at the thing
myself, too (i.e. first implement the core functionality, and then use
it in gitweb), but I honestly don't feel confident enough to hack at
git core.

--=20
Giuseppe "Oblomov" Bilotta
