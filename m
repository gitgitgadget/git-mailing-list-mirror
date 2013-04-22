From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 16:55:01 -0700
Message-ID: <7vehe2m88a.fsf@alter.siamese.dyndns.org>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
	<87ppxmogdv.fsf@linux-k42r.v.cablecom.net>
	<CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
	<87wqruk2pj.fsf@linux-k42r.v.cablecom.net>
	<CALkWK0mUH2m5zJ4MwPWC85CsZZ=2RODumLvsF9q3rLj-+d7vBw@mail.gmail.com>
	<CALkWK0n5gaz3A7kHT6+5z3YkYdpgU5p6Pv4heMbLzikTbROwkA@mail.gmail.com>
	<CALkWK0k0LbAnkhAAqdeAvBnCig_HO+bT+WiQuQQ3Fgc=FzFtRw@mail.gmail.com>
	<87zjwqpebl.fsf@hexa.v.cablecom.net> <vpqr4i2z35n.fsf@grenoble-inp.fr>
	<7vmwsqns4p.fsf@alter.siamese.dyndns.org>
	<CALkWK0mO0L4YrZFGmzWkiO4V18p-ydKyjVOe4vJ2H-d7Kz+qOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 01:55:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUQZm-0003tJ-0v
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 01:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354Ab3DVXzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 19:55:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39608 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752423Ab3DVXzF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 19:55:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4E4C19CD5;
	Mon, 22 Apr 2013 23:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pxz8/1REL/Zc4Tj7lv4hIuvzU9A=; b=oVWTqx
	LR30SFX0GRCT7xz5Ax6CvxDdAOKwICurwkKu+IdNPu+N3C08mlB1H3Xu/6Bw2w2I
	IV0du4U6dhhPQZJBFseFLdWpiR0hFIDbcW1/Oz+DbChShHwFwjzheLEsx2CIm23g
	qt5J/iFU7WU0fpzcZF3gUQQ5pvhETtjKNEIDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TT+7zX3YvwKqbWwNApHu9nZY/gV6OLYi
	CoHu/yWJq7HrSxUjUlcmOitVvAk00xt71KyK0LfqdbGU09saZx2VYkfTDkgj8Buk
	2ZMliqfxbv+wE4xCnXEpQNhdI4acMUtCmU9UULhTSf4d4eQXzxgi+g+QDVLrWQVM
	HRbRjrm3bGQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC50519CD4;
	Mon, 22 Apr 2013 23:55:03 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3138419CCE;
	Mon, 22 Apr 2013 23:55:03 +0000 (UTC)
In-Reply-To: <CALkWK0mO0L4YrZFGmzWkiO4V18p-ydKyjVOe4vJ2H-d7Kz+qOw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 23 Apr 2013 04:22:05 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0CD9EDA8-ABA8-11E2-AC12-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222131>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Am I making any sense?

I dunno.  Depends on the definition of "sense".

It sounds like you are repeating the same old "let's record renames
in the commit", and in a system (not Git) where recording renames
may make sense, you may be making sense.

But we will not record renames in the commit.  Time to re-read
$gmane/217, perhaps?

A subtree merge that slurps everything from a side branch under a
single directory, say gitk/, is not at all different from a normal
merge with many renames.

Imagine an alternate world where we had a small "git.git" project
with 11 files totallying 1244 lines.  Then Paul Mackerras forks that
project, remove everything from the top-level directory and adds a
Tck/Tk script "gitk".  Linus merges that history as-is, keeping all
our files intact (i.e. ignoring his removal) but taking the addition
of "gitk" from him.

Then after I inherit the project, I rename "gitk" to "gitk-git/git".
Paul does not rename his.  We keep developing in parallel and I
occassionally merge from his tree, which has "gitk" at the top,
while mine has it in a directory "gitk-git".  The ordinary rename
detection kicks in and integrates his updates to "gitk" into my
"gitk-git/gitk".

The only difference the above imaginary history has from the reality
is Paul's history does not share that root, but everything else is
the same.
