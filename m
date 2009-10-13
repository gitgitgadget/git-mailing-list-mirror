From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect reset: Allow resetting to any commit, not just a 
  branch
Date: Tue, 13 Oct 2009 00:21:50 -0700
Message-ID: <7vbpkb21yp.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.10.0910121237540.2223@dr-wily.mit.edu>
 <7vr5t8coex.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0910121708030.5105@dr-wily.mit.edu>
 <7vaazw6uyi.fsf@alter.siamese.dyndns.org> <4AD42203.6030802@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Anders Kaseorg <andersk@MIT.EDU>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 13 09:39:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxbw1-00016f-0T
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 09:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933614AbZJMHWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 03:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758975AbZJMHWr
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 03:22:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59502 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757222AbZJMHWq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 03:22:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 39E2975D64;
	Tue, 13 Oct 2009 03:22:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AV+HJdlnHD1ylhTUUiL5g05/AYY=; b=bJwHxQ
	+vqwumt3e/oMnYVnPa5M0FDRD0YtJEucm1C9Ddhhn0lsoOQfuEs6aUcSFLdWbpVT
	VWhXRrKgLqOebHMsK/TkqyJFdXtaqo7n+ctHBzsFSb9vLZYaDRnUkvjnQzT/T1m+
	SSIGM29loxqcE7Yt04OpF+ZDI718lL7yPjN1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SCvUlDqFdAj/xSiBOVAG7BnWU4CSOw0J
	CI4mM3skI6HAZK8hNBb5W8v1O+KJhThIcrSgDjPMBgmOIVq/qcZHfzDjwZG4y2zJ
	sPjt1k+NnsbMV7zVahhmvlM2aA3/Sj2TRvgruAys3QErKWElYCLFebjjOG6uUDTO
	JZajjJCgNGw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F85175D63;
	Tue, 13 Oct 2009 03:21:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 981EC75D62; Tue, 13 Oct 2009
 03:21:51 -0400 (EDT)
In-Reply-To: <4AD42203.6030802@viscovery.net> (Johannes Sixt's message of
 "Tue\, 13 Oct 2009 08\:45\:23 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1705677A-B7C9-11DE-86D8-A730BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130142>

Johannes Sixt <j.sixt@viscovery.net> writes:

> The situation that I'm faced quite frequently is that after I find a
> regression, I cannot tell which released version did not have the
> breakage. Hence, the first thing I have to do is to find a good commit.
> Therefore, I jump around in ancient history until I find a good commit.
> Then I start bisect. I certainly do NOT want to be warped back to this
> ancient commit by 'bisect reset'.

Unlike your other message, now, I can see _this_ one making sense very
much.

It is a very good explanation as to why BISECT_START (whose sole purpose
is to go back there) is not a very useful concept.  What you wrote deserve
to go to the "bisect reset" documentation to explain what the optional
<branch> argument (perhaps we would make it a <commit> with Anders's
patch) is good for and how it is intended to be used.
