From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI
 revamp
Date: Sun, 02 Nov 2008 14:01:20 -0800
Message-ID: <7vtzap23f3.fsf@gitster.siamese.dyndns.org>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
 <20081030143918.GB14744@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org,
	Sam Vilain <samv@vilain.net>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Nov 02 23:03:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwl22-0003Ld-8t
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 23:02:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754313AbYKBWBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 17:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754305AbYKBWBh
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 17:01:37 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38751 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093AbYKBWBg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 17:01:36 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6D27977497;
	Sun,  2 Nov 2008 17:01:36 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D7DF877490; Sun,  2 Nov 2008 17:01:26 -0500 (EST)
In-Reply-To: <20081030143918.GB14744@mit.edu> (Theodore Tso's message of
 "Thu, 30 Oct 2008 10:39:18 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D17C9D30-A929-11DD-906D-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99879>

Theodore Tso <tytso@mit.edu> writes:

> Here are my favorites:
>
> * Add the command "git revert-file <files>" which is syntactic sugar for:
>
>         git checkout HEAD -- <files>

This is good; I do not recall offhand what we do if some of the <files> do
not appear in HEAD right now, but I have a suspicion that it would be a
no-op, in which case interested parties may first want to fix checkout to
remove such paths.

Also I thiink you can add "git revert-commit [$committish]" as a synonym
to the current "git revert [$committish]" if it makes things easier to
explain to others.

> * Change the argument handling for "git format-patch" so it is
>   consistent with everything else which takes a set of commits.  Yes,
>   it means that where people have gotten used to typing "git
>   format-patch origin", they'll have to type instead: "git
>   format-patch origin..", but's much more consistent.

I think that has already happened some time ago in the sense that you can
say "origin.."  and it does what you want.  I do not think it merits to
deprecate the original one --- if you do not like it, you do not use it
nor teach it to others.
