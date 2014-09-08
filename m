From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v2 1/2] Makefile: add check-headers target
Date: Mon, 08 Sep 2014 11:56:57 -0700
Message-ID: <xmqqiokylz46.fsf@gitster.dls.corp.google.com>
References: <1410049821-49861-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 20:57:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR47d-0008PV-0Z
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 20:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbaIHS5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 14:57:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60781 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752994AbaIHS5A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 14:57:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 72AA837281;
	Mon,  8 Sep 2014 14:56:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Aw0cJ2emAATf5fUIQEJSVDPaaGw=; b=CO58xW
	DjzpR90uLepJhGbfiVukLXlKJU2DvTG2jzUBVV8bNbu4a9J21LK2402Y30bo/5KP
	5Cr3rbg2P+d5fUqdJu7NHJhwU4yI8o8ASGGmRHnCHYG+aVDBwQRsnc9T3097Lxmd
	qErmJVynIhA5LqWBVs1KAn5Ai+WUhPV8Q9k8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ySMxAuMiK/akT0oIW4hIBZdtvbNCJEHV
	KUhePtLIgs+a82OrUp/fDqhfBWxmVmXOkB2+o/kQphyy1lmZtys9oMUn4c12w66/
	OmMU6s2LXdLws/prDtgJVOQYeJ8O2ndeyF6PtAAa2CYZult1SWhsEIC4R30JmPik
	XdiBdcQKyyw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6991F37280;
	Mon,  8 Sep 2014 14:56:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DF0353727F;
	Mon,  8 Sep 2014 14:56:58 -0400 (EDT)
In-Reply-To: <1410049821-49861-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Sat, 6 Sep 2014 17:30:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E920CACA-3789-11E4-BEC2-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256669>

David Aguilar <davvid@gmail.com> writes:

> +IFS='
> +'
> +git ls-files *.h ewah/*.h vcs-svn/*.h xdiff/*.h |

Hmm.  This is only for true developers (not one who merely compiles
after expanding a tarball), so "git ls-files" may probably be OK.

But "/bin/ls" would be equally fine for that, no?  After all, you
are letting your shell to expand the wildcard, and a developer would
want to make sure his new header is kosher before running "git add"
on it.
