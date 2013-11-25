From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git issues with submodules
Date: Mon, 25 Nov 2013 12:53:45 -0800
Message-ID: <xmqq61rgxkx2.fsf@gitster.dls.corp.google.com>
References: <CALkWK0n7jdLKOAFoFjuRz0aTCssorAgk2y=Vce76Y5aHWbj53Q@mail.gmail.com>
	<CAErtv27dMepNSbBVdOokn6OF858ENaKooL+FzD7JHtp9nRPufw@mail.gmail.com>
	<CALkWK0nDME-z7G4kcag=ad3qH5FL9FawrYFyVLQB6Z_g+TV+vQ@mail.gmail.com>
	<20131122151120.GA32361@sigill.intra.peff.net>
	<CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com>
	<CALkWK0m9MK=RBBor-ZeGrGU9KA6tZa89UUi0J7j9fxr1g6uJtQ@mail.gmail.com>
	<CAErtv24Lv1JegCBQ=TXvOsgBNHp=Rphk5YVAq2qqRbNmqfNSkw@mail.gmail.com>
	<CAErtv24P+wyZKvvuuPJJ0oxzMif7XtOwJDtKcTKQdKHZaAUbig@mail.gmail.com>
	<CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com>
	<528FC638.5060403@web.de> <20131122215454.GA4952@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sergey Sharybin <sergey.vfx@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Nov 25 21:53:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl3AK-0008KF-7j
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 21:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665Ab3KYUxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 15:53:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45439 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709Ab3KYUxt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 15:53:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52B0C5396D;
	Mon, 25 Nov 2013 15:53:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6coV9Leji0Ko33kn+f6grGcLm0k=; b=Shb9oF
	DoYlgxopTybl36X/CulnKPtw+DXSZZq8AlgyVwMcajukTVRplLxvojAp3tblgB4P
	KWQsa15C8ZPPtH3OLkU8eeBkF412Hzq+X7mmMah6r0mewaDWX8yhZP2Rg9CgF1ts
	zFqL++CAvviD5T8eSo3faNm3d/tLdXPNdqJc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ec7NVjwlra7ycxCePARbCmPXaJ3BfB8E
	H6/A7Jp0bAXbZK+6rga4ktxPiPS4crKtyzBn0wM86r2MIV40gxQOnX8onGUpWlpZ
	Easal3oqUqOBF+b0kynHgIAZvdGxAQqdYFM75QDQecXNbkWFFREQadji00nbSt1v
	TzgFrqvEPJI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 434EB5396C;
	Mon, 25 Nov 2013 15:53:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 863F253969;
	Mon, 25 Nov 2013 15:53:47 -0500 (EST)
In-Reply-To: <20131122215454.GA4952@sandbox-ub> (Heiko Voigt's message of
	"Fri, 22 Nov 2013 22:54:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AE0B4530-5613-11E3-A1BE-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238348>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> What I think needs fixing here first is that the ignore setting should not
> apply to any diffs between HEAD and index. IMO, it should only apply
> to the diff between worktree and index.

Hmph.  How about "git diff $commit", the diff between the worktree and
a named commit (which may or may not be HEAD)?

> When we have that the user does not see the submodule changed when
> normally working. But after doing git add . the change to the submodule
> should be shown in status and diff regardless of the configuration.

Yes, that sounds sensible.
