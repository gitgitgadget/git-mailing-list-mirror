From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Add log.abbrevCommit config variable
Date: Tue, 17 May 2011 14:50:21 -0700
Message-ID: <7vtyctf142.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=og+e6JW8t+sCvkFJUnR=SrFtWGg@mail.gmail.com>
 <1305413341-56450-1-git-send-email-jaysoffian@gmail.com>
 <7vei3zoab9.fsf@alter.siamese.dyndns.org>
 <BANLkTi=iFgJ12=_amoxT8x+hNMEhQtOVBg@mail.gmail.com>
 <20110516070047.GA26270@elie> <7vei3xgsy3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 17 23:50:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMS9y-0004h3-Ok
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 23:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481Ab1EQVu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 17:50:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61027 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932445Ab1EQVu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 17:50:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E13354F17;
	Tue, 17 May 2011 17:52:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dldqyntioI8jgHXWDNxIsmCwc/s=; b=DfFqaL
	HaqPibh6tOD6fWiOhCcYflaf1A5debqtyklF8g6UfRY6EAZZCS9jXjyI+g64qEUz
	AHtRQ5R41/MIVPm7XCtuZ6xWmbNLpvZ2ZNav2ULFFREzHg6X4aNc+QpNebgLFB8o
	TGW2/UEqPpt/tnO4cLZHEvknWdtA8vPMabfl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ij1dBqCfgi1kRppz8dFgXYGgpMPAKJ24
	SNOV/1QpH+464PlKHVXpzWMHK1wweXP3cBRvbCYOWq/Ru57UGoWGrUGO5NcBQIol
	eljL7lsiH+Qxv+veEGhWRQiahrlGNjA2Hc/lHzqjGwZZ0Za9zd6ZSyiUOsD2CHv0
	CQGolpQp6kw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A5A5A4F0E;
	Tue, 17 May 2011 17:52:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CD0AB4F0D; Tue, 17 May 2011
 17:52:29 -0400 (EDT)
In-Reply-To: <7vei3xgsy3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 17 May 2011 10:03:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F7DA4114-80CF-11E0-B1DF-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173826>

Junio C Hamano <gitster@pobox.com> writes:

> But having slept on this, I would agree that it is a pragmatic solution to
> declare "pretty=raw _is_ special" and keep it that way.  Let's queue v3
> from Jay and see what happens.

Having looked at this a bit more, there seems to be a special case in
cmd_log_reflog() that the command wants to default to abbrevCommit.

I haven't applied v3 (nor my fix-up in the discussion) yet, as this is not
my itch, but have you tested all commands from "log" family with your
patch, including "git reflog"?
