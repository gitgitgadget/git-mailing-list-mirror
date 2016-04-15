From: Junio C Hamano <gitster@pobox.com>
Subject: Re: possible to checkout same branch in different worktree
Date: Fri, 15 Apr 2016 08:36:31 -0700
Message-ID: <xmqqk2jydgu8.fsf@gitster.mtv.corp.google.com>
References: <CAJZYdzhG8h3s=Ep1fuGbam1cWhYkv0tW6tQ7pBGGj+fj6=Nrsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Rappazzo <rappazzo@gmail.com>
To: Reto =?utf-8?Q?Habl=C3=BCtzel?= <rethab.ch@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 17:36:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar5nZ-00045z-1I
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 17:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbcDOPgg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Apr 2016 11:36:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65455 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750924AbcDOPgf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2016 11:36:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CAB0311FC5;
	Fri, 15 Apr 2016 11:36:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LIPu1gRAvGs8
	i6C8mS/GoBdsoKc=; b=DyYAz1hwePUfT6PNs9I3HZp9RTD5TwGLSLzYXsfFTv4w
	EzHJI/IZFJWteFGLlzzaavCWc2p/gNHAMgWzjBFpAIHY2q8S7MYn91MEs4sK4rqC
	6n32wJwAds9Jk4rlOlRnSSIG4gfWDGUpdkQRWFQAbpPu+nbpEefgr3X9mtNh9Ro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=i8qI9A
	Q7z8MMPGq0Z+gjUap1Tm1kTgYbBG9JUH38T7Fb/kx11IvpkzF9ML2zeGwji7hMgY
	xragf+eq9AW1obqhGUh03mzrZYOKp3NpB+0gNOQCpfzdqrKoQGzxzuVFHm1r3L9A
	8iVkXPD0k9yXwmRlm51nCFOQK5l0UMT3pcyhQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C366511FC4;
	Fri, 15 Apr 2016 11:36:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4183611FC3;
	Fri, 15 Apr 2016 11:36:33 -0400 (EDT)
In-Reply-To: <CAJZYdzhG8h3s=Ep1fuGbam1cWhYkv0tW6tQ7pBGGj+fj6=Nrsw@mail.gmail.com>
	("Reto =?utf-8?Q?Habl=C3=BCtzel=22's?= message of "Fri, 15 Apr 2016
 15:53:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D4F0C31C-031F-11E6-B4CA-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291611>

Reto Habl=C3=BCtzel <rethab.ch@gmail.com> writes:

> the checkout command prevents me from checking out a branch in the
> current worktree if it is already checked out in another worktree.
>
> However, if I rebase the branch in the current worktree onto the
> branch in the other worktree, I end up in a situation where the same
> branch is checked out twice in the two worktrees.

I agree that any end-user facing subcommand like "git rebase", even
if it is not "git checkout", should refuse to work on and update a
branch that is checked out elsewhere.  Otherwise it will end up
causing confusion.

Thanks for a report.  The "multiple worktree" feature is still
highly experimental and those who are working on it would appreciate
your reporting issues with it.
