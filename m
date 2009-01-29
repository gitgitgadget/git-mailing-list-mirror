From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "malloc failed"
Date: Wed, 28 Jan 2009 23:53:25 -0800
Message-ID: <7vfxj2h7ka.fsf@gitster.siamese.dyndns.org>
References: <878wow7pth.fsf@mcbain.luannocracy.com>
 <20090128050225.GA18546@coredump.intra.peff.net>
 <c26bbb3fe074f6f6e0634a4ae8611239@206.71.190.141>
 <87skn3rn5n.fsf@mcbain.luannocracy.com>
 <20090129052041.GB31507@coredump.intra.peff.net>
 <20090129055633.GA32609@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 29 08:55:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSRjr-00020j-9G
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 08:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbZA2Hxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 02:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbZA2Hxc
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 02:53:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbZA2Hxb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 02:53:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4B0542A04F;
	Thu, 29 Jan 2009 02:53:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 850292A03B; Thu,
 29 Jan 2009 02:53:27 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EBEE9322-EDD9-11DD-8B51-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107641>

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] avoid 31-bit truncation in write_loose_object
>
> The size of the content we are adding may be larger than
> 2.1G (i.e., "git add gigantic-file"). Most of the code-path
> to do so uses size_t or unsigned long to record the size,
> but write_loose_object uses a signed int.

Thanks.

I wonder if some analysis tool like sparse can help us spot these...
