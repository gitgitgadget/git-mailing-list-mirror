From: Mariusz Gronczewski <xani666@gmail.com>
Subject: Re: [BUG] Veryfing signatures in git log fails when language is not english
Date: Fri, 15 Feb 2013 15:14:47 +0100
Message-ID: <CAJ9Ak2oF+SiYjStJndRZqLfnzBisn3TyXr3U_E_42BHrKbKPfQ@mail.gmail.com>
References: <20130214011837.04880b3e@hydra.devrandom.pl>
	<511CC288.30607@drmicha.warpmail.net>
	<CAJ9Ak2pLqUesOWKNtjwG7P_BW7-EqJP4Kaj0FF_+72Wn=oGoew@mail.gmail.com>
	<7vliaq3kr0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 15 15:15:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6M4X-0007Ot-7V
	for gcvg-git-2@plane.gmane.org; Fri, 15 Feb 2013 15:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754901Ab3BOOPC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2013 09:15:02 -0500
Received: from mail-vc0-f176.google.com ([209.85.220.176]:35237 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034Ab3BOOPA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2013 09:15:00 -0500
Received: by mail-vc0-f176.google.com with SMTP id fk10so2141490vcb.7
        for <git@vger.kernel.org>; Fri, 15 Feb 2013 06:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=dNK7thH9gxN9YY6UidSp/Akx4aDZEdAS1AT45yxES28=;
        b=P2d005g4OwDtsgIHtUQlYAqIeNETiBUH0UNkm/WxGA2Fe/TLtEFayVvKnqdQ03+7V9
         0dirW17DpoIMy8T7yTnnVG3iflYV1U/2dMHkVZhjdE6+X3maYC2Cbd0uKlcPE22TblVE
         Kd5Js+EQjYjLmmE+Hy6UhVg9+r2w4u9RQaJx1otrILspYZmKtgXYQesEkTCQI69AGQRA
         hJsAzjInxxZyth/u3FU+Oo1I3DJHkEFSs4/Dw14avMhQmiBNxWL6v39/GFA1+uUhn1A6
         X4ykpJy172ZVQd8ae12164GIewZzl5dtqQVSi9KfAQTeUSq+dw2+3AFqe1MCC+MjjdcT
         bxLg==
X-Received: by 10.58.245.200 with SMTP id xq8mr3443687vec.21.1360937687504;
 Fri, 15 Feb 2013 06:14:47 -0800 (PST)
Received: by 10.58.235.199 with HTTP; Fri, 15 Feb 2013 06:14:47 -0800 (PST)
In-Reply-To: <7vliaq3kr0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216346>

2013/2/14 Junio C Hamano <gitster@pobox.com>:
>
>     - The "right" one you mention for %GS is easier than you might
>       think.  If you just verify against the accompanying "tagger"
>       identity, that should be sufficient.  It of course cannot be
>       generally solved, as you could tag as person A while signing
>       with key for person B, but a simple social convention would
>       help us out there: if you tag as Mariusz Gronczewski, your
>       signature should also say so.
unless there is someone else with same name, which happens more often
(so far i've seen it happen twice) than same GPG IDs. It's all fine if
you just have one keyring that you can use to validate against all
repos but when there are multiple projects each with different persons
responsible for deploying it can get messy ;].

my use-case is basically "allow only commits signed by person X Y or Z
to be deployed on production" and  "allow only persons A, B, C, X, Y,
Z to commit", while latter case can be solved by software like
gitolite, credential validation is messy at best as you have to
validate:
- ssh key
- if ssh key owner matches commiter name
- if commiter name =! author name, if a given person can do that
(project architect or some other person accepting patches) or can't
and I'm trying to implement GPG signing so if someone does something
malicious i can say "OK that commit was signed by your key ID, why you
did it?"


-- 
Mariusz Gronczewski (XANi) <xani666@gmail.com>
GnuPG: 0xEA8ACE64
