From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Improve remote helper documentation
Date: Fri, 07 Dec 2012 11:09:37 -0800
Message-ID: <7v1uf1he6m.fsf@alter.siamese.dyndns.org>
References: <1354038279-76475-1-git-send-email-max@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Fri Dec 07 20:10:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th3JB-0000LA-JG
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 20:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756693Ab2LGTJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 14:09:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35621 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756686Ab2LGTJo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 14:09:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC5179F30;
	Fri,  7 Dec 2012 14:09:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q7j12qxVzeXEZ0yBlycS5s4dq14=; b=di7Lfr
	pNY1Q6hQNKOKkJ9vbUIztuhDMGCLLgKY/fAGPknjjNFmSFaOjwBIfPjcKJpq8Nv/
	otkTSgbhIiIvTaNqhhDDhJJFxJz+axnEnimHC6qnpioadAxajh1gRBe11RvegqIT
	nj1oSlodwArMMxAbtDZL3GDwjMyIg/QYJ2DlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=URSEsx/cXnAap9iHXURD8nbE2JR95Rb5
	a+ArZcNXZXjs1fSlevMC/IELmqKf7UzFvaFbZ1qRQdEOvUj1jUXGZAxRLjLDGYzP
	x0p/PQs2dk0JES8pbm+kDXDBQ7aHaRtd0/Wkb4W/peMOmUBpI6BnA/aPFP8sThy7
	hr4XOHTuUpo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3F6D9F2E;
	Fri,  7 Dec 2012 14:09:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFFE79F2D; Fri,  7 Dec 2012
 14:09:39 -0500 (EST)
In-Reply-To: <1354038279-76475-1-git-send-email-max@quendi.de> (Max Horn's
 message of "Tue, 27 Nov 2012 18:44:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A65EA0E4-40A1-11E2-B94E-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211187>

Max Horn <max@quendi.de> writes:

> Various remote helper capabilities and commands were not
> documented, in particular 'export', or documented in a misleading
> way (e.g. 'for-push' was listed as a ref attribute understood by
> git, which is not the case). This patch series changes that, and
> also address some other things in the remote helper documentation
> that I found jarring when reading through it.
>
> Note that the description of export and (im|ex)port-marks probably can be
> improved, and I hope that somebody who knows more about them
> than me and/or is better at writing documentation will do just that.
> But I felt it was better to provide something than to do nothing
> and only complain, as I did previously on this subject ;-).

A second ping to people who have touched transport-helper.c,
remote-testsvn.c, git-remote-testgit, and contrib/remote-helpers/ in
the past 18 months for comments.  I've re-read the documentation
updates myself and didn't find anything majorly objectionable.

Except for a minor nit in 6/6; I think "defined options" should be
"defined attributes".

    --- a/Documentation/git-remote-helpers.txt
    +++ b/Documentation/git-remote-helpers.txt
    @@ -227,6 +227,8 @@ Support for this command is mandatory.
            the name; unrecognized attributes are ignored. The list ends
            with a blank line.
     +
    +See REF LIST ATTRIBUTES for a list of currently defined options.
    ++
