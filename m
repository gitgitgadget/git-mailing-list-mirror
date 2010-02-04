From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] add --summary option to git-push and git-fetch
Date: Thu, 04 Feb 2010 09:25:49 -0800
Message-ID: <7vwrysdiaq.fsf@alter.siamese.dyndns.org>
References: <20100130020548.GA29343@cthulhu>
 <7vsk9oysds.fsf@alter.siamese.dyndns.org> <20100201005751.GA8322@cthulhu>
 <20100204171619.GA9367@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 18:27:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd5UI-0004Ys-Ez
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 18:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933370Ab0BDRZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 12:25:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60141 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932922Ab0BDRZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 12:25:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CFB497489;
	Thu,  4 Feb 2010 12:25:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7Fx2CVmbpKY71xiziE3y57+7Ebo=; b=DrcxJo
	KNqU3kXrJtTVrh0xLM+mHOK57OxpXQ0QZWcyWg2OUrIwXWTS96IqW4ptWKVsxhwf
	TKIaaZyMp0y2gBSnT+0LNsNZi0IhAFgNGD65kmcYdYrSIzyeg/jL1i45MLkggQQ6
	9QD1bu+nLuhTyyvtndusEQIPQ7qdX2c/1v+8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W6qNfUc+NEuBA7v66xqkkydZphSZx85+
	qlcNKIEp2CByqax7b1c4emCBnxO72+CJSNTn8wpaGoZmFzreduG1LBLTxvHaW+O+
	SNiJnI6pTZ2mHYjHMYpj3JmqO7AVfYMzWp55tBLRXQ63vcsXyTjO3P+z58nEOkXe
	bbdUGXokfTo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E90F197487;
	Thu,  4 Feb 2010 12:25:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 318DD97486; Thu,  4 Feb
 2010 12:25:51 -0500 (EST)
In-Reply-To: <20100204171619.GA9367@cthulhu> (Larry D'Anna's message of
 "Thu\, 4 Feb 2010 12\:16\:19 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 58F4E00A-11B2-11DF-81BE-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138987>

Larry D'Anna <larry@elder-gods.org> writes:

> * Larry D'Anna (larry@elder-gods.org) [100131 19:57]:
>> So i guess you're saying that it would be better for update_local_ref and
>> print_summary_for_push_or_fetch to clear the flags, and just pass a rev_info for
>> print_summary_for_push_or_fetch instead of quickref?
>
> So, should I submit a version of the patch that does it this way?  Should it use
> a subprocess?  Should the option be called something other than --summary?

I dunno.  If it delegated to a subprocess it would certainly be easier to
review and get convinced that the change won't affect object flags for
other parts of the system in bad ways, but there obviously is a
performance downside.

I vaguely recall there also were comments on the output format not being
consistent with output of similar nature from other parts of the system,
but I am not the one who is particularly interested in this feature, so
I'll let you and the list decide.
