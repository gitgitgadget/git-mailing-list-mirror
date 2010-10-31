From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] Documentation: kicking the "reset --hard" habit
Date: Sat, 30 Oct 2010 20:53:51 -0700
Message-ID: <7vd3qr3tm8.fsf@alter.siamese.dyndns.org>
References: <20101029083516.GA26290@burratino>
 <vpqzktwv3yx.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	bebarino@gmail.com, srabbelier@gmail.com,
	Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Oct 31 04:59:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCP4a-0000tl-K5
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 04:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690Ab0JaDyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Oct 2010 23:54:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33044 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764Ab0JaDyL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 23:54:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BCE931137;
	Sat, 30 Oct 2010 23:54:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e4CFb69Ylx6KY3YIE2mEsIRO8cA=; b=nkXOtz
	hspgjggaDePUDek0ZR/fUQtDuNbovmi5VxuA9rgwY21+QhqctIX8GvRNIQVbEbWr
	lgtWnI6CoFdW+fI+dJPf6gaD3NicI2rMzhrwlEf/DsG3MDj9Z5ftSJr3B4qbPFPH
	lpOeF0bp34AyyWtDU5svZbaZyArENTRwZZ4cE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eUD2yDkLxjM3u/C3TiaBlWQcc479S5v1
	0KHDbf6HpDJA2Kbjunj6TTSJaK5H8fOG528L+CZzwrX223JZVLd+xfhRZPo1coSR
	6cbPAzJn9h+6K3Op3ORo8pARiaUHcGHWB7g/3gMI24YcSft6VbhwendHaaNq6F1k
	KBikuKCed4w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 295571123;
	Sat, 30 Oct 2010 23:54:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4E9A111D; Sat, 30 Oct
 2010 23:53:52 -0400 (EDT)
In-Reply-To: <vpqzktwv3yx.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sat\, 30 Oct 2010 03\:55\:50 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7F9DDA18-E4A2-11DF-9E3F-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160412>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Sadly, at least the user manual change suggested below is probably
>> not suitable, since reset --keep and --merge have not been around
>> since git 1.5.3 days.  Ideas for working around that and other
>> comments would be welcome.
>
> Do we really want to keep the user manual compatible with 1.5.3
> forever? It's nice to keep the user manual usable by slightly outdated
> Gits, but 1.5.3 starts being really old,...

1.5.6 is more than 2 years old (June 18th, 2008), 1.5.3 is more than 3
years old (September 2nd, 2007).  In git timescale, they are becoming
prehistoric.

Even though the knowledge of the conceptual structure and the philosophy
learned with old versions like 1.5.X series would still apply to today's
git, at the UI level facing the end users, there are vast differences
(some may call that improvements ;-) between them and today's git.

I am tempted to say we should 1.5.X series behind, and name one that is
still relatively old like 1.6.3 (May 2009) or 1.6.4 (July 2009) the oldest
vintage we currently recognise as a proper member of our family.

What is the oldest version of git that is shipped with _current_ distros,
by the way?
