From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Worktree "gitdir" file being mangled after upgrade to 2.7.0
Date: Wed, 13 Jan 2016 18:36:16 -0800
Message-ID: <xmqqh9iglwf3.fsf@gitster.mtv.corp.google.com>
References: <20160113234753.GA26473@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Erik Johnson <palehose@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 03:36:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJXlx-0000cZ-Go
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 03:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295AbcANCgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 21:36:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58454 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752023AbcANCgT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 21:36:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C28F83C005;
	Wed, 13 Jan 2016 21:36:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PqT38vE8i178/Kz/OADUX4UgY8Q=; b=NmH3vh
	uQv9A8PVtQapYzKy+lb8Xf1N2113rvgI7ieWm/aORJRntfXtA6qNTwqqkXx+yyA/
	HAMEEGI5736060c3UouRHLX2OWfkxuTkvEdXklx8YbA4yEQbNxzIiVG6qf/3mMkn
	1Ej7+YtZ4zXuFQqmdBOc0VJjdv8oIliP1u2HA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nai1qR7Zumz6932ckpwDUiXnl44HIUxN
	roGipXjWnFltkuhWEUgHztDPTNPTPrV6H/WO1g9H+lFQriiwpfD2/aGKLCZevUxx
	f6wz4Q4hsuc3VavsvU5z6hmDXVBw9r/V5gW1x35xROrdo8OoZTOSlaJdc/VPRBPx
	yM0qxzT9O9U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA5E13C004;
	Wed, 13 Jan 2016 21:36:17 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 366153C001;
	Wed, 13 Jan 2016 21:36:17 -0500 (EST)
In-Reply-To: <20160113234753.GA26473@gmail.com> (Erik Johnson's message of
	"Wed, 13 Jan 2016 17:47:53 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 966631FA-BA67-11E5-A231-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284000>

Erik Johnson <palehose@gmail.com> writes:

> Since upgrading to 2.7.0 last week, eventually I'll get to a point when
> I run 'git worktree list' where several worktrees are incorrectly
> reported as pointing to my main git checkout. Further analysis of the
> files in $GIT_DIR/worktrees/worktree_name/ shows that the gitdir file
> for the worktrees which display incorrectly contains ".git" instead of
> what it should contain (i.e. "/path/to/worktree/.git".
>
> This was reported a couple days ago on Github:
>
> https://github.com/git/git-scm.com/issues/650
>
> Since the audiences for the mailing list and Github don't overlap
> completely, I figured I'd report it here to get this issue in front of
> as many eyes as possible.

Thanks for relaying.  Duy, Michael, I think this is your area?
