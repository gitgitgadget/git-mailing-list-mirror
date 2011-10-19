From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: What should "git fetch origin +next" should do?
Date: Wed, 19 Oct 2011 09:45:34 -0400
Message-ID: <4E9ED47E.5050408@xiplink.com>
References: <7v7h45s8rh.fsf@alter.siamese.dyndns.org> <20111017171041.GA12837@sigill.intra.peff.net> <7vipnnmppx.fsf@alter.siamese.dyndns.org> <4E9CA5E2.2020701@xiplink.com> <7v8vohfvqs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 15:45:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGWSk-0007Hn-QN
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 15:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756254Ab1JSNpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 09:45:38 -0400
Received: from smtp152.iad.emailsrvr.com ([207.97.245.152]:42100 "EHLO
	smtp152.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667Ab1JSNpi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 09:45:38 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp25.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 5B61A30089B;
	Wed, 19 Oct 2011 09:45:37 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp25.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 1B895300894;
	Wed, 19 Oct 2011 09:45:37 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <7v8vohfvqs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183929>

On 11-10-19 12:31 AM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> In all cases if the command-line refspec has no RHS then git should try to
>> figure out which local ref to update from the config, and it should die if it
>> can't figure out a local ref to create or update.  (As I said above, maybe
>> allow "git fetch origin foo:" to let the user put the tip of origin's foo ref
>> into FETCH_HEAD.)
> 
> I'd agree with everything you said in your message, except for the above
> "it should die" part.
> 
> You are assuming that the user knows what his configured refspecs would
> normally do and that is the whole reason why "git fetch origin next" that
> would update the remote tracking branch specified for the upstream's next
> might feel more natural than the current behaviour. I too think that is a
> reasonable assumption.
> 
> With the same assumption, if you said "git fetch origin frotz" when you
> know you are not usually tracking the remote 'frotz' branch, the command
> just should store what is fetched in FETCH_HEAD (and nowhere else) without
> dying. I do not think how it helps the user to die in that situation.

Sounds reasonable to me.

In all cases, I'd expect fetch to tell me what it did.

>> All this gets a bit more complicated if the user has currently checked out
>> the a ref that should be updated (regardless of the presence of a LHS +).
> 
> That "do not update the currently checked out branch" already exists and
> is correctly handled by "git fetch", I think.

Sweet!

(I'd also be happy if fetch updated the ref, and left the checked-out HEAD
detached, with attendant messages.  But then I'm quite comfortable working
with detached HEADs.)

		M.
