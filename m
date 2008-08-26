From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 13:39:30 -0700
Message-ID: <7vr68b8q9p.fsf@gitster.siamese.dyndns.org>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
 <1219664940.9583.42.camel@pmac.infradead.org>
 <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vy72kek6y.fsf@gitster.siamese.dyndns.org>
 <20080826145719.GB5046@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	users@kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 22:40:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY5LL-0001m8-SM
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 22:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbYHZUjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 16:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbYHZUjn
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 16:39:43 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34345 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbYHZUjm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 16:39:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6061169B9C;
	Tue, 26 Aug 2008 16:39:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 65DED69B99; Tue, 26 Aug 2008 16:39:32 -0400 (EDT)
In-Reply-To: <20080826145719.GB5046@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 26 Aug 2008 10:57:19 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1BCC6362-73AF-11DD-B27A-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93813>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 25, 2008 at 04:41:57PM -0700, Junio C Hamano wrote:
>
>> > Umm.  What exactly makes you feel you should ignore the discussions we had 
>> > around the issues on the git and msysgit mailing list?
>> 
>> Well, this was partly my fault, as I did not make it clear in this part
>> that beating the horse that has been dead for two years is not a
>> productive way to spend out time.  I however did, in the part David did
>> not quote, try to make it clear:
>> 
>>   That's all history now anyway.  We should try to do better the next time,
>>   which is much more important, and that is the topic of this message.
>
> I don't want to stir up this discussion too much; I am sure you have
> many more important things to be working on. But I did want to make one
> observation.
>
> One side of the argument, I see a lot of "I would prefer it this way."
> And on the other side I see a lot of "this discussion is already
> history" and "but I do not care personally that much."
>
> It makes me wonder why nobody has said "no, really, I prefer it without
> the programs in /bin." Are they simply confident that the decision has
> been made, and don't feel the need to say something?

To me, one of the two saddest part of this story is this.

I was among the "don't change anything, get used to it just like old
timers are already used to" camp, when people said that having many
commands in /usr/bin (or $HOME/bin) would scare people and pushed for this
change, around the end of 2005 through early 2006.  The pros-and-cons
wasn't clearly cut-and-dried.  Moving out of /usr/bin has slight technical
merits (e.g. "bash completion not showing 150+ commands but only selected
Porcelains", "not scaring people off", "dashless form is needed if you
want to use global options", and "moving away from dashed form will
eventually let us get rid of copies on systems without hardlinks even from
under /usr/libexec/git-core").  But I do not think the advantage was so
great.

When I hear something like what David Woodhouse said in this thread, I
should be feeling "People -- those of you who claimed to be the silent
majority -- see, I told you so!  This is a very bad move".

But I can't.  People who complain _now_ just annoy me even more.  Why
weren't you defending the backward compatibility with me, which you seem
to value it so much, perhaps even more than I did back then?  Why are you
wasting our time bringing it up again, instead of joining the discussion
when it _mattered_ back then?

And I still think there is no great reason to pick one way or the other.
Having everything in /usr/bin does not have any better reason than "it has
been that way from the beginning", and that certainly is not a reason
strong enough to revert this anymore, as the opposition now has "the
latest and greatest was shipped with the new layout" which is an equally
valid argument.

Another, even more sad part of this story is that the thread was confused
into talking about the change that has already happened, which is a total
offtopic, and wasted even more time from people.

Read the subject line again, and notice that we are not talking about
/usr/bin vs /usr/libexec/git-core; the request-for-discussion was about
removing "git-add" and friends from /usr/libexec/git-core/, so that we do
not have to even have these many hardlinks there.  Except for Linus (and
obviously myself who started the thread), I saw nobody expressed any
opinion on it.
