From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert diffstat back to English
Date: Thu, 13 Sep 2012 14:10:41 -0700
Message-ID: <7v627h7hny.fsf@alter.siamese.dyndns.org>
References: <20120913132847.GD4287@sigill.intra.peff.net>
 <1347545786-936-1-git-send-email-pclouds@gmail.com>
 <7vzk4t960y.fsf@alter.siamese.dyndns.org>
 <7va9wt9377.fsf@alter.siamese.dyndns.org>
 <20120913210111.GA16956@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 13 23:11:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCGgY-0000bU-55
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 23:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755834Ab2IMVKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 17:10:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65035 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075Ab2IMVKo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 17:10:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 517D28313;
	Thu, 13 Sep 2012 17:10:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ah+wyfQH9OKhUBKqkqxtRBlvqmE=; b=mcIH5g
	Hpg88g7/0t40lySsK6o0BwL4XGLVkTBdpsnASugASMC7OtC/EZOWPCO6vrVgs5CQ
	gLsLuvVksOTJpQ8O4NVIWX90sOIVvKTSnGIVNZNowjC7flkG41gXEb5U7vcsMnb3
	8a5cuLJgQsWoB41fZMX4ZlHgSWPcj4AXz87qE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X0Guiy+L00MVY+s6S7uu0ZdQD+WJgztY
	J5u/HF4LJWQy3bwnhy30Ea6yYQfGpXjXdwed0nMYu3/P9h28sxWmx1DBoVhjl4bA
	SuCHNFdG9U+8a2B3fwr7JVOHmOGR99FehNeOWEIXbW4RJw7Q4vmY0Tcu+FOmdGsf
	VtSEsv+9gVE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CED78312;
	Thu, 13 Sep 2012 17:10:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94564830F; Thu, 13 Sep 2012
 17:10:42 -0400 (EDT)
In-Reply-To: <20120913210111.GA16956@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 13 Sep 2012 17:01:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A222994-FDE7-11E1-A3D5-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205422>

Jeff King <peff@peff.net> writes:

> I suspect we will end up with people not setting i18n.projectlang, and
> getting Klingon diffstats on the list.

Yes, but when our starting point is that the diffstat summary is not
meant for machine consumption, which I tend to agree, that is a
logical consequence no matter how you cut it, no?  After all, they
want to be careless when running format-patch meant for _this_
project whose project language is C locale, but still want to be
able to see output that is not meant for machine consumption in
their native language, and these are incompatible goals.

Giving them a mechanism so that they do not have to remember setting
LANG/LC_ALL every time they context switch into this project would
be the best we can do, I am afraid.

Unless somebody has a better design that does not involve three
languages (always C, project language and Klingon), that is.
