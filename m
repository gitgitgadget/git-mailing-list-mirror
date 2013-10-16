From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Wed, 16 Oct 2013 14:32:41 -0500
Message-ID: <525ee9d93c3af_3983c19e7caa@nysa.notmuch>
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
 <CAEBDL5We2wshgMZcTXoDziXskKvb9s2=2DEZtXRBgbTiitCOZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Krzysztof Mazur <krzysiek@podlesie.net>, git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 22:03:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWXJL-0003Qh-4k
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 22:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761226Ab3JPUDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 16:03:10 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:63811 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760844Ab3JPUDI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 16:03:08 -0400
Received: by mail-ob0-f177.google.com with SMTP id wm4so1048394obc.22
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 13:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Xg7lq5qkGnPbfoRFIWU9ad76LWrfzcXkDpZjda70QWM=;
        b=KNkhmvssdpImqqDvm/1OIts1W2CoPqodCMkdKB9/XGFxzli2sVN9cgYRypGDQKHnp6
         aTjQSn1bS8STp9JyxS5U9Rn1eE9QEWjq+JSL8bGKlBQdk8d1/w7/f4o7mdzJZBxIEiB8
         xJHSezuUBQmHjUaVHLhoIZvN6/NO4BW+7CWo7dLE5M51hyHkKXI7FQZLxVOflfBR7DmH
         kzK+QCUFH5MGtAfP9Gs8XLZVIjjkYldFGRPPZ00WSsT8q8h0yD9ccjsMuG6zI7DvFv8u
         I92mjosdtOp5nd2HSrkL4Jg9MoKPjIdMYiWViuFCVFjkBDJzCXNZK12Ifx9VT9UmMr+T
         YDcg==
X-Received: by 10.182.66.164 with SMTP id g4mr5656330obt.47.1381953788063;
        Wed, 16 Oct 2013 13:03:08 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hl3sm65556235obb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Oct 2013 13:03:07 -0700 (PDT)
In-Reply-To: <CAEBDL5We2wshgMZcTXoDziXskKvb9s2=2DEZtXRBgbTiitCOZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236258>

John Szakmeister wrote:
> On Tue, Oct 15, 2013 at 11:55 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> [snip]
> > We cannot change the behavior of push.default = simple already, so at least
> > that option is not in question.
> 
> True.
> 
> > Presumably you are worried about the other options that can't be enabled in any
> > way.
> 
> Yes.
> 
> > But think about this; you are worried that if we add an *option* to enable this
> > new behaviors, then we would be kind of forced to keep these behaviors. That
> > seems to imply that you are proposing the current default; we wait until 2.0
> > and not make it an *option*, but make it *default*.
> >
> > I think waiting until 2.0 to make it a default without evern having an option,
> > and thus nobody actuallly testing this, is way worst than what I'm proposing;
> > to add an option to start testing.
> 
> My concern is that people don't treat it for what it is--a way to
> experiment with the new behaviors--and then they get upset if we
> discover that some behavior was not well thought out and it disappears
> "unexpectedly" when we correct the matter.

Yes, but that's like removing the --force option in rm, because the user might
"unexpectedly" remove files (s)he didn't intend to. If the user uses rm
--force, the user must know what (s)he is doing, that's just the way it is.

Similarly, if a user does core.mode = next, the user is expecting to enable all
future behaviors, because that's what core.mode = next does, if he doesn't want
to do that, then why would he use that option?

Particularily because there's push.default, and there would be core.addremove,
and everything that core.mode = next does would be possible to do in other ways
that are not going to introduce new behavior as the version of Git advances.

> We have a balance to strike: annoying users and getting some miles on the new
> behaviors.  I see the technical end of this--your proposal to have a
> 'core.mode'--but where is the non-technical end of this argument?  What
> message are we proposing to send to the users?  What's our promise to them
> surrounding core.mode and the new behaviors it offers?  Perhaps we don't have
> much today that this affects, but what about tomorrow?  Are we saying that
> behaviors enabled by core.mode=next are concrete (they're going in as-is, and
> we won't alter their behavior before 2.0)?

I'd say we make it explicit that if you turn on core.mode = next, the behavior
you experience is going to change from version to version. In other words,
there is no backwards compatibility promise for the behaviors core.mode = next
enables. In a way it's kind of experimental, except that it's very likely the
new behavior won't be reverted back, just not 100% sure.

> As I said, the only real drawback is that I see this as the latter,
> because any other choice means users will get annoyed when something
> changes out from under them.

If the user doesn't want things to change dramatically, the user shouldn't use
core.mode = next.

> >> So, at the end of the day, I'm just not sure it's worthwhile to have.
> >
> > This is exactly what happened on 1.6; nobody really tested the 'git foo'
> > behavior, so we just switched from one version to the next. If you are not
> > familiar with the outcome; it wasn't good.
> 
> You're right, I wasn't around for that.  And on the whole, I
> absolutely agree: it's nice to get miles on these new
> behaviors/features/etc.  I just worry that having an option like this
> means we've committed to it,

It doesn't meant we are committed to it, because the behaviors in core.mode =
next have no promise to stay.

Either way, these behaviors have been announce in each Git release for several
releases, and we are already warning the users that things will change in v2.0.
I'd say that already means we've committed to it.

> and I'm not sure that we want to give up the ability to change them without
> having to go through some sort of deprecation cycle.  Or worse, we have to
> wait until 3.0 and 2.0 hasn't even come out yet.

I don't see why we would be giving up that ability.

> I hope others chime in here.  And don't mistake me as dissenting; I'm
> not.  And, I'm not assenting either.  I just want to know if you've
> thought about what this means to users, and what we're prepared to
> deal with.  Right now, I feel like half the argument around the option
> is missing.

Of course I've thought about that, otherwise I wouldn't have sent the patch.

But I have no hope of others chiming in.

> > So I say we shouldn't just provide warnings, but also have an option to allow
> > users (probably a minority) to start testing this.
> 
> "probably a minority" -- I guess that's the part I disagree with.

How many people do you think want to start testing v2.0 behaviors? How many
people do you think will enable core.mode = next? I'd say the people that test
release candidates are the minority, and I'd say the wants that would turn on
core.mode = next would be even less.

> I'm not sure what a minority means here, but I don't think it'll be a handful
> of people.  How big does that number get before we get concerned about
> backlash from users if we decide to change course?

I don't think it does matter, that's why I put the comment in parenthesis.

If 99% of users do 'rm --force' that doesn't make the --force option worst,
--force means --force, and that's that.

And core.mode = next doesn't include any promise of the new behaviors locked
in, and that's that. Even if 100% enable core.mode = next, it would still mean
no promise.

> Or, is that simply not an issue?  Why or why not?  I have to be honest, if
> the option was available, I'd have my developers turn it on.  I'm sure a
> great deal of others would do so too.

You are welcome to do that, but then you should be aware there's a possibility
that if you rely on a v2.0 behavior, it might change.

If you are not willing to accept that caveat, then core.mode = next is not for
you. It's that simple.

> Is there some other way we can solve this?  Having an experimental
> branch with all the 2.0 features merged and those concerned can just
> build that version?  I see the downside of that too: it's not as easy
> for people to try, and there is nothing preventing folks from posting
> binaries with the new behaviors enabled.

I actually think we should have both. A branch were incomplete or potentially
dangerous features are being worked on, but we have agreed they should be
merged eventually *and* a configuration option to turn v2.0 behavior.

The experimental branch would be clearly experimental, but that doesn't fullfil
the need of the v2.0 mode option, because the people that might to test this
could be end users that don't want to compile their own Git, they want to use
their distro's git-1.9, just enable that option, and see how things fare.

> It leads me to feeling that we're stuck in some regard.  But maybe I'm being
> overly pessimistic here, and it's really all a non-issue.  As I said earlier,
> it'd be nice if others chimed in here.

We are stuck, but not because we don't have options, but because these options
would never be realized. core.mode = next is one option, the experimental
branch is another option, and yet none of those are going to happen.

At the end of the day the collision course is set, and nobody would be testing
this stuff for v2.0 and the complaints will come in a similar way as they did
in v1.6, probably less because this time we have warnings, and probably way
less because the behaviors changes are very subtle, but exactly like in v1.6,
nobody will test this behavior until v2.0 is release (except me, apparently).

But this is not what really worries me, what worries me is that we don't have
enough changes for v2.0, we need more backwards incompatible change, and we
need to start testing it *now*, that way v2.0 will be better as it would
introduce more improvements, and the backwards incompatible changes would be
accepted by the users. Alas, that's not going to happen. Change and Git don't
go together.

Cheers.

-- 
Felipe Contreras
