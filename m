From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] t9700: fix test for perl older than 5.14
Date: Fri, 04 Mar 2016 13:21:08 +0100
Message-ID: <1457094068.2660.85.camel@kaarsemaker.net>
References: <CAP8UFD1z9H=SygaMVzpc__mXTbnFc2XiW0LZ+sfzdCPmrnXW6g@mail.gmail.com>
	 <20160304085649.GA29752@sigill.intra.peff.net>
	 <1457089104.2660.79.camel@kaarsemaker.net>
	 <20160304114321.GA569@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 04 13:21:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abojS-0005PJ-2H
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 13:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbcCDMVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 07:21:13 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34430 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbcCDMVM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 07:21:12 -0500
Received: by mail-wm0-f45.google.com with SMTP id p65so17987595wmp.1
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 04:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1mvNbEG9Amh5v11R6M3E+ZzYzav41ijCvBt0cJ8FAZ4=;
        b=nX3aWfkQnjmA9vG9nNB8uRiUPUHo3BGLaJWpku8ABdjGcgnCZ6BAFUemJ4h90sDJBn
         xNn+/nJPCP9rvXE5GjozdyDljZcRe8QjBJqgI0erVgdvKlZb6MpZgPylKva90baDDC8P
         6TlR3dzZUkf24FUvCXgwyKMtVqaPPexlHSxregg9joyubV7zQNu8TKX1bno8ysK2xAiy
         3dWm/aVgsjfbncb0wee6nlMchE7cFUjnyIINMIIAhtCbKg8hcJnYN+IIT2VS6RAyenT3
         qhpD7qSLaQJxAlN7NDEsBZuSStmdP3q+vuOqBtoPiP3tCuwiKrkJiA13/YngGasV8pbh
         vW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1mvNbEG9Amh5v11R6M3E+ZzYzav41ijCvBt0cJ8FAZ4=;
        b=Rsj3Qm1p92rmQHiKPvxzTglGKGFR2YuXWd6PxZ5P5+xGuJ5+lLrbLdaz/RlM2SkKqa
         IgqN1VsKeWzDiPIJhfIgLRVHNcjpBOpbPS3pfs7ud62fftV7wYWtWgE4qe4KFib2p9xy
         vVHiNR4Gj1x771h3lDBmXlNxBRYGwPR0ekJkjWeGxEQ+8OCsEafqMT8+sNjQkCpoknKi
         KzgyNmMvLuoxRG+a8Bmt1SBH9nZe4vTYUuvi+MNAIJmYDwCNy6Jf3Bni5GJUPAvICPeQ
         N1e8Cn7pIzP06bh4N41O2YSikMUyYpk1aYQOaj6VyRh8skZorh+f6LUmEdicZUzKa0D2
         JTFw==
X-Gm-Message-State: AD7BkJLIzp+wf+25xp9YxyVJmP1ddMZe8AK+bwaKvQtG8eQ0mdvNZcMl0FXec6oQaTgESg==
X-Received: by 10.28.138.149 with SMTP id m143mr5157893wmd.94.1457094070589;
        Fri, 04 Mar 2016 04:21:10 -0800 (PST)
Received: from seahawk.local (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id 82sm3070053wmd.4.2016.03.04.04.21.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Mar 2016 04:21:09 -0800 (PST)
In-Reply-To: <20160304114321.GA569@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288252>

On vr, 2016-03-04 at 06:43 -0500, Jeff King wrote:
> On Fri, Mar 04, 2016 at 11:58:24AM +0100, Dennis Kaarsemaker wrote:
> 
> > On vr, 2016-03-04 at 03:56 -0500, Jeff King wrote:
> > > ? Those are just guesses, but if we are tickling a bug in perl's parser,
> > > this might avoid them. I also wondered when "/r" appeared. It was in
> > > 5.14, so you're presumably good there. The "use" statement at the top of
> > > the script says "5.008", so perhaps we should be writing it out longhand
> > > anyway (that version is "only" 5 years old, so I suspect there are still
> > > systems around with 5.12 or older).
> > 
> > Knowing the system Christian is testing on, I think the problem is that
> > the tests are actually being run against perl 5.10, which RHEL 6 ships
> > as system perl. As that's still a supported OS, writing tests in a form
> > compatible with it would be a good thing :)
> 
> That would make sense. `perl` in t9700-perl-git.sh (and all of our
> scripts) is actually a shell function:
> 
>   perl () {
>           command "$PERL_PATH" "$@"
>   }
> 
> to make sure we respect PERL_PATH everywhere. And that defaults in the
> Makefile to /usr/bin/perl. Christian presumably has 5.14 in his $PATH,
> but /usr/bin/perl is the system 5.10.

Yeah, that's how our systems are set up.

> One workaround would therefore be for him to tweak PERL_PATH, but
> obviously that does not help anyone else. I think we should do this:

Tested against 5.10 and 5.18 and works with both. I also tested the /r
variant with 5.18 and that works as expected.

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
