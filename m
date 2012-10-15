From: Junio C Hamano <gitster@pobox.com>
Subject: Re: build deps
Date: Mon, 15 Oct 2012 13:53:08 -0700
Message-ID: <7vd30jwj7v.fsf@alter.siamese.dyndns.org>
References: <CACnwZYe_vhH9Ui8W9D=M_8avgEugR+UvM1E+jH7fxr+8yk2UtQ@mail.gmail.com>
 <5072FAD1.1000807@gmail.com>
 <CACnwZYeJ-FKXterxd697iu+U4HobqEaP0zx_p8CZDsPZx4hbHQ@mail.gmail.com>
 <50735939.10604@gmail.com>
 <CACnwZYf56XkqW085HoWhAN2EnjCJd=VYHGAD8fZCCe6_FNhO2A@mail.gmail.com>
 <50776D0D.9090306@gmail.com>
 <CACnwZYfmz1BTo6okzFh8jXbw+0MAV0sEanYXNzAnV7L4p7nY_g@mail.gmail.com>
 <507C2F6E.9060100@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>,
	Andrew Wong <andrew.kw.w.lists@gmail.com>,
	Andrew Wong <andrew.kw.w@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 15 22:53:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNrf8-0002ZK-9m
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 22:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754990Ab2JOUxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 16:53:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48228 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754671Ab2JOUxK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 16:53:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 776D88A89;
	Mon, 15 Oct 2012 16:53:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b5EhTs+lDjZ/cWTBmLe7hv++m4c=; b=QrWEZ1
	XnyRMnek5ea1lOD3Wb0pB4VkaN21/GwaBkxib2hmiKjRNbN4AJYQwa7SLIpwmq7f
	GMRcrBoPRkFKxpd0g+twJmpzbntP4GoflO95b13uAA/cUIhWSwzXbiCToVl/Vk8p
	pGI86ahzhm4Ac/rB2DroziFoG6/VroUtAtVqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UxOzWrhxkomD8eCCJaIhZsbC1XHggry1
	6fPBBjExShhy9f+uIE8RQUKcPDLkZViEsVH/N9AXvzflxwPC5x+RD3nMLNQ/aamW
	0koM9tB0xLPAsFvTHcNuTN/OuENNT2l7vEe0+T8HJE3JjwhRgBeLLX65kyXhXhoa
	uFlIsLSd27M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63D908A88;
	Mon, 15 Oct 2012 16:53:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC0168A87; Mon, 15 Oct 2012
 16:53:09 -0400 (EDT)
In-Reply-To: <507C2F6E.9060100@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon, 15 Oct 2012 17:44:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 53D017E2-170A-11E2-8C61-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207778>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> grep.c:451:16: warning: comparison of unsigned enum expression < 0 is
>> always false [-Wtautological-compare]
>>                 if (p->field < 0 || GREP_HEADER_FIELD_MAX <= p->field)
>>                     ~~~~~~~~ ^ ~
>> 1 warning generated.
>
> Right, that enum type starts at 0. Junio, you last touched this area.
> Can we just dump the first comparison or did you have something else in
> mind?

I think it was a leftover from the very first implementation that
defensively said "this has to be one of these known ones", and tried
to bound it from both sides of the range, regaredless of the actual
type of the field (these GREP_HEADER_WHAT things may have been
simple integers with #define'd values).  Dropping the "negative"
comparison is perfectly fine.
