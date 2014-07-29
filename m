From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 3/2] stash: show combined diff with "stash show"
Date: Tue, 29 Jul 2014 11:13:37 -0700
Message-ID: <xmqq1tt43uem.fsf@gitster.dls.corp.google.com>
References: <20140729115334.GA8976@peff.net> <20140729120732.GA9302@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 29 20:13:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCBuJ-000146-OD
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 20:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbaG2SNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 14:13:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64657 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268AbaG2SNq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 14:13:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D56B02C5D4;
	Tue, 29 Jul 2014 14:13:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eKGeF++vH0vjQkWp+jH8rLtFcbs=; b=vmD890
	cwVEWPSgrE7VJB9y9Flz65yzMJCFBUSLS8apYvV+C+80aZT0296l2kYKWr5/7c8e
	tHwFrXU1J3vjaDsDESTmkIkA4KZkT06UGBiDO8M/V2N9V6H7JwROyHocsBWSGihP
	8SBzYaZmpMOoZim0eZHCFB4kbK2tyzDSyY3vI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dfJ/1SLWL6Q7tC+h+toJAnmF3itbx+vA
	4unarJ5PwsHqfbrKperyRRsvnMvy+oCQDQ+s1c6U+e9Wga763EJDrPYAMBtnIU1Z
	01xpdCleqTzWW6VjBJcN11IWGwrL0S3SFaMOtAC9EMmzf786YAF87HsaLKvh9OJg
	D1Va+EEVsQ0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CAE822C5D3;
	Tue, 29 Jul 2014 14:13:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 883EC2C5CF;
	Tue, 29 Jul 2014 14:13:39 -0400 (EDT)
In-Reply-To: <20140729120732.GA9302@peff.net> (Jeff King's message of "Tue, 29
	Jul 2014 08:07:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 10DA955E-174C-11E4-9ED8-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254458>

Jeff King <peff@peff.net> writes:

> ... People might be doing things like "git stash show | git
> apply", and would want to ignore the index content ...

FWIW, that is exactly how I use "git stash show -p" most of the time.
