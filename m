From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tagging  a branch as "not fitted for branching" ?
Date: Mon, 28 Apr 2014 16:34:41 -0700
Message-ID: <xmqqoazlm3ji.fsf@gitster.dls.corp.google.com>
References: <535E4507.2070805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 01:34:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wev4W-00049a-58
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 01:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbaD1Xer convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 19:34:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52324 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753252AbaD1Xeq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2014 19:34:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8139681EFA;
	Mon, 28 Apr 2014 19:34:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xbSzs1CWAIf2
	3jV2mou0mvDkqGs=; b=OqQlVmvkTOwP917NVVIF2iOYNplexVs217nqqhjG8MmA
	wAnifKBt+/8iT+sHtsVw9OjbBZFy6jSvZPjPlDgQ3JIQ1lyjbusi/7P79pKHEVQb
	65tJRCbMoG55tLOrWBt8bZlvyE/nZvzj2Mv7PeWctf5t3m+tXTRj0iy838IrGdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JKd5Fc
	ANmq7ittH9LNnLjXgEfwqyAediLEeeyzG71j6ykidTG5IiGxzdoMY0zpZ0MPCEnV
	OOsM1yLtINPCFrPbP5vTj9urNS0LJuvTVl/kvFGAdSJcymA1/5zrNwz2wICSbC7X
	G25YV9SLiBrhCTaOy7dSVCe+zOE7buGPWvkHw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6764D81EF9;
	Mon, 28 Apr 2014 19:34:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5032681EF7;
	Mon, 28 Apr 2014 19:34:43 -0400 (EDT)
In-Reply-To: <535E4507.2070805@gmail.com> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 Avila"'s message of
	"Mon, 28 Apr 2014 14:09:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ACF5A602-CF2D-11E3-BAFD-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247495>

Jean-No=C3=ABl Avila <avila.jn@gmail.com> writes:

> Most manuals on git state that it is bad practice to push -f a branch
> after have meddled with its history, because this would risk to upset
> the repositories of the coworkers. On the other hand, some workflows
> use branches to propose modifications, and need some rewritting of th=
e
> history after some review steps. In this case, the branch should only
> be seen as a mere pile of patches. Having this two-sided discourse is
> often misunderstood by casual git users.
>
> The proposed solution would be to be able to flag the branches with a
> special tag "not fitted for branching" that a collaborator could use
> when pushing it. This tag would be passed on to any pulled
> remote. When another collaborator would then issue a "git checkout
> -b", the command would fail with a warning message, unless forced wit=
h
> -f'.
>
> Is this feature already present? If not, would it be of any interest?

Since nobody seems to be responding...

I do not think there is anything like that.  I am not personally
interested in it very much without seeing much details on how we go
about implementing such a feature.  Note that I am not speaking on
behalf of the project, or as its maintainer, but just as one of the
active contributors to the project, so my "not interested" is in no
way final.

There are ways other than "checkout -b" to end up having your
commits on top of a forbidden commit.  Are you going to cover all of
them and at what point?  You may rebase your work based on 'master'
(which is not one of these forbidden branches) onto it.  You may
start your WIP on top of 'master', realize that you need something
that is cooking only in 'pu' (which is a forbidden-to-be-built-on
branch), and then do a "git checkout -m pu^0" in order to further
experiment with it in an ideal world in which that prerequiste of
yours already has graduated, and then decide to keep the WIP on a
branch that you are not going to publish with "git branch wip" after
commiting it on a detached HEAD.  Requiring "-f" during such an
exploratory, idea-forming programming exercise might be a bit too
much, and I cannot offhand see where the good place is to require
"-f" in the first place.  At the final "git branch wip" step is too
late, as you have already expended a lot of effort to build that
WIP, and your saying "git branch wip" should be an enough clue for
Git that you do mean to save it.

At the first glance, I do agree (and to only this part I can say "I
am interested in") that it might be a good idea if we had a bit more
formal way to convey that branch 'pu' is not something you may want
to base your final work on, but I am not sure if such a tag would
help very much in practice or would be seen as a mere unnecessary
roadblock that prevents them from freer experiments once the
developers get used to the convention of their projects.
