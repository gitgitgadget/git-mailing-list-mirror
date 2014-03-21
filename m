From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][GSOC] Selection of the verbose message is replaced with generated message in install_branch_config()
Date: Fri, 21 Mar 2014 10:09:19 -0700
Message-ID: <xmqqr45vv5q8.fsf@gitster.dls.corp.google.com>
References: <1395050104-19152-1-git-send-email-moxobukob@gmail.com>
	<loom.20140318T124348-742@post.gmane.org> <lg9l22$qto$1@ger.gmane.org>
	<CAPig+cQLACyFwVypi08ZGQ14mpc0zt0fRRNhPzswRjsTaFQz2A@mail.gmail.com>
	<lgekju$u6t$1@ger.gmane.org>
	<CAPig+cRv-WvoMVY0PDgtLawywe0QfpX8oPetzNwD-9Jq6BOjyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aleksey Mokhovikov <moxobukob@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 18:09:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR2wi-0007YF-O3
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 18:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbaCURJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 13:09:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50680 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751594AbaCURJX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 13:09:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFB4474BC9;
	Fri, 21 Mar 2014 13:09:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QeVk/97vZUWkyEE+Zt+6NkXNVwI=; b=JDL23R
	7nCN5iprGRB0a29JCGBBXTcjhScVgPlxdxGoJkglvwZYPy+V4TQFeObMxqvkyjcU
	O0oz8oxt5Yv9eZeAO2sI2td3GAsY68ACOlccQtUFWCTX2cj/j0q+/dIfWaoRe7Wz
	6AyZqij96QBvJ1nN6n2aMgzuSANUkWAGQUTbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EkhUPcCcYFoCmy/7KQIl+F4edNrZJAVK
	hzPkCkW3knIAPrdn7m7r9AJxqVdSfQaen+ugb8hoQgyL75uToJa7Dp85AGeiKFF8
	hB8kmMtkynGFbMdqg/fkh7eXp+VuYBNbU5h1QxImOO59r+/+NLT7teOiFUcBQCbS
	SjizyMW+zwQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C44F74BC8;
	Fri, 21 Mar 2014 13:09:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D72B874BC6;
	Fri, 21 Mar 2014 13:09:21 -0400 (EDT)
In-Reply-To: <CAPig+cRv-WvoMVY0PDgtLawywe0QfpX8oPetzNwD-9Jq6BOjyw@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 21 Mar 2014 00:03:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8BCCBF90-B11B-11E3-BD3A-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244703>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Sorry, you're right about message[0] case not being a crasher (though
> the assert() still seems overkill).

Assert() often becomes no-op in production build.  I think this may
be an indication that "table-driven" may not be as good an approach
as many candidates thought.  The microproject suggestion asks them
to think _if_ that makes sense, and it is perfectly fine for them if
they answer "no, it introduces more problems than it solves".
