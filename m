From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: Change whatchanged to report changes from merges by
 default?
Date: Sat, 20 Dec 2008 12:09:05 -0800
Message-ID: <7vvdtewqvy.fsf@gitster.siamese.dyndns.org>
References: <20081220104232.5ff1b7c0@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Burton <markb@ordern.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 21:10:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE89o-0001hc-6s
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 21:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbYLTUJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 15:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753248AbYLTUJN
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 15:09:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36403 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198AbYLTUJN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 15:09:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 855D01A7CA;
	Sat, 20 Dec 2008 15:09:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5E37C1AB73; Sat,
 20 Dec 2008 15:09:06 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1071EED2-CED2-11DD-8754-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103656>

Mark Burton <markb@ordern.com> writes:

> Is it just an accident of history or by design that whatchanged
> requires the -m option to show changes introduced by merges but
> diff and git log show those changes without requiring any extra
> options?

Mostly personal preference and inertia..

I personally do not see any reason for anybody to use whatchanged (what a
long single-word to type!) since around git version v1.0.0 or so.  Back
then, whatchanged was a good way to satisfy "I want a quick sanity check,
but I want to see a bit more than just names of files to assure me.  But I
want to get that without actually running the diffs or stats because I
consider that anything that takes more than half a second is too
expensive."  But ever since we made the diff generation built-in, the
performance objection ceased to be an issue.  These days I'd imagine that
"log --name-only" or even "log --stat" would be perfectly acceptable and
easier to explain alternative, especially if you happen to be a very early
adopter whose fingers are trained to type "whatchanged".

IOW, I consider "whatchanged" a command that is kept only for old timers'
sake.  There is no reason to promote it, but there is no reason to
deprecate it, either.  Which means the answer to this question...

> Would it not make more sense to have git whatchanged show the changes
> introduced by merges by default and then people can use the (already
> supported) --no-merges option to suppress that behaviour?

... is a NO spelled in capital letters.
