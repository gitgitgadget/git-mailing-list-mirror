From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem in our test setup
Date: Thu, 15 Nov 2007 09:30:26 -0800
Message-ID: <7v3av75sct.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711150618300.4362@racer.site>
	<7vzlxg6kzt.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711151237400.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 15 18:31:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsiYM-0000f4-Qp
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 18:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756830AbXKORam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 12:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756187AbXKORal
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 12:30:41 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50758 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756538AbXKORal (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 12:30:41 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 9140B2EF;
	Thu, 15 Nov 2007 12:31:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2AF6C96072;
	Thu, 15 Nov 2007 12:31:00 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711151237400.16728@wbgn129.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 15 Nov 2007 12:40:30 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65142>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Funnily enough, it _is_ the non-dash form that I replaced.  What happens 
> is this: the git wrapper looks for a builtin named 'runstatus', does not 
> find it, then calls out for something like 'git-runstatus', which is found 
> in my $HOME/bin.

Yes, but at that point we know we are looking for "git"
subcommand not general command on PATH, so we can only look for
"git-runstatus" in the git_exec_path (initialized by $GIT_EXEC_PATH 
or compiled-in) and correctly fail during the test.
