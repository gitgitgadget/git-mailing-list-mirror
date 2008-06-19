From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add option to git-branch to set up automatic rebasing
Date: Thu, 19 Jun 2008 16:24:10 -0700
Message-ID: <7vabhhroth.fsf@gitster.siamese.dyndns.org>
References: <1213836802-3163-1-git-send-email-pdebie@ai.rug.nl>
 <alpine.DEB.1.00.0806191459150.6439@racer>
 <20080619154350.GA21625@atjola.homenet>
 <7vr6attey8.fsf@gitster.siamese.dyndns.org>
 <12AB50C8-6CBF-4D96-8FAB-90234A9006D0@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Fri Jun 20 01:25:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9TVU-0006mP-19
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 01:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754100AbYFSXYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 19:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754091AbYFSXYh
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 19:24:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61839 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066AbYFSXYg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 19:24:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3FC001CFD7;
	Thu, 19 Jun 2008 19:24:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5B0FC1CFD5; Thu, 19 Jun 2008 19:24:20 -0400 (EDT)
In-Reply-To: <12AB50C8-6CBF-4D96-8FAB-90234A9006D0@ai.rug.nl> (Pieter de
 Bie's message of "Fri, 20 Jun 2008 00:58:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DC24B760-3E56-11DD-AEB8-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85575>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> That's why I suggested --auto-rebase, which is more verbose in what
> it does. Perhaps we should add it as an optional flag for --track, like
>
>   git branch --track --auto-rebase local remote/branch
>
> ? That is a bit long though.

That does not make _any_ sense unless you also have --auto-merge.  And
which part of rebasing is auto anyway?  "git checkout local" won't rebase
onto remote/branch for one thing.

> I don't think "--track=rebase" makes a lot of sense, since "track" is
> still a boolean in my head ;)

Well, track _is_ boolean.  You usually build and develop yourself, but if
you are following somebody else, you say "this is not really a pure
development but is used to trail somebody else (aka "track mode ON"), and
the way for this branch to follow that somebody else specifically is to
merge from it or rebase on top of it (aka "how it tracks")".
