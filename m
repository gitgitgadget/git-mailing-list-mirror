From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Adding Exit status documentation to all git commands starting
 with git status
Date: Sat, 13 Dec 2008 12:04:52 -0800
Message-ID: <7v4p176duj.fsf@gitster.siamese.dyndns.org>
References: <200812132036.39318.nadim@khemir.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git list" <git@vger.kernel.org>
To: nadim khemir <nadim@khemir.net>
X-From: git-owner@vger.kernel.org Sat Dec 13 21:06:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBakj-0000t5-9h
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 21:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbYLMUE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 15:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbYLMUE6
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 15:04:58 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52689 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657AbYLMUE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 15:04:58 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 104F287A22;
	Sat, 13 Dec 2008 15:04:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3768687A21; Sat,
 13 Dec 2008 15:04:54 -0500 (EST)
In-Reply-To: <200812132036.39318.nadim@khemir.net> (nadim khemir's message of
 "Sat, 13 Dec 2008 20:36:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5077AFB6-C951-11DD-B4F5-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103016>

nadim khemir <nadim@khemir.net> writes:

> There are different styles to add exit status, give me your input on why and 
> why not using one or the other. I list 3 solutions and what I think about 
> them.

No matter what you do, I think EXIT STATUS section should consistently
come near the end of the document, immediately before SEE ALSO, which is
where people who know how manual pages are written expect to find it.

> EXIT STATUS
> -----------
> The command exits with non-zero status if there is no path that is 
> different between the index file and the current HEAD commit (i.e.,
> there is nothing to commit by running `git commit`).

Prose is much easier to read as long as it is brief enough, than two-item
enumeration:

> EXIT STATUS
> -----------
> Zero status:      There is a different between the index file and HEAD.
> Non-zero status:  There is nothing to commit by running `git commit`. 

whose use of "Zero status" makes it look doubly funny (traditionally
manual pages do not seem to spell out exit status 0 as "zero", but
"non-zero" is Ok).

Avoid talking about only one side of the condition if you can without
being too verbose.

        The command exits with status 0 if there is something to commit by
        running `git commit` with corresponding arguments, and non-zero
        otherwise.
