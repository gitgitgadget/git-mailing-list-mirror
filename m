From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Mon, 15 Apr 2013 21:12:22 -0700
Message-ID: <7v1uabp109.fsf@alter.siamese.dyndns.org>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
 <CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
 <7vip3npet0.fsf@alter.siamese.dyndns.org>
 <CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 06:12:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URxFt-00025M-DA
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 06:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573Ab3DPEMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 00:12:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59681 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002Ab3DPEMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 00:12:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5650110710;
	Tue, 16 Apr 2013 04:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=txZEa3CGU1AFH0WH/U6pQtsijfk=; b=B9SDUb
	S8S/eA01OqQqlZUR12He5eVnNd9Pt/+5hZBza+flFr5Aifqg2S0rtEfDhgeEgDqh
	hqng8B4cj5v14lVQ8HDopwe54OuSgRGZihX7VbjagmJNwIjMaamRNn2X96kanY84
	WyqlzhgUgmc48k4wqvQp4WZpQ7BC6w3jq+zDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qzW+I/Po1Ehq05UZqT1izblSvmjXHk8U
	UxkIoWpy/0Rddvpe4FiHwbriiaxaxHwXfh7PxGF8vMfvOq2rd5KtO7BKPwFgj/DV
	WJHJIVD8PmjjLaJ7VN1gZBI4RTjNwBoJRT/W2u4ZZzrFRX3KTGgOY0u2Nmhs7jSR
	nCRoj+R6+IA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49DF91070B;
	Tue, 16 Apr 2013 04:12:24 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4C291070A; Tue, 16 Apr
 2013 04:12:23 +0000 (UTC)
In-Reply-To: <CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com> (Felipe
 Contreras's message of "Mon, 15 Apr 2013 18:30:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D72FA014-A64B-11E2-9481-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221358>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> So it should be clear now: the remote namespace refs/origin/master is
> updated, but not the remote helper's namespace
> refs/testgit/origin/master, which is what I already said. I don't know
> what more do you expect. When you push 'refs/heads/master' to origin,
> you expect 'refs/remotes/origin/master' to point to the same commit,
> same with 'refs/testgit/origin/master', why would you expect to point
> somewhere else?

Let me play somebody who comes later and wonders about this exchange
three months down the road...

You mention three refs/ here.  Do they live in the same repository?
Any Git person is expected to know refs/heads/master, which is "my
local branch I have worked on and I am pushing".  It also is easy to
guess what "refs/remotes/origin/master" is, even though we are not
talking about a usual Git remote.  It is to keep track of the remote
behind the helper we are pushing into, and is updated to pretend as
if we fetched immediately from the place we just pushed.  The latter
being in sync with what we pushed is something that can naturally be
expected.

Now, what is this third "refs/testgit/origin/master" thing?  Is it
expected to always be the same as "refs/remotes/origin/master"?  If
that is the case, why do we even need such a redundant information
in the first place?
