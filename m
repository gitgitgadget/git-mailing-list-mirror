From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 16:36:24 -0800
Message-ID: <7vd436m8af.fsf@alter.siamese.dyndns.org>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
 <20091125203922.GA18487@coredump.intra.peff.net>
 <7viqcytjic.fsf@alter.siamese.dyndns.org>
 <20091125210034.GC18487@coredump.intra.peff.net>
 <7vmy2as319.fsf@alter.siamese.dyndns.org>
 <20091125214949.GA31473@coredump.intra.peff.net>
 <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com>
 <60F92BD7-6FFF-4D9A-B2F0-0858F4E90B59@wincent.com>
 <7vd436p339.fsf@alter.siamese.dyndns.org> <4B0DC8F7.1000509@gmail.com>
 <7v4ooinnkx.fsf@alter.siamese.dyndns.org> <4B0DCC27.4030702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Wincent Colaiuta <win@wincent.com>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 26 01:36:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSLm-0006oi-E8
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbZKZAgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759585AbZKZAgf
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:36:35 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35737 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759347AbZKZAge (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:36:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B9EA8278D;
	Wed, 25 Nov 2009 19:36:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EkWiuCIsULK32GTv4ohtCbxpHAQ=; b=bs1Xoh
	H81p+Em9V+eQI3ivQmw/ynqklaI046g90awXXRd5suBU1Rulse0LLlbFcCQUMiVH
	vL6CoXR2Ipfmvg+wi9Nk/Y6xyvxm3vmbkrBjdI+4Cm6IFDt6N+z9xZTlsUk85ORr
	wGFq4xV8KxNRJRZfCFkG41wdZPVgV4pVe/65w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=elMTBhHunXcvFtj8Ea93iyRXWuE2/7G0
	s+e2IiUHE3ZtLICFZv4x26Hy7pHDO93bRyy5M8d7QMORMcR/OpUleiMR5TfkHwwr
	VjZzqg7MCrbFg/pIaNPaN/U1PuQCutU600ZdW6eqsv0zvX+lcBrVAJcf2vhOPiao
	bvOX01swKN0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C40AC8278C;
	Wed, 25 Nov 2009 19:36:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A920D82787; Wed, 25 Nov
 2009 19:36:25 -0500 (EST)
In-Reply-To: <4B0DCC27.4030702@gmail.com> (A. Large Angry's message of "Wed\,
 25 Nov 2009 19\:30\:31 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BED087C4-DA23-11DE-AB06-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133717>

A Large Angry SCM <gitzilla@gmail.com> writes:

> Junio C Hamano wrote:
>> A Large Angry SCM <gitzilla@gmail.com> writes:
>>
>>> But the users are almost always dealing with things (objects) that
>>> started as files, act like files and may be files again. Why should
>>> they not expect filesystem semantics.
>>
>> Do you truly want to see this?
>>
>>     diff --git a/var/tmp/git/Makefile b/var/tmp/git/Makefile
>>     index 5a0b3d4..e9b03a8 100644
>>     --- a/var/tmp/git/Makefile
>>     +++ b/var/tmp/git/Makefile
>>     @@ -1985,3 +1985,4 @@ coverage-report:
>>     ...
>>
>> As long as you are talking about paths you communicate with git, your
>> root _is_ the root of the work tree, and it shouldn't matter where you
>> have your work tree.
>>
>> That is what I meant by "the root _in the context_".
>
> Nice example for a command output. But what did the user specify on
> the command line?

Either relative path from $(cwd) or full pathname from the root of the
filesystem in your world (because you do not understand the value of the
context), and ralative path from $(cwd) or full pathname from the root of
the work tree in my world.
