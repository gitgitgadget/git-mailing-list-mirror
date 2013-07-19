From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add the GIT_SENTINEL macro
Date: Thu, 18 Jul 2013 20:30:27 -0700
Message-ID: <7vr4evz0oc.fsf@alter.siamese.dyndns.org>
References: <51E849C4.7020305@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 19 05:30:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V01Ot-00053x-JC
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 05:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759625Ab3GSDac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 23:30:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62034 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755182Ab3GSDaa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 23:30:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4F7A26875;
	Fri, 19 Jul 2013 03:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jKHOklwqfi3OM4G53O3xJh8o2NE=; b=tSQB/d
	QFcv2Sb080drbEJ7ZD+NLcEF+pCF3Dhtv4EZ2IG3/mqirk3nMPYmt1bMyeNe8VQY
	dRxBOJmhfZ+1pmqWimept8dScHAO53a3k6vXT6lisRHbgEr0nAs5PuKPhQxgKFtl
	ZqIsVh/AFw0fHgGU5Zq7wEH9W3I27wJ88fzrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mJl+1diMGBajVI7PeF60b+alwsehaJo0
	kv3s/bdYCS6nB7LTGvD9wX+4IEit2Tw2vB2/FNN5gJ2ekDDXqBVIZXfGa7+7V/xc
	KMBhvW+6Qnfad5t8F+sZucg3M+rkXa2XxEMh0v00BU4b+7iFgMkIqVQtnYNvMME7
	5n5/PbH5168=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC4C026874;
	Fri, 19 Jul 2013 03:30:29 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3268D26871;
	Fri, 19 Jul 2013 03:30:29 +0000 (UTC)
In-Reply-To: <51E849C4.7020305@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Thu, 18 Jul 2013 21:02:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F3C442A-F023-11E2-A7BA-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230776>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> The sentinel function attribute is not understood by versions of
> the gcc compiler prior to v4.0. At present, for earlier versions
> of gcc, the build issues 108 warnings related to the unknown
> attribute. In order to suppress the warnings, we conditionally
> define the GIT_SENTINEL macro to provide the sentinel attribute
> for gcc v4.0 and newer.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> This was built on the next branch

It seems to apply well on the tip of jk/gcc-function-attributes.


 - This macro is not about "git" at all, so I'll edit the patch to
   call it GCC_ATTR_SENTINEL before applying.

 - Also I'll drop the (0) at the end.

Thanks.
