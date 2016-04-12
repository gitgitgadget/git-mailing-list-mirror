From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/1] contrib/subtree: Add a test for subtree rebase that loses commits
Date: Tue, 12 Apr 2016 16:27:28 -0700
Message-ID: <xmqqpotummqn.fsf@gitster.mtv.corp.google.com>
References: <CAPig+cS6ouc+kdJaz10M2AApPoDODDcgDX9Azz8ih=4zxxD2zg@mail.gmail.com>
	<3eb25268597083cdb10303e3d5790302e719a803.1453172369.git.greened@obbligato.org>
	<xmqqsi1tbh68.fsf@gitster.mtv.corp.google.com>
	<87wpr4ubzo.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com,
	davidw@realtimegenomics.com
To: greened@obbligato.org (David A. Greene)
X-From: git-owner@vger.kernel.org Wed Apr 13 01:27:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq7iZ-0003iO-BK
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbcDLX1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 19:27:31 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:65422 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933934AbcDLX1a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 19:27:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B97E45527C;
	Tue, 12 Apr 2016 19:27:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6I74hbrEhowao1rw5ut8LPQnUGY=; b=lvlDeV
	NKv/fCQoB3sZOc6TMj2XkX/WCmrJMg0JxfC1BLf5s+euIt1UrnKUgvBvywh47B74
	WcCD+STF3UeYfKmTAImujr+pIB+vP9jqfYxUGhlgT+t/CPxaKITOqpwNC+Fxn15S
	qAso64eSi0c14fH6rtLwfpZlms0czendySTJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AAaI2zYc5pusS0Kxitbx6n5AmUQW9YV4
	M5jDDoz3Hv2y+L+DeRRx5hw1bvUUdy/HuQW0XHG3ZfrHQaMvlMZYyuXZGrPllEPL
	pfCPZ/raaR4DnUxA+bFeiUCBbyRCM4DjZFa/J8ef1pPSZ6u7F9ywREe03JHkentO
	hW2LSHRxZ8w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B1E155527A;
	Tue, 12 Apr 2016 19:27:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3106C55278;
	Tue, 12 Apr 2016 19:27:29 -0400 (EDT)
In-Reply-To: <87wpr4ubzo.fsf@waller.obbligato.org> (David A. Greene's message
	of "Tue, 19 Jan 2016 22:10:51 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1F8CAC0E-0106-11E6-831F-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291326>

greened@obbligato.org (David A. Greene) writes:

>> I also notice that files_subtree/master4 does not appear in any of
>> the verification in the three tests that use the history being
>> prepared here, i.e. if master4 is silently dropped while master5 is
>> kept, such a bug won't be caught by them.
>
> Ah, good catch.  I should add a test for that.
>
> Let me do a re-roll of this since I think you bring up some excellent
> points.  Might be a few days due to work obbligations.

A friendly ping to see if I missed anything that happened after this
message...
