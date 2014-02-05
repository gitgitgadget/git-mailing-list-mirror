From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Bug] branch.*.merge interpreted too strictly by tracking logic
Date: Wed, 05 Feb 2014 13:10:42 -0800
Message-ID: <xmqq38jx2rl9.fsf@gitster.dls.corp.google.com>
References: <xmqqa9e67atv.fsf@gitster.dls.corp.google.com>
	<20140205205030.GA16394@sigill.intra.peff.net>
	<xmqqbnyl2run.fsf@gitster.dls.corp.google.com>
	<20140205210831.GB16753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 05 22:11:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB9kn-0004As-Ow
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 22:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770AbaBEVLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 16:11:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59645 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932680AbaBEVKp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 16:10:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DE2D670C0;
	Wed,  5 Feb 2014 16:10:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8HLjf11sLR32rsLcrPUdpP4JFo0=; b=U8PMCp
	3hRXXqV4x1EH6UMcw3gkHjzhylaBbyATQAQWrYz8Wp3kyhy4cP2GTvK1FMblspt4
	Gp+W1jbClgIVWyAue3gbEGx5U4WeKpXlY4FoJfHBsv67U7C1KJfOaoyx8TxCJrDH
	LD3uLZMTzxsmu9UsFh9jYRszDQBqBDxCWqciI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CdkK0sRaNxaMpLLDgXq8cP4sTLGidQMC
	dtd0Ch9tLElcwoZcvR62hpcdNC0kjE2HZxcr7tV8XduME3FOFJXTwEjgpxkKsluR
	azDb6Qvhwe2FwBuULdDewyGG85Igf/FoBbeXyqZdLq7p1r/7w7cP+I9ScaxV3sfe
	IweAK5Rroec=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D67D670BF;
	Wed,  5 Feb 2014 16:10:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DD02670BC;
	Wed,  5 Feb 2014 16:10:44 -0500 (EST)
In-Reply-To: <20140205210831.GB16753@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 5 Feb 2014 16:08:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F9D3F722-8EA9-11E3-BC90-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241667>

Jeff King <peff@peff.net> writes:

> .... Did your report come
> out of a real case, or was it just something you noticed?

Some git-wrappers (like "repo") are reported to muck with the
configuration files.
