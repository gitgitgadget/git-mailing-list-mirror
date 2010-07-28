From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: inotify daemon speedup for git [POC/HACK]
Date: Wed, 28 Jul 2010 01:03:14 -0500
Message-ID: <AANLkTinabaO3csi3TBRJKPTZ1zVGgK8-ijs6h1YUkT-n@mail.gmail.com>
References: <20100727122018.GA26780@pvv.org> <AANLkTinuU6b1vmRFuBrA4Tc5H6gmC5cMP3Pa8EYz-8JE@mail.gmail.com> 
	<9E67A084-4EDB-4CCB-A771-11B97107F4EF@gmail.com> <AANLkTi=oA33M4DmS5FyDx7Wn1DFrUGcmhSYkvcSYMc2r@mail.gmail.com> 
	<20100728000009.GE25268@spearce.org> <AANLkTimkLrTwavErFkyaUTSVU-2s3me5f+cyqNFp7n+D@mail.gmail.com> 
	<52EDBD9A-2961-4F66-88B3-07BF873FA994@gmail.com> <AANLkTi=TQnyATgJ0LSdR3qeeCVAgu+wOFcHmHUBguPiV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Joshua Juran <jjuran@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 08:03:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odzjw-0006R0-FO
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 08:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939Ab0G1GDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 02:03:35 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50531 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab0G1GDe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 02:03:34 -0400
Received: by gxk23 with SMTP id 23so1557309gxk.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 23:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=dgpwmr7I7ZZhnk1/OHi2m02i6mqEftdSvY8CMFHxKl8=;
        b=MHCD3TiJ5MN8ViGMS4t69sVy3cgpftsbnDglfe94oNEeLSsXhA/CF0hoYgu0LrcDf6
         UiypngPgBTFwnNZM2pRJ8aZQBwOzZCXkhkP4454ZF+FEqgSCEdRbbUoiP8la7n5dHgug
         g6k1hGWiGsI148xtNvd6Rkla2spuki96jTpZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=BrjztDAz4UknreooJGBcY/Bm5mc9v9IVuIkSs7t/jRxwyJqrjO4Dxpssorbkvf8ykc
         l25hJqj4XBwmw0+/W2fxV9VzaCevNnFbyd6CxiXG3XJ0PrWDKWGFPEgDY3quUl451o59
         G7eFfLC/zZjfMhMMV3qAmmVByS7gDEC0j71l0=
Received: by 10.150.75.17 with SMTP id x17mr11978744yba.279.1280297014166; 
	Tue, 27 Jul 2010 23:03:34 -0700 (PDT)
Received: by 10.150.66.12 with HTTP; Tue, 27 Jul 2010 23:03:14 -0700 (PDT)
In-Reply-To: <AANLkTi=TQnyATgJ0LSdR3qeeCVAgu+wOFcHmHUBguPiV@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152038>

Heya,

On Tue, Jul 27, 2010 at 20:31, Avery Pennarun <apenwarr@gmail.com> wrote:
> That's what made me think that
> sqlite might be a sensible choice, since it's already a database :)

Sounds very sensible to me, especially the fact that (if it is indeed
fast enough, which I can't imagine it not being) it would make
development so much easier. At least, I think that having sqlite deal
with backwards comparability of your schema is easier than having to
manually do that? Also, sqlite is known to scale, is exactly one file
worth of dependency, what's not to love (other than having to support
upgrading to 'index vSqlite').

-- 
Cheers,

Sverre Rabbelier
