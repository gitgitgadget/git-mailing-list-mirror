From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/4] magic pathspec: add tentative ":/path/from/top/level"
 pathspec support
Date: Fri, 8 Apr 2011 19:00:08 +0700
Message-ID: <BANLkTi=YK-4TOxoD1qR8TO4SymLK6sPnQA@mail.gmail.com>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-2-git-send-email-gitster@pobox.com> <BANLkTint7sGCg7_seu1-SWJC=_sKF-FKYw@mail.gmail.com>
 <7vd3kyf327.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 14:00:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8AMz-00030j-KM
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 14:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022Ab1DHMAk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Apr 2011 08:00:40 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60218 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812Ab1DHMAj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2011 08:00:39 -0400
Received: by bwz15 with SMTP id 15so2769257bwz.19
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 05:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=ywGJFMHwmBZjczIzYAylF4su/EJlIhS5c3lRYcPJdnc=;
        b=eZdBOwp+zgtJTL2DsSB4bD2vjQ9iYbkmHpK/PZzOk/YgO/ssQAY2JmoJcYOegxa9Sp
         tJwJ9EHZYEqhaI10uRNZo67CSLqftLLkkYb1SGbKSNYbTuLE/n0FuphksQ1v1IZ0+xZX
         UzweCTSwDRopgXcFbVCOnKwl1Dp/9AIIfx2O8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KXTtujUWhgV4fo2J4QOo0QVGOFlYn1GGculSKS5fhmSQx56x/TRUJk5eJzznEKEz2W
         agxwDMW9CvB3yB7EfZZyjYr/ZxdAdeTbhdhXC2pHYUZfrasd2Eq+XEsI2KJvrDTBaZba
         fNOMzKaO1yAmA+8DdeQoRK/o9qtZ1/xjX6PK0=
Received: by 10.204.143.4 with SMTP id s4mr1807838bku.98.1302264038100; Fri,
 08 Apr 2011 05:00:38 -0700 (PDT)
Received: by 10.204.37.195 with HTTP; Fri, 8 Apr 2011 05:00:08 -0700 (PDT)
In-Reply-To: <7vd3kyf327.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171123>

On Thu, Apr 7, 2011 at 11:18 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> Also the patch does not catch this (ie. not die() on unrecognized si=
gnature).
>
> Of course it doesn't.
>
> I didn't say "everything that is not alphanumeric is magic". I only s=
aid
> "all the magic are not alphanumeric". =C2=A0Notice the difference.
>
>
> This is so that you can say ":/.gitignore" and do not have to say
> ":/:.gitignore".

But then, say people have a file named @foo at top dir. They can write
":/@foo" to address the file. Some time later we decide to use '@' as
magic, how can we re-train user's fingers?

> I am also tempted to special case a ':' followed by a zero magic as i=
f it
> specifies the top magic, e.g. ":Makefile" is the same as ":(top)Makef=
ile",
> aka ":/Makefile". =C2=A0It is not in the published code, but the shor=
t-cut
> would help ":.gitignore".

If you're not too tempted to do it, then reserve the case (ie. die()).
Although I quite like it, one less keystroke for me.
--=20
Duy
