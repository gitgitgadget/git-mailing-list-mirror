From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is it possible to roll back unstaged changes while leaving the
 staged ones for the next commit?
Date: Wed, 17 Dec 2008 14:59:22 -0800
Message-ID: <7vbpvajtmd.fsf@gitster.siamese.dyndns.org>
References: <c115fd3c0812171157m3d180534gb5630fbcf39b2bbd@mail.gmail.com>
 <7vy6yelf2m.fsf@gitster.siamese.dyndns.org>
 <c115fd3c0812171448o3db6f4c1oc24e39f9a68ed1d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tim Visher" <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 00:00:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD5Nn-000708-Qi
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 00:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbYLQW73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 17:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbYLQW73
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 17:59:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47141 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbYLQW73 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 17:59:29 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CA9331A766;
	Wed, 17 Dec 2008 17:59:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 480C01A728; Wed,
 17 Dec 2008 17:59:23 -0500 (EST)
In-Reply-To: <c115fd3c0812171448o3db6f4c1oc24e39f9a68ed1d3@mail.gmail.com>
 (Tim Visher's message of "Wed, 17 Dec 2008 17:48:50 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5B2E4510-CC8E-11DD-B0E2-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103408>

"Tim Visher" <tim.visher@gmail.com> writes:

> On Wed, Dec 17, 2008 at 3:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>>  (1) if you want to get rid of garbage changes in your work tree, you
>>     would want "git checkout $that_path";
>>
>>  (2) if you want to temporarily stash away further changes in your work
>>     tree, because you would want to first test what is staged, commit it,
>>     and then later continue to refine the changes stashed away thusly,
>>     you would want "git stash --keep-index".
> ...
> Unfortunately I couldn't figure out how to do this.  The solution I
> came up with was to go ahead and `git commit` the staged changes and
> then `git checkout PATH` the just committed file to overwrite the
> local edits with the version of the file I wanted.

How about omitting the "git commit" and do "git checkout PATH" after you
are done with the staging?  IOW, (1) above.
