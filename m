From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git-users] Problem using detached worktrees with commands implemented in scripts
Date: Fri, 18 Oct 2013 15:43:52 -0700
Message-ID: <xmqqy55qurmf.fsf@gitster.dls.corp.google.com>
References: <201310162003.r9GK3UYj014414@freeze.ariadne.com>
	<xmqqeh7k51vg.fsf@gitster.dls.corp.google.com>
	<201310171909.r9HJ9mxd007908@freeze.ariadne.com>
	<xmqq4n8fzmmj.fsf@gitster.dls.corp.google.com>
	<201310182225.r9IMP4i3002659@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: worley@alum.mit.edu (Dale R. Worley)
X-From: git-owner@vger.kernel.org Sat Oct 19 00:44:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXIm1-0006lq-Tm
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 00:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757559Ab3JRWn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 18:43:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53757 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757067Ab3JRWn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 18:43:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB64D4BC64;
	Fri, 18 Oct 2013 22:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nTiJn71TZxPj+GJ3oLtkM1+KP0w=; b=PVeomQ
	yUOq9GBdBiRwCgkfjgRQz+hOVPIxBUKd/Uux89WTJt+/M3W20oRUtyEFA64i+vWF
	EBeEli39GfJBt5wUOUgroL/rCTjOoTJ+AOMY7zibRDX9Q4xEgKEeP0Qr9hTqRqmo
	ryejTzYTb6SktH65WlNosmVcPGP9fv+VhClzk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=flo7ptY3rFkKXZLHIp4wrRQriHO+wxf7
	imihYNc/QqX/KhJsOjIX4k8WTWAn9x6xqxsn+WUqrif0daQl7OSRIiMBS/HWLLkc
	keYu6oWPvI1br4wcTojvy2x/c4FBGbMeBJIE//N3x3KQLLVXYemsi5lMBK4c5MDB
	DDSGZES0JRU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFB614BC63;
	Fri, 18 Oct 2013 22:43:56 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F6E14BC5B;
	Fri, 18 Oct 2013 22:43:55 +0000 (UTC)
In-Reply-To: <201310182225.r9IMP4i3002659@freeze.ariadne.com> (Dale
	R. Worley's message of "Fri, 18 Oct 2013 18:25:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C4D92ACE-3846-11E3-8C82-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236375>

worley@alum.mit.edu (Dale R. Worley) writes:

>> From: Junio C Hamano <gitster@pobox.com>
>
>> 	Side note: without GIT_WORK_TREE environment (or
>> 	core.worktree), there is no way to tell where the top level
>> 	is, so you were limited to always be at the top level of
>> 	your working tree if you used GIT_DIR to refer to a
>> 	repository that is not embedded in your working tree.  There
>> 	were some changes in this area, but I do not recall the
>> 	details offhand.
>
> That's not true.  The core.worktree config variable tells the top of
> the worktree, so once you've located the repository, you know where
> the worktree is.

Read the second line again, perhaps?

> ... it's not clear why GIT_WORK_TREE exists, ...

The configuration item came _way_ later than the environment, and we
need to keep users and scripts from old world working, that is why.
