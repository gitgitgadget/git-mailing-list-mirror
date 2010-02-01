From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pack.packSizeLimit, safety checks
Date: Mon, 01 Feb 2010 10:45:29 -0800
Message-ID: <7vvdeg23sm.fsf@alter.siamese.dyndns.org>
References: <loom.20100201T101056-232@post.gmane.org>
 <alpine.LFD.2.00.1002011100550.1681@xanadu.home>
 <7vvdeg50x4.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002011240510.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergio <sergio.callegari@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 01 19:46:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc1HO-000604-PT
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 19:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755606Ab0BASpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 13:45:41 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400Ab0BASpk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 13:45:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B0B7296C58;
	Mon,  1 Feb 2010 13:45:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CBJcWyI6Ea6O8yIyJPLt4xs2tl0=; b=pmh5T3
	TNaaJcooQ+S3E8DsHMDvpGqOjixeK+U+Cu9aVmCMgen+/H06iek56snyWbm5a3BO
	UT+LINEJrPZzOztMPp2RorblFTkIsJ9nGv6cCHzQgZXAzoOxG6Txe/CCC9FhI+8V
	2MnqBXV3Zfnxh1Cnc+wttTs7MizhHVO91BGK8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LlSKF2XBgnYq7JvXDJF864qR6pJWePJB
	8z41pqn56VyRCDfZeJkVZ8fI0ZHs1ZXUE/WV/diNHAzQu5sb2vsV/YPnUd2IOVLc
	hPk4VC4mku9RSHLkPrsyO+T1pIOmN3zAarbkF8mU9rmswfY6vpw97F6QR9XYTvfH
	idCXhTVLI30=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BEF896C57;
	Mon,  1 Feb 2010 13:45:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EE1A96C27; Mon,  1 Feb
 2010 13:45:31 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1002011240510.1681@xanadu.home> (Nicolas
 Pitre's message of "Mon\, 01 Feb 2010 13\:04\:35 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FBBC4E7A-0F61-11DF-8A57-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138640>

Nicolas Pitre <nico@fluxnic.net> writes:

> While I share your concern for advance warning and such, I think those 
> concerns are worth an effort proportional to the depth of user exposure.  
> Like for the THREADED_DELTA_SEARCH case, I'm wondering how much pain if 
> at all might be saved with a transition plan vs the cost of maintaining 
> that plan and carrying the discrepancy further.

Absolutely.  I just wanted to hear that --max-pack-size command line
option is not widely used and it is Ok to change it.
