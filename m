From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] sound fixes for 3.6-rc6
Date: Thu, 13 Sep 2012 08:14:27 -0700
Message-ID: <7vhar29cq4.fsf@alter.siamese.dyndns.org>
References: <s5h392m1728.wl%tiwai@suse.de>
 <CA+55aFyo6do-dZiZMiwZkN1Ko+W58+4-zkbfJnpQR+ufw=+8ig@mail.gmail.com>
 <s5hzk4uyvsr.wl%tiwai@suse.de> <s5hvcfiyum4.wl%tiwai@suse.de>
 <20120913130344.GC4287@sigill.intra.peff.net> <s5hligeyrz8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Git Mailing List <git@vger.kernel.org>
To: Takashi Iwai <tiwai@suse.de>
X-From: linux-kernel-owner@vger.kernel.org Thu Sep 13 17:14:48 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1TCB7r-0001xY-SN
	for glk-linux-kernel-3@plane.gmane.org; Thu, 13 Sep 2012 17:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755043Ab2IMPOc (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 13 Sep 2012 11:14:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43180 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751773Ab2IMPOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Sep 2012 11:14:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE2168F73;
	Thu, 13 Sep 2012 11:14:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j4AMrYkUxW3AohwRp09SVe79Odw=; b=G+lP2s
	g/IxmzPcfZyQ66ZUICU/2oO4tTdpAon08FFE4bDUs+EbAUeesc/UBoixBjQ334Yv
	pGipzV5DBIf/t5KHR08y50Xek0ysvmfp/SEdziNJ0ABiXdTiPYgJFWWgMiv68ocG
	JAFv/AXM+zRADGXUQ6+wkxSTgG87yz25J2bzk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hb3b5mcBDyj59tUhibX9gPcAh2DMpE/2
	4hBt3HJzgAOBrSpfJIHW4vPow0VquYoPyA1ncDgMyGzjSSNknECYaVg4garac7Z3
	GymtOzKRhyfsnFW/mzVvakulAr+HHbKHNqT/FvCsXOMLljZ9/U7u+DGCMRNGwqW0
	Uv+h42P1RM4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB6248F72;
	Thu, 13 Sep 2012 11:14:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 451E58F6F; Thu, 13 Sep 2012
 11:14:29 -0400 (EDT)
In-Reply-To: <s5hligeyrz8.wl%tiwai@suse.de> (Takashi Iwai's message of "Thu,
 13 Sep 2012 15:25:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6A39F74-FDB5-11E1-BAE0-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205384>

Takashi Iwai <tiwai@suse.de> writes:

>> I can't reproduce here. What is your exact request-pull invocation?

This question was not answerd.  Did you ask request-pull to ask for
a branch to be pulled, or did you ask it to ask for the tag to be
pulled?

If the former, I would have say it is a pebcak.  Linus asked you to
ask a signed tag to be pulled, and you want to have the tag to be
pulled, but if you do not give "git request-pull" the tag but a
branch that the tag points at, the command does not have a good
reason to countermand your (apparent) wish that the branch is what
is to be pulled.

>> Is request-pull showing a warning like:
>> 
>>   warn: You locally have sound-3.6 but it does not (yet)
>>   warn: appear to be at git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>>   warn: Do you want to push it there, perhaps?
>
> Hm, it looks like the check is performed only for tag objects.
> In the example below, no warning appears:
>     % git tag mytest for-next
>     % git request-pull mytest~ git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git mytest
>
> With an annotated or a signed tag, git seems giving a warning like
> above, indeed.  So my test seemed wrong.  Sorry for the noise.

OK.
