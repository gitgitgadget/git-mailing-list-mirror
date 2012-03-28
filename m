From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git add -p and unresolved conflicts
Date: Wed, 28 Mar 2012 08:10:08 -0700
Message-ID: <7vbongyd67.fsf@alter.siamese.dyndns.org>
References: <CABPQNSYVXMxS3kugu1j=62ArJ_1saYYfMjJdZvqhjgPFGN=Eqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 28 17:10:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCuW7-0006cH-4j
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 17:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758418Ab2C1PKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 11:10:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55037 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758185Ab2C1PKM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 11:10:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6523759E0;
	Wed, 28 Mar 2012 11:10:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=smMNI+iOxV7a746tkNkhO8+zThU=; b=PiHyOf
	VRr22U6O32TchV+iMO/5SG0zqE+z7M6vDLGyrF8gEGMCjbXietASHvu8GhDol7nL
	hNYjmdftJzrEq8dkpJgCHKjp2vsvdItWVknqdQDD5r+0Smu+kNe50Jr6DQi7lrsS
	pBi6PMmm7w/e51g5HxHf9R5jmKqFARXRKRLow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t6KDWPiCsN1xLgGflaDzGry33LnWK6yC
	0AbSUSrU75O2GJuPnyu1OQ7KwiQncipjl9AJwStvbtD0EShACcjbwxRA8tyJWMZv
	jhtF5g/IAktPVC9w/N7A6/F7jUtdHRNI0gQjHsgKySHo/k8+guOakcf4iDOu/9b6
	9AV+CvvmLpw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CC6959DF;
	Wed, 28 Mar 2012 11:10:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED34E59DE; Wed, 28 Mar 2012
 11:10:09 -0400 (EDT)
In-Reply-To: <CABPQNSYVXMxS3kugu1j=62ArJ_1saYYfMjJdZvqhjgPFGN=Eqw@mail.gmail.com> (Erik
 Faye-Lund's message of "Wed, 28 Mar 2012 11:51:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C447A4A-78E8-11E1-9EB9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194127>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> I'm running git version 1.7.9.msysgit.0.390.g01fca.dirty, and I've
> noticed a puzzling behavior with "git add -p" on a conflicted file: it
> seems to simply spew the diff and exit the process.

Yeah, when I wrote the 'p'atch mode in "add--interactive", I wasn't
interested at all in letting it be used on a conflicted path, so that is
not a designed-in behaviour but merely whatever it happens to do.  So at
least it should not allow the user to pick a path that has conflicts in
it.

What the behaviour for people who *do* want to use the patch mode for
conflicted paths should be is a separate matter.  As I said, I am not
interested in it, so I wouldn't be the best person to design it.

I mildly suspect nobody would come up with a sane behaviour, but what
would I know...
