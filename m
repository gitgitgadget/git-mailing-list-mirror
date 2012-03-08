From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-rerere: document 'remaining' command
Date: Thu, 08 Mar 2012 14:30:00 -0800
Message-ID: <7veht2buaf.fsf@alter.siamese.dyndns.org>
References: <1331036512-7626-1-git-send-email-vfr@lyx.org>
 <7vwr6xsfbn.fsf@alter.siamese.dyndns.org>
 <CABURp0rOFgwLu0pX0W5txOH=CH6Yb4NchYLaj91m1nMve_zjDg@mail.gmail.com>
 <7vvcmgkq20.fsf@alter.siamese.dyndns.org>
 <CABURp0run5zYLBkUsNQEJq3h_1y7bQ44XZb9BPja+RjX8OLyfg@mail.gmail.com>
 <7vr4x3is39.fsf@alter.siamese.dyndns.org>
 <CABURp0pd4wAw0ax5jjaoOR-bAWUGUQa-k1xby9_Bb_wQwsLk7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	martin.von.zweigbergk@gmail.com
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 23:30:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5lqe-00009t-Tg
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 23:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758868Ab2CHWaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 17:30:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55159 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758773Ab2CHWaG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 17:30:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF59D6653;
	Thu,  8 Mar 2012 17:30:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qU3/aKA+G3tSn8B5jj2FDFCvDqU=; b=hILrzi
	PL161F9kgrJ7UaFiacIJtbdG/x+SgTNOkoJ70CkG2VwPGlF3URqr5BfVcJaHcx29
	vQ1ceKiRNV8O6F90x5pXIR7wJYbZGXvlnzeGYhv/6XLjfVcPzxLOKYni8bOmU5/x
	yS6aLhNt2r/v8m++RHhUUtWEOliYhCDFZ3lkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OwTaBdeEBa7uYKD+BpPBdsoilLq3rGZY
	pzojcnXlCWfsA+Ma6VuaVq/w9NY5jNFNr5hpT2GEuqNkkADGB4CYPYH91OQJLE7h
	c3mhXmNPN2md54zvHGflPFIMFTp2xzH3Kl/tP+GK6ss8t0TT+QzfSJlS862I4Gii
	Hh/EBNSf/kk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A566A6652;
	Thu,  8 Mar 2012 17:30:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5366E6650; Thu,  8 Mar 2012
 17:30:03 -0500 (EST)
In-Reply-To: <CABURp0pd4wAw0ax5jjaoOR-bAWUGUQa-k1xby9_Bb_wQwsLk7w@mail.gmail.com> (Phil
 Hord's message of "Thu, 8 Mar 2012 16:08:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3FAE827A-696E-11E1-A894-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192661>

Phil Hord <phil.hord@gmail.com> writes:

> On Thu, Mar 8, 2012 at 12:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Phil Hord <phil.hord@gmail.com> writes:
> ...
>   $ git rebase origin/master
>    Noise, noise, noise
>    Resolved 'foo' using previous resolution.
>    Failed to merge in the changes.
>
> I reach for my utility belt, but my usual tricks all fail at this point:
>
>    $ git mergetool
>    No files need merging
>
>    $ git rebase --continue
>    foo: needs merge

Just to make sure we are on the same page (I do not personally use
"mergetool"), the above looks like a bug in mergetool.

Are you reporting a still-unfixed breakage, or is it an anecdote on
how you were frustrated in the past due to a bug that has since been
fixed?

> How's this:

Looks good.

>  'status'::
>
> -Like 'diff', but this only prints the filenames that will be tracked
> -for resolutions.
> +Print paths with conflicts whose merge resolution rerere will record.
> +
> +'remaining'::
> +
> +Print paths with conflicts that have not been autoresolved by rerere.
> +This includes paths whose resolutions cannot be tracked by rerere,
> +such as conflicting submodules.

We might want to add "and a path that was deleted by one branch and
modified by the other branch" at the end here.

Unless an earlier part of the documentation that discusses what kind
of resolutions get recorded and reapplied makes it clear enough that
the reader can easily guess a delete/modify conflict is not handled,
that is.  I _think_ the description at the top makes it clear the
two branches being merged both need to have a file at the path, so
in that sense, singling out delete/modify and mentioning it here
might be redundant, but I am not the target audience (I wrote and
named it rerere after all ;-), so I shouldn't be my own judge.

Thanks.
