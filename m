From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Intricacies of submodules
Date: Thu, 17 Apr 2008 13:44:33 -0700
Message-ID: <7vabjsnrda.fsf@gitster.siamese.dyndns.org>
References: <47F15094.5050808@et.gatech.edu>
 <46dff0320804110904w531035f4w79c1889bc90c09ee@mail.gmail.com>
 <7vmyo0owep.fsf@gitster.siamese.dyndns.org> <1207970038.10408.8.camel@ginkgo>
 <7vlk3jlkrr.fsf@gitster.siamese.dyndns.org>
 <1208202740.25663.69.camel@work.sfbay.sun.com>
 <7vd4or7wdt.fsf@gitster.siamese.dyndns.org>
 <1208317795.26863.91.camel@goose.sun.com> <87lk3c4ali.fsf@jeremyms.com>
 <1208461808.26863.129.camel@goose.sun.com>
 <46a038f90804171306t22491685p87d7445d44f00879@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Roman V. Shaposhnik" <rvs@sun.com>,
	"Jeremy Maitin-Shepard" <jbms@cmu.edu>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Ping Yin" <pkufranky@gmail.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 23:02:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmazG-0005WD-06
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 22:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbYDQUox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 16:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753291AbYDQUox
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 16:44:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54035 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbYDQUox (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 16:44:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8E5783E90;
	Thu, 17 Apr 2008 16:44:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9D1BB3E8F; Thu, 17 Apr 2008 16:44:40 -0400 (EDT)
In-Reply-To: <46a038f90804171306t22491685p87d7445d44f00879@mail.gmail.com>
 (Martin Langhoff's message of "Thu, 17 Apr 2008 17:06:27 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79822>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On Thu, Apr 17, 2008 at 4:50 PM, Roman V. Shaposhnik <rvs@sun.com> wrote:
>>  There are two things at play: first of all, I usually *do* trust the
>>  content of the repository. Call it matter of personal preference,
>
> I think most people here split the trust into "before or after
> compilation". I must trust that I can clone/checkout code safely so I
> can review it.

I think that summarizes the arguments so far pretty well.

Having said that, the current "clone" implementation may happen to ignore
in-tree anything, e.g. ident filter defined in .gitattributes may not be
applied due to chicken-and-egg issue of not having .gitattributes
initially in the work tree when you check everything out to an empty work
tree for the first time.

But I consider that is not by design, but is a limitation of the current
implementation that can be improved.
