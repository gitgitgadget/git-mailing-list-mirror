From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to merge into my working copy?
Date: Fri, 06 Nov 2009 09:53:37 -0800
Message-ID: <7v8wejzgim.fsf@alter.siamese.dyndns.org>
References: <e2a1d0aa0911060653t7bbb54ebp948eac0dffeaba64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 18:53:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6T0R-0000VB-Rl
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 18:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757898AbZKFRxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 12:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757625AbZKFRxj
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 12:53:39 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377AbZKFRxj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 12:53:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 334B776ED3;
	Fri,  6 Nov 2009 12:53:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z7NBvkK6lx6gMUgFFmADyck6w/k=; b=ra6pFp
	IDSw+IrtelYAFzEouDuPobQ7z18FGxNwQ2/opAcVC9Tdl/8vTi4L20Aa3lPqBrab
	UpFusmKYvylL5GKq1wfGhYKYUaznoFuY2fboHJyoM+mT0Llu/vNDhXBmlgcyIi/y
	aibAInYVZ0slhr7Ndwg+Lk2J5DVJ/Kh9RDbxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H868PSAkFkhqDmFhFQadTWAnsLmHdplV
	seWhmMDPs5YnxdZ7d+Ps0WfUyo1IpqKswDVWigVXQgXDIYkNF9DYLmIoCAEVVTdK
	9PCTu1+pOWh4nGbtMvgTTiCghW78TsPg9lrjhgNCPirDz5sYaZzXh6JR3Mfdm7Yz
	n2MkplcZcyQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FC1F76ED1;
	Fri,  6 Nov 2009 12:53:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E4BD76ED0; Fri,  6 Nov
 2009 12:53:39 -0500 (EST)
In-Reply-To: <e2a1d0aa0911060653t7bbb54ebp948eac0dffeaba64@mail.gmail.com>
 (Patrick Doyle's message of "Fri\, 6 Nov 2009 09\:53\:02 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5214F3FC-CAFD-11DE-B705-7C40EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132316>

Patrick Doyle <wpdster@gmail.com> writes:

> I would like to pull a set of changes from a branch back into the
> working copy of my current branch without affecting the index.  I
> can't figure out the right combination of --commit, --no-commit, -ff,
> -no-ff, --log, --no-log, --squash, --no-squash, etc... options to use
> with git-merge.
>
> Basically, I created a branch off my mainline branch a few days ago.
> Made some commits on that branch.  Then went back to my mainline
> branch, made a few commits there, and now I would like to make my
> working copy look like a merge of its current state with the changes
> from the branch, minus any associated commits.

If you do not have to have your extra "without affecting the index"
constraint (which I do not see a sensible reason to want to, by the way),
you can "merge --no-commit that_branch", I think.
