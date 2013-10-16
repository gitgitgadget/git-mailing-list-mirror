From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Tue, 15 Oct 2013 23:03:26 -0500
Message-ID: <525e100e45ee8_81a151de74ed@nysa.notmuch>
References: <1381561485-20252-1-git-send-email-felipe.contreras@gmail.com>
 <20131014205908.GA17089@shrek.podlesie.net>
 <525c63b6711fa_197a905e845b@nysa.notmuch>
 <20131015123505.GA3097@shrek.podlesie.net>
 <525d35e766ad4_55661275e7426@nysa.notmuch>
 <20131015133327.GA22723@shrek.podlesie.net>
 <525d4354a5436_5844e73e843d@nysa.notmuch>
 <20131015145139.GA3977@shrek.podlesie.net>
 <525d8ebd19c67_5feab61e8037@nysa.notmuch>
 <20131015220125.GA14021@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Krzysztof Mazur <krzysiek@podlesie.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 06:15:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWIVh-0002lL-9T
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 06:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397Ab3JPEO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 00:14:57 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:61191 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab3JPEO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 00:14:57 -0400
Received: by mail-ob0-f173.google.com with SMTP id vb8so154887obc.18
        for <git@vger.kernel.org>; Tue, 15 Oct 2013 21:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=quYZtckxbHMAm4z2Qw+AQ2H85ZFpQbngKI9iQ1jieYo=;
        b=hqlfsKKnADXZgwr/9eeyUd0GOej6n8Z2NgWE5AdQRamsBRCpak8Ot6KU6pxsFhdLaR
         q6EVLFKLL5FllTKu/5I04Ybm/c/qZpWrUSFZDF2hMB9zaVWKo/EtaZwEtPSghlWQ5vfH
         V6moJBtfUvpfO8hrFDs16BEXqKfVl6EwxwphupqthU5JXHlQhrqCTM1Q3R1IpSx7c/9g
         hL1Jb3wHfa6bSuLAd17VITAUk6yLt1xgW2Xl/XSNf6NpEFPXHfOg6XKba5WU6HvNdMvz
         guJnoJqQD/QeEhPi3Pk1Hv+KYK3UK5XSxIJDRyUM9qxWP4FJP9ZJHqcmW7CGOO0bNtcK
         3p0g==
X-Received: by 10.182.60.194 with SMTP id j2mr1199840obr.2.1381896895639;
        Tue, 15 Oct 2013 21:14:55 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id bq4sm57639578obb.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 21:14:54 -0700 (PDT)
In-Reply-To: <20131015220125.GA14021@shrek.podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236232>

Krzysztof Mazur wrote:
> On Tue, Oct 15, 2013 at 01:51:41PM -0500, Felipe Contreras wrote:
> > 
> > I don't see what is the problem. We haven't had the need for push.default =
> > simplewarning, have we? If you want the warning, you don't change anything, if
> 
> simplewarning makes no sense, because push.default=simple sets exact
> behavior,

Exactly.

> not some "next" behavior that may change in future.

But I'm suggesting to add a core.addremove option as well, like you suggested,
am I not?

That option wouldn't change in the future.

> > you want to specify something, you already know what you are doing.
> > 
> > > Maybe we should also add core.mode=next-warn that changes defaults like next
> > > but keeps warnings enabled until the user accepts that change by setting
> > > appropriate config option?
> > 
> > Maybe, but would you actually use that option?
> 
> No.

So you would be happy if we had core.addremove = true *and* core.mode = next,
right? You would use one, different people with different needs would use the
other.

> > > That's safer than next (at least for interactive use) and maybe more users
> > > would use that, but I don't think that's worth adding.
> > 
> > Maybe, but I don't think many users would use either mode, and that's good.
> > 
> > > For me, old behavior by default and warnings with information how to
> > > enable new incompatible features, is sufficient. So I don't need
> > > core.mode option, but as long it will be useful for other users I have
> > > nothing against it.
> > 
> > OK, but that seems to mean you don't need core.mode = next-warn either. I'm not
> > against adding such a mode, but I would like to hear about _somebody_ that
> > would like to actually use it. I don't like to program for ghosts.
> >
> 
> As I said earlier, I don't think that next-warn it's worth adding, but
> such option might increase the number of people interested in the
> core.mode.

Well that's a hypothesis, and I would be interested in finding out if that's
true, but until I see somebody that says "I want core.mode = next-war", I'm
going to assume they are hypothetical.

-- 
Felipe Contreras
