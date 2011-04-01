From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Try to remove the given path even if it can't be opened
Date: Fri, 1 Apr 2011 16:01:50 +0200
Message-ID: <AANLkTikjfkieO9VdpEka7Hb0Fk3st1+dCMF9ti0Kg5Fw@mail.gmail.com>
References: <AANLkTikfmXiZQquWi4STTCUy0qoY9J_waJ44nrPAvB1d@mail.gmail.com> <4D95D528.6050409@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 01 16:02:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5evb-0001ej-4w
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 16:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756709Ab1DAOCO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2011 10:02:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49933 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394Ab1DAOCN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 10:02:13 -0400
Received: by bwz15 with SMTP id 15so2544802bwz.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 07:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=m292rYRy75uSyKRXwHv+QmuRiResGVoZtTP0Zfn1Ja0=;
        b=Dwdf3H8kIIQXwmo0awgzTjjDeBItsn0WQ880M8QB4Z6tDhkWQT+7guYRV8aU6xP5h7
         L3FG8bArb6lw2b9ok6LfdCQJArHRCtifOtGF/D3pGUZc3d5ZHkOswRdboN5R8ck06e5m
         EUP+Cl3m2oUcTDb55l04CTDE6Kseh3LwXtaD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ovrWnY8yOFBmQGdkJ4lXJMcWYDGsvHMUkN2yMLq0gwxpEoroGpifqhCaQC+D3gWHMU
         IESUdvQ9wMIxB2SFRGChxA/MvWGCv6lQtJ4TtXmZspc/aEDHAgr3PuGuc4zfbL+4Qemg
         AhJ/dWlM2rQPWZN4kb+1e4IyaFqgINeiSd5wc=
Received: by 10.204.187.129 with SMTP id cw1mr3612463bkb.138.1301666532663;
 Fri, 01 Apr 2011 07:02:12 -0700 (PDT)
Received: by 10.204.29.2 with HTTP; Fri, 1 Apr 2011 07:01:50 -0700 (PDT)
In-Reply-To: <4D95D528.6050409@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170588>

On Fri, Apr 1, 2011 at 15:37, Michael J Gruber <git@drmicha.warpmail.ne=
t> wrote:
> How about simply
>
> if (!dir)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return rmdir(path->buf);
>
> like we do later on in that function?
>

I'm used to try to keep the returned value of a function I modify,
and I'm also used to not trust the return values of the functions
I don't control. That's to my defense.

But you're unquestionably right.
