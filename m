From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 14:38:32 -0700
Message-ID: <7vwrif5q93.fsf@alter.siamese.dyndns.org>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
 <4DB80747.8080401@op5.se>
 <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
 <4DB82D90.6060200@op5.se> <7vbozr8uo8.fsf@alter.siamese.dyndns.org>
 <7vpqo77dlr.fsf@alter.siamese.dyndns.org>
 <1303930175.25134.38.camel@drew-northup.unet.maine.edu>
 <20110427194233.GA16717@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 23:38:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFCRe-0003Ga-2Q
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 23:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756767Ab1D0Vio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 17:38:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59902 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171Ab1D0Vin (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 17:38:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C95DB49F4;
	Wed, 27 Apr 2011 17:40:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mlMc5NeKbOqlNxHzYwvMYNkpgf0=; b=MtFKvm
	MRJ0+s8CpX2DqsQpGT1wdlfm2TnFC+cjY6z3Ye2PF7xP94pkqbd3DYui3hNpRCQi
	OEnu65CpsyPA/4bC2AE01dz46CpZgrjpFGkapUDVqTUDxILxwMS8BF9NtAbh9LO1
	xYucCVhzMq0Mh7b45BH3Fqz4pXia8F19T2BLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vYfHy7U+p7LQO88UCyeZFttM91+M8nI/
	O+l/8BpKs1qKgf0HgotRXoRUiqOoEAugZlYN4B/i95WWEKCXsuznyqGgJwOR+Ih3
	pufMUDdhF3U3VrM1KgaUzHBVsLuK1SLU7n1HrMOr7RHeHswWo0dT6UJG0xta7Teo
	IKQ3Hx+yWN4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A4D1749F3;
	Wed, 27 Apr 2011 17:40:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AFFCC49F2; Wed, 27 Apr 2011
 17:40:37 -0400 (EDT)
In-Reply-To: <20110427194233.GA16717@gnu.kitenet.net> (Joey Hess's message of
 "Wed, 27 Apr 2011 15:42:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF331170-7116-11E0-9CA2-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172278>

Joey Hess <joey@kitenet.net> writes:

> Tools like autoconf etc already know how to install man pages into the
> right places. I don't see the need for any additional support for git
> here.

But the original point by Andreas was that third-party tools like "git
work" should be able to just say "make install", and of course the distro
people can take it from there, but the thing is, distro people can take it
from a very low starting point.  Unless "make install" does not figuire
out how the user's git is configured and installed, it won't be very
useful for end users who do say "make install" for whatever reason,
instead of installing it from their distro.

For example, on my primary development box, I do not have any git
installed from distribution, but I do have git on my $PATH.  For such
users, "make install" should be able to find out that the right place to
install git-work.1 is in $HOME/some/where/man/man1 directory.
