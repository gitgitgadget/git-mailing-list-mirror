From: Michael G Schwern <schwern@pobox.com>
Subject: Re: Extract Git classes from git-svn (1/10)
Date: Tue, 24 Jul 2012 15:38:28 -0700
Message-ID: <500F23E4.9090306@pobox.com>
References: <5004B772.3090806@pobox.com> <20120717174446.GA14244@burratino>
 <5005F139.8050205@pobox.com> <20120717233125.GF25325@burratino>
 <7vy5mhwrdl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	robbat2@gentoo.org, Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 00:38:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StnkU-0007Qi-4l
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 00:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755509Ab2GXWic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 18:38:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54360 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755269Ab2GXWib (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 18:38:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD2538E9D;
	Tue, 24 Jul 2012 18:38:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=0qvshcJWjYI8
	TLKnreVRL+4XW9Q=; b=OOF+eA4v2Sm5lirEv0nBY/YGRoyDS8l573A/W63esVJm
	VzWqOD9QtUZUfJYp5fc3rbRJqG9TIdYtjbOxHJc/zZgUzlisOLntC7dyIwG/Dc8o
	iIopJ1swGCNBFndR6HQYMfEVJaP/Zbyww75yVjC3j6bZiRZ1ndUYXbhUHuTFJBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bl5yuv
	wKiOuRbY/MHRYUeFHVS2m5lNYFU7Z7S6iCk2ZY6/55NKi+qkENFsAUD+01WUkySu
	LmsxyVlc8XQqwCfVb0183kZqAMRMJeyRNo9gh3P1wAGdy2OkLwgn8WAq5doAWc21
	v7NraU6kJqH8aQ57UBA3bIT69aDcX86Qq9oPM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA6FE8E9C;
	Tue, 24 Jul 2012 18:38:30 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56C108E9B; Tue, 24 Jul
 2012 18:38:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vy5mhwrdl.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 4AA018C2-D5E0-11E1-8777-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202079>

On 2012.7.17 10:49 PM, Junio C Hamano wrote:
> By allowing people to easily publish a completed work, and making it
> easier for them to let others peek at their work, Git hosting
> services like GitHub are wonderful.  But I am not conviced that
> quality code reviews like we do on the mailing list can be done with
> existing Web based interface to a satisfactory degree.

In this instance, I was just using Github for repository storage.  I was
hoping I could just submit a remote git repository and people would look at it
from there.  No Github required.

I understand this makes things very convenient for you to review patches, let
me convey my POV...

After I'm exhausted from volunteering all the coding work, rather than
submitting a URL to a remote repository I find I have to learn new specialized
tools.  It's extra learning and work, an extra step to screw up, and foreign
to me (even as a experienced git user).  It is of little benefit to me as a
casual volunteer submitter.

I can see if you've been on the git mailing list for a while and have git-am
and all that set up, this system is great.  But it comes at a cost which is
offloaded onto new and casual contributors.


> Patches with proposed commit log messages are sent via e-mail,
> people can review them and comment on them with quotes from the
> relevant part of the patch.  The review can even be made offline,
> yet at the end, the list archive is an easy one-stop location you
> need to go to see how the changes progressed, what the background
> thinking was, etc. for all the changes that matter.
> 
> Look at recent ones (randomly, $gmane/199492, $gmane/199497,
> $gmane/200750, $gmane/201477, $gmane/201434), and their re-rolls,
> and admire how well the process works.
>
> I've played with GitHub's in-line code comment interface, but
> honestly, it is cumbersome to use, for one thing, but more
> importantly, you have to click around various repositories of pull
> requestors, dig around to see in-line comments, and I do not see how
> we can keep a coherent "discussion" like we do on the mailing list.
> 
> There may be a hosting site with better code review features, but
> all the code review of Git happens on this mailing list, and that is
> not likely to change in the near future.

Everything you've said above is correct... but it creates a procedure
optimized for the convenience of the long time reviewers at the expense of new
and casual submissions.  I'm going to guess you live in email and have your
client setup to do fancy things to extract patches from your mailbox and the like.

This sort of specialized setup makes people bounce right off the submission
process.  At OSCON I was asking around for help getting things setup so I
could submit patches here properly.  As soon as they said "which mail daemon
are you running?", I said "stop!  I don't want to know any more".  I have too
many things to do to be fiddling with my mailer configuration just to submit
volunteer work in the right form (that said, I'm pleased as punch that
git-send-email now has instructions for sending via GMail).  You're
volunteers, too.  We're all volunteers, so a more balanced submission process
would be nice.

But since you brought Github up... (I get the impression its kind of a dirty
word around here)

As somebody who doesn't live in email anymore (once upon a time I did), I find
the Github Pull Request model to be an excellent... I'm not even going to use
the word "compromise" because I don't feel like either side has been
compromised... it's an excellent enhancement.  The commits and conversations
about the commits are all there on one page.  Looking at a commit is a click
away (I usually open them all in tabs at once, much faster).  You can comment
on them as a whole or inline.  Those comments appear BOTH in the commit AND in
the larger conversation on the pull request keeping it coherent, no clicking
around.  And it has email mirroring.  All that and its tracked and organized
in an issue tracker.

Here's an example that includes commits, discussion about the larger issue,
comments on commits, more commits based on those comments, and so on.  As you
can see, the conversation is complete and coherent.  It wasn't always this
way, but they're constantly improving.
https://github.com/schwern/test-more/pull/319

A concrete downside it is that it does not work offline.  I agree that's a
problem.  I don't think it's a veto.  There are various work arounds which are
less complicated than your typical git-to-email-to-git setup.  We can talk
about that you're interested.

I've gone all in on Github Pull Requests such that most of my projects don't
even have mailing lists (issues are used for discussion).  This avoids a split
community between Github and the mailing list.  And they have email mirroring,
so issue discussion can be done all in email (I prefer email for things that
involve push notification and replies).

Github has a nice API and it would be possible to create a Github Pull Request
<-> Mailing List gateway.  Perl 5 uses something like that for bug reports.
All bug reports submitted via web or email all go into a bug tracker.  All
discussion on the web is mirrored to a thread on the mailing list and vice
versa.  Web users are happy.  Mailing list users are happy.  Everything is
archived and organized in the tracker.

If you were interested in going down this road, I'd be interested in helping.
 Step one would be to have pull requests on Github posted to the mailing list.
 Link to the pull request, links to each individual commit.  Then those who
want to work on Github can do it.  Step two would be to have activity on the
pull request mirrored back to the list, still a SMOP.  Step three would be to
have replies on the list mirrored back into the Github discussion.  It could
even submit the pull request with git-send-email and mirror individual replies
to patches back as comments on individual Github commits.

If all the clicking and opening tabs in a browser feels uncomfortable to
you... its something you learn like anything else.  Less and less people are
comfortable in mail clients.  Who is the system optimized for?  It doesn't
have to be a zero sum game.

If you're interested, I'd be happy to help put something like this together if
it will break the "ease of review" vs "ease of submission" deadlock.


-- 
Don't try the paranormal until you know what's normal.
    -- "Lords and Ladies" by Terry Prachett
