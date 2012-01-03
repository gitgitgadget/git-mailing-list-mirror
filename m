From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix hang in git fetch if pointed at a 0 length bundle
Date: Tue, 03 Jan 2012 12:13:14 -0800
Message-ID: <7v7h18tuhx.fsf@alter.siamese.dyndns.org>
References: <20120103011352.GA13825@localhost>
 <20120103134603.GA31034@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Harring <ferringb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 03 21:13:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiAja-0004vl-Co
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 21:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880Ab2ACUNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 15:13:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43835 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754873Ab2ACUNR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 15:13:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C385F6387;
	Tue,  3 Jan 2012 15:13:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Oa2wnBt7xZzCXbW1eDo0psrAG1Q=; b=RBAYT7
	Lw/dcBCMQhv9795viHNCUaWCilU1XKHXjBXL35I/6h3QnVsNHWILGD2Kix9f5x3W
	IMSzuRa+7tLcgRa310W8EliA4G7hbOLhCxdNxIqtE+/v7wVXOHxfyvYuHGJdlDWR
	LZqbQwSjLsorLdpBIRezUobP+BWwM8LNN8th8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cAcnH79cdNDQPB4gGR0XphXxTiZgG2c5
	Sam6DBC0qOxpGKxhQGVJrWHk02Jd7h1p8kKcFnkFrNILEttlVhPBa9xt5zO5iY+A
	anKTEMs42CI7AVDL1EnWv42q10T4QvBqz8Gn/1gLZVVXdh/bCTClY+Fdqrhr2cKS
	bRkKrClk3ag=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA9A86386;
	Tue,  3 Jan 2012 15:13:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 308836384; Tue,  3 Jan 2012
 15:13:16 -0500 (EST)
In-Reply-To: <20120103134603.GA31034@localhost> (Brian Harring's message of
 "Tue, 3 Jan 2012 05:46:03 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5EFDB7AE-3647-11E1-BA4B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187890>

Brian Harring <ferringb@gmail.com> writes:

> git-repo if interupted at the exact wrong time will generate zero
> length bundles- literal empty files.  git-repo is wrong here, but
> git fetch shouldn't effectively spin loop if pointed at a zero
> length bundle.
>
> Signed-off-by: Brian Harring <ferringb@chromium.org>
> ---

Thanks.

Also thanks to all reviewers.
