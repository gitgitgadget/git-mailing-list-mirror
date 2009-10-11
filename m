From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.6.5
Date: Sun, 11 Oct 2009 11:47:19 -0700
Message-ID: <7vfx9pydhk.fsf@alter.siamese.dyndns.org>
References: <7v8wfi1fya.fsf@alter.siamese.dyndns.org>
 <f488382f0910110930u1af92299ld5d72dbb31ed1914@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Noonan <steven@uplinklabs.net>
X-From: git-owner@vger.kernel.org Sun Oct 11 20:49:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx3Th-0007eK-0x
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 20:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbZJKSsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 14:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbZJKSsJ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 14:48:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61547 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbZJKSsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 14:48:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E50E05515E;
	Sun, 11 Oct 2009 14:47:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Htc+VCTp7gXitJyfonM3kp3DIFQ=; b=Zmv3H3
	U1M4ZyriBdRNRJ0chIgVqUUkFRPllwgDg3W1gBo54oKSMrkjwJNkfeszgBcP+ZNh
	IC9HIEUIWHkWzOIhxRo5pUv8ckyfQ6E0AlPjXJNskt+ZY4i2bQi3y/lNJdrNniNA
	DR82gXd5KeOmeVXRGrCA+dQ7Sanvq2zSB7FOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s/Gtv9uvKl9vzCp8YMqjgIBamflWrEfo
	28TlVOEvysndZTraOl97980H0thUIDOGo9ZQqdU0AoEagvNA/nv/EcCp9EHmxDT/
	6Gm/JYVq9SVwgbqwQ0q1lUU6EOY5sXOwERlC1Pby1HmyThPgmBi5xovfazNkYRya
	CzEEU9zC1kI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C788A5515D;
	Sun, 11 Oct 2009 14:47:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38AE95515C; Sun, 11 Oct
 2009 14:47:21 -0400 (EDT)
In-Reply-To: <f488382f0910110930u1af92299ld5d72dbb31ed1914@mail.gmail.com>
 (Steven Noonan's message of "Sun\, 11 Oct 2009 09\:30\:13 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 83A8854E-B696-11DE-AEE8-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129941>

Steven Noonan <steven@uplinklabs.net> writes:

> Uh-oh.
>
> Alcarin:crisscross steven$ git remote update
> Updating origin
> fatal: 'git@github.com/tycho/crisscross.git' does not appear to be a
> git repository
> fatal: The remote end hung up unexpectedly
> error: Could not fetch origin

Try user@site:path/to/repo.git with a colon.  As you mentioned already,
you could also use ssh://user@site/full/path/to/repo.git

> The 'ssh://' part is omitted in numerous places on github.com. I
> realize github.com isn't the final authority on the syntax of the URI,

What do you mean by "final authority"?

Your misconfigured URL is diagnosed by the local client on your end and I
do not think it has anything to do with github.  Do you mean github.com
documentation primarily uses scp syntax (i.e. [user@]site:path/to/repo)
instead of the fake URI syntax (i.e. ssh://user@site/full/path/to/repo),
*but* misspells the former without colon (i.e. [user@]site/path/to/repo)?

If that is the case, it is something github folks need to fix, but I doubt
they have such a breakage.

> but was this an intentional change or a regression?

I do not think older clients ever allowed your colon-less scp syntax.  Do
you really see any *change*?  IOW, not the difference between the ssh://
syntax and a misspelled scp syntax, but a difference between versions of
git working and not working with a misspelled scp syntax?

Which version of git worked with "git@github.com/tycho/crisscross.git" for
you?
