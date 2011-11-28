From: Junio C Hamano <gitster@pobox.com>
Subject: Re: what are the chances of a 'pre-upload' hook?
Date: Sun, 27 Nov 2011 22:41:39 -0800
Message-ID: <7vzkfgvjdo.fsf@alter.siamese.dyndns.org>
References: <CAMK1S_jaEWV=F6iHKZw_6u5ncDW0bPosNx-03W9bOLOfEEEY1Q@mail.gmail.com>
 <CAMK1S_gh_CsWc-DnbOuUwn+H1i3skm99xzDbWe-wxsKKS0Qw-w@mail.gmail.com>
 <20111125144007.GA4047@sigill.intra.peff.net>
 <7v7h2my0ky.fsf@alter.siamese.dyndns.org>
 <20111126225519.GA29482@sigill.intra.peff.net>
 <7vr50uwk7x.fsf@alter.siamese.dyndns.org>
 <20111126233133.GA31129@sigill.intra.peff.net>
 <CAPc5daXY_4aimugj8Z4BFE8YvBSM1K+evPU69rLGH5ETo6PO=Q@mail.gmail.com>
 <20111126235135.GA7606@sigill.intra.peff.net>
 <CAPc5daUodry_=6pZxA=QOpuRUj9C2ed9Gzp6E1_G93iGfOOvOA@mail.gmail.com>
 <20111127000603.GA7687@sigill.intra.peff.net>
 <7v8vn2vt8p.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jbofsWyag3Sospz8wYHqD4Z1Fs0p+MJWi02eCq0e+uHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 28 07:41:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUuuS-00056m-4o
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 07:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275Ab1K1Gln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 01:41:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58869 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101Ab1K1Glm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 01:41:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C64F12F3C;
	Mon, 28 Nov 2011 01:41:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f+oYVFPzsHCMh557iWhfv6d2Ah0=; b=LPW1Or
	tzHpFDNZFM3eb8Zng4/4HlXDbXs/KMVO6gtuoKG2Q9m50e9/fL76eFVQK15sxf03
	p0DE2DVSRwHN2VN/eWmeiVi1P863mfUbrz6e2Px7RMzp0Khst2QjC1KNFoKVt+sW
	XsI+Bp7v0v//b4veMUZtpqk3mwtSXIXPlvzks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FYbZErq33Agut7iHekFiQXstunnigRmX
	8tFX41VtGKQHN9+AS056WO7/H40a4/9qO0x3REcWNIbCycZMXCgYeBH1X5m3c0TO
	kXeGXIiqEVwhWekPZpd5qzZjHLgtQY3PTehqIxYixicPbGCClRzhByN+9zx1nzk4
	YJ/ZBx5e+MU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE7052F3B;
	Mon, 28 Nov 2011 01:41:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 452392F2F; Mon, 28 Nov 2011
 01:41:41 -0500 (EST)
In-Reply-To: <CAMK1S_jbofsWyag3Sospz8wYHqD4Z1Fs0p+MJWi02eCq0e+uHQ@mail.gmail.com> (Sitaram
 Chamarty's message of "Sun, 27 Nov 2011 18:46:25 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 07B073A6-198C-11E1-BC42-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186000>

Sitaram Chamarty <sitaramc@gmail.com> writes:

>> I actually like the idea of allowing pre-upload-pack hook on git:// and
>> possibly http:// only....
>>
>> One scenario I do not want to see is this. Suppose ...
>
> I'm sorry I started this discussion.  I worked around it, though it's
> a bit kludgy, so maybe time to drop the debate.

I do not want you to feel sorry, and I do not understand why you feel that
way.

I think a reasonable and safe way to trigger an action in response to a
request to fetch from a repository _is_ a sensible thing to wish for. So
far, we established that we cannot just simply add pre-upload hook back in
and be done with it, as that is not a safe way. We learned something.

Jeff may be right that any approach based on hooks cannot be made totally
safe. But the discussion can lead to a workable alternative. The "enable
the hook only on git:// and http:// and no other" approach might or might
not be such a workable alternative. The "try talking to a service process
via named pipe, instead of spawning a hook" might or might not be such a
workable alternative. Other possibilities may be there to be explored.
