From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] read-tree: at least one tree-ish argument is
 required
Date: Fri, 18 Dec 2009 11:49:57 -0800
Message-ID: <7veimsvz8a.fsf@alter.siamese.dyndns.org>
References: <4B274BDE.8000504@viscovery.net> <4B2B5085.1050906@viscovery.net>
 <7v4onoywws.fsf@alter.siamese.dyndns.org>
 <200912182004.25520.j.sixt@viscovery.net>
 <7voclwxemf.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0912181137t1265f86cs9e02019da136a0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 20:50:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLiq8-0001z7-TK
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 20:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbZLRTuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 14:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbZLRTuJ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 14:50:09 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58672 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbZLRTuH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 14:50:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 516D18919C;
	Fri, 18 Dec 2009 14:50:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HaZm+ii1vVCAVGVCWNYLHQFDB/c=; b=oL3wDl
	levrgY+kY4UaxeOwr+fUn8qzy/Jo2Ti0MJhakk/Ei26/A5LZFVg6yOuz8KDDFDwf
	eZRzv7Aj51FNEPyVeNVYn393OWiaSH7EB+rwcu6vYcR9havfeBuSEWTEHG+CzP6S
	FyIxGWhlv5PTQdTScrjL0spCkTGzsjhm8AUlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F27H+NBoRlhd2FSbuPbEiaoQ97WVMeFu
	3lOQZJSAwV2G5NNo1r+cx/uRrtPomZkBwmqRUCs0+qvRVkSnwzjeoP9V7UyU5sD9
	wDWqZJD3M+gCt1dwaCh+0n54sTsrahcxHD7qqPj+TnN2iKo/Ahv/HwSkgSeb8z8H
	5BeYYV4g6B8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1778F8919B;
	Fri, 18 Dec 2009 14:50:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E3D589199; Fri, 18 Dec
 2009 14:49:59 -0500 (EST)
In-Reply-To: <fabb9a1e0912181137t1265f86cs9e02019da136a0a@mail.gmail.com>
 (Sverre Rabbelier's message of "Fri\, 18 Dec 2009 13\:37\:03 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8872ADEA-EC0E-11DE-ABD9-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135433>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Fri, Dec 18, 2009 at 13:32, Junio C Hamano <gitster@pobox.com> wrote:
>> Sure, it will empty the index, so it is dangerous in the same sense that
>> "reset --hard" is dangerous because it will wipe all your local changes,
>> or "rm -rf it" will remove everything underneath it.
>
> With the difference that both 'reset --hard' and 'rm -rf' need a flag
> to do their destructive work? Although 'git reset' might be just as
> destructive if you've been using 'git add -p' a lot or something,
> mhh...

I'll grant you that at least "rm -rf it" names "it" that will be wiped
very explicitly.  But just like the index and the work tree plus the index
are the implicit targets to "reset" and "reset --hard" respectively, the
index is the implicit target to "read-tree".

So it may be "dangerous" in the sense that "it would change things and if
you meant to do something else the end result would be different from what
you wanted to do".  In that sense, "log", "cat-file" and friends may be
danger-free commands and all others would be dangerous.  You might type
"commit" when you meant to say "commit -a" and record an incomplete state;
it is "dangerous" in that sense.

These are part of their feature.
