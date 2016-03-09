From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/7] replacing strbuf_getline_lf() by strbuf_getline()
Date: Wed, 09 Mar 2016 12:28:45 -0800
Message-ID: <xmqqr3fjgzuq.fsf@gitster.mtv.corp.google.com>
References: <56D28092.9090209@moritzneeb.de> <56D401C2.8020100@moritzneeb.de>
	<56DF6D67.9040103@moritzneeb.de>
	<xmqq37s0jxgg.fsf@gitster.mtv.corp.google.com>
	<56DF78BD.2030506@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Wed Mar 09 21:28:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adkiy-0002AN-Qa
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 21:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbcCIU2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 15:28:50 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59745 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753847AbcCIU2s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 15:28:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 87F994C7FD;
	Wed,  9 Mar 2016 15:28:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0YcBDri1L3ufX7jl3id2RV4HtyE=; b=cDyUPV
	ZsWMeWwnzeaPfrcKXRit/t/jsCSfw6OmbPBqu1mwt4mAA7cWSaO1a3/VHBlQLSbV
	nbFrsu1K/T3knrQ65VcNOj2nuCDUZybEmp1ezoxS5QnEYdWPR1GH5tdk7pP/IKU7
	of33yFo8JcY91pevNz7PtJ3TSzpA4pX+EbscY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jl0t9os+cQ+4EApPHfhnO8CXqavHwi5o
	IPE0vgFRlu5w4sQWypGMdCet+rpEXXA2pIrpp4qyV0vb7/W0gRAgb8adZbu+T94L
	w/NAFNhaLmYbKefOr6ufBaGLmjEN/tvQF6pPEXvyG7oqzZXmaiWV068/+3wt6Dep
	pqak1Dc+mbo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7F4874C7FC;
	Wed,  9 Mar 2016 15:28:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 05AC84C7FB;
	Wed,  9 Mar 2016 15:28:46 -0500 (EST)
In-Reply-To: <56DF78BD.2030506@moritzneeb.de> (Moritz Neeb's message of "Wed,
	9 Mar 2016 02:13:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 86973E82-E635-11E5-AEAE-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288573>

Moritz Neeb <lists@moritzneeb.de> writes:

> What I can imagine could lead towards finding regessions, though
> maybe a bit aimless: Go through the list of changes/patches that
> are supposed to be included in v2.8.0 and confirm they are working
> as expected. This would be like a post-review.

That would be one way for a very dedicated contributor.

Normal use of Git in your everyday workflow, noticing any unexpected
behaviour and digging into it would be what I had in mind, though
;-)
