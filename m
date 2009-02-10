From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] shortstatus v1
Date: Tue, 10 Feb 2009 07:58:47 -0800
Message-ID: <7vwsbynv0o.fsf@gitster.siamese.dyndns.org>
References: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com>
 <20090210110330.GB12089@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 10 17:00:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWv2J-00054y-T3
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 17:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795AbZBJP64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 10:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753251AbZBJP6z
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 10:58:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39687 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbZBJP6y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 10:58:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DC31F98DC1;
	Tue, 10 Feb 2009 10:58:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8AAC798DBF; Tue,
 10 Feb 2009 10:58:49 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B74CEC5C-F78B-11DD-8FE4-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109260>

Jeff King <peff@peff.net> writes:

> Some comments:
>
>   1. Is the staggered indentation intentional? It looks awful, and the
>      only use I can think of is to separate unstaged from staged
>      changes. But surely there must be a more obvious way of doing so.

Probably not.

>   2. Why do staged changes get a letter marking what happened, but
>      unstaged changes do not?

Bug?   FWIW, the original patch from October shows:

    M changed
M   M changed-again
M     changed-staged
    D deleted
D     deleted-staged

(where changed-again has both staged changes and further changes in the
work tree).

The gap between these two are to show the rename similarity index, which
we could do without.

>   3. What advantage does this have over just doing:
>
>        (git diff --name-status;
>         git diff --cached --name-status) | sort -k2
>
>> Right now this is basically Junio's shortstatus
>> from Oct 25th 2008 with no substantial change
>> except a line or two.
>
> This is not a very helpful commit message. What is it supposed to do?
> What does the output look like? Why is it implemented this way? If Junio
> sent a patch in October and it isn't substantially changed, why wasn't
> it accepted then?

The output mimicked what was in Shawn's "repo" tool announcement IIRC.

My patch was supposed to give interested parties hint to base a patch like
Tuncer's on (I think this answers your last question, too).
