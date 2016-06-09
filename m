From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] Documentation: triangular workflow
Date: Thu, 09 Jun 2016 10:02:17 -0700
Message-ID: <xmqqmvmui9d2.fsf@gitster.mtv.corp.google.com>
References: <1465288693-6295-1-git-send-email-jordan.de-gea@grenoble-inp.org>
	<1465475708-1912-1-git-send-email-jordan.de-gea@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: mhagger@alum.mit.edu, philipoakley@iee.org, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	tom.russello@grenoble-inp.org, Matthieu.Moy@grenoble-inp.fr,
	peff@peff.net, artagnon@gmail.com
To: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 19:02:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB3Lh-0002mm-V0
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 19:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbcFIRCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 13:02:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61916 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932118AbcFIRCV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 13:02:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E488C2198C;
	Thu,  9 Jun 2016 13:02:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LvQzwJyfOELrOrfHRd5U2E30ybA=; b=T2HbFW
	rqjjtU7Qt/Om+o4Q8Iar8NGjiNJZgViWZFuWW/hScMuQB2/o+fv28uQAIaWv1/ek
	M49dFXbz18UsID3mfaHlvR9JYb0WMOx9dOj5JXBEJAaPaN73s4LjOYAxcruTbIpD
	6jUAJV0lPHLXrbKhsV93K8CDrTzi3uonZfVDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kp9e6YuH7TomtRt+0uiQo23M5lkGd1bM
	SK0hoBCZ34R2++CstGTA4hBHUUbyrG3GXADdE1TZMV2485rAPQgGlv2DlzY14FPD
	+47UQXbiodlbZVOqQr7xzxOgAvA0xubFo6qECk4R/O8QEqv7+hwGXiywtEcycER5
	iSBBnSBPA5w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DBA8F2198B;
	Thu,  9 Jun 2016 13:02:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 51C632198A;
	Thu,  9 Jun 2016 13:02:19 -0400 (EDT)
In-Reply-To: <1465475708-1912-1-git-send-email-jordan.de-gea@grenoble-inp.org>
	(Jordan DE's message of "Thu, 9 Jun 2016 14:35:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ECFE496A-2E63-11E6-82AE-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296902>

Jordan DE GEA <jordan.de-gea@grenoble-inp.org> writes:

> +Motivations
> +~~~~~~~~~~~

> +* Allows contributors to work with Git even though they do not have
> +write access to **UPSTREAM**.
>
> +* Allows maintainers to receive code from contributors they may not
> +trust.

I somehow don't think "even though" sits well here.  You can work
with Git all you want locally even if you do not have write access
anywhere, but that is stating the obvious.  Also, unless the only
alternative you are contrasting "triangular" with is "a single
central repository workflow", "may not trust" is not a unique
advantage of "triangular".  You can exchange patches and reviews
with contributors just like you do.

I think the more important thing to say instead of the above two is
that this arrangement allows distributed workflow; you publish to
your place at your own pace, they pull from you if and when they
choose to, and they publish their result to their place at their own
pace.

> +* Code review is more efficient

I have no idea what data you have to back this claim up.  More
efficient compared to what?

If you are contrasting "triangular" with "a single central
repository everybody pushes into", then one big advantage
"triangular" can have around "code review" is that it allows reviews
before the code hits the authoritative history of the project.  If
your project works with a single central repository everybody pushes
into, things tend to run in reverse--after you push questionable
stuff into the project history, somebody else has to spot problems,
go in and fix it after the fact.

> +* Encourages clean history by using `rebase -i` and `push --force` to 
> +your public fork before the code is merged

This is a side-effect of "review before merge" mentioned earlier.


> +Preparation
> +~~~~~~~~~~~
> +
> +Cloning from **PUBLISH**, which is a fork of **UPSTREAM** or an empty
> +repository.
> +
> +======================
> +`git clone <PUBLISH_url>`
> +======================
> +
> +Setting the behavior of push for the triangular workflow:
> +
> +===========================
> +`git config push.default current`
> +===========================
> +
> +Adding **UPSTREAM** remote:
> +
> +===================================
> +`git remote add upstream <UPSTREAM_url>`
> +===================================
> +
> +With the `remote add` above, using `git pull upstream` pulls there,
> +instead of saying its URL. In addition, `git pull` can pull from
> +**UPSTREAM** without argument.
> +
> +For each branch requiring a triangular workflow, set
> +`branch.<branch>.remote` and `branch.<branch>.pushRemote`.
> +
> +Example with master as <branch>:
> +===================================
> +* `git config branch.master.remote upstream`
> +* `git config branch.master.pushRemote origin`
> +===================================

Wouldn't it be much simpler to manage if you instead start from a
clone of **UPSTREAM** and then fork **PUBLISH** and push your work
out to the latter?  You do not have to do per-branch configuration
that way, no?  Instead you would set default.pushRemote to publish
just once, and no matter how many branches you create later, you do
not have to do anything special.

It smells like you are deliberately presenting a more cumbersome
way, as a prelude to add even more configuration that is not
necessary if you started in the right direction in the first place.
