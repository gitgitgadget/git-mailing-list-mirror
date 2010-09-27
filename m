From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv5 04/12] gitweb: nagivation menu for tags, heads and remotes
Date: Mon, 27 Sep 2010 08:48:30 +0200
Message-ID: <AANLkTi=nG9Day4ZCF88JwyeNx2qEM=+hKaKoyWRSTUFW@mail.gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1285344167-8518-5-git-send-email-giuseppe.bilotta@gmail.com> <201009261952.07803.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 08:49:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P07WF-0004lA-N2
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 08:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758393Ab0I0Gsz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 02:48:55 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47658 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754894Ab0I0Gsy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 02:48:54 -0400
Received: by iwn5 with SMTP id 5so4526985iwn.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 23:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ao4tTwKHS253+oC5KqEkvQrppTTurMegyZLe1jxwlF8=;
        b=ViDl1jdgR+x8V36qUa1KLz6IrcThydpaffVChSRkyhVBMl9koUzahfBclfhEEHzX7S
         0rKWNsjQcxY7C5gjsgjoRGQRm0Z7McDl6mWxBZo51hAjQ1PhLEa3mZpI1vqVYv1cBmJg
         n317a52AwxazAinr3DWaTaw623St7WjlcsHA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Y7LLm8VWKbG+O8QcqDXeUqQ8YAlTOg7zQuRkZFWJf/DLlaeLXmpxlN0zpKr3oOHk4N
         BpL6xEZTuvMmQEDddJxtylSiE2CpkKLiYUdOLvI7psy74N80NDlJrmUQQIi15sLgqjLl
         m+hbM59POlbopCJT9J3ig4UcMXvR6p16asKXI=
Received: by 10.231.160.77 with SMTP id m13mr8724510ibx.22.1285570130537; Sun,
 26 Sep 2010 23:48:50 -0700 (PDT)
Received: by 10.231.166.145 with HTTP; Sun, 26 Sep 2010 23:48:30 -0700 (PDT)
In-Reply-To: <201009261952.07803.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157306>

2010/9/26 Jakub Narebski <jnareb@gmail.com>:
> On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:
>>
>> +# returns a submenu for the nagivation of the refs views (tags, hea=
ds,
>> +# remotes) with the current view disabled and the remotes view only
>> +# available if the feature is enabled
>> +
>
> Minor nitpick: this empty line here is not necessary. =A0But I think
> that Junio can remove it when applying.

Since there have been a couple of stylistic suggestions for the
comments in the first two patches too, I can probably resend the whole
series including these changes, unless Junio wants to do the
hand-tuning.

>> +sub format_ref_views {
>> + =A0 =A0 my ($current) =3D @_;
>> + =A0 =A0 my @ref_views =3D qw{tags heads};
>
> Hmmm... should we pass it as argument, or use $action in place of
> $current? =A0Each solution has its advantages and disadvantages. =A0C=
urrent
> solution has the advantage of avoiding using global variables, soluti=
on
> using $action has the (supposed) advantage of automatically detecting
> current action.

Not using $action has the advantage of making it possible to enable
the $action command if it's wanted, which is something that I use in a
subsequent patch (when enabling single-remote view). But this is of
course debatable.

--=20
Giuseppe "Oblomov" Bilotta
