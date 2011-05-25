From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] Support multiple virtual repositories with a
 single object store and refs
Date: Wed, 25 May 2011 12:43:32 -0700
Message-ID: <7vipsy36sb.fsf@alter.siamese.dyndns.org>
References: <1306274066-4092-1-git-send-email-jamey@minilop.net>
 <7v7h9f7kzx.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1105250847380.2701@bonsai2>
 <20110525154405.GA4839@oh.minilop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Wed May 25 21:43:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPJzn-0002ux-NX
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 21:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736Ab1EYTnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 15:43:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61864 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420Ab1EYTnu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 15:43:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AFDD75CAD;
	Wed, 25 May 2011 15:45:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/PXnuy0mcayo94fUJgtpojhicSY=; b=JoOHOH
	tlYuZbEufRLweGyNDPETb7fiipJ+ogLUyAxN4ZIhsgYrs6ziw56ZQcBKWw4zCmmp
	7WpwAqimnQXOC6hivGWB+myP+shzgWpU1wX4dJSAa6euXplgj0QuRX7gbWKhlitH
	/8059JKCt8NPn+yCJ0x+e47AO5IOuzI5PhgKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yNZVnqq1SUjXC7k1lT9FLsxK432LmWNk
	heJ7HZ6yjKMq27UwNYnBqX4zt98P+k77j1jqyJh5oZcG5Raler6mEmRkmfG3ZERU
	+1Uv9kcpZBUp29f/7i6TvhyCtjBq+oxbr725oIdDjaER48KR8q8TB/LfS/DJepV8
	Vtr3+NvSPKQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 41BF95C9F;
	Wed, 25 May 2011 15:45:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 78A9D5C9A; Wed, 25 May 2011
 15:45:41 -0400 (EDT)
In-Reply-To: <20110525154405.GA4839@oh.minilop.net> (Jamey Sharp's message of
 "Wed, 25 May 2011 08:44:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 972B6792-8707-11E0-8906-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174453>

Jamey Sharp <jamey@minilop.net> writes:

>> I had to read the example call to understand that 'virtual repository' 
>> means 'one real catch-em-all repository'.
>> 
>> I wonder about two things, though:
>> 
>> 1) Would teaching git clone to understand "-t this/repo/*" help?
>
> Sure, that would be an improvement for our use case,...

Hmm, what does the "-t" option do?  Is there a side-band communication
between you guys that I am not seeing?  I didn't see anything to make me
say "Sure" or otherwise.

I had a feeling that you wanted to keep the illusion to the users that you
are serving multiple repositories independently, so a solution that does
not have to make "git clone" on the other side aware of the layout on your
server would probably be more preferrable to you anyway.
