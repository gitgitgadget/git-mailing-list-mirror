From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] http: try http_proxy env var when http.proxy
 config option is not set
Date: Tue, 06 Mar 2012 07:58:44 -0800
Message-ID: <7vboo9vhzf.fsf@alter.siamese.dyndns.org>
References: <4F54D91C.6080905@seap.minhap.es>
 <7v4nu32bwp.fsf@alter.siamese.dyndns.org> <4F560196.8070500@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, sam@vilain.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Tue Mar 06 16:58:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4wmp-0007BG-B9
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 16:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491Ab2CFP6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 10:58:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34602 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751264Ab2CFP6q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 10:58:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CB025218;
	Tue,  6 Mar 2012 10:58:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l+x1bxPZ+cxuCcTlPMqQ1GRsUeM=; b=r8mzov
	nhLPiB7AczywiKytnyBQLo8Co11cB5fXKCu/dVCPu4Z4GltBOL4c64e5rU8pdr4+
	B6/bFd5QaLZNgEa4dNAeIpiVvCLd6k9eXTqXi5xqxyuzV+IeH3VcB8+fOpKDuK6X
	EgTFrJn9AMrnlxl+X8dRJZd7Mm2bFBuU9mXC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aP1sdBsC6PUxbIlFPQ/BFnAZbGuyIhAq
	SaQnARkbJoVVVjSGe4lzzM1Wb5ethSJuIv9WfNIRUkuvgzhS5pQUP86+iVSdaDJo
	1Ymjv4k5Yb0DmKx4smYwIut7jYBM6XjpKBkgeqr/Z5etV/aCkbeXjZe6EcL1Ai0r
	jfWUZYxdrvc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1234B5217;
	Tue,  6 Mar 2012 10:58:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9AF935212; Tue,  6 Mar 2012
 10:58:45 -0500 (EST)
In-Reply-To: <4F560196.8070500@seap.minhap.es> (Nelson Benitez Leon's message
 of "Tue, 06 Mar 2012 13:22:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 410D44B4-67A5-11E1-B955-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192359>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

> As I said in the commit message, in that cases a 407 error will be
> returned from those applications, because curl will not ask you for
> the password,...

If that is the case, people cannot write their username in the
http_proxy environment variable---otherwise they will not be able to
use these applications. If people do not have username in that
environment, this patch will not help us.

I think I saw you and Peff discussing down-thread that this patch
may not be needed, so if that is the case it is good---we won't have
to worry about it.

Thanks.
