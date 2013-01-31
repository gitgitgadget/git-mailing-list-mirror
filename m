From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] branch: let branch filters imply --list
Date: Thu, 31 Jan 2013 09:02:00 -0800
Message-ID: <7v4nhxi8vr.fsf@alter.siamese.dyndns.org>
References: <20130131064357.GA24660@sigill.intra.peff.net>
 <20130131064611.GB25315@sigill.intra.peff.net> <1504250.y8BAS4sG2O@al>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Peter Wu <lekensteyn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 18:02:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0xWt-0000N2-Bi
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 18:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577Ab3AaRCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 12:02:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51948 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485Ab3AaRCD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 12:02:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DDC2B4C7;
	Thu, 31 Jan 2013 12:02:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4AMyJc4VsQhE2m05gVcgTniF/zw=; b=k2Cp+c
	XDPdrnaAzneMd0GSHiHgxiHjiRvreh07Nb40E1HLrCYugHdjK8HLrI2WlNrqHXL0
	VOWL8hH1yu1R0emQGbISbN6ATrtr/L0IaSR7ZSdF4ZqDEgxtdP9ub4NrXMSy4MDC
	0T4UeoSBAm98ZzI6dTdr/qcnKGKzTrCYy/fIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vX5CPZ00Clbl7KCjPVkGtwammHeSDOvg
	IgCI3sQ1HhEfA14dR7rdkLppu21EOuqmFSi1V/CMpZqL/9myu2Nu+muiwQFRkSUb
	jtP1JXTn8zSDcGfj4JUNPAg0x2bqfgoE3i/J0wrqtxkWWu83/Ka1aQd6nFvVjoqD
	LF+WxvsaImI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22723B4C5;
	Thu, 31 Jan 2013 12:02:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 870F2B4C4; Thu, 31 Jan 2013
 12:02:01 -0500 (EST)
In-Reply-To: <1504250.y8BAS4sG2O@al> (Peter Wu's message of "Thu, 31 Jan 2013
 17:13:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE52F598-6BC7-11E2-9761-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215126>

Peter Wu <lekensteyn@gmail.com> writes:

> One note, the following command spits out master without complaining about the 
> non-existing branch name:
>
>     git branch --contains <id> master <non-existant branch name>
>
> (the order of branches doesn't affect the result.)

That is perfectly normal.

What you gave after "--contains <id>" are *not* branch names.  They
are patterns against branch names that fits the given criteria (in
this case "--contains <id>") are matched, and the branches that do
not match any of the patterns will not appear in the result.
