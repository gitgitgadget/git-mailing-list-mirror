From: Michael G Schwern <schwern@pobox.com>
Subject: Re: Extract Git classes from git-svn (1/10)
Date: Tue, 24 Jul 2012 22:37:18 -0700
Message-ID: <500F860E.5010909@pobox.com>
References: <5004B772.3090806@pobox.com> <20120717174446.GA14244@burratino>
 <5005F139.8050205@pobox.com> <20120717233125.GF25325@burratino>
 <7vy5mhwrdl.fsf@alter.siamese.dyndns.org> <500F23E4.9090306@pobox.com>
 <20120725025507.GB13236@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	robbat2@gentoo.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jul 25 07:37:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StuIE-000221-Lo
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 07:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485Ab2GYFhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 01:37:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54502 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab2GYFhU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 01:37:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C4C14A54;
	Wed, 25 Jul 2012 01:37:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=Lf+7Lxp38D9i
	KajCicNvQLHzOng=; b=Xge+P7S0osRIgKbrB4MW0F+kCtD1J5n1ZAu0kj16mgZj
	bgZuArgDsdTm4ylPNreTmu76T9G2JmJzBmQRlSrhmrSI31IT7MLzAn0R13c3APf1
	u6yKh7u2Ddt4kFg/UdcS3RK6Pg6tgk2gdQWZ4ODvL8ypiBo1Rvv/Z/G335pQpxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=J7sOEK
	46jvlQzD6IAp3LcOGQKONJdhrNL/pglmzZ6i0AOcZE0dkVacC+zg/f4pulBXtRED
	K4OiusDEwiho3NJNxwfaSi5IltZQR/5xHgyt2C4rCAutFyf/qhEvaaLhk9lFMVpK
	7Nt3YpCce7RoW5KINSNwLcT+dxufkJbTPDzAM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18A6E4A53;
	Wed, 25 Jul 2012 01:37:20 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0327D4A52; Wed, 25 Jul
 2012 01:37:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120725025507.GB13236@dcvr.yhbt.net>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: CD0F8BE6-D61A-11E1-A27C-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202122>

On 2012.7.24 7:55 PM, Eric Wong wrote:
>> After I'm exhausted from volunteering all the coding work, rather than
>> submitting a URL to a remote repository I find I have to learn new specialized
>> tools.  It's extra learning and work, an extra step to screw up, and foreign
>> to me (even as a experienced git user).  It is of little benefit to me as a
>> casual volunteer submitter.
> 
> Except git is also a "new specialized tool".  Your examples are exactly
> why I'm saddened many projects only adopted git, but not the workflow
> which _built_ git (and Linux).

There is an important difference between a tool which is useful for one or two
projects and one which is useful for a broad spectrum of projects.  I learn
git once (or diff or bash or Perl or whatever) and I'm going to use it again
and again all over the place.  I learn git-send-email and (if I'm not a kernel
developer) I'm going to use it on a handful of projects maybe.  It's O(1) vs
O(n) effort.

Github also has broad spectrum utility.  I learn how to fork and work with a
Github pull request once, and I can repeat that on thousands of different
projects of all different sorts of things.

This commonality of tools and techniques is very important to easing the on
ramp for new (to-your-project) developers.


>> I can see if you've been on the git mailing list for a while and have git-am
>> and all that set up, this system is great.  But it comes at a cost which is
>> offloaded onto new and casual contributors.
> 
> Email is integral to Free/Open Source development and remains one of the
> few things on the Internet not (yet) controlled by any central entity.
> Once setup, the same email setup can work across all projects which use
> email.  These projects need not be hosted on the same websites/servers
> at all.

While I hear your concern about being centrally controlled, it is largely
irrelevant to the new user experience.  And remaining independent does not
mean you can't use web tools.  Be wary of a false dichotomy between Free and web.

"We use a mailing list" is by no means an indication of commonality.  Every
project of the "send patches to the list" form has their own quirks and ways
of doing it.  Usually they're not written down.  This is what I've been
struggling with.  I've been sending patches to mailing lists for decades and I
can tell you everybody does it differently.  "Send a patch to the list" is one
of the steeper project on-ramps.


>> This sort of specialized setup makes people bounce right off the submission
>> process.  At OSCON I was asking around for help getting things setup so I
>> could submit patches here properly.  As soon as they said "which mail daemon
>> are you running?", I said "stop!  I don't want to know any more".  I have too
>> many things to do to be fiddling with my mailer configuration just to submit
>> volunteer work in the right form (that said, I'm pleased as punch that
>> git-send-email now has instructions for sending via GMail).  You're
>> volunteers, too.  We're all volunteers, so a more balanced submission process
>> would be nice.
> 
> How about we educate users about a proper email setup instead?  If
> they're capable of learning git, they're surely capable of setting up an
> email client properly, and perhaps more projects can adopt an
> email-centric workflow.

SubmittingPatches would be helped by that, particularly with a clear
step-by-step example of using git-send-email and all its numerous command line
switches.

I was showing Jonathan the guide I have for releasing Perl modules which is
both A) step-by-step and also B) covers the numerous little problems that are
usually only in somebody's head or scattered around the docs.  It was built in
order to allow a person who had never released a module to release a module.
Then we watched just such a person follow the directions.  As they asked
questions, struggled or made mistakes we filled in the gaps in the docs.
https://github.com/scrottie/autobox-Core/wiki/How-To-Make-A-Release

But this is also not about capability.  Yes, people are capable of figuring
out git-send-email, but its Yet Another Special Thing to learn before they can
submit a patch and call their work done.  Volunteers, especially brand new
ones, have only so much volunteerism to burn before they'll walk away.  You
want them burning that on productive patching and contributions, not learning
specialty tools.

And, finally, the last thing most people want is more email.  Seriously.  It
sounds like you live in your mailer, but fewer and fewer people do that.  Me?
 I don't want to join another mailing list.  My email management is a disaster!

What it comes down to is this: is it enough to contribute to git.git to know
how to work on git.git?  Or do you also need to live in your mailer?  Bolt on
that extra requirement and you lose a large swath of contributors.


>> But since you brought Github up... (I get the impression its kind of a dirty
>> word around here)
> 
> (Not speaking for the git project)   I'm entirely against the way GitHub
> (or Ohloh or similar services) gamifies software development and tries
> to tie a person to all their other projects.
> 
> Much of my code is public, but I am a private person.  I want code to be
> judged solely on its own merits of that code; not from what the author's
> achieved or how "popular" the person might be in the development world.
> Unfortunately, GitHub (and other social networks) is structured to
> encourage that sort of thing (which I know is appealing to many).

FWIW this aspect of Github is just a toy.  For some people it acts as a
carrot, but nobody worth caring about takes it seriously.  I wouldn't get too
worked up about it.


> For me, the whole social network followers/timeline thing also has a
> _huge_ creepiness factor to it.  How one prioritizes and spends time
> between different different (especially unrelated) projects should be
> nobody else's business.
> 
> I don't make it /easy/ for someone (e.g. Junio) to know I'm slacking
> off on my git work to hack on ProjectNoOneUses :)
> 
> One could try using a different account for every project, but that's
> also violating the terms of service.

You want to know what's creepy?  That you'd think people work like that.

It doesn't work out that way.  People have far better things to do than stalk
your Github commits to see how you're spending your time.  You're just not
that interesting.  Neither am I!

(If I really wanted to I could just compile your activity from public list
archives and repositories, so you're really not broadcasting any less
information about yourself by staying off Github.  But I wouldn't want to,
because you're just not that interesting and I have better things to do with
my time!)

Besides, Facebook is where all the stalking is at! ;)


>> If all the clicking and opening tabs in a browser feels uncomfortable to
>> you... its something you learn like anything else.  Less and less people are
>> comfortable in mail clients.  Who is the system optimized for?  It doesn't
>> have to be a zero sum game.
> 
> (Still not speaking for others)  I believe GUIs are (mostly) harmful.

You can hate GUIs, but you should also realize that just about everyone out
there likes them, and they're not all morons.  If you deny GUIs as a tool for
git.git developers because of your blind spot, then you're losing potential
contributors.  More and more as time goes on.

Recognize it as a personal blind spot, don't punish your users because of it.

Me?  I hate IDEs.  Won't touch em.  Do I really think emacs or vim are
superior and all those IDE users are deluded?  HELL NO!  I think I'm ignorant
and don't understand IDEs.  I really don't know anything about them.  I don't
even know what I don't know.  I generally keep my mouth shut and listen rather
than blab a bunch of old guy ignorance.


> Graphical browsers don't interact well with command-line tools.
> Browsers have no concept of a working directory; I can't fire up a
> browser tab/window for each project I work on and edit/apply patches
> directly from the browser like I can with an MUA.

I'm not sure what you're talking about, or what sort of workflow you've got
going with your mailer, but I'm sure with just as much time and effort as
you've put into your CLI and MUA setup you can be just as efficient or moreso
GUI.  One can do crazy shit in browsers these days either in Javascript or by
writing or using an add-on.  But also, one doesn't have to do EVERYTHING with
a single tool.  Amazing But True!

You should consider sitting down with somebody who works very differently from
how you do and see how they do it.  You might learn something you don't know
you don't know!

And again, it *does not have to be zero sum*.  It doesn't have to be email VS
GUI.  You can have your cake and eat it too.


-- 
125. Two drink limit does not mean two kinds of drinks.
    -- The 213 Things Skippy Is No Longer Allowed To Do In The U.S. Army
           http://skippyslist.com/list/
