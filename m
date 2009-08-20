From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make 'diff C^!' show the same diff as 'show C'
Date: Thu, 20 Aug 2009 16:35:36 -0700
Message-ID: <7vk50ynjnb.fsf@alter.siamese.dyndns.org>
References: <86d1201d8adf53c1f48c0f3526d8e81475b18244.1250806019.git.trast@student.ethz.ch> <7vocqanjua.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Abhijit Menon-Sen <ams@toroid.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 01:36:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeHAt-0006zl-SY
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 01:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbZHTXf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 19:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755074AbZHTXf4
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 19:35:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49896 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755097AbZHTXfz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 19:35:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 05FF631663;
	Thu, 20 Aug 2009 19:35:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yEBpxdGuYSs+A7TbtfRQcljcTeY=; b=iIdxmY
	ls2i38hbPON/haMYL9eRUH8mFbiYb7B87dGvKcs1J6JPNwG9P9Jq+Oa9pkJhVxam
	CYjS4oNjz/yAMj8oyG73+pQktUQeoGgijLRCTCPA0aWNoW0XHfETfG0sKx2O66Qr
	uMimDfqhOg57MjRs6CrIYpd3yjf0AttA9IWSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fCCnFGDqR2Wi94VMyHZKJTaXTaNN0wJ8
	D5ejZY21QgzrMQPJJ+SnUjX1/hDG4gxknxofS12xizYdHMq9SdVJx6a7NPTHPOvM
	TYKtxcSBXSh2MvFNLpooMx+IwbcAmeorSvQsHGZWFMTtnujm6qUeOQXC6M5d4iQG
	suz+iwUXj6M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BFE2331660;
	Thu, 20 Aug 2009 19:35:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 91D233165E; Thu, 20 Aug 2009
 19:35:38 -0400 (EDT)
In-Reply-To: <7vocqanjua.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 20 Aug 2009 16\:31\:25 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 31EC2C1A-8DE2-11DE-8E31-3142836986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126663>

Junio C Hamano <gitster@pobox.com> writes:

> We already mark the left side commit "..." with SYMMETRIC_LEFT bit, so you
> should be able to detect it from the setup_revisions() result.  If we were
> to formerly add some special meaning (other than being a short-hand of

blush.  I meant "formally".

> ^C^n C) to the ugly C^! syntax, I would suggest marking the result of in a
> similar way to allow you to detect it from the result.
>
> But I do mean moderately strong negativeness when I say "if we _were_"
> above.
