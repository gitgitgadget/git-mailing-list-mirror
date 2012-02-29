From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] pickaxe: allow -i to search in patch
 case-insensitively
Date: Wed, 29 Feb 2012 10:05:34 -0800
Message-ID: <7vpqcxtt01.fsf@alter.siamese.dyndns.org>
References: <1330474831-9030-1-git-send-email-gitster@pobox.com>
 <1330474831-9030-3-git-send-email-gitster@pobox.com>
 <20120229083534.GC14181@sigill.intra.peff.net>
 <7vy5rmt3w8.fsf@alter.siamese.dyndns.org>
 <20120229091855.GE14181@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 29 19:05:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2nuJ-0006Fp-Cz
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 19:05:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757679Ab2B2SFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 13:05:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43808 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757503Ab2B2SFh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 13:05:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A34787A5D;
	Wed, 29 Feb 2012 13:05:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6u+pZhhTn7Lu5quVl8Ta4bT5LN0=; b=o4tPm3
	dsnjgpdbWnLsZxgOVZCAQaMmHrYyiFFCEyWX7Bu5GwZxFLh/AB7Q445jDfuEpoqP
	bVrhwi3cBtZeTqPrh7Hnh1kFTQpcrzzdTuG4M+g8lZJPHXCyxuRha3YQ4/w70qNq
	OpJlEikug00YENxWUMIWMfwpKP/qDRdtVFS6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dzMp69jeTZOlsJHhbEcWvLc3RJ5tSmC/
	IVkjGfJYVNwYeOUNRWRXw1EDptSpljIffZEk2XPlkWe12eY6N2qDDXelMaVMDYK1
	NKI7IsEzGEu6z1Pvzjklv1wkuOtBgcaOQHwK6nmrQmAXeirvG2dA93n55JJ3ni/z
	iyq1nOcI3+g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AD9D7A5C;
	Wed, 29 Feb 2012 13:05:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 313C47A5B; Wed, 29 Feb 2012
 13:05:36 -0500 (EST)
In-Reply-To: <20120229091855.GE14181@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 29 Feb 2012 04:18:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FAD2B6D6-62FF-11E1-9C6E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191837>

Jeff King <peff@peff.net> writes:

> Hmm. So there are actually three potential options to flip. However, I
> think the reasoning above is still sound.

Yes, the grep side of the things is easier to understand and explain if
only one option controlled the case insensitivity or whatever aspect of
the search: "It is like searching things in 'log -p' output!"
