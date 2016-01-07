From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: clarify that passing --depth to git-clone implies --single-branch
Date: Thu, 07 Jan 2016 11:45:04 -0800
Message-ID: <xmqqmvsh41j3.fsf@gitster.mtv.corp.google.com>
References: <n6j1cs$p4$1@ger.gmane.org>
	<CACsJy8D5DeDOCd1tn876s3+2fBR6e-X1UANkAeiw8tzAeDcDng@mail.gmail.com>
	<568D10D6.7020707@gmail.com> <568D1167.30700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 20:45:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHGUl-0004iW-B1
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 20:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbcAGTpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 14:45:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52912 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753127AbcAGTpG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 14:45:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D6DA23859B;
	Thu,  7 Jan 2016 14:45:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wwbliPSolfzU1lc0S5LHQKqJ05g=; b=bNJWy2
	iqrjNq5w4D4IiXs/qBHCkojn9NUB8UUtMSduLDY6MRtJoUgNeqe9sHyLAwEaHMrA
	kqVOZxXcUfPkMo05u3TFdP9TCSosvJjClpInkwW4NqrFIoi4RWbuRU7UXA0rqgW+
	seAgB0AnM9ttU4Kr9IjW1+1Eilw0mfUEwSCWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mA+K86T5ND8JnoTptr1uiX0AKyXgIsHI
	Ocg+5dQf5Nkf+LnfQsDmx2QlLoGxevqb+d6K+nj/RyhCdkTKBLZWe550MI5nwgLt
	NcnpaJk2ekFt03D9jk91lsjBa3ldEPOwv1t8CfEx1EpvJWKsPXkBRKFJ2fGhYRN1
	2Mvn81wEDZ8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CEA0F3859A;
	Thu,  7 Jan 2016 14:45:05 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0F23D38594;
	Thu,  7 Jan 2016 14:45:04 -0500 (EST)
In-Reply-To: <568D1167.30700@gmail.com> (Sebastian Schuberth's message of
	"Wed, 6 Jan 2016 14:06:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 262B0FAE-B577-11E5-94F0-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283501>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> It is confusing to document how --depth behaves as part of the
> --single-branch docs. Better move that part to the --depth docs, saying
> that it implies --single-branch by default.
>
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---

Yeah, the new organization is much easier and intuitive to follow.

Thanks.


>  Documentation/git-clone.txt | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 6bf000d..943de8b 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -190,15 +190,14 @@ objects from the source repository into a pack in the cloned repository.
>  
>  --depth <depth>::
>  	Create a 'shallow' clone with a history truncated to the
> -	specified number of revisions.
> +	specified number of revisions. Implies `--single-branch` unless
> +	`--no-single-branch` is given to fetch the histories near the
> +	tips of all branches.
>  
>  --[no-]single-branch::
>  	Clone only the history leading to the tip of a single branch,
>  	either specified by the `--branch` option or the primary
> -	branch remote's `HEAD` points at. When creating a shallow
> -	clone with the `--depth` option, this is the default, unless
> -	`--no-single-branch` is given to fetch the histories near the
> -	tips of all branches.
> +	branch remote's `HEAD` points at.
>  	Further fetches into the resulting repository will only update the
>  	remote-tracking branch for the branch this option was used for the
>  	initial cloning.  If the HEAD at the remote did not point at any
