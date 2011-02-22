From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] merge: improve inexact rename limit warning
Date: Tue, 22 Feb 2011 10:46:57 -0800
Message-ID: <7vsjvfdhzy.fsf@alter.siamese.dyndns.org>
References: <20110219101936.GB20577@sigill.intra.peff.net>
 <20110219102051.GA22508@sigill.intra.peff.net>
 <7vzkppgdz9.fsf@alter.siamese.dyndns.org>
 <20110222153909.GB27178@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 22 19:47:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrxGX-0000Dz-Si
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 19:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543Ab1BVSrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 13:47:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36489 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635Ab1BVSrM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 13:47:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 18FC84DB8;
	Tue, 22 Feb 2011 13:48:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gPcXyC8IvgDC5AqjR2fMkQ4TNbg=; b=ITxsNC
	FuQpYHbWeeCAnBS7n35kVhgkWHi+N1ussImOqfyz4cyL5MfOmcrTL4OLVGPBsyu9
	Xq/I1DI93+QmOuR0PvQwYiQDBwCbLl4zJbiZN7Ij+5fhQmHpYQxa9w680+c9z/z+
	RdC+YoDetjNS9dFNJbh/z2G6kSM/OZp8n8ovg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nJJRti7uc2fV+qmTRAqePAG8MLv9t/oM
	LOP9cE7aAfgaxsiww8RQAvRcYg/QyfXw6ktzsr8ceahJpq2dn2h6izJHAYI5DGUE
	chPwHgnRCHMc8NrG/HrwT+N/LJMc4Bt/1qEY5d7OSyxCaTYGmP6rARPVt7H+W3Kv
	UvQFjZczdfE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CA39A4DB4;
	Tue, 22 Feb 2011 13:48:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A45464DB2; Tue, 22 Feb 2011
 13:48:10 -0500 (EST)
In-Reply-To: <20110222153909.GB27178@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 22 Feb 2011 10\:39\:09 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5090DFE2-3EB4-11E0-89DD-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167572>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 21, 2011 at 03:33:14PM -0800, Junio C Hamano wrote:
> ...
>> This conflicts with 2840824 (diffcore-rename: fall back to -C when -C -C
>> busts the rename limit, 2011-01-06) on 'pu', unfortunately.
>
> Do you want to do the merge, or do you want me to rebase on top of
> 2840824?

Please check the resolution queued on 'pu'; I suspect that your series
should graduate before the fall-back-to-c-from-c-c topic, so I'd rather
not to see you rebase this.
