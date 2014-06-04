From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9001: avoid not portable '\n' with sed
Date: Wed, 04 Jun 2014 12:01:59 -0700
Message-ID: <xmqq1tv4v6qg.fsf@gitster.dls.corp.google.com>
References: <538ED6DF.5020505@web.de>
	<xmqqr434vaeh.fsf@gitster.dls.corp.google.com>
	<20140604184604.GC14457@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jun 04 21:02:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsGRy-0002YA-2M
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 21:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbaFDTCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 15:02:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60686 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777AbaFDTCI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 15:02:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6C54D19FAB;
	Wed,  4 Jun 2014 15:02:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7GnQMGE5/ExObM1MhXj+EvIqEpA=; b=T+N03i
	dx0loAKCNjRrRcloS5ex1c9CyKlj0iJq8TOM+mUJWCYBn0sdowWkHIKAvg0ZTeGh
	YiH+3mg2oxtSGhzeoYhHHrbHgtnHUasgbBP+E113LNABnO4OTCuLALcCZv0wLVV+
	zDpN/almB7MW4LhYO1AxeajK0GymkDjvcYG98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j1upz6HALJ6pKpa1R8ka7BM7UyIDzAuW
	DBCZSy81nYtzf56c0jMb2T9QZkBCJ91nD8VKtrWZYJNqrklcsUQAvoEZghAghGA6
	eO71kjELO8p3mKRcJABJx8+hH3gIAFlEmFSaWpZ26jXAgyO2LeGa5B4ouzjnYxHm
	EO/bgmZlotY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 62B5519FA8;
	Wed,  4 Jun 2014 15:02:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F21C519F91;
	Wed,  4 Jun 2014 15:02:01 -0400 (EDT)
In-Reply-To: <20140604184604.GC14457@serenity.lan> (John Keeping's message of
	"Wed, 4 Jun 2014 19:46:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B63D51F6-EC1A-11E3-99E3-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250771>

John Keeping <john@keeping.me.uk> writes:

> Note that quoted section of POSIX says "embedded in the pattern space";
> under the description of the "s" command, it says:
>
> 	The replacement string shall be scanned from beginning to end.
> 	[...]
> 	The meaning of a <backslash> immediately followed by any
> 	character other than '&', <backslash>, a digit, or the delimiter
> 	character used for this command, is unspecified.

Very true.
