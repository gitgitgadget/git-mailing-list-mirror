From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-ls-tree.txt: Add a caveat about
 prefixing pathspec
Date: Mon, 28 Jul 2008 02:23:46 -0700
Message-ID: <7vabg2s6ot.fsf@gitster.siamese.dyndns.org>
References: <20080720233956.GH10151@machine.or.cz>
 <20080721075618.14163.45309.stgit@localhost>
 <7v1w1nvf7q.fsf@gitster.siamese.dyndns.org>
 <20080721210452.GP10151@machine.or.cz>
 <7vd4l6sqqz.fsf@gitster.siamese.dyndns.org>
 <20080722224759.GJ32184@machine.or.cz> <20080728004604.GF32184@machine.or.cz>
 <7vvdyqx0i0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jul 28 11:24:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNOyL-0008Vt-Mq
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 11:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbYG1JXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 05:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbYG1JXx
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 05:23:53 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbYG1JXx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 05:23:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D229A3FF8E;
	Mon, 28 Jul 2008 05:23:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 18A203FF8D; Mon, 28 Jul 2008 05:23:48 -0400 (EDT)
In-Reply-To: <7vvdyqx0i0.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 27 Jul 2008 18:26:15 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E469FC66-5C86-11DD-B5B0-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90430>

Junio C Hamano <gitster@pobox.com> writes:

> Petr Baudis <pasky@suse.cz> writes:
>
>>> We may throw a dice or go with your version, I don't care *that* much
>>> about this change, I just wouldn't make it personally.
>>
>> What is the status of this patch? :-) Dropped altogether?
>
> Left behind on the far side of oblivion; I do not offhand recall what this
> was about, sorry.

Ok, I now recall this bit:

        You are right, now that I understand the issue better, there's no good
        fix for this except perhaps introducing --no-prefix, which is not my
        itch to scratch. Here's my original wording improvement:

                Note that if you are within a subdirectory of your working copy,
                'git ls-tree' will automatically prepend the subdirectory prefix
                to the specified paths, and assume the prefix specified in case
                no paths were given - no matter what the tree object is! Thus,
                within a subdirectory, 'git ls-tree' behaves as expected only
                when run on a root tree object.

Eventually somebody may write a Porcelain that benefits from --no-prefix,
but it is safe to defer the implementation until the need becomes real.

I'll add some explanatory message to the documentation.
