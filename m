From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] upload-pack: add a trigger for post-upload-pack hook
Date: Mon, 31 Aug 2009 16:36:10 -0700
Message-ID: <7vab1fzhcl.fsf@alter.siamese.dyndns.org>
References: <1250579093-40706-1-git-send-email-tom@mojombo.com>
 <12c267e40908251043g4f3e36aya05d9c705f5afee2@mail.gmail.com>
 <20090825184525.GC23731@coredump.intra.peff.net>
 <7vprajmp16.fsf@alter.siamese.dyndns.org>
 <7v1vmycfhd.fsf@alter.siamese.dyndns.org>
 <7vy6p69j6a.fsf@alter.siamese.dyndns.org>
 <9e0f31700908270509o1031a027y1b49efe7ea9a4fd3@mail.gmail.com>
 <m3ws4pl6x7.fsf@localhost.localdomain>
 <7vljl3p2iw.fsf@alter.siamese.dyndns.org>
 <12c267e40908311150n2aad598aw978c4691c27ac0fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johan Sorensen <johan@johansorensen.com>,
	Jeff King <peff@peff.net>,
	Tom Preston-Werner <tom@mojombo.com>, git@vger.kernel.org
To: Tom Werner <mojombo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 01:36:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiGQO-0002e2-8h
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 01:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbZHaXg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 19:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbZHaXg1
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 19:36:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41895 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbZHaXg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 19:36:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A38E33E178;
	Mon, 31 Aug 2009 19:36:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=YSy+CSTqqI14hgvkqpZ+3GZrTtY=; b=r0pwK7aYa+kCn9cLVEAKmw1
	Hc74FM3wYV0hUFMZcUrMq5+hVUe7RPQV7t4d7TWCkraz9Em3WgPqdnuyAykUl94i
	AibOkvkBTPvkcvTDQBqEZfCVvztjMXHYcr2OSoFXfRLWAGrrc8NhRxTQNrZRNNt3
	5ltGUFhTlGxm9YhmpWyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Hs/s0UAvbZYst8VpydicIPHNljTflJUBLfNZ/qIBkuvALDxCR
	1X04iSNpoHl9XS02EGussYVxkLKks+Rt7bpLivdamw13Maa8C7mfqgFEOY9BFNB0
	lpRmWXaI5pCMnl42f0giyubyZdv3wUyBACzA4/EKCh/uSdRtpSzo6505Bw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4E6303E16C;
	Mon, 31 Aug 2009 19:36:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 01EB13E158; Mon, 31 Aug 2009
 19:36:11 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 16124FC6-9687-11DE-8B2B-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127507>

Tom Werner <mojombo@gmail.com> writes:

> ... I'd be happy
> with the previous incarnation of the post-upload-pack that simply
> sends the HAVEs and WANTs.

Thanks.  This settles the biggest worry I had.

The worry was not about "do we feed clone/fetch info?", but was about
getting a complaint "Now, these changes to feed info from standard input
does not help anybody but forces us to update our hooks for no good
reason" from you guys ;-).
