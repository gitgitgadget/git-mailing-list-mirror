From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t: Replace 'perl' by $PERL_PATH
Date: Tue, 12 Jun 2012 07:56:56 -0700
Message-ID: <7v4nqg4lzb.fsf@alter.siamese.dyndns.org>
References: <1339441313-5296-1-git-send-email-vfr@lyx.org>
 <7v1ull7j9k.fsf@alter.siamese.dyndns.org>
 <20120612123454.GA25407@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: vfr@lyx.org, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 16:57:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeSWm-0007CD-51
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 16:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371Ab2FLO5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 10:57:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53159 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752145Ab2FLO47 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 10:56:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6106D95A3;
	Tue, 12 Jun 2012 10:56:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S3HZyYw/hI1IQv+MOuqJqCXYpGA=; b=TBmzfP
	wi1ybCm71ghSzwE92idy63VgvpoZkAgcBSWgDAeEeO4pSQxitGLtrtes4+PaqWkf
	nHxhRypbs+pNVSSNHD5QCFhBGZtyy3RECAjxRz/nlnCaXvb+exCMpn+b8DsKdh1c
	YiWaQZkT3qpiH6zwYEAijf/Y2+YtR5sLcN+dY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SqCD4JxvGf8ED+s3YN37/Ao8U8brAVHs
	9lfGfW2pm68pBk0IGIRMCWoXWe5qWRRmtKHeNqH54WiYRMv857KBEhEtJqC1EGoZ
	+9Kturfq81bCQuuinRSgdNAEqeaurAkVoGwF8tP1rYO5TJ+QxNV88FOvixub8bXH
	4VSmC3SRcaw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53F3C95A2;
	Tue, 12 Jun 2012 10:56:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCEEF95A1; Tue, 12 Jun 2012
 10:56:57 -0400 (EDT)
In-Reply-To: <20120612123454.GA25407@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 12 Jun 2012 08:34:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB83C81A-B49E-11E1-B539-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199798>

Jeff King <peff@peff.net> writes:

>> I personally do not mind if we do this consistently, but I am not
>> sure your $PERL_PATH that is not quoted is the right way to invoke
>> it; look for PERL_PATH in t/ to see the existing uses.
>
> My biggest concern is placing an extra portability burden on
> test-writers (who will inevitably forget, and won't notice because what
> they are doing is only broken on obscure systems). Is there a way we can
> hide this behind a perl() shell function or something?

I am hoping that writing 'perl' without any adornment will hopefully
stand out like a sore thumb if all perl invocations in existing code
are spelled '"$PERL_PATH"'.  We forbid "! git cmd" and tell people
to write "test_must_fail git cmd" instead, and I think it has worked
reasonably well.
