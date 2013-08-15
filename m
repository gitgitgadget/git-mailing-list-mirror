From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 3/3] status: always show tracking branch even no change
Date: Thu, 15 Aug 2013 15:56:37 -0700
Message-ID: <7vvc36o95m.fsf@alter.siamese.dyndns.org>
References: <6bc0643a5fa0fae03be6fdb59f63075be1e4d983.1376590264.git.worldhello.net@gmail.com>
	<7vbo50uvty.fsf@alter.siamese.dyndns.org>
	<224af6e4fce9004aa50ea0c11c703107857c46f0.1376590264.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 00:56:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA6TF-0007Fo-IC
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 00:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306Ab3HOW4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 18:56:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45109 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024Ab3HOW4k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 18:56:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 310C6390A1;
	Thu, 15 Aug 2013 22:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mTB0+o9yQqJfY3kMRVH9HA3smBc=; b=QUbH4C
	rYhJm84OuvpAN8uSkVLC9ToT8ReT6E48wm2fS6VzemrZYxbTjRKn9oopaW7E5iz0
	I1NfVIG9gCn5ZV6Cc1Eg/qH7/M3UzsVaYlY5wzanqCcyE2pAszqc9HQ3bPRVkyXX
	RrAEVqsEDSS0jKRQdpSQBH5+ksjpuE6wcdPDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cARRBV56YEobjrze/11wOkcRcxc2yKan
	dmn4yh9f/iT88jlgQHrpoK+kKlIFL7n3TDagLFkIahIm0hNPxctxhgfJeorDajk/
	QZAdmdYq4gJRld+exd4FFUbseRt41SrlSfYT2F3KekxvpWCZ1r368A960R3JEWHr
	cjeY3MTJno0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2465E3909F;
	Thu, 15 Aug 2013 22:56:40 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62EFD3909D;
	Thu, 15 Aug 2013 22:56:39 +0000 (UTC)
In-Reply-To: <224af6e4fce9004aa50ea0c11c703107857c46f0.1376590264.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Fri, 16 Aug 2013 02:11:23 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1E08F60-05FD-11E3-A0DD-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232386>

Jiang Xin <worldhello.net@gmail.com> writes:

> In order to see what the current branch is tracking, one way is using
> "git branch -v -v", but branches other than the current are also
> reported. Another way is using "git status", such as:
>
>     $ git status
>     # On branch master
>     # Your branch is ahead of 'origin/master' by 1 commit.
>     ...
>
> But this will not work if there is no change between the current
> branch and its upstream. What if report upstream tracking info
> always even if there is no difference. E.g.
>
>     $ git status
>     # On branch feature1
>     # Your branch is identical to 'github/feature1'.
>     ...
>
>     $ git status -bs
>     ## feature1...github/feature1
>     ...
>
>     $ git checkout feature1
>     Already on 'feature1'
>     Your branch is identical to 'github/feature1'.
>     ...

The sentence that began with "What if ..." never completed?
