From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] git-rev-parse.txt: Document ":path" specifier
Date: Fri, 25 Jun 2010 08:53:40 -0700
Message-ID: <7vd3vfkt17.fsf@alter.siamese.dyndns.org>
References: <7vvd98b1jh.fsf@alter.siamese.dyndns.org>
 <633f42d1967049780d66cf72552b22ae17bbbead.1277476258.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 25 17:53:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSBE4-0008DQ-2k
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 17:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756378Ab0FYPxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 11:53:48 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54544 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756353Ab0FYPxs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 11:53:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AC2CBBFEBB;
	Fri, 25 Jun 2010 11:53:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bt9ssJAUw3L+8fAHJKn63yioWwU=; b=HhDRvS
	KCpOFmn5S2v75RhkrzEWS3fDfV1rX291yn2V9FA6od7I755RRhVHsjq9OkaE4cxO
	iqi4O0JgWsEfxjyI27To53OZdJ6y7SBYNEp1Nqa+nneYrsesDFYECz5z3NRmlSj/
	mobuchFMYI+6ee2gqcInTAuKgDis8mTFRKyKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XyTxnOQYNMSz+zGU7rEDEcjoKwHsWA5Z
	xJt2grACLIPqjbjVcewUd73KKaVjvk3tBtLKMU8SCzP0mnEgo4c5AOKCq3BR6qo9
	qguCfNcHyJNRVFjgCQddmH0v6FhOmTH6gyvWJs4hTgs1WSzorMgQiT1iSRjXJ4mI
	1q+xiqey+oc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 61DE8BFEBA;
	Fri, 25 Jun 2010 11:53:44 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B187EBFEB9; Fri, 25 Jun
 2010 11:53:41 -0400 (EDT)
In-Reply-To: <633f42d1967049780d66cf72552b22ae17bbbead.1277476258.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri\, 25 Jun 2010 16\:32\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D55D5A9A-8071-11DF-93E7-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149694>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The empty treeish in ":path" means "index". Document this.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  Documentation/git-rev-parse.txt |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index 8db600f..f964de4 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -290,8 +290,9 @@ the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
>    followed by something else than '!' is reserved for now.
>  
>  * A suffix ':' followed by a path; this names the blob or tree
> -  at the given path in the tree-ish object named by the part
> -  before the colon.
> +  at the given path in the tree-ish object named by the ref
> +  before the colon. An empty ref before ':' denotes the content
> +  recorded in the index at the given path.

I am wondering if it is less confusing to present these two cases as two
independent entries...

    A colon ':' followed by a path names the blob at the given path in the
    index.

    A tree-ish, followed by a colon ':', followed by a path names the blob
    or tree at the given path  in the tree-ish.

It is not like we treat the index as a pseudo tree, but your wording
implies we do in this syntax.  We of course cannot treat the index as a
pseudo tree in all operations, and people can get confused and ask "When
can I say empty to mean index?"...

Thoughts?
