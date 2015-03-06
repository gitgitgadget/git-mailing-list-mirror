From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC microproject help] Allow "-" as a short-hand for "@{-1}" in more places
Date: Fri, 06 Mar 2015 12:37:38 -0800
Message-ID: <xmqqpp8lyi99.fsf@gitster.dls.corp.google.com>
References: <loom.20150306T210409-558@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sundararajan R <dyoucme@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 21:37:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTz0G-0003SN-JJ
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 21:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756494AbbCFUho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 15:37:44 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53327 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752368AbbCFUhm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 15:37:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 151253D803;
	Fri,  6 Mar 2015 15:37:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pGx/WqSLKBcMuyQW2+/MP9tYsYA=; b=PNmXdG
	ai3mxH12WnkXMmbw3PuILc9YX16fcnKcNEIQb4REIaRproouIZ3nhfpoFlpObZak
	opnRKCM4bET2VDcb4pw/VDDIMRiGaE72l1gfApcvGcMxFjeXs0+SkzlV+RzOsV3E
	oQLIXarvCsr0IgQcB55N/WdYmlN5XpfOngxOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uq645POX4DGWNkk/EDwZBxCD0NPNn8z3
	N8V78GfQ1pYEJDKEVYCdOj1FPSY4X6gerFJz3kWLG2CiC31/NgjwvyGYtKCr7dRo
	JFZCuq84S46nyOQj902OzRWGzQjdRuUYf5ZtooTSmYGmFPNZQfR/5MDdy1kY9YuO
	+joNvLNRXBo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D4F83D802;
	Fri,  6 Mar 2015 15:37:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6AD963D7FE;
	Fri,  6 Mar 2015 15:37:39 -0500 (EST)
In-Reply-To: <loom.20150306T210409-558@post.gmane.org> (Sundararajan R.'s
	message of "Fri, 6 Mar 2015 20:05:50 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A181344A-C440-11E4-8ABE-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264958>

Sundararajan R <dyoucme@gmail.com> writes:

> Although I have been using git from a long time, this is 
> the first occasion when I have picked up reading its source code. Can 
> somebody please help me by telling me how to start off with the above 
> mentioned microproject?

A good place to start on the specific coding side is to see how
existing changes for the same objective were done.

Hints:

  Does reading "git log --grep='@{-1}'" help you?  When was @{-1}
  introduced, and how is it connected to the "-" short-hand that is
  exposed to the end-user by what mechanism in commits surrounding
  the one that introduces the @{-1} mechanism?

  Does reading "git grep '@{-1}'" help you?  Where does it appear?
  What code interprets it to find the last branch before you
  switched and how?  Who calls that code?  Is there something that
  turns a user-supplied "-" into "@{-1}" before calling that code?
  What did that caller looked like before it started noticing "-"?
  Does running "git blame -L<line range>" on that caller help you to
  find out which commit made the change, and does running "git show"
  on that commit help you understand how the change was done?

At the same time, GSoC is about working _with_ the development
community, so another good place to start (you need to start on both
fronts) is to subscribe and read this mailing list and also to dig
the list archive (hint: the search interface of gmane often let you
find gems) to understand how other people propose new changes and
how their changes are discussed, reviewed and polished.  You'll be
part of that kind of exchanges yourself once you become part of the
project.

Welcome.
