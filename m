From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default: current vs upstream
Date: Mon, 02 Apr 2012 11:40:04 -0700
Message-ID: <7vobraf057.fsf@alter.siamese.dyndns.org>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
 <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vty15ltuo.fsf@alter.siamese.dyndns.org> <vpqty12h995.fsf@bauges.imag.fr>
 <7vlimegjw9.fsf@alter.siamese.dyndns.org> <vpqy5qejbjl.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 02 20:40:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEmAr-0002GV-1N
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 20:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684Ab2DBSkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 14:40:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46288 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753173Ab2DBSkI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 14:40:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A09B7546;
	Mon,  2 Apr 2012 14:40:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+ivr22himJcQFDm8x+oHrxniCz4=; b=RbQ2sl
	N4PBlMJ8OZnlBTw70Vi5OxxdxJBGD9AEI4Z2M62T+SCVwjkDGAwk/B7e+r+BJZAc
	8bT03w5uHe+MjA50BozsQyQ3WFXwbi6MKMpRH7tWO9IFdsV3d11KPdDt4nGnXS96
	x7YCap7MX0JsMounuGKqbEcICPRlOsMqIFJLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u2HBcEcj6NvRgeogNp4Jz7tof9N6/Joi
	G1Re1f2MSerLaFXucDqufhItMCSFIfMbWAhThi2QOj/GUUc0MPNas7PAYQNAUdt5
	znTGxDDScZ09UlhbXiGzDFBb3Y7FGL43XQoqB52QXS8bLHzLPfon2MqTmYGMBh4A
	VPDwMnrmiow=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30FA07545;
	Mon,  2 Apr 2012 14:40:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82F58753F; Mon,  2 Apr 2012
 14:40:05 -0400 (EDT)
In-Reply-To: <vpqy5qejbjl.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 02 Apr 2012 19:20:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 43E00286-7CF3-11E1-945D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194548>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Before saying "again", perhaps we should read and think about what the
>> other side said.  I think [*1*] raises a good point.
>
>> *1* http://thread.gmane.org/gmane.comp.version-control.git/194175/focus=194470
>
> I think this message precisely supports my claim: we focus the
> discussion on "git push", without thinking on the big picture "git pull"
> AND "git push". The message you point to does not talk at all about "git
> pull".

I do not think so; that "name" argument is about this part from Peff's
message, to which it is a response:

>> > my two concerns is that this:
>> >
>> >   $ git clone ...
>> >   $ git checkout -b topic origin/master
>> >   $ hack hack hack
>> >   $ git push
>> >
>> > will try to implicitly fast-forward merge your commits onto master.
>> 
>> And the reason why it is surprising to the beginners is?  Because "topic"
>> and "master" (of "origin/master") are not the same name?
>
> Sort of. It is more because "upstream" is an overloaded concept. Perhaps
> you created the branch from origin/master because you wanted to say
> "this is where my topic is based, and when I 'rebase -i' later, I want
> it to be considered the baseline". Or perhaps you meant to say "I am
> going to work on origin's master branch, but I would prefer to call it
> 'topic' here".

If you re-read it, it should be clear that this is _also_ about "git pull";
"I am going to work on origin's master branch" is about pushing the result
back there.

In the former case, you may want to push it to 'topic' to work further
with your collaborators.  In the latter case, you would want to push it
back to 'master', even though you are calling it locally 'topic' for some
sick reason (read: because you can).
