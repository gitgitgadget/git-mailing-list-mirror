From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "unpack-objects --strict"
Date: Fri, 14 Aug 2009 00:31:43 -0700
Message-ID: <7vocqisvfk.fsf@alter.siamese.dyndns.org>
References: <20090813103231.GY14475@mail-vs.djpig.de>
 <20090813111933.GZ14475@mail-vs.djpig.de>
 <7vd46zbjae.fsf@alter.siamese.dyndns.org>
 <20090814060307.GA31721@auto.tuwien.ac.at>
 <7vocqiucpw.fsf@alter.siamese.dyndns.org>
 <20090814071949.GA2342@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Fri Aug 14 09:35:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbrJP-0007wo-66
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 09:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003AbZHNHbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 03:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754833AbZHNHbs
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 03:31:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44122 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831AbZHNHbs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 03:31:48 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2CB3328F34;
	Fri, 14 Aug 2009 03:31:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D6E0B28F29; Fri, 14 Aug 2009
 03:31:44 -0400 (EDT)
In-Reply-To: <20090814071949.GA2342@auto.tuwien.ac.at> (Martin Koegler's
 message of "Fri\, 14 Aug 2009 09\:19\:49 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 872BE636-88A4-11DE-89DB-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125914>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> I'm talking on the server side of a push operation (receive-pack), not
> the client side. The patchset should prevent invalid data from
> entering the repository, thereby preventing upload-pack (during further
> fetch operation) and other git programs (eg. called from gitweb) from
> failing/segfaulting.

upload-pack won't feed starting from a random object for a reason, so your
worry is unfounded.

I'd agree gitweb may be a problem.  Ideally it should restrict itself from
anything reachable from the refs of he repository---patches welcome.
