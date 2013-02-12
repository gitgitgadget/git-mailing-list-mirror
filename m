From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Fix installation paths with "make install-doc"
Date: Tue, 12 Feb 2013 15:16:15 -0800
Message-ID: <7va9r9dsxs.fsf@alter.siamese.dyndns.org>
References: <cover.1360700102.git.john@keeping.me.uk>
 <20130212222508.GG12240@google.com> <7vmwv9ducx.fsf@alter.siamese.dyndns.org>
 <7vip5xdtt6.fsf@alter.siamese.dyndns.org> <20130212230600.GB22779@river>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Feb 13 00:16:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5P5h-0005db-89
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 00:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758925Ab3BLXQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 18:16:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45727 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758863Ab3BLXQS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 18:16:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67F5BB80F;
	Tue, 12 Feb 2013 18:16:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5mo1pMAdiYkAoYWkUtw8S6LjWf4=; b=e4TgjI
	bo9UP0w79mRslaA0DzshCSG50JL4lwVUPNM8yXTQArEEi+DL43UryorzQcgdAU5i
	Q+CcL/4W2v6qZ5r94MsRkIFRY+pgEGjoAoDpsrGs7L4LQ2bbW82+sXhU/J2eCl1S
	YIFjEJV5M9F4hIAEcfRnWp7zaU6qm0Syim+mM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tABzbFuU0W5dcOGmD/nGRIdP5tOppoUu
	0hl/p8jwaSSAoB7KkWGbUeCQoiaG4ZBhriVUyzpsu6JXAyvVMiRtNPTlNT3FUuiV
	IdT4lrkqmcXZdWAlrlSlekwbH+NA/kMf2idrLcjtzORkUKjtvaQcnrrrt9ZzklVP
	Z8ZURoKQnPI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 502B5B80D;
	Tue, 12 Feb 2013 18:16:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C35DAB806; Tue, 12 Feb 2013
 18:16:16 -0500 (EST)
In-Reply-To: <20130212230600.GB22779@river> (John Keeping's message of "Tue,
 12 Feb 2013 23:06:00 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 33A70160-756A-11E2-AD12-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216220>

John Keeping <john@keeping.me.uk> writes:

> Looks like it - I tried this for the first time today (with pu) so I
> didn't realise it was a recent change, and I didn't think to blame the
> export line.

Unfortunately that bogus change is already in 'next', but luckily we
caught it before it graduated to 'master' ;-)

I'll queue the regression fix patch (already sent separately); the
patch should bring everything in Makefile back to the same state as
in 'master', so in that sense it fixes the regression, but it does
not address the real cause of the confusion, solution to which is
hinted in the log message of the patch.

Thanks for catching this.
