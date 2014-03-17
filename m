From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2014, #03; Fri, 14)
Date: Mon, 17 Mar 2014 11:01:25 -0700
Message-ID: <xmqq4n2wg0wa.fsf@gitster.dls.corp.google.com>
References: <xmqqlhwcfn4a.fsf@gitster.dls.corp.google.com>
	<EA1EF5746EA7414CAE1320AA61100178@PhilipOakley>
	<CALkWK0npxgi2gWQbuYZLn_N0GxgTdPTR8c-yhgCxEV=mM2Zngw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 19:01:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPbqx-0005uk-E3
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 19:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755462AbaCQSBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 14:01:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56659 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753210AbaCQSBa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 14:01:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41F0371FEB;
	Mon, 17 Mar 2014 14:01:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KURKxWWjO38THFpwiaxnDwQ4rrE=; b=DAayfr
	ExgFf3cOt2btZK2+YPtwAYi0DTscIJG7K5h0L97hhNQiCTsXoVZwf1q/R3DQtPjY
	4MFKny0Oe9zgFtexMdrkfmom1ukve+Oa8ieT/9b+iJSSn5GBmSN/5ajcpuriUKLw
	y04/Cu4z0DvEuAc6zreZnKU+T6EHnUuHjh8Zc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xNfg+Bo3fIBlZFWafu18eCXNSimGUnwf
	gHqJ7KEPxLo6TwVhnb4WlwtBhBMuKR1JiE0awKuhwG0ojX8htnfAZkweDU8BUoqw
	AHEUIrZ20E7cD3yR1sxY9PNYlhuFLB2KD2HADGL3x07Mx/sOqd5VcPSgtRghwLye
	FNhLg1MP1pk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FBE371FE9;
	Mon, 17 Mar 2014 14:01:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4BF9171FE6;
	Mon, 17 Mar 2014 14:01:28 -0400 (EDT)
In-Reply-To: <CALkWK0npxgi2gWQbuYZLn_N0GxgTdPTR8c-yhgCxEV=mM2Zngw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sun, 16 Mar 2014 19:15:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 29A47BF2-ADFE-11E3-B5FA-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244259>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> ... I'd first fix the main issue: stale content. I'm not sure
> who uses git show-branch or mailx anymore, for instance.

Unfortunately, I haven't seen a representation better than what
show-branch gives me when assessing what needs to happen during
rebases of multiple topics some of which depend on other topics.
"git log --oneline --graph" is *not* it, with too much clutter.

I do not think "stale" is the issue.  Common-ness may be an issue,
as the usage of Git surely does not have to involve show-branch for
a simple workflow, e.g. a beginning standalone developer's.

The show-branch (and mailx) example are headed by "My typical Git
day" in the "Integrator" section (emphasis on "My"---it was not
meant to be "You ought to do like I do because I know this is the
best current practice" back when it was written, as none of us had
enough experience to declare what the BCP was).  You may argue the
command set shown there may be specific to "My" usage, and it is
atypical for the "Integrator" workflow.

We could try to come up with a different/better workflows for each
classes of developers to replace that "examples" sections, and that
will be the first step to update the listed set of commands for each
classes, I would think.  You need to realize that the workflow
described in the examples section is a real, battle tested one, not
something that came out of thin air, though.

The way forward would be to think about the following things, in the
order listed here:

 (1) Review the classes of developers.  Is the classification we
     have in the document still good?  Do we need to add new classes
     of developers?  Do we need to collapse some into one?

 (2) For each class of developers, review the workflow illustrated
     in the "Examples":

     . Do the steps illustrate a typical flow of activities for the
       class of developers?  Are there steps that typically happens
       during a developer's day that are missing in the flow?  Are
       some of the steps in the example unnecessary?

     . Have we made improvements to various Porcelain commands since
       the document was written?  Do we have better ways to achieve
       some steps illustrated there?

 (3) For each class of developers, review the commands listed before
     the "Examples" section and adjust to the "Examples" updated in
     the second step.

Thanks.
