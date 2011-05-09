From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 (for maint)] git-completion: fix zsh support
Date: Mon, 9 May 2011 18:28:04 -0500
Message-ID: <20110509232804.GB23781@elie>
References: <BANLkTikkhryMa69DSx4EAYjw+aar4icKcQ@mail.gmail.com>
 <1304979299-6496-1-git-send-email-felipe.contreras@gmail.com>
 <20110509225307.GG22908@elie>
 <BANLkTim1Di2ABtrv8ncVPT6+vCvq5pD_kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 01:28:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJZs7-00052Y-NC
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 01:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755768Ab1EIX2K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 19:28:10 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36199 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755129Ab1EIX2J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 19:28:09 -0400
Received: by gxk21 with SMTP id 21so2006691gxk.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 16:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Ou/jejmmJTO/Sn5qjGkX4FCH1kOj8Y4yl9xeOHJwn+o=;
        b=QoTJP7N27wyfeV/yUWiD8sjQf6pvzulyB3z0Lp9czOp5/l/cEt240Tav2yjT7jHGlC
         i5KPsaUfvrYxzYEqEderfoc4aIw4Bz5ESFvG2DZ8xt+r8+abOaerXUR+94zgDSPiBjmi
         wOoBM7BlE3O8msEYprqG++EmRnOxK2VszygBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=KlEDYQKU2ILXalTJASuWWKaSzSP6e8nRZOlcziM9FBmjaKatTpHLWlK+d4b07CHgmr
         MV4rd/oJuXH6Du6OD9m6Gz2nmgSs/WUOhMzCrq3J24lD19wVKRxejnK4paWEfc7kQhg1
         o8uzv0MO7Rord8EDbfVvNhbOLaHRPkYYZbBOo=
Received: by 10.236.161.232 with SMTP id w68mr9101102yhk.24.1304983688694;
        Mon, 09 May 2011 16:28:08 -0700 (PDT)
Received: from elie (adsl-68-255-107-251.dsl.chcgil.sbcglobal.net [68.255.107.251])
        by mx.google.com with ESMTPS id u29sm2852208yhn.69.2011.05.09.16.28.06
        (version=SSLv3 cipher=OTHER);
        Mon, 09 May 2011 16:28:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTim1Di2ABtrv8ncVPT6+vCvq5pD_kw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173288>

=46elipe Contreras wrote:
> On Tue, May 10, 2011 at 1:53 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> =C2=A0- the fix in sg/completion-updates is less likely to be broken=
 by
>> =C2=A0 future changes in the bashcompinit library.
>
> How exactly?

Because there remains the possibility that functions from bashcompinit
will make use of the $words variable.  I have said this about three
times.  It is not very likely, assuming the zsh developers want to keep
supporting that fix (and I think they should), but the chance is there.

>> =C2=A0- this fix is conceptually simpler. =C2=A0In a way, the fix in
>> =C2=A0 sg/completion-updates only works by accident.
>
> You are missing other advantages:

Sorry, I should have prefaced the above with "in my opinion".  And to
be clear, I am not saying this fix should not be applied; I am just
explaining the trade-offs as I understand them.

The reason I asked for another opinion is that I find it hard to be
objective in this case, because of another consideration I didn't
mention: each moment I have been spending on this is an exercise in
frustration.

I even _like_ your fix (just like I _like_ G=C3=A1bor's cleanup and see
no reason to contemplate the possibility of backing it out).  So it's
a shame.
