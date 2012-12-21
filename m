From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Fri, 21 Dec 2012 08:58:58 -0800
Message-ID: <7vzk171gvh.fsf@alter.siamese.dyndns.org>
References: <20121211153903.7522d6b0@chalon.bertin.fr>
 <7vd2yg8ngk.fsf@alter.siamese.dyndns.org>
 <20121212094432.6e1e48c8@chalon.bertin.fr>
 <7v38zb3ux0.fsf@alter.siamese.dyndns.org>
 <877goht6eu.fsf@pctrast.inf.ethz.ch>
 <20121217114058.449cbc3c@chalon.bertin.fr>
 <CAP8UFD2pkotNy=t5wTxDH-pMivQsTz-kw2y8Y7rWY42YKabp7g@mail.gmail.com>
 <m21ueo78f8.fsf@igel.home> <7vwqwgjs8f.fsf@alter.siamese.dyndns.org>
 <20121218120058.0c558ba5@chalon.bertin.fr>
 <7vehinibpc.fsf@alter.siamese.dyndns.org>
 <87ip7yp4mf.fsf@pctrast.inf.ethz.ch>
 <7vvcbx956f.fsf@alter.siamese.dyndns.org>
 <50D45A78.3020104@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Yann Dirson <dirson@bertin.fr>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Christian Couder <christian.couder@gmail.com>,
	git list <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Dec 21 17:59:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm5wY-00063b-Pr
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 17:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340Ab2LUQ7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 11:59:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53998 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091Ab2LUQ7L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 11:59:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B7F3A52C;
	Fri, 21 Dec 2012 11:59:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lXVDBElQyjETXr6J11tYAmEwjeM=; b=TZEcM8
	J/1YB0fqX6m+nO5Dqk0YuET0wbe0tO8LHXfYr5TVbOUo6fk94+f6tWZS5efyeMiH
	sNlj6Q7PtNEOkIsd1eYBxX0DzcWPqbPDtCa0MQHLxmX5/yLxfyabvRYvH1D3YmHP
	D2TUCpmo8/5Z+HhFOzMHTUrIfpTSmbam3Z+9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ASBIhfnTKoeF4Q8ITp4Gxj4qxdkblnu8
	BWIcCyeGqCJdaHnugO87KD1KrdqNLU3SvuvFi8MUUNxTfNPvPMUjx258bp9jBdUV
	1N3ohD0gaHolqaTYwzUaOHpDj87iknZoI7O7Kxo2pl7QbBLidaGpTeW+PCPqhbt6
	/q9wX3NAcEc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 327A1A52B;
	Fri, 21 Dec 2012 11:59:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF5DBA526; Fri, 21 Dec 2012
 11:59:04 -0500 (EST)
In-Reply-To: <50D45A78.3020104@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri, 21 Dec 2012 13:47:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA008E70-4B8F-11E2-A66C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211984>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> While replace refs are much more general than grafts, it seems the two
> main uses are:
>
> - grafts (change the recorded parents for a commit)
> - svn cleanup (convert tagging commits into tag objects)
>
> The latter one being quite a special case already.
>
> The script below has helped me move from grafts to replace objects.
> While not being super clean, something like it may be fit for contrib.
>
> I think we ought to help John Doe get along with parents, while we can
> safely leave most more advanced operations to people who know how to
> edit a raw object file. Putting that facility into "git-commit" seems to
> be too encouraging, though - people would use replace when they should
> use amend or rebase-i. I'd prefer a special git-replace mode (be it
> "--graft" or "--graft-commit") which does just what my script does. We
> could add things like "--commit-tag" later, a full blown
> "object-factory" seems like overkill.
>
> Michael
>
> --->%---
>
> #!/bin/sh
>
> die () {
> 	echo "$@"
> 	rm -f "$commitfile"
>  	exit 1
> }
>
> warn () {
> 	echo "$@"
> }
>
> test $# -gt 0 || die "Usage: $0 <commit> [<parent>]*"
>
> for commit
> do
> 	git rev-parse --verify -q "$commit" >/dev/null || die "Cannot parse
> $commit."
> 	test x$(git cat-file -t $commit) == "xcommit" || die "$commit is no
> commit."

s/==/=/ or you have to say #!/bin/bash on the first line, I think.
Appears multiple times throughout this script.


> done
>
> commit="$1"
> shift
>
> commitfile=$(mktemp)
>
> git cat-file commit "$commit" | while read a b
> do
> 	if test "$a" != "parent"
> 	then
> 		echo $a $b

You are losing information on non-header lines by reading without
"-r" in the above, and also multi-line headers (e.g. mergetag),
aren't you?

> 	fi
> 	if test "$a" == "tree"
> 	then
> 		for parent
> 		do
> 			echo "parent $(git rev-parse $parent)"
> 		done
> 	fi
> done >$commitfile
> hash=$(git hash-object -t commit -w "$commitfile") || die "Cannot create
> commit object."
> git replace "$commit" $hash
> rm -f $commitfile
