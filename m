From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git alias and --help
Date: Fri, 28 Oct 2011 11:07:08 -0700
Message-ID: <7v62j9t2gj.fsf@alter.siamese.dyndns.org>
References: <j8clg9$ldh$1@dough.gmane.org>
 <7vfwiexe6m.fsf@alter.siamese.dyndns.org>
 <7v8vo6xd4u.fsf@alter.siamese.dyndns.org>
 <buoty6t9937.fsf@dhlpc061.dev.necel.com>
 <m362j95jv3.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>, Gelonida N <gelonida@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 20:07:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJqpu-0004v9-LE
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 20:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037Ab1J1SHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 14:07:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50076 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753679Ab1J1SHM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 14:07:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C8F144A7;
	Fri, 28 Oct 2011 14:07:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9fgXBmHWRgmXC4TuxVQk74a+Ru4=; b=egBkiV
	4oFvUtmSPDUzLjT1dsIWJ3OkQSCuReF4vyn/D7lAP1BJ6ixPJIcVDqphj+A3DwCv
	hBT/zXALGgDz8Ln+5F8kaZFRxVawZrMyIunDjXSCuuSAAy7G6DLi/94dOIlrPEWL
	wKoh4XcEYI+g+HXEIEiOnUO+QWU2D6NMI36Hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mYjCyT3yZieDInGZ5RRB+shp1UWNr/ME
	OPInoVcApCNV27CVdPCMjfzrz1Ai528GXQyore9GIJDAnPPH+p/V3zqzO6JIIMiy
	TIDJLqqsdyewQbiP6/hQYpFyzLhdKrGP8wyEQROhq9UjH57p4N5CdL+nijhxjLb5
	bewX5R7N6sM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03BF844A6;
	Fri, 28 Oct 2011 14:07:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F4A044A5; Fri, 28 Oct 2011
 14:07:10 -0400 (EDT)
In-Reply-To: <m362j95jv3.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Fri, 28 Oct 2011 06:26:04 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7BDE78A-018F-11E1-A59E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184420>

Jakub Narebski <jnareb@gmail.com> writes:

>> What I've often wished is that git's help system would output
>> something like:
>> 
>>    $ git help co
>>    `git co' is aliased to `checkout'
>> 
>>    Here's the help entry for `checkout':
>> 
>>    GIT-CHECKOUT(1)                   Git Manual                   GIT-CHECKOUT(1)
>
> Wouldn't it be more useful to say something like this:
>
>   $ git co --help
>   `git co' is aliased to `checkout'
>  
>   You can see help entry for `checkout' with "git checkout --help"
>
> Then help is only copy'n'paste away.  

Describe your algorithm to come up with the equivalent to the above
'checkout' in this example:

    $ git one --help
    `git one' is aliased to `!sh -c 'git show -s --pretty="format:%h (%s, %ai" "$@" | sed -e "s/ [012][0-9]:[0-5][0-9]:[0-5][0-9] [-+][0-9][0-9][0-9][0-9]$/)/"' -'

If we decide to punt on the '! <cmd>' form, i.e. "take the first token and
if it is a git command then do this special thing but otherwise don't make
things worse", then you could improve this example:

    $ git lgf --help
    'git lgf' is aliased to 'log --oneline --boundary --first-parent'

with "git log --help", but that is aiming too low for my taste.

If you are redesigning the help system, isn't it a shame that you are
discarding other tokens in the alias when giving help? Wouldn't it be
wonderful if you extracted the option descriptions for these three options
specified and showing only that, for example?

You would need to ensure that the manual pages for all commands share the
same structure to make that happen, which goes without saying.
