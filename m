From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Mon, 19 Mar 2012 14:43:03 -0700
Message-ID: <7v62e09sig.fsf@alter.siamese.dyndns.org>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
 <7vty1ndcoi.fsf@alter.siamese.dyndns.org> <4F6461D7.40303@pileofstuff.org>
 <7vipi1d9r7.fsf@alter.siamese.dyndns.org> <4F6792DE.80208@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 22:43:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9kMH-0002db-J5
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 22:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756287Ab2CSVnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 17:43:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56018 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756260Ab2CSVnG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 17:43:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC8BA6975;
	Mon, 19 Mar 2012 17:43:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=19Ggf1flVIy1U1y6yz4hXbtRYdY=; b=QRzPAh
	Fu1OyFXjp6k+EbKVVVoNVdT+Xg030Kgg80rf6I5TxQVQoDFq/G7Y74Uq5AkdTj8G
	Flnce8PQgOcam2o1KnYYGpbC3Ww3LyS1tSqHCfyBaN/LDJqwmtNoTUHDUurb/Dq5
	Jbae1ake8rAoleiEKfVE9BBlvLrMhI6HmrcmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v/45CPrU0hfeR2/fq+jJwCmrV2+PbtyP
	A3Gx2TmUW4Gp/Tu895UnlZruZfdbHVWKDJJHRSRO6No2dGp3BtJ7z03oWVZzCKfw
	WcMqTkzvyOPuBxe4zZmrUZ/9KeWYfIXJli7T3gZY15fXnBUYeyIe+mxGTK0m99o/
	ZvglWDtaq/w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C29566973;
	Mon, 19 Mar 2012 17:43:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 540DA6971; Mon, 19 Mar 2012
 17:43:05 -0400 (EDT)
In-Reply-To: <4F6792DE.80208@pileofstuff.org> (Andrew Sayers's message of
 "Mon, 19 Mar 2012 20:11:10 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82911570-720C-11E1-AC63-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193464>

Andrew Sayers <andrew-git@pileofstuff.org> writes:

> On 18/03/12 18:50, Junio C Hamano wrote:
>> 
>> ... but in short, it is not a problem we can solve
>> (nor we should be solving), as long as we have a reasonable migration plan
>> and if the user is locked out of that migration plan---whoever is doing
>> the locking-out is taking responsibility for these users who are out of
>> our reach.
>
> I take the point that distros have their own support infrastructure, so
> perhaps this would be a better example:
>
> Many administrators in corporate environments will install git from
> source, because they don't trust RPM/need some feature in the latest
> version/are just that way inclined.  Having installed it, they tend to
> sit on that version for a few years ...

The same response applies. These administrators are taking responsibility
for their users by making them out of our reach.

> ... a
> slightly better solution:
>
> When a user upgrades to a mid- or post-change version of git, I think
> it's a good idea for them to be warned about the change of behaviour.
> But new users, and old users with new repositories, gain nothing from
> the little history lesson.

You are right for new users, but are wrong for old users who aren't aware
of the switch-over, *and* are harmed by the switch-over.
