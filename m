From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Include rev-list options in git-log manpage.
Date: Fri, 18 Jan 2008 11:51:42 -0800
Message-ID: <7v8x2mewtt.fsf@gitster.siamese.dyndns.org>
References: <20080117214425.GP29972@genesis.frugalware.org>
	<7vejcfiop4.fsf@gitster.siamese.dyndns.org>
	<20080118161714.GS29972@genesis.frugalware.org>
	<4790D5B7.2000508@viscovery.net>
	<20080118171827.GV29972@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 20:52:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFxGE-000281-VL
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 20:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761909AbYARTvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 14:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761801AbYARTvu
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 14:51:50 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33197 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761706AbYARTvt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 14:51:49 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 856266B2A;
	Fri, 18 Jan 2008 14:51:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 086466B28;
	Fri, 18 Jan 2008 14:51:44 -0500 (EST)
In-Reply-To: <20080118171827.GV29972@genesis.frugalware.org> (Miklos Vajna's
	message of "Fri, 18 Jan 2008 18:18:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71056>

Miklos Vajna <vmiklos@frugalware.org> writes:

> +ifndef::git-log[]
>  Using these options, linkgit:git-rev-list[1] will act similar to the
>  more specialized family of commit log tools: linkgit:git-log[1],
>  linkgit:git-show[1], and linkgit:git-whatchanged[1]
> +endif::git-log[]

> +ifndef::git-log[]
>  --bisect::
>  
>  Limit output to the one commit object which is roughly halfway between
> @@ -388,6 +302,7 @@ may not compile for example).
>  This option can be used along with `--bisect-vars`, in this case,
>  after all the sorted commit objects, there will be the same text as if
>  `--bisect-vars` had been used alone.
> +endif::git-log[]

I do not like these.  What you are really trying to express is
"this section makes sense only in rev-list documentation", not
"among the current set of documentation, the one this section
does not make sense in is git-log".  We might end up including
this in some other documents.

IOW, they should rather be "ifdef::git-rev-list[]" instead,
(of course you have to define that token yourself if there isn't
one already).
