From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to selectively recreate merge state?
Date: Fri, 11 Dec 2009 13:14:48 -0800
Message-ID: <7vtyvx1ad3.fsf@alter.siamese.dyndns.org>
References: <76718490912101556o3e2911e8t32b48c0b735fd98c@mail.gmail.com>
 <200912110233.18756.jnareb@gmail.com> <4B222289.6000004@drmicha.warpmail.net>
 <200912111220.40844.jnareb@gmail.com> <hfuakf$fnd$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Dec 11 22:15:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJCpL-0006gh-JD
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 22:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758952AbZLKVOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 16:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756127AbZLKVOv
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 16:14:51 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48365 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165AbZLKVOv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 16:14:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F6388725C;
	Fri, 11 Dec 2009 16:14:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ukipm2Ln4KtcVCq8VhFtXU+DecQ=; b=ER9ZeX
	OXUxcMrOkyfzZ5RsNIedgFe6F4bruKTH0NZK+PQ2+swqfVzF1RELxqhZQ2Y1QTtL
	YgxdDSJzILPBoyHaPqil+dE/enltGO2fP96v0vP4gCUvZSQavOXnUKiqY4p9QiBa
	4/5dyM6AWm8wkuwcSeh1NeI0gnjbu7HboG9g0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gsx1GFNDOjj0WlLaLZnm8ejBX6KaFOsc
	HhQLtsIud9CHh+LhfZUli3e4RqXyDBlzFTrpW7ZXBElWadROGuVZJtIRs/h2hq3m
	fsdYoXBbn+0Qpx6ubBYQsuNpAptdEP6T40xpYBzJZX5yODHlGL2lA8f8Lkw2MMfx
	1dDoW2iqX3A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 69A7A8725A;
	Fri, 11 Dec 2009 16:14:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A252687255; Fri, 11 Dec
 2009 16:14:50 -0500 (EST)
In-Reply-To: <hfuakf$fnd$1@ger.gmane.org> (Paolo Bonzini's message of "Fri\,
 11 Dec 2009 21\:38\:39 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3A39FDB4-E69A-11DE-A7B9-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135104>

Paolo Bonzini <bonzini@gnu.org> writes:

> On 12/11/2009 12:20 PM, Jakub Narebski wrote:
>>> >  2 and 3 are easy (cheap) to recreate from HEAD and MERGE_HEAD, 1 is not.
>>> >  I guess that's why --unresolve doesn't even attempt to do anything with 1.
>> But then "git update-index --unresolve<file>" is next to useless.
>
> Only "next to".  It can still be useful if you added a file before
> editing it, so you left in the conflict markers.

To be fair, these need to be judged within their context, and then get
updated to today's reality.

"diff --cc" was merely a relatively new curiosity that allows a different
view into a conflicted merge (it was still cooking in 'next').  The
primary ways to inspect a conflict were "diff --theirs" and "diff --ours";
repopulating stages #2 and #3 was sufficient for them.
