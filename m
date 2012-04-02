From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default: current vs upstream
Date: Mon, 02 Apr 2012 09:48:06 -0700
Message-ID: <7vlimegjw9.fsf@alter.siamese.dyndns.org>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
 <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vty15ltuo.fsf@alter.siamese.dyndns.org> <vpqty12h995.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 02 18:48:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEkQS-0007wy-An
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 18:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571Ab2DBQsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 12:48:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62073 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751656Ab2DBQsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 12:48:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B3E757C2;
	Mon,  2 Apr 2012 12:48:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R3B9wVTeDHXR3GtPP4ZzSjw/v7o=; b=mxzV3k
	jGYiNC/7uegd48YqEM5oEj+YKiscQ0fs8mqMxhxp8SwFyNrFF50IidXRFdaHAwjv
	jfV5IkhZX6GSu+QwMF9Z/+FrdQkzALEkP7deNjWdxNIKqNx0FSPd+C2aUE3HcfCL
	AbQzTjQbttnWM6dTNLEoTqJwYJqHVNckLpf2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lqGIYQmGNE3qLaNvHYzwcuKcOHWx4xRu
	ksgC693ZPy/5YTluQ5RBlQidbmZ+ldKNGnAEHut6WucKtn/lvRYwO/zdIqKPvvMB
	4h/RMCg5bE/1t+tqgH4Upmbtt8hZ+EUzbD2tP9hEHB/4ZcB4PK+FUhpkVRx2PQOz
	kbbSwjkzLAE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8296C57C1;
	Mon,  2 Apr 2012 12:48:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E62CE57C0; Mon,  2 Apr 2012
 12:48:07 -0400 (EDT)
In-Reply-To: <vpqty12h995.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 02 Apr 2012 09:40:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9FE0AA50-7CE3-11E1-9333-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194533>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Obviously the
>> former is much simpler to explain and understand, as people do not have to
>> learn upstream tracking before doing their first "push".
>
> Again, this is simple only for people who never run "git pull" without
> argument.

If you are running "git pull" with what to pull and integrate, you know
system much better than those who only use the canned "git pull without
argument" settings, so customizing push.default should be easier for you
than the real beginners whom we try to avoid confusing with the built-in
default, no?

Before saying "again", perhaps we should read and think about what the
other side said.  I think [*1*] raises a good point.

> For the others, they already have to learn about the "upstream"
> semantics.

But the others have graduated from CVS/SVN mentality.  Also, "upstream"
needs to be carefully chosen; I suspect that it is not as trivial for the
beginners to wrap their mind around it as you seem to be implying.

After a "git clone", you may want to work on whatever you are doing on
your topic branch, and then share it with your collaborator and polish it
to be suitable for the master, you may want to do this:

    git checkout -b topic ; work work work
    git push origin topic

But if your work on topic is ready to be published for everybody, you may 
just do this:

    git checkout -b topic ; work work work
    git push origin master

The upstream of topic for the former case would be origin/topic while for
the latter case it would be origin/master.

I and you know that.  But is the rest of the user experience set up to
easily arrange this automatically?  With branch.autosetupmerge, I suspect
that the above can be generalized to:

	git push origin master:topic ;# create the shared starting point
	git checkout -b topic origin/topic ;# and fork it

        repeat the three steps below 0 or more times
          work work work
          git push ;# goes to @{u} that is origin/topic
          git pull ;# takes work by collaborators from @{u}

	git push origin HEAD:master ;# topic is fully cooked, ready for master

and everything *should* go smoothly when @{u} is set up correctly.  At
least, that was the plan for @{u} mechanism.

The last step that pushes "git push origin HEAD:master" *might* be simpler
to explain if it were done this way:

	git checkout master
        git pull ;# syncs to the origin/master
        git merge topic
        git push

Also see Peff's 194414 in the same thread.

[References]

*1* http://thread.gmane.org/gmane.comp.version-control.git/194175/focus=194470
