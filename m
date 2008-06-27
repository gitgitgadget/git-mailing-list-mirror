From: Junio C Hamano <gitster@pobox.com>
Subject: Re: is rebase the same as merging every commit?
Date: Thu, 26 Jun 2008 18:08:18 -0700
Message-ID: <7vvdzvn0ql.fsf@gitster.siamese.dyndns.org>
References: <1006.35704952783$1214525911@news.gmane.org>
 <7vzlp7n1j4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "David Jeske" <jeske@willowmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 03:09:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC2St-0001ZP-V2
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 03:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676AbYF0BIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 21:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754633AbYF0BIc
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 21:08:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41413 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754141AbYF0BIb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 21:08:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D123722A3D;
	Thu, 26 Jun 2008 21:08:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 045B522A3C; Thu, 26 Jun 2008 21:08:25 -0400 (EDT)
In-Reply-To: <7vzlp7n1j4.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 26 Jun 2008 17:51:11 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8DE96BD8-43E5-11DD-88BA-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86513>

Junio C Hamano <gitster@pobox.com> writes:

> "David Jeske" <jeske@willowmail.com> writes:
> ...
>> (2) From the documentation diagrams, it looks like the rebased A' has
>> only (G) as a parent, not (A,G). If this is the case, why?  (i.e. not
>> connecting those nodes throws away useful information)
>
> You would rebase ONLY WHEN the project as the whole (either "other people
> in the project", or "yourself down the road one year from now") is
> interested mostly in the progress of 'master' D-E-F-G, and nobody cares
> whether you developed your A (or B or C) on top of E or G.  So the answer
> is definite "no" --- the line you drew between A and A' is a useless
> information.  Nobody cares you did it first on top of E but then you have
> redone the patches based on G (because things changed between E and G).

The last sentence came out in somewhat inappropriate way.

	In the situation "rebase" (which is a way to help you pretend you
	did not start building on a stale codebase) is appropriate, nobody
	wants to know you did it first on E

is what I meant.  More importantly, _you_ do not want anybody to know.
That is the whole reason you would rebase.

With that clarification in mind, the explanation would flow more smoothly
to this part...

> If the fact that parallel developments have happened is important, instead
> of the second picture like you drew, you will just do the real merge
> naturally to create a merge "M" like the picture I drew above.

So you have a choice between merging and rebasing.  And your extra parents
goes against the reason you chose rebasing in the first place.  That is
why we do not record the original parents anywhere.
