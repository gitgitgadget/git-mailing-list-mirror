From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv2 1/6] decorate: allow storing values instead of
 pointers
Date: Thu, 14 Jul 2011 14:06:28 -0700
Message-ID: <7vipr4373f.fsf@alter.siamese.dyndns.org>
References: <20110713064709.GA18499@sigill.intra.peff.net>
 <20110713065700.GA18566@sigill.intra.peff.net> <20110713175250.GA1448@elie>
 <20110713200814.GD31965@sigill.intra.peff.net>
 <20110714173454.GA21657@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 14 23:06:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhT7I-000108-5n
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 23:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160Ab1GNVGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 17:06:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62482 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754455Ab1GNVGe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 17:06:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 953E84C32;
	Thu, 14 Jul 2011 17:06:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=50KkAWCmTV3G0YDd2sEckVCcSj8=; b=FQiIJM
	3RBKQid6TghfFJlpCM0sW8FyqLhgKYTaAQ/zDofFeqoWnGQQzRtTmudsTf+g05sC
	L4nVXZbV0x1Ci0yXhSQVyCi62cZuSUsqMUa2C4NthYgbtVxnW9yunPdPjvKnvR0h
	AgUYLSqg1JVg+YLID4GCeQ+iPqJRydiI1Fn5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dHCPTemhxD78JlWhbqvAAH/BMJDh+xKx
	YhdapVh7JRxOv7dUy6vR9mR4dSzf2r1uYRrtn2aKOM0xWNhPrsUCtGc5K7/zSPDx
	FPML8VFTbL+9faY4QMU9XlDKAC0jDYOtqNe0tt7Zximmh5546/ZH7yD5Y1nUqDJo
	nwSFNejQGqY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A5B14C31;
	Thu, 14 Jul 2011 17:06:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11E054C30; Thu, 14 Jul 2011
 17:06:30 -0400 (EDT)
In-Reply-To: <20110714173454.GA21657@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 14 Jul 2011 13:34:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 253EEE6A-AE5D-11E0-827A-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177177>

Jeff King <peff@peff.net> writes:

> Doing macro meta-programming like this makes me feel a little dirty, but
> I actually think the result is more readable.
>
>   [1/3]: implement generic key/value map
>   [2/3]: fast-export: use object to uint32 map instead of "decorate"
>   [3/3]: decorate: use "map" for the underlying implementation
>
> What do you think?

Yeah, dirty but nice ;-)
