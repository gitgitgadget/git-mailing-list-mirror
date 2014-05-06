From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Use ref transactions for fetch
Date: Tue, 06 May 2014 11:40:28 -0700
Message-ID: <xmqq61lig38j.fsf@gitster.dls.corp.google.com>
References: <1398192327-21302-1-git-send-email-sahlberg@google.com>
	<53677483.4050409@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 06 21:58:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhkID-00012u-8o
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 20:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbaEFSkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 14:40:36 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63974 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752199AbaEFSkd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 14:40:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C8F2A13AFE;
	Tue,  6 May 2014 14:40:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fpe8QbCej8nk6w8h+pZTVBvqdbE=; b=bA4KRr
	W184C79Bq7lhUDSbI2tT8BzlAoGKnFzhlGE6sPohJ2dnCYgUB/48rVhUPus0iyxo
	8MFpQrtJWBsTRLesUpjz8DSY7llgxLosNenh7zxDYFc9L48l6EKLTqaiUnd6eGFV
	GAVxtZvdgfkBfcrkdo1DXgkxsLnv+b8xmmkyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vc6q+AkyOIkaT1vjUbBtNLkPuFV0v64/
	nN9HYwJM3obvK2NSFGOmvQgmw9tvrbpC2H8/02UOVWO6m/kbP2AimKOeTOeRF5wd
	O7wsX45e9faYUi82zaPNXFc/LgHSF1RhDr/4MEVtg5KqwRuAulkHumsoKibPJr+R
	xU/+JIqMM2g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA5D913AFD;
	Tue,  6 May 2014 14:40:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6425313AF9;
	Tue,  6 May 2014 14:40:30 -0400 (EDT)
In-Reply-To: <53677483.4050409@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 05 May 2014 13:22:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E64CB410-D54D-11E3-B1D5-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248228>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It would be pretty annoying to spend a lot of time fetching a big pack,
> only to have the fetch fail because one reference out of many couldn't
> be updated.  This would force the user to download the entire pack
> again,...

Is that really true?  Doesn't quickfetch optimization kick in for
the second fetch?
