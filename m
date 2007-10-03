From: Junio C Hamano <gitster@pobox.com>
Subject: Re: making "git stash" safer to use
Date: Wed, 03 Oct 2007 14:36:37 -0700
Message-ID: <7vwsu3dgnu.fsf@gitster.siamese.dyndns.org>
References: <200709301421.52192.bruno@clisp.org>
	<200710021350.54625.bruno@clisp.org> <47023699.3080606@byu.net>
	<200710032331.41385.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Benoit SIGOURE <tsuna@lrde.epita.fr>,
	Eric Blake <ebb9@byu.net>
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 23:37:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdBtn-000416-Fc
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 23:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbXJCVgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 17:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754958AbXJCVgr
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 17:36:47 -0400
Received: from rune.pobox.com ([208.210.124.79]:54696 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753077AbXJCVgr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 17:36:47 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id D246E141316;
	Wed,  3 Oct 2007 17:37:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id DBDA9141309;
	Wed,  3 Oct 2007 17:37:02 -0400 (EDT)
In-Reply-To: <200710032331.41385.bruno@clisp.org> (Bruno Haible's message of
	"Wed, 3 Oct 2007 23:31:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59891>

Bruno Haible <bruno@clisp.org> writes:

>> While we're at it, I wish 'git stash clear' would take an optional
>> argument that says which stash(es) to clear, rather than blindly clearing
>> the entire stash.
>
> It would help if git would store which of the stashes were applied since
> they were created and which were not. A stash that was not yet applied must
> be considered "precious", whereas a stash that was applied is redundant,
> right?

Wrong.  I would say all stash entries are precious unless you
explicitly say "I'm done with it".  The problem is that we do
not have a way to say it explicitly.
