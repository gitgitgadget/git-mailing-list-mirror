From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-walkthrough-add script
Date: Fri, 04 Jan 2008 18:50:08 -0800
Message-ID: <7vprwhf0kf.fsf@gitster.siamese.dyndns.org>
References: <1199426431-sup-6092@south>
	<20080104072650.GA24685@coredump.intra.peff.net>
	<1199471454-sup-4786@south>
	<20080104210751.GB26248@coredump.intra.peff.net>
	<1199500441-sup-4067@south>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: William Morgan <wmorgan-git@masanjin.net>
X-From: git-owner@vger.kernel.org Sat Jan 05 03:50:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAz7a-0002A6-Hf
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 03:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682AbYAECuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 21:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754733AbYAECuY
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 21:50:24 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60152 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428AbYAECuX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 21:50:23 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 28C91359C;
	Fri,  4 Jan 2008 21:50:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 69E88359A;
	Fri,  4 Jan 2008 21:50:15 -0500 (EST)
In-Reply-To: <1199500441-sup-4067@south> (William Morgan's message of "Fri, 04
	Jan 2008 18:37:34 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69632>

William Morgan <wmorgan-git@masanjin.net> writes:

> Excerpts from Jeff King's message of Fri Jan 04 13:07:51 -0800 2008:
>> But if you have interface improvement suggestions for "git-add -i" or
>> "git-add -p", I'm sure they would be well-received (post-1.5.4
>> release, of course).
>
> Not to show off my git newbness any more than necessary, but when I run
> both git-add -i and git-add -p, I see exactly the same output and
> interface. Are they meant to be different?

They are meant to be different.

    $ git reset --hard
    $ echo >>Makefile
    $ echo >>psql/Makefile
    $ git add -p
    diff --git a/Makefile b/Makefile
    index a2177bc..eb250b0 100644
    --- a/Makefile
    +++ b/Makefile
    @@ -54,3 +54,4 @@ snapdiff ::
            latest=`ls -1dr $(_snap)/release-????-??-?? | head -n 1` &&
            \
            diff -X dontdiff -ru "$$latest" .

    +
    Stage this hunk [y/n/a/d/?]? ^C

    $ git add -i
               staged     unstaged path
      1:    unchanged        +1/-0 Makefile
      2:    unchanged        +1/-0 psql/Makefile

    *** Commands ***
      1: [s]tatus     2: [u]pdate     3: [r]evert     4: [a]dd
      untracked
      5: [p]atch      6: [d]iff       7: [q]uit       8: [h]elp
    What now> ^C

There may be something broken with your git installation.
