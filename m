From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Wed, 16 Oct 2013 14:31:19 -0500
Message-ID: <525ee9872ab50_3983c19e7c27@nysa.notmuch>
References: <1381561485-20252-1-git-send-email-felipe.contreras@gmail.com>
 <20131014205908.GA17089@shrek.podlesie.net>
 <525c63b6711fa_197a905e845b@nysa.notmuch>
 <20131015123505.GA3097@shrek.podlesie.net>
 <525d35e766ad4_55661275e7426@nysa.notmuch>
 <20131015133327.GA22723@shrek.podlesie.net>
 <525d4354a5436_5844e73e843d@nysa.notmuch>
 <20131015145139.GA3977@shrek.podlesie.net>
 <CAEBDL5V8wfbQTZ5do-UMRpSsxRN8bFaHVnG7kRNfP0t+oYbfNg@mail.gmail.com>
 <525e0e1b28c87_81a151de743f@nysa.notmuch>
 <20131016070900.GC24964@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org
To: Krzysztof Mazur <krzysiek@podlesie.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 21:38:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWWvU-0007vF-A4
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 21:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761220Ab3JPTic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 15:38:32 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:60874 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761138Ab3JPTic (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 15:38:32 -0400
Received: by mail-ob0-f178.google.com with SMTP id uz6so1034798obc.37
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 12:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=qKMTmSV84IbKeyHyUoKv/OHz6LFQHJpzXr01D3PeuQI=;
        b=R2rzEAdpqRPpWdRkuL5XEcnGjw4A7CygpXV7IuSaSUiLZqeMUTItAnJywwZYvwQjwL
         XnCShYsqR9O+eWOH4R+0DhwlSM9v1fQNyQHrJdnrmDV5QekfAx/aqgFbOzlGZnlZTymr
         jApP7ZHegxx8XE0y6k2bYbdkqZAZkEJn9XNJ6Lx7lJ6tiE9hZzkP71cvNkaOkiURBhof
         ldkdBCZOgTMeuPAg77MKd25n2nlaUSz6MdeYBuEqLWLR6Y33DO/B2lLfF1Qe2yLRP1zQ
         t9+gzvhFmETAb+gGUGtYuVb8/y1v77rD/cJIBZqyVswVN8QV3eE3GABfc3Wce7DoTm9g
         bwbw==
X-Received: by 10.182.55.38 with SMTP id o6mr6940928obp.26.1381952311628;
        Wed, 16 Oct 2013 12:38:31 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z5sm65365983obg.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Oct 2013 12:38:30 -0700 (PDT)
In-Reply-To: <20131016070900.GC24964@shrek.podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236255>

Krzysztof Mazur wrote:
> On Tue, Oct 15, 2013 at 10:55:07PM -0500, Felipe Contreras wrote:
> > John Szakmeister wrote:
> > > 
> > > I like the idea that we could kick git into a mode that applies the
> > > behaviors we're talking about having in 2.0, but I'm concerned about
> > > one aspect of it.  Not having these behaviors until 2.0 hits means
> > > we're free to renege on our decisions in favor of something better, or
> > > to pull out a bad idea.  But once we insert this knob, I don't know
> > > that we have the same ability.  Once people realize it's there and
> > > start using it, it gets harder to back out.  I guess we could maintain
> > > the stance that "the features are not concrete yet," or something like
> > > that, but I think people would still get upset if something changes
> > > out from under them.
> > 
> > We cannot change the behavior of push.default = simple already, so at least
> > that option is not in question.
> 
> If we add core.addremove=true the same applies to it - we cannot remove
> it later, the only we can do is to disable it by default in future
> versions after testing (core.addremove=true or core.mode=next).

That is true, but adding core.addremove = true would probably imply there's the
option of adding core.addremove = false.

> > > So, at the end of the day, I'm just not sure it's worthwhile to have.
> > 
> > This is exactly what happened on 1.6; nobody really tested the 'git foo'
> > behavior, so we just switched from one version to the next. If you are not
> > familiar with the outcome; it wasn't good.
> 
> BTW, I'm still using pre-1.6 git-foo, I have /usr/libexec/git-core
> in my PATH. So I would like to always have an option to disable some
> new incompatible "improvements".

That's what core.addremove = false would do, wouldn't it?

> > So I say we shouldn't just provide warnings, but also have an option to allow
> > users (probably a minority) to start testing this.
> > 
> 
> and an option to keep the old behavior, like we did with push.default.

Ditto.

-- 
Felipe Contreras
