From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] t3703: add test cases for pathspec magic
Date: Sun, 8 May 2011 16:59:57 +0700
Message-ID: <BANLkTikLxUtagAcujR8nzALnpUq-KHujtg@mail.gmail.com>
References: <1304764507-27547-1-git-send-email-pclouds@gmail.com> <7vwri2wd8x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 08 12:00:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ0mv-0003ol-Uv
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 12:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803Ab1EHKA3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 06:00:29 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59959 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480Ab1EHKA2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2011 06:00:28 -0400
Received: by bwz15 with SMTP id 15so3368036bwz.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 03:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=UbXe2Y+9u8IT01wRdtPzU06ksEmzOF19sEDNX81InNs=;
        b=wnGlX4WTkn8ZmJKkmY3pm4isr0V13ASc9p0LhS5rqD3CsZ6auO8Y/dMjT4pfUiYWx6
         5EZx0YUTevnxXUm4Ai11drfFbRjadLXqB065/QRBmojP9CooiRRAGD5eehN8/nlfLXf1
         P3DRkRqrcOOuSEg0EihE3kg4o4+vB9CSy2ggI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CZV85TL5RTch+MH8ABkmjUE++FpN2TzOVnY/FvaiQ82uk7wddxZNFLxxhK0qD4YOfV
         S6nrs7FWcof4m06YlVOwMBp8pj/JV6tiY9+JYqVkAPyl93i8DYtsLn1FCTFX1PePpHgE
         EkCzY6RDUwk7Qdr1vsBoa6V5l955esHTHKlGY=
Received: by 10.204.7.213 with SMTP id e21mr2290775bke.209.1304848827197; Sun,
 08 May 2011 03:00:27 -0700 (PDT)
Received: by 10.204.53.13 with HTTP; Sun, 8 May 2011 02:59:57 -0700 (PDT)
In-Reply-To: <7vwri2wd8x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173087>

2011/5/8 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> That was the intention, but it raises a question: what do we do if a
>> file happens to have the same name with the given magic pathspec, as
>> in the last two tests?
>
> I would have expected that in such a case the user would pass a "\:" =
or
> even ":::" to match the file ":", and "\:(rubbish)" to match the file
> ":(rubbish)". =C2=A0The whole ":" is special thing comes from the obs=
ervation
> that a path that begins with a colon is rare, so it is Ok to require =
the
> user to do some more work (typing an extra backslash) when he really =
wants
> to match with such a thing.
>
> A script that takes a pathname that is meant to be a literal from the=
 user
> in its variable $x would pass ":(noglob)$x" when it wants to be stric=
t. =C2=A0A
> script that lets the user say whatever and wants to pass would just p=
ass
> "$x" along the callchain.
>
> I do not expect this to be an issue in practice, though. =C2=A0Have y=
ou seen a
> script that tries to quote all the possible globbing characters in "$=
x"
> before calling into git with the current codebase without this magic?

Point taken.
--=20
Duy
