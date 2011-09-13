From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/7] Improved infrastructure for refname normalization
Date: Tue, 13 Sep 2011 10:43:57 -0700
Message-ID: <7vlitswd5u.fsf@alter.siamese.dyndns.org>
References: <1315637443-14012-1-git-send-email-mhagger@alum.mit.edu>
 <7vehzmbd0o.fsf@alter.siamese.dyndns.org> <4E6E2122.8000201@alum.mit.edu>
 <7vwrdd90df.fsf@alter.siamese.dyndns.org> <4E6ED90D.1090704@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 13 19:44:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3X1p-0002Y9-T9
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 19:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755838Ab1IMRoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 13:44:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64300 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755734Ab1IMRoB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 13:44:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEE8A4647;
	Tue, 13 Sep 2011 13:43:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QIqNqNZBxIg+zj27TFRdGQ9szpA=; b=ilkr8f
	AFdBbJGc2n3emc/E2ttA9Z2VwWV/FRHD85o7coOTPhi3Jn/d4wW3icTUx3wM1qyj
	b2QsaIzS8uKlaQYU8T2pUAmCzU1Ed711kR4RJNKqohEtCLWBTI+zbgtgZlg16gFW
	tJ/kwn3MehTbFF87rdPa+ocbkkOM7Iy42IwtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BAbmHFYUslmeN8dse2Lt1pmbNDrTMKqA
	+Bo0Fdp0uxwNtI57wPmg5b6OhCVKIUZObqfroUeVu0oi5xshWHPvsWG/kq3sjn1e
	+DOtK/VKb48EsGJd/O0HvYRCqj6kUVd8/4B7TkPo9BNNgPveduBJXI5hJwJgTzXe
	ymkMQ0uVm/I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2DC04645;
	Tue, 13 Sep 2011 13:43:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 573174644; Tue, 13 Sep 2011
 13:43:59 -0400 (EDT)
In-Reply-To: <4E6ED90D.1090704@alum.mit.edu> (Michael Haggerty's message of
 "Tue, 13 Sep 2011 06:16:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F608618C-DE2F-11E0-ACB8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181300>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Consistency of the UI should be the goal.  Supporting unnormalized
> refnames some places, but not others, will just confuse and frustrate
> users.
> ...
> So I propose the following:
>
> * Institute a policy that refnames in the UI must always be normalized
>
> * On a best-effort basis, emit errors whenever unnormalized refnames are
> encountered
>
> * Continue to support "git check-ref-format --print", which script
> writers can use to normalize refnames if they need to.
>
> The only disadvantage of a stricter policy is that some of today's
> sloppy scripts, which today might sometimes work (but not reliably),
> break in a pretty obvious way that can be fixed with a single call to
> "git check-ref-format --print".
>
> I'd rather get beyond this swamp and start working on the hierarchical
> reference cache, which will bring some real benefits.  (The hierarchical
> reference cache requires some sanity in refname handling, which is why I
> got into this mess in the first place.)

Both the analysis and theproposal I find very sane and sensible. Thanks.
