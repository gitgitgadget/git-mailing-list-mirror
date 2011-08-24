From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] get_indexed_object can return NULL if nothing is in that
 slot; check for it
Date: Wed, 24 Aug 2011 14:10:11 -0700
Message-ID: <7vpqjuo6rw.fsf@alter.siamese.dyndns.org>
References: <20110824054717.GA16512@localhost>
 <7vmxeypudw.fsf@alter.siamese.dyndns.org> <20110824204021.GA28157@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Harring <ferringb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 23:10:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwKiN-0004o3-Ss
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 23:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818Ab1HXVKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 17:10:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54965 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752116Ab1HXVKP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 17:10:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E48A94800;
	Wed, 24 Aug 2011 17:10:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k1jDjEuKmcXfRKWfC6i48v+EwMY=; b=Su3dTS
	vD7LYQbmV7GXakT40NFKQe3o0TVDsEaLbjcppQPLSWCBC55MXqrdphJnCmoaV6wV
	/3GkhqPDyVdi+zP6NJ3l1DfpKnMxVLocTazzEt/8pgvTwHW/V7E5cs6NAxoqJHUN
	EMlFSlKpuet53NHMZrMzD6nC3PFhpnCLY2O5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wDeihmwEGDwq99BlMeXCCZMdi0/8FljA
	n1FKAAWkDGShoPBmQ1NXSXK48RksnKcmN7auEXgQmXmZ4miQxYXS4leQQ6+tcFHn
	zFSzcTWtMqhTzygDHIFnDM8aAMb6EFPA9cogWcRSajv6gVRtBYmG8URpu9kpTj1u
	gq49GeESUZA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D46D747FF;
	Wed, 24 Aug 2011 17:10:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6694447FE; Wed, 24 Aug 2011
 17:10:13 -0400 (EDT)
In-Reply-To: <20110824204021.GA28157@beast> (Brian Harring's message of "Wed,
 24 Aug 2011 13:40:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7549715C-CE95-11E0-8C73-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180040>

Brian Harring <ferringb@gmail.com> writes:

> On Wed, Aug 24, 2011 at 10:54:51AM -0700, Junio C Hamano wrote:
>> Thanks for a fix.
>> 
>> It is both interesting and disturbing to see that these small mistakes are
>> discovered a week after the topics hit 'master', even though it has been
>> cooking in 'next' for a week before that happened (in the case of this
>> topic, it also hit 'maint' yesterday).
>
> I'll admit I'm slightly surprised it slipped past for initial 
> development- that said, you have to explicitly trigger the race to 
> trigger the segfault.  And that's not easy w/out building out a 
> custom setup- even w/ that setup, you need to go digging in server 
> logs to realize the previous serverside failure just converted to a 
> segfault.  Clientside, it hung just the same.
>
> Bit nonobvious.  Plus, shit happens. ;)
>
> Either way, I was poking at the source trying to figure out how to get 
> some unittests for an end to end testing of the http/smartserv; that 
> said I was having a helluva time finding a way to do it without 
> bundling a stub of a webserver.  Suggestions would be welcome on that 
> one.

I probably should have made it clear that I was not complaining, and if it
sounded as if I was complaining at _you_, my deepest apologies.

In any case, thanks, and congratulations for your first commit in git.git
;-)
