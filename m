From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI
 revamp
Date: Tue, 04 Nov 2008 11:46:36 -0800
Message-ID: <7vr65rqnoj.fsf@gitster.siamese.dyndns.org>
References: <20081030002239.D453B21D14E@mail.utsl.gen.nz>
 <20081031003154.GA5745@sigill.intra.peff.net>
 <7v3ai9226q.fsf@gitster.siamese.dyndns.org>
 <1225691960.20883.41.camel@maia.lan>
 <20081104091800.GB24100@dpotapov.dyndns.org>
 <1225822231.6722.3.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, Jeff King <peff@peff.net>,
	Sam Vilain <samv@vilain.net>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>,
	"J.H." <warthog19@eaglescrag.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Nov 04 20:50:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxRui-000370-9D
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 20:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237AbYKDTsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 14:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753804AbYKDTsi
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 14:48:38 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45423 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307AbYKDTsh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 14:48:37 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1336F795D2;
	Tue,  4 Nov 2008 14:48:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 853F0795A8; Tue,  4 Nov 2008 14:46:43 -0500 (EST)
In-Reply-To: <1225822231.6722.3.camel@maia.lan> (Sam Vilain's message of
 "Wed, 05 Nov 2008 07:10:31 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 910BCF60-AAA9-11DD-85F6-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100098>

Sam Vilain <sam@vilain.net> writes:

> On Tue, 2008-11-04 at 12:18 +0300, Dmitry Potapov wrote:
> ...
>>  The only one who does publishing to the official repository
>> is the maintainer, and the maintainer is most likely to run some tests
>> after merging all changes, which takes some time. So, it is rarely push
>> the current branch, it is usually the branch that has been tested, so
>> the name of the branch should be specified explicitly anyway.
>
> Why is that relevant?  That person can still use the explicit version of
> the command.

Back when "git push $there :" were not available, the default matching
behaviour was the _only_ way to say "I know the set of branches I want to
publish, and I have many more private branches in my primary work
repository.  I do not want to list the set of branches to publish every
time when I type 'git push', nor I want to configure it --- Heck, I
shouldn't have to list them, the public repository I am pushing to already
has that list, and it is the set of branches that exist there".

These days, people who would want the maching behaviour can explicitly ask
for it, so there is one less reason to resist changing the default
(i.e. earlier explicitly askinf for "matching" was impossible, but now we
can).  The remaining reason of resistance is pure inertia (i.e. not
changing the behaviour of the command only because you upgraded your git),
and the only way to address it is to start issuing the warning when "git
push" or "git push $there" is used and the matching behaviour was chosen
without configuration (i.e. no "remote.<there>.push = :"), and keep it
that way for two release cycles, and finally change the default.
