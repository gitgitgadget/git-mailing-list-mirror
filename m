From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] gitweb: Use "previous" header of git-blame -p in
 'blame' view
Date: Fri, 10 Jul 2009 15:21:05 -0700
Message-ID: <7v4otkuqlq.fsf@alter.siamese.dyndns.org>
References: <200907102354.43232.jnareb@gmail.com>
 <200907102357.43475.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 00:21:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPOT2-0000y7-SA
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 00:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756744AbZGJWVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 18:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756719AbZGJWVN
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 18:21:13 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63424 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756626AbZGJWVN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 18:21:13 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2C3E02600D;
	Fri, 10 Jul 2009 18:21:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4E07726008; Fri,
 10 Jul 2009 18:21:07 -0400 (EDT)
In-Reply-To: <200907102357.43475.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri\, 10 Jul 2009 23\:57\:42 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F98D031A-6D9F-11DE-A9AE-424D1A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123090>

Jakub Narebski <jnareb@gmail.com> writes:

> Luben Tuikov changed 'lineno' link (line number link) from pointing to
> 'blame' view at given line at blamed commit, to the one at parent of
> blamed commit in
>   244a70e (Blame "linenr" link jumps to previous state at
>            "orig_lineno", 2007-01-04).
> This made it possible to do data mining using 'blame' view, by going
> through history of a line using mentioned line number link.

I was playing with this feature the other day (and I think you can guess
what I was writing when I was doing so as preparation).  I was mildly
annoyed that these links on the commit object names go to the commit view.

I think going to commitdiff view would make it far more useful while
digging.

Suppose if you were somehow interested in the recent commit by Peff,
"Makefile: install 'git' in execdir".  You go to:

    http://repo.or.cz/w/alt-git.git

and look at commitdiff of the commit from the shortlog part.

You read the diff, understand what the changed Makefile does, but you get
curious to see the blame.  Nicely, the commitdiff view has a list of the
files changed, and each entry in the list has "blame" link.

Clicking it would give you the blame on each line from the Makefile.

So far, very smooth experience.  Then you scroll to an area of the file
you are interested in, and click on one of the commits.

Oops.

It does not show the change of the commit made by this one, even though it
does list Makefile in the list of files changed, and it has a blame link,
the commit view without diff disrupts the thought process I had in the
previous blame page, and I have to go to commitdiff to reorient myself.
