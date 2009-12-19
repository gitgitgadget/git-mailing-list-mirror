From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] am: fix patch format detection for Thunderbird "Save
 As" emails
Date: Fri, 18 Dec 2009 23:39:31 -0800
Message-ID: <7vk4wjfm4s.fsf@alter.siamese.dyndns.org>
References: <7vtyvpcf36.fsf@alter.siamese.dyndns.org>
 <1261172078-9174-1-git-send-email-bebarino@gmail.com>
 <loom.20091218T223918-175@post.gmane.org>
 <1261173577.14059.5.camel@swboyd-laptop>
 <loom.20091218T234129-280@post.gmane.org> <4B2C395A.6080300@gmail.com>
 <4B2C66D3.1070508@byu.net> <4B2C70ED.1020602@gmail.com>
 <4B2C7B9C.1030404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Blake <ebb9@byu.net>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 08:40:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLtv5-0008Ii-DR
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 08:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbZLSHjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 02:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbZLSHjs
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 02:39:48 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64431 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbZLSHjs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 02:39:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 611A6A8DCB;
	Sat, 19 Dec 2009 02:39:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wWP6eMLpVWd9HXkpbHeG5AoP3uA=; b=cSF6A3
	cnwWHFYI9NvY14ku0L4iP6n6lZkREigeGxEVQc3YoehD2r66YeMUWos01lo9xeX1
	xSjIyXWJxFGKH68ZzpjgAWjuHx/svdqNWLwcW6BVXcvGRgDu2RkD9PVZWCBkRUVO
	gRS0l0zUO5h6uYaYeKo+P+ffWnVsNSq2OFiWY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qWclIGSWectHs8oVA1sIvQ5JDboi7ucM
	b7Ev95aRgK+yvmE7izU3dcqRwwK7HdqCkuhcrwtmBFAeBWlYCcMSCiC4ITyi2v0N
	R+ntxStoh+kKCICNbG/hdLYo+uEtX5xz6L6t1JG2a7MrKdiWrhkK5iNQSJyKqSot
	HcYl2IBhbFU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2E0E2A8DCA;
	Sat, 19 Dec 2009 02:39:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1E0BAA8DC4; Sat, 19 Dec 2009
 02:39:37 -0500 (EST)
In-Reply-To: <4B2C7B9C.1030404@gmail.com> (Stephen Boyd's message of "Fri\,
 18 Dec 2009 23\:07\:08 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AB8FDD26-EC71-11DE-A316-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135468>

Stephen Boyd <bebarino@gmail.com> writes:

> I found this in t0022
>
> sed -e "s/\$/
> ^M/" "$TEST_DIRECTORY"/t0022-crlf-rename.sh>elpmas&&
>
> so I'd like to use that if possible.

That needs fixing; I think we caught something similar from Shawn before
it got in, primarily because the mail path corrupted the message and
turned the literal CR into LF.
