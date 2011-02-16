From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH 2/2] Teach commit to handle CHERRY_HEAD automatically
Date: Tue, 15 Feb 2011 19:03:08 -0500
Message-ID: <AANLkTinrQ4hSh-dg6mU=gYi6C8ZWS4eFKbAV=8eucEg2@mail.gmail.com>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
 <1297805034-3512-3-git-send-email-jaysoffian@gmail.com> <20110215230015.GA17812@elie>
 <AANLkTinZ0ewJy01rV66xMMCKLon=7qz=hoJ3DbtXmtXL@mail.gmail.com> <20110215234735.GA18151@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 01:04:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpUt4-00066k-3R
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 01:04:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755315Ab1BPAEu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 19:04:50 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37505 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab1BPAEs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 19:04:48 -0500
Received: by iwn9 with SMTP id 9so745392iwn.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 16:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=PSP7xjFeB3a911jxyuRebn7qvSyunPFZ1sEXiOiKOYM=;
        b=UWSvSOrC5l/5Wvf8SUUCMOw5Xj/+Qfl8Uv9voUfyfhajgMtFKfSJ9XIolbJYO/x8nE
         FWronzSkBhLultcdbDp5BaHwZJua6JRUW7TRuZwi6OaTcVPWTn/t8Uq/HcQEi3v+sZlt
         2+i+b3HxRMHv+nbN0rJEzrDfKZ/yq3bSLvOAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=SdwpT2ehlZ9MvyLTQFP1ANvnlRuteYVmyplYCqQcrymfJC9TlXTc424W6v80F5uL5k
         VrIoIlUWTZOLlBv9jw1UrxJKWM/KpwrUpFy7jsQm6r/pXnAfEzV7jci/vUj6g8Ys6Odk
         BNyFYdVKzrvJGFoVqp9iE+aliaPmwjdhC/GXc=
Received: by 10.231.37.138 with SMTP id x10mr4360341ibd.192.1297814618170;
 Tue, 15 Feb 2011 16:03:38 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Tue, 15 Feb 2011 16:03:08 -0800 (PST)
In-Reply-To: <20110215234735.GA18151@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166906>

On Tue, Feb 15, 2011 at 6:47 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> I meant the following sequence of operations:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# by the way, does this set CHERRY_PICK_HE=
AD?
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git cherry-pick --no-commit F
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -C F-prime

CHERRY_PICK_HEAD is not written if you use --no-commit.  I'm going to
punt here and say that's not my itch, thus...

> But that was a silly example --- -C takes care of authorship on its
> own. =C2=A0A better example might be
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git cherry-pick --no-commit F
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -F the-message
>
> or
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git cherry-pick --no-commit F
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit --amend -C F-prime


Because CHERRY_PICK_HEAD wasn't written, commit in this case behaves
as it did before this series.

j.
