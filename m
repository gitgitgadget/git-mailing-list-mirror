From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] completion: complete "unstuck" `git push --recurse-submodules`
Date: Tue, 22 Jul 2014 14:17:13 -0700
Message-ID: <xmqqha29f606.fsf@gitster.dls.corp.google.com>
References: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
	<8303c95dd3e3ee8d77d4b994bb2d33b6a155a17f.1406053442.git.john@keeping.me.uk>
	<xmqqr41df8hu.fsf@gitster.dls.corp.google.com>
	<20140722205730.GD26927@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Jul 22 23:17:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9hR9-0004Jj-EW
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 23:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbaGVVRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 17:17:23 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57786 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932226AbaGVVRV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 17:17:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 19B442C33B;
	Tue, 22 Jul 2014 17:17:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BpLULhA3HMNxKH9M1Nq1ZpqmSo4=; b=mw9l0x
	+ghUhWXAkdc71nyPUDb9zOm/pbSfpJJXjCLPpXcwCMxUYcQYbKCmPEjTKVBlJNiR
	q1SXdIeVZBQNmOiQ1lde6A8Q+SHk0KNBXeqH7IMq0AVcpXa00anDvFf0EIBc37Pa
	zTu2jyCxGSgOJONAFs/Ey1O0/kEhPf3ohHHD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YaAG3cOgXcsNk5pyGwRlMK/zHdzYTdVm
	SCLyZKz1/X0XJE5mU5a4E8aQCs9IyiC4UUoL4Wf6SVWhi176VfDwc/vMZrRBWiNH
	l/xXMCPZiGg9iwk6zWvbgsT56I+1FrRZDaz7ca3WFp6lHrek7/F/RAgTBvaS2Oig
	RmNL5hNDd3o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0F56D2C33A;
	Tue, 22 Jul 2014 17:17:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DB29B2C329;
	Tue, 22 Jul 2014 17:17:14 -0400 (EDT)
In-Reply-To: <20140722205730.GD26927@serenity.lan> (John Keeping's message of
	"Tue, 22 Jul 2014 21:57:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8D9DFC6E-11E5-11E4-B09F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254040>

John Keeping <john@keeping.me.uk> writes:

> Makes sense.  I don't think I noted the order in the "$cur" case, I just
> put the new one in here so that they were sorted lexicographically.

Unless there is particular reason, consistently using lexicographic
order in all related places is one good way to organize things, but
doing so would involve flipping orders in the other case statement
for this particular patch.  In general, I prefer to see people add
new things at the end, when there is no particular reason to do
otherwise.

> Do you want me to re-roll with this change or can you replace the patch
> while applying?

I think I had to flip the third one to adjust to the change I
suggested to this; the result will be on 'pu', so please double
check when I push it out.

Thanks.
