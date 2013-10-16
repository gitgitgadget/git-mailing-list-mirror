From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Tue, 15 Oct 2013 22:55:07 -0500
Message-ID: <525e0e1b28c87_81a151de743f@nysa.notmuch>
References: <1381561485-20252-1-git-send-email-felipe.contreras@gmail.com>
 <20131014205908.GA17089@shrek.podlesie.net>
 <525c63b6711fa_197a905e845b@nysa.notmuch>
 <20131015123505.GA3097@shrek.podlesie.net>
 <525d35e766ad4_55661275e7426@nysa.notmuch>
 <20131015133327.GA22723@shrek.podlesie.net>
 <525d4354a5436_5844e73e843d@nysa.notmuch>
 <20131015145139.GA3977@shrek.podlesie.net>
 <CAEBDL5V8wfbQTZ5do-UMRpSsxRN8bFaHVnG7kRNfP0t+oYbfNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>,
	Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Wed Oct 16 06:08:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWIPf-0008At-KH
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 06:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933545Ab3JPEIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 00:08:37 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:39729 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265Ab3JPEIg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 00:08:36 -0400
Received: by mail-oa0-f48.google.com with SMTP id m17so129319oag.21
        for <git@vger.kernel.org>; Tue, 15 Oct 2013 21:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=ZWIKK5uDhFuQ2lnrdAYyVnUqNvxi4ml/cpUd57hRt7A=;
        b=wDfTjXy+GnNX06Nd6Huq43PhQrK1gSu9xtR+PRbtoYE4mLq+sy/+3OmW3s+jlp7zsc
         J64cZQsXbmqrgzXhts1t+EoWul5ZRlcC1nmY//CB/1tboWmIeHAraom2EbLWQeeWvcfJ
         DXtVudes78s+llo4BQGpxx1HhCFzFK2+K54DTo1LEXQaoZZcm7W+Xg7iET7Z5fCm7jxi
         y70GI00rPhFyZz+asW8egcppLd9CwocYfrxemoWkuiBwzeVqZgFIItnjiugTjvTfoqRc
         mM6T4vsinZcE/yXEasmji8eCb6zAeaREWdWxLzw/6B9zb2mufdNSYrkjw9XluZSexqj+
         Zzjg==
X-Received: by 10.182.220.225 with SMTP id pz1mr43254obc.51.1381896515365;
        Tue, 15 Oct 2013 21:08:35 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r6sm57644190obi.14.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 21:08:33 -0700 (PDT)
In-Reply-To: <CAEBDL5V8wfbQTZ5do-UMRpSsxRN8bFaHVnG7kRNfP0t+oYbfNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236231>

John Szakmeister wrote:
> On Tue, Oct 15, 2013 at 10:51 AM, Krzysztof Mazur <krzysiek@podlesie.net> wrote:
> > On Tue, Oct 15, 2013 at 08:29:56AM -0500, Felipe Contreras wrote:
> >> Krzysztof Mazur wrote:
> >> > On Tue, Oct 15, 2013 at 07:32:39AM -0500, Felipe Contreras wrote:
> >> > > Krzysztof Mazur wrote:
> >> > > >
> >> > > > But with core.mode = next after upgrade you may experience incompatible
> >> > > > change without any warning.
> >> > >
> >> > > Yes, and that is actually what the user wants. I mean, why would the user set
> >> > > core.mode=next, if the user doesn't want to experencie incompatible changes? A
> >> > > user that sets this mode is expecting incompatible changes, and will be willing
> >> > > to test them, and report back if there's any problem with them.
> >> >
> >> > With your patch, because it's the only way to have 'git add' v2.0.
> >>
> >> Yeah, but that's not what I'm suggesting. I suggested to have *both* a
> >> fined-tunned way to have this behavior, say core.addremove = true, and a way to
> >> enable *all* v2.0 behaviors (core.mode = next).
> >
> > I'm just not sure if a lot of users would use core.mode=next, because
> > of possible different behavior without any warning. Maybe we should also
> > add core.mode=next-warn that changes defaults like next but keeps warnings
> > enabled until the user accepts that change by setting appropriate
> > config option? That's safer than next (at least for interactive use) and
> > maybe more users would use that, but I don't think that's worth adding.
> 
> I like the idea that we could kick git into a mode that applies the
> behaviors we're talking about having in 2.0, but I'm concerned about
> one aspect of it.  Not having these behaviors until 2.0 hits means
> we're free to renege on our decisions in favor of something better, or
> to pull out a bad idea.  But once we insert this knob, I don't know
> that we have the same ability.  Once people realize it's there and
> start using it, it gets harder to back out.  I guess we could maintain
> the stance that "the features are not concrete yet," or something like
> that, but I think people would still get upset if something changes
> out from under them.

We cannot change the behavior of push.default = simple already, so at least
that option is not in question.

Presumably you are worried about the other options that can't be enabled in any
way.

But think about this; you are worried that if we add an *option* to enable this
new behaviors, then we would be kind of forced to keep these behaviors. That
seems to imply that you are proposing the current default; we wait until 2.0
and not make it an *option*, but make it *default*.

I think waiting until 2.0 to make it a default without evern having an option,
and thus nobody actuallly testing this, is way worst than what I'm proposing;
to add an option to start testing.

> So, at the end of the day, I'm just not sure it's worthwhile to have.

This is exactly what happened on 1.6; nobody really tested the 'git foo'
behavior, so we just switched from one version to the next. If you are not
familiar with the outcome; it wasn't good.

So I say we shouldn't just provide warnings, but also have an option to allow
users (probably a minority) to start testing this.

-- 
Felipe Contreras
