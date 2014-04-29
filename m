From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/27] Use ref transactions for all ref updates
Date: Tue, 29 Apr 2014 14:41:24 -0700
Message-ID: <xmqq4n1bke4b.fsf@gitster.dls.corp.google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:41:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfFmP-00046y-88
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 23:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757589AbaD2Vl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 17:41:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36577 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365AbaD2Vl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 17:41:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5426B7FDD8;
	Tue, 29 Apr 2014 17:41:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=aHVRqbGwV4zznWwMqCw1jVnenL8=; b=HM8JfUOWxMk5kb/jJsWj
	6+5NoCZEuCf6zfnaeia1ObY8oEeawal09iRWnFR1nHQoYX1VS+Qd7E6CB6RCr0on
	ga0rHomnW9XN6zI0yUewtEbklQA/ySY+Nh1DESB9X7XFu/AZx3CZ7EcuWIcwAUGm
	1PcGXJ9mYRmGey1YohO6GoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Pu4jwMIGdR7Z6kq4nV+WEgAyeyyp4xNc+pf29vjkIrVsaQ
	XG/+TvXVkPQT4/M1HM2OK1R69DJwcBAPJhqvGehjSUIBSpX8/TPz3/d9GsjYWGOI
	6e9gfbS4O95zBYCjhGXou+funowtIrTcZTVvYRwshU9AWtm0QgmIo+/YCEWx4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DE167FDD7;
	Tue, 29 Apr 2014 17:41:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50AC97FDD6;
	Tue, 29 Apr 2014 17:41:26 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 040D2EBA-CFE7-11E3-B363-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247610>

Ronnie Sahlberg <sahlberg@google.com> writes:

> This patch series is based on mhagger/ref-transactions and expands on the
> transaction API. It converts all external (outside of refs.c) callers to
> use the transaction API for any writes.
> This makes most of the ref updates to become atomic when there are failures
> locking or writing to a ref.

I think I saw some more comments to be addressed on this round, but
I'll try to push it through into 'pu' by attempting to resolve
conflicts so that I can ask you to eyeball the result.  This series
seem to conflict with your own rs/ref-update-check-errors-early
topic that is already in 'next'.

If I screwed up the conflict resolution (which is very possible), I
may have to ask you to rebase this series on top of acc62aa (which
is the merge of rs/ref-update-check-errors-early to 'next'), but I
am hoping that conflict resolution I'll push out today will be
correct.  We'll see.

Thanks.
