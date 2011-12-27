From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] honour *_ASKPASS for querying username and for
 querying further actions like unknown certificates
Date: Tue, 27 Dec 2011 12:56:55 -0800
Message-ID: <7vlipx68dk.fsf@alter.siamese.dyndns.org>
References: <4EC52508.9070907@tu-clausthal.de>
 <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
 <4EC65DE4.90005@tu-clausthal.de>
 <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
 <4ED0CE8B.70205@tu-clausthal.de>
 <20111130064401.GC5317@sigill.intra.peff.net>
 <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
 <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
 <4EF9ED24.2040902@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Tue Dec 27 21:57:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rfe51-0001fZ-5l
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 21:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236Ab1L0U47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 15:56:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63746 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932Ab1L0U45 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 15:56:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 589AD5112;
	Tue, 27 Dec 2011 15:56:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GggFPg6Uad5oTilEInTtiTGrm/k=; b=umYGsJ
	krK9klAy1SBCOx9QlMQP1lTfRDH7X4pv1ZOmgVljbP3yhHSHMwfHoBSMZCMUS6RL
	ZdSV/9/M8yexiS2+BswSe8YLkgQH1vBn3KI07iKQkRDlVhDG2265FFcgZfG2ZLIa
	OGZSLuKRBukQnHMR6Bq8zD7LC3unhL1apo4zM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xSjDb8w5aKEi0KDJVNoOqqih8SgR1QER
	j1sfnEssjmeEqo2NbJXH7LEF6B7iI3xfMUx8xAMvN48UdFgc0TG+kROmWUKO99aN
	AIuo/e6cAt0katjjjwbt7A/cTiogrEaK7rLvRd2OWV4iWAoXzIXYWKtB923NALUv
	rH4jLtR6K9k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 510825111;
	Tue, 27 Dec 2011 15:56:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA6BD5110; Tue, 27 Dec 2011
 15:56:56 -0500 (EST)
In-Reply-To: <4EF9ED24.2040902@tu-clausthal.de> (Sven Strickroth's message of
 "Tue, 27 Dec 2011 17:07:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 500A0EC0-30CD-11E1-A37D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187728>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> git-svn reads usernames (and other stuff) from an interactive terminal.
> This behavior cause GUIs to hang waiting for git-svn to complete (http://code.google.com/p/tortoisegit/issues/detail?id=967).

(style) Wrap the line perhaps after "to complete".

Does the above mean "GUIs hang, until the user goes back to the terminal
and authenticates"?  Where is the "interactive terminal" connected when
running the GUI?

With that bit information, I think the above is a decent problem
description (i.e. "what problem is this change trying to solve? is it
worth solving?").

The second paragraph (missing) should then discuss what approach is taken
by the proposed patch to solve that problem. Something like

    Instead of using hand-rolled prompt-response code that only works with
    the interactive terminal, use the git_prompt() method introduced in
    the earlier commit.

would suffice (I didn't check what method name you used, though).

> Also see commit 56a853b62c0ae7ebaad0a7a0a704f5ef561eb795.

I checked that commit, and what you wanted to say is unclear. Are you
saying this patch attempts to fix the breakage by that commit? That commit
tried to go in a right direction but did not go far enough and you are
trying to enhance it? Somerthing else?

Which means that you shouldn't have said "Also see..." at all and instead
directly said what you wanted to say here.
