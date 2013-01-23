From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2013, #08; Tue, 22)
Date: Wed, 23 Jan 2013 09:13:27 -0800
Message-ID: <7vsj5rhlfs.fsf@alter.siamese.dyndns.org>
References: <7va9s0n8gv.fsf@alter.siamese.dyndns.org>
 <20130122234554.GI7498@serenity.lan>
 <7vobgglpv4.fsf@alter.siamese.dyndns.org>
 <20130123092858.GJ7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Chris Rorvick <chris@rorvick.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jan 23 18:13:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty3tY-0004Tf-Uy
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 18:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756437Ab3AWRNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 12:13:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38593 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754740Ab3AWRN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 12:13:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4347CB4FD;
	Wed, 23 Jan 2013 12:13:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=adPJHOgmXI9bsBd+Frff8wxstMk=; b=m0EvVN
	Qu1miioJb0dA3BcQJa+HZK3KmA09rAp6fYThXoeE3IqC5CZNKukoiVeJXL8sGtjJ
	VfWfuWMV3mt8TrkLCJNRV9+hRSifmZtLXRamN0s073zZtJUXv1aNa3C/JqW0dmqk
	Rg2mVngaC5Zf7bgMAMppQ6CrmE9wGrNvM5s1w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DZNJBZPNICzUlAiGdc18FCAdCthV6IXm
	2/OX7sFc94AdYkC8wLQCHvKzEhEDW45AyOc7yih3IBk48JfSKxCPSEZuU70TGDZZ
	RmlBDoJuRQL5FfbITx6d/UCr/So5ie/u0xhglzBYf/bmG3jGKpcBJC2n+eORNdbi
	0xuPGBLFlZM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36813B4FC;
	Wed, 23 Jan 2013 12:13:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90BCAB4F7; Wed, 23 Jan 2013
 12:13:28 -0500 (EST)
In-Reply-To: <20130123092858.GJ7498@serenity.lan> (John Keeping's message of
 "Wed, 23 Jan 2013 09:28:58 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3486D028-6580-11E2-9CA8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214337>

John Keeping <john@keeping.me.uk> writes:

> My preference would be for something like this, possibly with an
> expanded examples section showing how to pipe the output of cvsps-3 or
> cvs2git into git-fast-import:
>
> -- >8 --
>
> diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
> index 9d5353e..20b846e 100644
> --- a/Documentation/git-cvsimport.txt
> +++ b/Documentation/git-cvsimport.txt
> @@ -18,6 +18,11 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> +*WARNING:* `git cvsimport` uses cvsps version 2, which is considered
> +deprecated; it does not work with cvsps version 3 and later.  If you are
> +performing a one-shot import of a CVS repository consider using cvsps-3,
> +cvs2git or parsecvs directly.
> +
>  Imports a CVS repository into git. It will either create a new
>  repository, or incrementally import into an existing one.
>  
> -- 8< --

OK, that is certainly a lot simpler to explain.

Is it "it does not work yet with cvsps3", or "it will not ever work
with cvsps3"?  The impression I am getting is that it is the latter.

Also, should we have a suggestion to people who are *not* performing
a one-shot import, i.e. doing incremental or bidirectional?
