From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge <tag>: Spawning an editor can't be disabled
Date: Thu, 09 Feb 2012 11:54:55 -0800
Message-ID: <7v4nuzwzn4.fsf@alter.siamese.dyndns.org>
References: <20120209153431.GA24033@godiug.sigxcpu.org>
 <20120209160803.GA5742@burratino> <7vzkcrx4f2.fsf@alter.siamese.dyndns.org>
 <4F34158D.3030903@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Feb 09 20:55:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rva58-0004Bj-Dl
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 20:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758511Ab2BITy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 14:54:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62956 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754479Ab2BITy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 14:54:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BFBE6687;
	Thu,  9 Feb 2012 14:54:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7AKh2Y9wdIRl2QkUbDfUY24RA5Q=; b=W6HotZ
	E5Hto+HpSeSo4zqoiMKAB9IQF+izzISMtcaTetR6eRkuHli/FRuIkXFXK85II4oY
	xWX7eLvhr+jXY1EKDtwE4JbOTdXclXlmn/uZpUhmmFFUm6Ml1qnWxm8rD6s7qKfC
	MIAsCg1Bur4DhvMkv+bc3HuHlSu96K29CLo3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YwAW4KT/a9nLOvvcgRgAZZ/abndjVF/J
	M9HRE3w3M1MueAWq+SRvXQFN26ZD5yM9SZY8Elha4eJx1AS90EQhyLlzwoJDFpFk
	hslvbBBGQCdim85oYPy35BNgZReXdPefe02yDrjNcrFyx0gh1yZZUdhrITLMfn6m
	fqvpnoxqNzI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13D696685;
	Thu,  9 Feb 2012 14:54:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87D536684; Thu,  9 Feb 2012
 14:54:56 -0500 (EST)
In-Reply-To: <4F34158D.3030903@kdbg.org> (Johannes Sixt's message of "Thu, 09
 Feb 2012 19:50:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0D7217E-5357-11E1-9EBA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190315>

Johannes Sixt <j6t@kdbg.org> writes:

> It should behave as if the editor was spawned and the user did not
> change the content of the commit message.
> ...
> Contrived? Dunno.

No, just "Sane".

Thanks. And I think Jonathan's original patch is just fine as-is; the
commented verification result should be stripspace()'ed out when we make
the final commit if we do so ourselves, and will stay if the user ends up
having to help resolving the merge.
