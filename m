From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] Teach git var about GIT_EDITOR
Date: Fri, 30 Oct 2009 19:34:02 -0700
Message-ID: <7vws2cb8bp.fsf@alter.siamese.dyndns.org>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock> <20091031013934.GD5160@progeny.tock>
 <7vk4yccodl.fsf@alter.siamese.dyndns.org>
 <20091031022347.GA5569@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 03:34:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N43nT-0004ES-Qx
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 03:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757706AbZJaCeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 22:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757703AbZJaCeP
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 22:34:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33393 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757694AbZJaCeO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 22:34:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4D7308CFDC;
	Fri, 30 Oct 2009 22:34:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k6jF3yKp2Lz5AGMKK8mr3lFIPxM=; b=pX5/LP
	sRjnPpQ5XGgPC5xqLZBFJfz2imvhodFQcv4R1xYkfD5Wk3R9IEUZMeZhJux0Oodr
	UBZGejBKmhXK7S0HWB2IXUOwoQiwC/V2wCvM3HY6xgjFzGRkccsrsfLpduFLbj2m
	8E2QC1Tp6iwUEghXVqPkVVzfK+M5OZWVuZjGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GVXq5Eedt7jVr2PpALkuSMiuZNeoq1X5
	cODtIFgJW5sfkFXL1Wg4cI8/Wt7RnBb0osmyV04I7StSW9NZemr+wUyVXQDkPGJi
	SAN9LoFufGOa61I+H+q9tcM/mLKeY3U/bh1+eBf6Ibl/8OFhYHYBoVjzVL0+YlDW
	Ig3D2AFMtdA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 090268CFD8;
	Fri, 30 Oct 2009 22:34:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E786A8CFD7; Fri, 30 Oct 2009
 22:34:03 -0400 (EDT)
In-Reply-To: <20091031022347.GA5569@progeny.tock> (Jonathan Nieder's message
 of "Fri\, 30 Oct 2009 21\:23\:47 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DF19EC90-C5C5-11DE-A970-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131827>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>>> 	core.logallrefupdates=true
>>>
>>> 	*** Please tell me who you are.
>>>
>>> 	Run
>>>
>>> 	  git config --global user.email "you@example.com"
>>> 	  git config --global user.name "Your Name"
>>>
>>> 	to set your account's default identity.
>>> 	Omit --global to set the identity only in this repository.
>>>
>>> 	GIT_COMMITTER_IDENT=user <user@domain> 1256952739 -0500
>>> 	GIT_AUTHOR_IDENT=user <user@domain> 1256952739 -0500
>>> 	warning: GIT_EDITOR: terminal is dumb, but EDITOR unset
>> 
>> Sorry, I cannot grok this example.  Is it supposed to be a transcript
>> of a user session?  What did the user type?
>
> Oh, sorry about that.  The user typed 'git var -l', and that is all
> output from that.  More realistic examples:
>
> $ # what scripts see
> $ git var -l 2>/dev/null
> gc.auto=0
> rerere.enabled
> merge.log
> merge.conflictstyle=diff3
> core.repositoryformatversion=0
> core.filemode=true
> core.bare=false
> core.logallrefupdates=true
> remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
> remote.origin.url=git://repo.or.cz/git
> branch.master.remote=origin
> branch.master.merge=refs/heads/master
> GIT_COMMITTER_IDENT=user <user@domain> 1256952739 -0500
> GIT_AUTHOR_IDENT=user <user@domain> 1256952739 -0500
> $
> $ # what scripts pass on to the user
> $ git var -l >/dev/null
>
> *** Please tell me who you are.
>
> Run
>
>   git config --global user.email "you@example.com"
>   git config --global user.name "Your Name"
>
> to set your account's default identity.
> Omit --global to set the identity only in this repository.
>
> warning: GIT_EDITOR: terminal is dumb, but EDITOR unset
> $ 

This is more readable.

But the user did not even ask for GIT_EDITOR.  Should it even mention
"unusable"?  or should it just say something like

	GIT_EDITOR=

without complaining?

For that matter, I also wonder if we can squelch the user.email one when
we are only listing the variables (I know it is not part of this topic,
but I can still wonder).

> Would a more friendly message be helpful here?  I am not sure how 'git
> var -l' gets used.  I never liked using it directly myself, mostly
> because the long list of configuration items can be overwhelming.

I think people run "git var -l", store the results in variables (think
Perl or Python script) and read from there, instead of making separate
invocations of "git var" for individual variables.
