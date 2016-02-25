From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv17 00/11] Expose submodule parallelism to the user
Date: Thu, 25 Feb 2016 14:26:43 -0800
Message-ID: <xmqqoab4mnoc.fsf@gitster.mtv.corp.google.com>
References: <1456369618-18127-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	sunshine@sunshineco.com, jrnieder@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:26:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4N1-0006Jy-De
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbcBYW0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 17:26:47 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64206 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751030AbcBYW0q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 17:26:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 889DA487CD;
	Thu, 25 Feb 2016 17:26:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gXYpBDe8PCU0Uk1yqqwU6tCvx5A=; b=cxKzyA
	EgAHwPhoA+EtDuy56a6Ev5Z73ZMu7tTTRykPcip/PZdfiywjVQuRkBXP2blxiGit
	PBtmWMKJRWdQsW3aV+gT5dGD4p9nbrDvNEMW9Fh6Vtcz89wruuSYBcFLacbhqWMj
	CmvKfB6JkpCSRiEjlWh3CQyzOeCaJaVq+Dxhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hkib2UK98RGxTiFigAJEj70dAphuR8TM
	BA8XwMrO70OzVkTHpPPjRylkCOV7ytX7SEl4dkg1GjMPROJoHAdkw2+BxjWyBSJ3
	DtCMbjUm2mMNku4fujzBmjIU1B6UXYVaHhqF3fISEw06/oObVkWhTGR93JlCiah5
	VXshTQqN0Bs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7F6C2487CB;
	Thu, 25 Feb 2016 17:26:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D227C487CA;
	Thu, 25 Feb 2016 17:26:44 -0500 (EST)
In-Reply-To: <1456369618-18127-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 24 Feb 2016 19:06:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D9F13276-DC0E-11E5-90BA-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287447>

Stefan Beller <sbeller@google.com> writes:

> This replaces origin/sb/submodule-parallel-update and applies on
> origin/sb/submodule-parallel-fetch.

This round, when applied directly on top of 62104ba1 (submodules:
allow parallel fetching, add tests and documentation, 2015-12-15),
seems to break 7400 (43, 45, 78) and 7406 (3-5), at least.
