From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [updated PATCH] Protect current tags, import tags into remote
 tree
Date: Mon, 28 Apr 2008 23:18:33 -0700
Message-ID: <7vbq3t89qe.fsf@gitster.siamese.dyndns.org>
References: <20080427173246.10023.94820.stgit@aristoteles.cuci.nl>
 <7vmynec60v.fsf@gitster.siamese.dyndns.org> <20080428184859.GA21950@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Tue Apr 29 08:19:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqjBs-0002zJ-VF
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 08:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773AbYD2GS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 02:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753794AbYD2GS5
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 02:18:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbYD2GSw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 02:18:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A48793962;
	Tue, 29 Apr 2008 02:18:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id EDE2638FE; Tue, 29 Apr 2008 02:18:40 -0400 (EDT)
In-Reply-To: <20080428184859.GA21950@cuci.nl> (Stephen R. van den Berg's
 message of "Mon, 28 Apr 2008 20:48:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80652>

"Stephen R. van den Berg" <srb@cuci.nl> writes:

> Rerunning cvsimport on a regular basis causes the import to (re)create
> all the tags from CVS again; if this is done in your regular tags space,
> this is a mess at best, or overwrites whatever renamed tags you
> carefully created which happen to match with old CVS tagnames.
> ...
> - git-svn and git-cvsimport cross the boundary to a different VCS and
>   therefore can/should use an extra barrier before (auto)converting to
>   git native tags (and branches).

That sounds like a sound argument, and perhaps people may wish we did so
from the day one.  Alas, we didn't.

So the course of action would be to do these over a long period of time.

 - introduce this as an option now;

 - give another option to explicitly ask for the current behaviour;

 - perhaps give an advance warning that this optional behaviour will
   become the default; and

 - finally swap the default behaviour.

if people agree with this change, that is.
