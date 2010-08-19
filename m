From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] tests: fix syntax error in "Use advise() for hints" test
Date: Thu, 19 Aug 2010 12:22:31 +0000
Message-ID: <AANLkTikDq4eJfm2RnbGDuJMHCR8_4cn6NfJpoYWHbWWN@mail.gmail.com>
References: <20100811083100.GA16495@burratino>
	<1282142204-14720-1-git-send-email-avarab@gmail.com>
	<20100819043036.GD25649@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 14:22:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om48o-0003Vj-21
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 14:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792Ab0HSMWe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 08:22:34 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43862 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072Ab0HSMWd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Aug 2010 08:22:33 -0400
Received: by fxm13 with SMTP id 13so961846fxm.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 05:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=X3XK+cSpLv1+RRgFhrw5n3L/X2XfWQGjpBllJQozLBA=;
        b=MZ08EZ+x9QwX+XY9OpwEAsJGpLOLq/Ja+/g6+xcLoLVlEwGqBLJZtsxTYGcfzVqR3N
         GY9fD6HUACUHMt4laf83uel3zvFJQX6AimzKBU+EcYuyUgWgvDVv3HxzlUZdocDz9TFH
         Zq+itfVT0zSF32GiG44wsHUD8QzeIZBnA06a8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sJZDFprGSVxYxELhYRa6zQ4XJJrKqDTQyjKq+IYB1hjIO4n7gUml445mGz8wYRIPJt
         mFEn1x0syXbLlg5FwI+ptKMMKovWfeixjxjOLp5asY8GTJPFfPrTq1BCeg9lhLFHU9dT
         f1Yjuvr1k35Mo1hM8kcHNJjEV5G2G574Czhq0=
Received: by 10.223.110.212 with SMTP id o20mr9288111fap.27.1282220551721;
 Thu, 19 Aug 2010 05:22:31 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Thu, 19 Aug 2010 05:22:31 -0700 (PDT)
In-Reply-To: <20100819043036.GD25649@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153918>

On Thu, Aug 19, 2010 at 04:30, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Change the test introduced in the "Use advise() for hints" patch by
>> Jonathan Nieder not to use '' for quotes inside '' delimited code.
>
> Yikes. =C2=A0Thanks for catching this.

=46WIW prove flagged it:

    $ prove ./t35*.sh
    ./t3500-cherry.sh .................... ok
    ./t3501-revert-cherry-pick.sh ........ ok
    ./t3502-cherry-pick-merge.sh ......... ok
    ./t3503-cherry-pick-root.sh .......... ok
    ./t3504-cherry-pick-rerere.sh ........ ok
    ./t3505-cherry-pick-empty.sh ......... ok
    ./t3506-cherry-pick-ff.sh ............ ok
    ./t3507-cherry-pick-conflict.sh ...... 1/?
=2E/t3507-cherry-pick-conflict.sh: 59: cannot open paths: No such file
    ./t3507-cherry-pick-conflict.sh ...... ok
    ./t3508-cherry-pick-many-commits.sh .. ok
    ./t3509-cherry-pick-merge-df.sh ...... ok
    All tests successful.
    Files=3D10, Tests=3D62,  4 wallclock secs ( 0.08 usr  0.06 sys +  0=
=2E65
cusr  2.91 csys =3D  3.70 CPU)
    Result: PASS

> Although the style you chose is arguably the least ugly, nested shell
> interpolation can be hard to follow. =C2=A0How about this?

I think '\'' is harder to follow than \" and \$, but each to his own
:)
