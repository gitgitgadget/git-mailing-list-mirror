From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 0/2] bash completion: Support "divergence from
 upstream" messages in __git_ps1
Date: Fri, 18 Jun 2010 09:10:59 -0700
Message-ID: <7vljacxqwc.fsf@alter.siamese.dyndns.org>
References: <20100612000002.GA30196@neumann>
 <cover.1276336602.git.trast@student.ethz.ch>
 <4C13F32B.7060106@pileofstuff.org> <201006140942.43099.trast@student.ethz.ch>
 <4C17F5B3.4070907@pileofstuff.org> <7v7hlyg5nh.fsf@alter.siamese.dyndns.org>
 <4C1A9442.7080304@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Fri Jun 18 18:11:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPeA3-0007UO-Jp
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 18:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760972Ab0FRQLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jun 2010 12:11:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758580Ab0FRQLM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 12:11:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 38D1CBD4B0;
	Fri, 18 Jun 2010 12:11:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V45dHTabY8bOxFdBlR2l0dWbkaU=; b=Eszv//
	RfomSxfFKYD7x9e8AS1+5hdVwYcqTrY17WFFnTbkMVDMW8xnFtCvpRbvqGrgKG81
	6rj4PPayu2LEtEfFaysOkvl0jY7uyguVNANCQYhB0cYvb6NWWrhhfUI5F7WKYVlU
	VkZecjTzY/o8iJVG1SFMfTJfEhgCGKM9xCzSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=stK6rQIULkeZ2PpQ2csBfoWFNpXQK4U5
	UzWF/bTyj4FovTl8/L5DxsGvezqDHX5tdBeJMK0qfwVY5nd9xDz5jDW5gzEuvWLj
	ZnbZUvpgp/5oN3oz2bGouhIGTBqI5919up+jo0iow8YMWberxX9DakO6RlFVcwfI
	Zdv8nNBGxKo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ECB54BD4AC;
	Fri, 18 Jun 2010 12:11:05 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFD83BD4A8; Fri, 18 Jun
 2010 12:11:00 -0400 (EDT)
In-Reply-To: <4C1A9442.7080304@pileofstuff.org> (Andrew Sayers's message of
 "Thu\, 17 Jun 2010 22\:31\:46 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 194BA6F4-7AF4-11DF-9A65-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149350>

Andrew Sayers <andrew-git@pileofstuff.org> writes:

>>> +#       You can
>>> +#       override the value of GIT_PS1_SHOWUPSTREAM on a per-repository
>>> +#       basis by setting the bash.showUpstream config variable.
>> 
>> That's totally backwards from it should be, isn't it?
>> 
>> Usually configuration variables are used to give you the default, and
>> you use environment variables to override them.
>
> I basically agree with Thomas here.

Ok.

> ...  If someone had e.g. imported their old
> SVN history into a git project, or did clever git tricks on a branch
> they regularly merged into SVN, they would want to override the default
> behaviour.  This is probably quite rare now I think about it, and I've
> rejigged the documentation a bit to reflect that.

Yeah, I see.

But doesn't all of the above suggest the decision should be per branch?
It is not too implausible to have a branch that is actively interacting
with SVN upstream and another branch whose upstream has migrated from SVN
and now managed by git.  Say you and your pal are working with a project
that is managed by SVN, and you use one of your branches to interact
directly with SVN upstream.  Your pal has a branch forked from the same
SVN upstream, and one of your other branches is building on top of her
work.  When you are on the former branch, you would want to know how your
work diverged from the SVN upstream; when you are on the latter branch,
you would want to know how your work diverged from your pal's git branch
that you are using as its upstream.  No?

Which led me to this expectation:

>>> +			svn-remote.*.url)
>>> +				svn_remote[ $((${#svn_remote[@]} + 1)) ]="$value"
>>> +				svn_url_pattern+="\\|$value"
>>> +				upstream=svn # default upstream is SVN if available
>>> +				;;
>> 
>> I expected that (1) when on a branch that is a fork of a svn upstream, you
>> would use the svn magic; (2) otherwise when on a branch that is a fork of
>> a git upstream, you would use "@{upstream}".  That way, the users do not
>> even have to say "git" or "svn" in GIT_PS1_SHOWUPSTREAM at all, no?

I wonder if looking for "git-svn-id:" in the past log is the best you can
do to see if a branch is forked from a remote that is managed by git-svn;
for one thing, that would not work for "noMetadata" setting.

>> If you "tr" to trash "\0" anyway, do you need to run "config -z"?
>
> The `tr` is there to work around issues like this:
>
> 	git config bash.showUpstream $'svn\nlegacy'
> 	git config bash.showUpstream | tr '\0\n' '\n '

Is that even an issue?  Why should there be a LF in the value?  I thought
you defined it as a string with space separated magic tokens...  Perhaps I
am missing something?
