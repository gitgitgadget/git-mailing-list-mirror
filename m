From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Wed, 16 Oct 2013 06:54:31 -0400
Message-ID: <CAEBDL5We2wshgMZcTXoDziXskKvb9s2=2DEZtXRBgbTiitCOZQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Krzysztof Mazur <krzysiek@podlesie.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 12:54:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWOkR-0004Q8-I6
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 12:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934061Ab3JPKye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 06:54:34 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36009 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934058Ab3JPKyc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 06:54:32 -0400
Received: by mail-wi0-f178.google.com with SMTP id hn9so536201wib.5
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 03:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CPBptl4U3GB6nfT2yi50D7RJvpXnT+H3b+pJyVrepmQ=;
        b=L3B+vc26O/g8PUfd6l02SShBudJeS7Pt1L+rxMcgjFZ4+7EeENJil5wxrZZBTurPl/
         WDygeGZrsmMlFTMjRvsM6nV31bEsQzUo9LbbqQ14cf4FDAMDib23AIS5zId/id48aJNV
         xs8d6ab9bpMfSa4/1vLElfDqWNbGSdqP1IayruT4uVhBsenG7RiJow77951HOR12GAb3
         OgdH3VpkrbVEAtprE/8IZU28MyUgVQWZeyEN/BbPM9bAUs1jUoXbnDiCz/K9Cx2xf/V2
         e46AMzbEQ15kIpgRhoxY2LkoSwzHwctcUUkGgfJh9qAQYOav/XaQHj/pBuC4hGf5FMs4
         mrNw==
X-Received: by 10.180.20.46 with SMTP id k14mr1720795wie.39.1381920871090;
 Wed, 16 Oct 2013 03:54:31 -0700 (PDT)
Received: by 10.180.99.169 with HTTP; Wed, 16 Oct 2013 03:54:31 -0700 (PDT)
In-Reply-To: <525e0e1b28c87_81a151de743f@nysa.notmuch>
X-Google-Sender-Auth: YafsRNKNi4H1cCo91We_O0jy1uI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236243>

On Tue, Oct 15, 2013 at 11:55 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
[snip]
> We cannot change the behavior of push.default = simple already, so at least
> that option is not in question.

True.

> Presumably you are worried about the other options that can't be enabled in any
> way.

Yes.

> But think about this; you are worried that if we add an *option* to enable this
> new behaviors, then we would be kind of forced to keep these behaviors. That
> seems to imply that you are proposing the current default; we wait until 2.0
> and not make it an *option*, but make it *default*.
>
> I think waiting until 2.0 to make it a default without evern having an option,
> and thus nobody actuallly testing this, is way worst than what I'm proposing;
> to add an option to start testing.

My concern is that people don't treat it for what it is--a way to
experiment with the new behaviors--and then they get upset if we
discover that some behavior was not well thought out and it disappears
"unexpectedly" when we correct the matter.  We have a balance to
strike: annoying users and getting some miles on the new behaviors.  I
see the technical end of this--your proposal to have a
'core.mode'--but where is the non-technical end of this argument?
What message are we proposing to send to the users?  What's our
promise to them surrounding core.mode and the new behaviors it offers?
 Perhaps we don't have much today that this affects, but what about
tomorrow?  Are we saying that behaviors enabled by core.mode=next are
concrete (they're going in as-is, and we won't alter their behavior
before 2.0)?

As I said, the only real drawback is that I see this as the latter,
because any other choice means users will get annoyed when something
changes out from under them.

>> So, at the end of the day, I'm just not sure it's worthwhile to have.
>
> This is exactly what happened on 1.6; nobody really tested the 'git foo'
> behavior, so we just switched from one version to the next. If you are not
> familiar with the outcome; it wasn't good.

You're right, I wasn't around for that.  And on the whole, I
absolutely agree: it's nice to get miles on these new
behaviors/features/etc.  I just worry that having an option like this
means we've committed to it, and I'm not sure that we want to give up
the ability to change them without having to go through some sort of
deprecation cycle.  Or worse, we have to wait until 3.0 and 2.0 hasn't
even come out yet.

I hope others chime in here.  And don't mistake me as dissenting; I'm
not.  And, I'm not assenting either.  I just want to know if you've
thought about what this means to users, and what we're prepared to
deal with.  Right now, I feel like half the argument around the option
is missing.

> So I say we shouldn't just provide warnings, but also have an option to allow
> users (probably a minority) to start testing this.

"probably a minority" -- I guess that's the part I disagree with.  I'm
not sure what a minority means here, but I don't think it'll be a
handful of people.  How big does that number get before we get
concerned about backlash from users if we decide to change course?
Or, is that simply not an issue?  Why or why not?  I have to be
honest, if the option was available, I'd have my developers turn it
on.  I'm sure a great deal of others would do so too.

Is there some other way we can solve this?  Having an experimental
branch with all the 2.0 features merged and those concerned can just
build that version?  I see the downside of that too: it's not as easy
for people to try, and there is nothing preventing folks from posting
binaries with the new behaviors enabled.  It leads me to feeling that
we're stuck in some regard.  But maybe I'm being overly pessimistic
here, and it's really all a non-issue.  As I said earlier, it'd be
nice if others chimed in here.

-John
