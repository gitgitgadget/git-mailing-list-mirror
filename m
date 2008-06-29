From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told to
Date: Sun, 29 Jun 2008 01:56:38 -0700
Message-ID: <7vhcbcd3g9.fsf@gitster.siamese.dyndns.org>
References: <20080628090642.6117@nanako3.lavabit.com>
 <20080629073212.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Git Mailing List <git@vger.kernel.org>
To: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 10:57:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCsj8-0003B3-V6
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbYF2I4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbYF2I4q
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:56:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53562 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbYF2I4p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 04:56:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6CFF229CB;
	Sun, 29 Jun 2008 04:56:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B407229CA; Sun, 29 Jun 2008 04:56:40 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4C6B10D2-45B9-11DD-953F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86789>

しらいしななこ <nanako3@lavabit.com> writes:

> Quoting myself:
>
>>>> Don't you also want to talk about distinction between --cached and
>>>> --index that new people are often confused about?  These options are
>>>> defined consistently across commands but people who do not know it bring
>>>> up discussions to rename --cached to some commands to --index to make it
>>>> inconsistent and waste your time every once in a while.
>...
> Junio, I haven't heard back from you yet and I take it you mean you are not interested in a vague suggestion but in a concrete patch, so here it is.

Well, I pretended that I did not notice the original question because I
wanted to avoid addressing this issue ;-<.

While I think --index/--cached are not particularly good pair of words, as
one of the old article you pointed at in your documentation update states,
to describe the distinction, the commands do use them consistently to
differentiate what are operands to them clearly and consistently.  In that
sense, your documentation update would probably be a good idea.  At least
it makes it easier for new people to learn it just once, and once you know
the distinction and remember which is which, you can reuse the knowledge
to all the commands.


Even though I myself freely admit that these are not particularly a good
pair of words, it is not realistic to expect --index and --cached to ever
be deprecated.  But every time this comes up on the list, people end up
wasting time trying to repaint this old bikeshed.  That is the primary
reason I did not want to talk about it.  It still is possible to introduce
a pair of synonyms that new people might find more descriptive, perhaps:

	--index-only = --cached
        --index-also = --index

but I personally do not think it would add much value to the system..

> +NOTES ON FREQUENTLY CONFUSED OPTIONS
> +------------------------------------

Hmmm.  Is this in anticipation for more "confusing" options described in
this section?

> +Many commands that can work on files in the working tree
> +and/or in the index can take `--cached` and/or `--index`
> +options.  Sometimes people incorrectly think that, because
> +the index was originally called cache, these two are
> +synonyms.  They are _not_ --- these two options mean very

In e-mails we use _underscore_ but I do not think it works in AsciiDoc.
I'll munge this (you have others below) to "*not*".  Also unlike LaTeX,
long dash is two dashes (--), not three (---).
