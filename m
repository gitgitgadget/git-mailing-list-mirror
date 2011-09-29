From: Junio C Hamano <gitster@pobox.com>
Subject: Re: In favor of "git commit --no-parent"
Date: Thu, 29 Sep 2011 11:11:24 -0700
Message-ID: <7vmxdnte0j.fsf@alter.siamese.dyndns.org>
References: <1316960136073-6829212.post@n2.nabble.com>
 <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org>
 <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <vpq39fi9gf5.fsf@bauges.imag.fr>
 <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
 <vpqsjni6kkk.fsf@bauges.imag.fr>
 <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>
 <e4f46b39e9ed4203bfab8a81e25eb600-mfwitten@gmail.com>
 <7vaa9oz9rl.fsf@alter.siamese.dyndns.org>
 <271cc2ed03774b4988bb61cb3e79750e-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	<git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 29 20:11:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9L5B-0006xD-9I
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 20:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178Ab1I2SL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 14:11:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42417 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751165Ab1I2SL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 14:11:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04A074D4B;
	Thu, 29 Sep 2011 14:11:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GWRLjiCMAbVHnPYYerJCFxBigyQ=; b=efzEZt
	EXRVMbab/UfLr0Tsx6MxHq7khU0NOj9UjAl26bQme2AyymOFakgT7/iWqqgdpmWv
	BSCR1ZbFVP2AKzm5VfEmn/4THtBX/0dyVroc07xSMnTz8TXxoCbM0OrNDWEjEOAH
	tmJFBZ8kIjkVrEVSpykXbJknhjM7qOyD0TDc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EgJGzT65T3yn3gR5fSZ8kO3wHaqQHV4i
	eXYMQHzN6/LcyWn3hllv/+7ebRV34LGvXsDlG/7Xm/FdBTapyr3CP8zxaCZG+gTZ
	thgZcfrbRbxr8jojTmJocL/fCu/DkAg+PHU6PkBlCyqlg9UqAzNXj8r9q6FZYGAb
	Be5F/g83Eqs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF8F14D49;
	Thu, 29 Sep 2011 14:11:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74CFD4D48; Thu, 29 Sep 2011
 14:11:25 -0400 (EDT)
In-Reply-To: <271cc2ed03774b4988bb61cb3e79750e-mfwitten@gmail.com> (Michael
 Witten's message of "Thu, 29 Sep 2011 16:45:45 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71D3C7C8-EAC6-11E0-9606-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182418>

Michael Witten <mfwitten@gmail.com> writes:

> On Wed, 28 Sep 2011 13:34:22 -0700, Junio C Hamano wrote:
>
>> If you are bootstrapping a new open source project from the tip of a
>> proprietary tree, "checkout --orphan && edit to sanitize && commit" to
>> start your history afresh would be perfectly adequate for your PR people
>> to say "Now we are open".
>
> So, the two usages for a new root commit are:
>
>   * Separate History
>   * Hidden History

> As it turns out, the command:
>
>   git checkout --orphan
>
> which should be renamed:
>
>   git checkout --no-parent

I doubt that "should be" is anywhere near consensus.

> is best for the "Separate History" case,...

Step back a bit. There are two independent issues:

 - When does it make sense to originate two independent histories in a
   single repository that has a working tree?

 - What is the best tool to originate a new independent history in a
   single repository that has a working tree?

As I said number of times already, be it done with "checkout --orphan" or
"commit --no-parent", the "Separate History" use case is better done in a
separate repository. There is *no* advantage to originate the two separate
histories that do not share any resemblance of tree shape as branches in a
single repository with a working tree; "git checkout $branch" between the
two would actively work against you.

You are of course free to push from these separate repositories that have
disjoint roots of their own into a single distribution repository for
people to fetch from, if you want Separate Histories in a distribution
point.

That leaves "Hidden History" the only useful use case. IOW, the answer to
the first question above is not "Separate or Hidden History", but is
"Hidden History and nothing else".

And a half of the the answer to the second question is "checkout --orphan"
(and the other half would be "filter-branch"). "checkout --orphan" does
have major safety advantage than introducing "commit --no-parent", as Peff
pointed out earlier (to which I agreed).
