From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Git server eats all memory
Date: Mon, 9 Aug 2010 21:31:24 -0500
Message-ID: <AANLkTi=DcuHEkJf1s18LUHrA2L6jUiadhxKqQBO4QCHh@mail.gmail.com>
References: <wesfwyupgrg.fsf@kanis.fr> <robbat2-20100810T004153-279468425Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Ivan Kanis <expire-by-2010-08-11@kanis.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	jaredhance@gmail.com, Avery Pennarun <apenwarr@gmail.com>,
	jnareb@gmail.com, git <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>,
	Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Aug 10 04:31:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oied5-00012W-RI
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 04:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235Ab0HJCbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 22:31:47 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55768 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674Ab0HJCbq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 22:31:46 -0400
Received: by gxk23 with SMTP id 23so3625188gxk.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 19:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=mcCuz0LOjvG8VemGF8Td16afW9GtHmdFy5KdlxpKQR0=;
        b=XsivYX+r5v0SfsX/gNqsL0i17dPwQ3XKUilQxiF0nyA5SmGx7/3FB6jByqOQT+KdTO
         whOqmU/2beJOsRbmkJncs3b4cwUHeMQE7gMJoEJsduVBzwQ04N3Tm0HC/12M1KQBSbmU
         /L06nCd3AF/D1rC48xNgjP9RNJF7WScpjnYDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Rf/uBkz9MDqMNjJIpoJNX0CTz45vup/yj6wug8eO1+JxdDE0Xhivbn738e7zoSnwCJ
         VUB4AgaC5m9LUOtZxm6X/9izk+syjq8PjAKl6Og0Wt0m40jWwNIAFSV/6LgKRyoszP0e
         Y6MuO1YHHJ3Kgb/zDAMiTuloXbQYNLUFi5vEo=
Received: by 10.150.254.17 with SMTP id b17mr19013617ybi.82.1281407505319; 
	Mon, 09 Aug 2010 19:31:45 -0700 (PDT)
Received: by 10.151.6.12 with HTTP; Mon, 9 Aug 2010 19:31:24 -0700 (PDT)
In-Reply-To: <robbat2-20100810T004153-279468425Z@orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153070>

Heya,

[please don't cull the cc list]

On Mon, Aug 9, 2010 at 19:46, Robin H. Johnson <robbat2@gentoo.org> wrote:
> Our temporary solution plan is via hooks, if you're asking for a item
> before a certain point, throw an error telling you to download a
> git-bundle from a given URL instead (as a bonus you can resume that
> trivially).

Seems like there should be a way to tell the git server that certain
pack files should be sent to the client verbatim. Perhaps the protocol
could learn a new capability to support such a negotiation in which
the server will assume that the client either has the required packs,
or continue negotiation under the assumption that they will be
downloaded first.

Sounds like Sam might have some relevant to say about this? Or perhaps
the pack caching gsoc project is relevant?

-- 
Cheers,

Sverre Rabbelier
