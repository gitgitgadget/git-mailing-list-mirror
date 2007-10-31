From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Add --first-parent support to interactive rebase.
Date: Tue, 30 Oct 2007 22:05:27 -0700
Message-ID: <7vodefj2lk.fsf@gitster.siamese.dyndns.org>
References: <1193797309-1161-1-git-send-email-B.Steinbrink@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 06:06:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In5m5-00083F-1v
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 06:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbXJaFFg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2007 01:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752223AbXJaFFg
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 01:05:36 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:33255 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbXJaFFg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Oct 2007 01:05:36 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C07492EF;
	Wed, 31 Oct 2007 01:05:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 32B038E8C9;
	Wed, 31 Oct 2007 01:05:53 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62793>

Your MUA seems to mark the UTF-8 message you are sending out as
8859-1, which means your name in the message gets corrupt.

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> By default, rebase will take all commits from the branch that is to b=
e
> rebased which are missing in upstream. The new --first-parent option
> allows to just follow the first parent and thus completely ignore
> merges.
>
> Additionally, when used together with --preserve-merges (which is the
> more useful use-case) it will no longer rebase the commits from the
> merged-in branches, but instead redo the merge with the original
> parents.
>
> That means that:
>      ---H------I topicB

Please add a blank line after "means that:" for readability.

>     /    \      \
> ...
> does no longer become:
>                 -H'--------I'

Likewise; also, "no longer becomes:".

>                /  \         \
>               D'---E'---F'---G' topicA
>              /
>     A---B---C master
>      \
>       H---I topicB
>
> but instead:
>     A---B---C master

Likewise.

> ...
>         ---------H---------I topicB

And crucially, you forgot to say "... when you do X".

I am assuming that you meant:

    This (picture) becomes this (picture) instead of this (picture)
    when you run "git rebase -p -m master topicA".

but without it, the nice ASCII drawings loses their value.

It is somewhat disturbing that this treats the first parent too
special.
