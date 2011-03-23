From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Relative ls-files
Date: Wed, 23 Mar 2011 08:20:36 -0700
Message-ID: <7v39mdhni3.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=fP+jBpLuxst2rv02pYRmj4HOkv8Yenc-dR-N_@mail.gmail.com>
 <4D89D052.5030801@drmicha.warpmail.net>
 <AANLkTimc7gNKbh3C2hyMtFK6D1OWNALD+GvzmhG5cZrn@mail.gmail.com>
 <AANLkTimdLGgGXGRNVH5+X-cnhK2NWfWx9k0apt-6rr1Z@mail.gmail.com>
 <4D89DCBE.3060400@drmicha.warpmail.net>
 <AANLkTi=BrgZe47Bt5evr_qFzKBL=MY-6NmH22gsRurVV@mail.gmail.com>
 <7v7hbqgc7g.fsf@alter.siamese.dyndns.org>
 <AANLkTi=OJ_o2WQ2W6d30HXQZrg7=W70+fZWrbQPrAs=s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	demerphq <demerphq@gmail.com>, John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 16:21:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Pry-0004k6-7I
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 16:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933000Ab1CWPVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 11:21:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932963Ab1CWPVB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 11:21:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 520613568;
	Wed, 23 Mar 2011 11:22:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zqaHBC5vkPuReYQ0ThZhtUkEHSA=; b=FI9C4l
	UxLSNGsJt+gFZHtv7U/BkZZPyhKXRt1Nd5y9fOL3icZRVF3SJZ/e9qhEXhV9a5/u
	24uXBkH4kIGC14bWE7NqWY3AFWxcXcvaY5t+LreuJaiLMqbfAqv+S3KOwiB++IN2
	G/V+D4eRHAv4EDjR1JDROWuOLoo+oJXNwhjH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q2I3BBFFIQNF0P+lahd6tB3HcS1Nepee
	CFOwK7vGc53Nm9J2AxmPU6X1R14Dwj612PTubwyJktAI2GnOgk7nalSooItP2Y98
	R8dLqHMheFMe3nzm84oTLZnNxeCTWcUAnS8o6T6pkmHu9i2iNzD9AG2x+m3cUrCK
	HTPhwS7FeBM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E4D6E3567;
	Wed, 23 Mar 2011 11:22:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7C85C3562; Wed, 23 Mar 2011
 11:22:19 -0400 (EDT)
In-Reply-To: <AANLkTi=OJ_o2WQ2W6d30HXQZrg7=W70+fZWrbQPrAs=s@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Wed, 23 Mar 2011 21:14:08 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5F306BB2-5561-11E0-8805-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169840>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> (off topic?)
>
> "ls-tree -r" does not understand wildcards. Maybe it should not, but I
> think read_tree_recursive() should use tree_entry_interesting(). The
> function it uses for matching, match_tree_entry, looks like another
> variant of t_e_interesting.

I thought that you already did that within the scope of your earlier
topic.

"ls-tree" is quite a low-level plumbing, and until we absolutely know that
all the old scripts people wrote relying on its original behaviour are
extinct, we shouldn't touch it without a reasonable breakage protection.

It is Ok to give it a command line option to make it in line with other
pathspec users, namely, that causes the command to missing pathspec should
automatically mean the whole tree and to honor globs.  No existing script
would be using that option, so that is a safe thing to do.
