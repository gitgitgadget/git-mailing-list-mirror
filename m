From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] environment: add GIT_PREFIX to local_repo_env
Date: Fri, 08 Mar 2013 15:03:28 -0800
Message-ID: <7vmwudfq9r.fsf@alter.siamese.dyndns.org>
References: <20130308092824.GA9127@sigill.intra.peff.net>
 <20130308093025.GB1923@sigill.intra.peff.net>
 <CAPig+cRUCnWJLeuXL=LLk7kUkwPnHqaL_KGcSdq3yO+YZ345tQ@mail.gmail.com>
 <20130308214404.GA9723@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>,
	Mark Lodato <lodatom@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 09 00:04:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE6KV-0005jD-Ej
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 00:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933553Ab3CHXDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 18:03:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33079 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757654Ab3CHXDb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 18:03:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F56CB21C;
	Fri,  8 Mar 2013 18:03:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a2h2Xd9BsgNwr0UnDnbKaCpNEIg=; b=TWVl8b
	NiHUFBwAlMQOOdznElcr0DsoLOfRv23xVpjDfpUpIAvesOnFqo9gl5JIRiPhJ8Fl
	iVuPtEiL2Dd92M2Eq3IjjnZYy9FbUvPoi6+gMzEiXZNz+ACwBhxbeOtzvNRzwvN7
	UmMn9XaN5RFGf+JEAb27VToulYzRmbQbTYUpM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HvMOZza4FwiqY01fHjdJZryK60KpUjEI
	dSgm0D0OEno6qQEkmvS9mheBZXiRMimJVifXwePdkHJbmokiTk04p5JGI469hTtu
	Nirstjb1mw85e7c8E7VTXR3GuWkO0tBamrLQwVs+6dqeWR0eXo8b6ZMYQGzqGv6A
	8aPmlIWINPw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 449F5B21B;
	Fri,  8 Mar 2013 18:03:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7493B21A; Fri,  8 Mar 2013
 18:03:29 -0500 (EST)
In-Reply-To: <20130308214404.GA9723@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 8 Mar 2013 16:44:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 645E7CC4-8844-11E2-8DE7-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217690>

Jeff King <peff@peff.net> writes:

> On Fri, Mar 08, 2013 at 04:39:02PM -0500, Eric Sunshine wrote:
>
>> On Fri, Mar 8, 2013 at 4:30 AM, Jeff King <peff@peff.net> wrote:
>> > The GIT_PREFIX variable is set based on our location within
>> > the working tree. It should therefore be cleared whenever
>> > GIT_WORK_TREE is cleared.
>> >
>> > In practice, this doesn't cause any bugs, because none of
>> > the sub-programs we invoke with local_repo_env cleared
>> > actually care about GIT_PREFIX. But this is the right thing
>> > to do, and future proofs us again that assumption changing.
>> 
>> s/again/against/
>
> Yep, thanks.

Thanks; squashed-in.
