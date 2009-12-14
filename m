From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help.autocorrect: do not run a command if the command
 given is junk
Date: Mon, 14 Dec 2009 15:39:07 -0800
Message-ID: <7vaaxlcehw.fsf@alter.siamese.dyndns.org>
References: <4B263797.5070808@viscovery.net>
 <7v7hspjp3q.fsf@alter.siamese.dyndns.org>
 <200912142255.36949.j.sixt@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 15 00:39:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKKVk-0004Z5-OB
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 00:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704AbZLNXjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 18:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752307AbZLNXjW
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 18:39:22 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbZLNXjV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 18:39:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D2E0588ADF;
	Mon, 14 Dec 2009 18:39:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6cFLEWDsRl3WiXeFDC9ljLR5Lxg=; b=Wzbd2J
	yt9n7z+A5MHQ79ZsfyKcv6rg3ImtAdi41lGVNUEBR03En0Zn7ATBGI9Oj8HfX3nQ
	pKVgvHirRb/N0RgLtou8l7dLAPdKVi/YqvvTombUcSagze98avVszbMspGPWeI6L
	o496BHBeOOY55nXycrMPq9voW+uQd7rxIFduI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fW7kcvNzCkhHwqCdmybaf2bAz3ryZlPX
	cCHzZarPJdYRmQ06w/I9I5x7u5dWLlZWIo+lFskywoy2vYBQF4HVPXwYu3V37iZh
	bm+fLLI/QI36z27AOOiGDTW/KMLnXOI5OQvnMzCzPI5g9op2y0Uiz8bEAg7cZpg5
	Dgd/4QkqnF4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DA5088ADE;
	Mon, 14 Dec 2009 18:39:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D010C88ADB; Mon, 14 Dec
 2009 18:39:08 -0500 (EST)
In-Reply-To: <200912142255.36949.j.sixt@viscovery.net> (Johannes Sixt's
 message of "Mon\, 14 Dec 2009 22\:55\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E45F1042-E909-11DE-B014-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135255>

Johannes Sixt <j.sixt@viscovery.net> writes:

> On Montag, 14. Dezember 2009, Junio C Hamano wrote:
>> In the meantime, I think squashing the following in would help us keep the
>> two magic numbers in sync.
>
> I do not think that keeping the numbers in sync is necessary. For example, the 
> similarity requirement for commands that run automatically could be stricter 
> than for the list of suggestions. Then it would be possible that a unique 
> best candidate is not good enough to be run automatically; there would only 
> be a list of suggestions.

Well thought out.  Would you want to reroll a patch with two symbolic
constants then?
