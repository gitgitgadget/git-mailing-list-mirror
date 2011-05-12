From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fast forward a branch from another
Date: Thu, 12 May 2011 09:49:53 -0700
Message-ID: <7vfwojdfta.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=PtkDp8PNdMNi3hTwHPjFg+Jtftw@mail.gmail.com>
 <7vsjsjdhud.fsf@alter.siamese.dyndns.org> <4DCC0A4F.7000800@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Frederich <eric.frederich@gmail.com>, git@vger.kernel.org
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Thu May 12 18:50:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKZ5V-0005dS-Ip
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 18:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758049Ab1ELQuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 12:50:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758024Ab1ELQuC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 12:50:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A176C4D8D;
	Thu, 12 May 2011 12:52:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZR7n7N/f5o4KEf+s+aKKwLcE+SA=; b=o2JI4s
	t/9MKygW8VfINOnwI0ZQGMiKpx/IoayuBrD0KjDhduFa+I9FdAbIbWRV0DFmJ7KX
	V0GiUKTd9uwcmGN5EOIhE80qTnjuIEmQpJVPVZTSZmWtNvtmleEg7jy4BnLx5JZs
	Kv1iJqg2vyjMpJ6mBLvsXpjEXorPQ6gwzB/lM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HbATdTEht2UR4aniu9q9lg2h6KZhMGvY
	1nB/r9fnAVDaUx1aLqoFUmrt7lcV/4fPZrCE7GfNsLSqYUjpHJ38nvMSxc1nUxtZ
	uG4nWQ9N/ZTTuA2+LB5qCWy+83FncK/CUAgFy4qsYEtXXjgRZ7OqMloZ/tPj6LuO
	mDc8gTyzCvs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6C5894D8B;
	Thu, 12 May 2011 12:52:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4E7574D88; Thu, 12 May 2011
 12:52:00 -0400 (EDT)
In-Reply-To: <4DCC0A4F.7000800@cisco.com> (Phil Hord's message of "Thu, 12
 May 2011 12:26:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A1DA68C-7CB8-11E0-B4F8-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173483>

Phil Hord <hordp@cisco.com> writes:

> I don't see this feature listed in the git push [REMOTES] section.  Is
> it documented somewhere else?

Both "git help push" and "git help pull" will tell you in the "Git URLs"
section that a local file path is a way to name a repository.  Therefore,
you can say "git ls-remote $(pwd)" to list the the refs from the current
repository. If you are in git.git directory, "git ls-remote ../git.git"
does the same thing, so does "git ls-remote .".

These are merely specializations of more general "git push $path $refspec"
and nothing noteworthy.
