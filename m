From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: Why doesn't git-apply remove empty file
Date: Thu, 14 Aug 2008 22:17:54 +0200
Message-ID: <38b2ab8a0808141317i158e13fel102cdb7e880d5d7@mail.gmail.com>
References: <38b2ab8a0808120917h10f15c81v4d1f04c0174dc994@mail.gmail.com>
	 <7vod3xpxq2.fsf@gitster.siamese.dyndns.org>
	 <38b2ab8a0808130048t506dbb7ah1d6fcd6bd4f3c90c@mail.gmail.com>
	 <48A357BA.8060003@lsrfire.ath.cx>
	 <alpine.LFD.1.10.0808131602200.3462@nehalem.linux-foundation.org>
	 <38b2ab8a0808141242k4bd6867dt8ef54f160713061f@mail.gmail.com>
	 <alpine.LFD.1.10.0808141246190.3324@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Ren=E9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 14 22:19:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTjHu-0000JH-TZ
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 22:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932AbYHNUR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 16:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752730AbYHNUR4
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 16:17:56 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:36206 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883AbYHNURz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 16:17:55 -0400
Received: by yx-out-2324.google.com with SMTP id 8so434395yxm.1
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 13:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kDQgkohjtKfddXS4o6oZnY4DZbuhpFmGMVlf4Q+Gyh4=;
        b=RsWoYMakQ+PqS9U3PZh/XwaniXh4ZvsESbznpMmN5mrAC2t49SIq1znNOzw4qe83gR
         IxMgBb5MWyLvT8yOaaOsNGydU5ChasrkXWr+ctUVzigk3pdJnh0L9UegvscNSsJ12kZl
         YGgSzX5E1XlwVPG/NLelyRIf78rLIAxUC2+sY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=WiX9jhMfMvQD1XJQ/4cmhceX4/RAVTcBHPmYfZbpoxVsEuQc7XoQComAhOO1OUSCY/
         P0o2jttjrfLIXPiGzXbXJ+Ueu35iaRU4gto1SUY3ki78Tu10Ykr4ldBS/GDl1NbwiITi
         uKdIRl1dVkDW931ts3NV8ms4zhCCfB+4tCbcQ=
Received: by 10.141.75.17 with SMTP id c17mr999697rvl.212.1218745074100;
        Thu, 14 Aug 2008 13:17:54 -0700 (PDT)
Received: by 10.140.170.16 with HTTP; Thu, 14 Aug 2008 13:17:54 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0808141246190.3324@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92394>

On Thu, Aug 14, 2008 at 9:57 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The thing is, "patch" is a total piece of utterly unbelievable SH*T.
>
> git-apply acts differently, yes, but it acts differently for a damn good
> reason. No, you cannot replace git-apply with that horrible crap that is
> GNU patch.
>
> Some of the reasons are purely trivial implementation issues:
>
>  - git-apply knows about the index, and knows about updating it properly,
>   including tracking new files automatically.
>
> That's an important thing, but yeah, it's an implementation issue.
>
> The other things that git-apply do right are much more fundamental:
>

agreed with all of them...

> So no. There's no way in hell that git am should use GNU patch.
>

Just for clarification, I'm not saying to replace git-apply by patch in git-am !

But in few situations it might be better to use GNU patch for git-am.
So we could have such option:

              $ git am --applier="/usr/bin/patch" ...

thanks
-- 
Francis
