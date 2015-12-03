From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Split .git/config in multiple worktree setup
Date: Thu, 03 Dec 2015 11:52:43 -0800
Message-ID: <xmqqpoyntilw.fsf@gitster.mtv.corp.google.com>
References: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
	<20151203061505.GA4314@wheezy.local>
	<CACsJy8AOeFEKhhmH-TCK6gWZQAJX0kbTS0-=iyCji9eXwBr9QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Max Kirillov <max@max630.net>,
	Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 20:52:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Zvv-0002XA-3n
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 20:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbbLCTwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 14:52:47 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753233AbbLCTwq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2015 14:52:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 369D22EB01;
	Thu,  3 Dec 2015 14:52:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Glq+qren7GVAteDfBaxhjZ9klvY=; b=mVyM6n
	f7aN/Q/P+iK6b1Inx2WdG/X1CMvVWOwd5rgql+P527xPX+zMWsX2yyN786s6sCR0
	TYxk0WyW8x9vHzB3nUzVGIZ6nBLMf3PiBnSNIm9kkcw1Yx/IjDMzWMGJkHRUgvRT
	q99BJhDeUn21QxeOdcx0gasKH0UnmrxiNZ9CE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cnOZtI5v9if6Vs/Bs6dYcmg+Sus0Ie7q
	TECwdvE/tuPM04Sc6JcZRUPN0N53f0y+clnl+zEyXThKWbk3/cDOSN7zdncPJFvr
	0QyLedFvZauRyyxuGdy2puwRMxLitPNEVgVEocHARLPBZoBNlBnQTB/rV0iEjKVA
	gFO3PiPVOLY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2D9C92EB00;
	Thu,  3 Dec 2015 14:52:45 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A858F2EAFE;
	Thu,  3 Dec 2015 14:52:44 -0500 (EST)
In-Reply-To: <CACsJy8AOeFEKhhmH-TCK6gWZQAJX0kbTS0-=iyCji9eXwBr9QA@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 3 Dec 2015 09:07:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6BAB198E-99F7-11E5-BCCB-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281964>

Duy Nguyen <pclouds@gmail.com> writes:

> If a variable _must_ be per-worktree or something will break, then it
> should belong to the builtin list (so the user is less likely to mess
> with it). If it may or may not be per-worktree, depending on one's
> preference, then we can keep this in info/config.worktree. I made the
> builtin list for that reason (user not breaking stuff accidentally)
> and another one, which is upgrade issue. Suppose you introduce a new
> per-worktree variable in the new git version. If it's in the builtin
> list, we don't have to update every repo's info/config,worktree.

I agree with your reasoning to have built-in set of files that are
per-worktree. I actually prefer *not* to have any configurability
to avoid confusion between users.
