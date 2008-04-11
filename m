From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] When a remote is added but not fetched, tell the user.
Date: Fri, 11 Apr 2008 14:39:11 -0700
Message-ID: <7v4pa8rs00.fsf@gitster.siamese.dyndns.org>
References: <20080409101428.GA2637@elte.hu>
 <1207869946-17013-1-git-send-email-g2p.code@gmail.com>
 <alpine.DEB.1.00.0804111621080.31025@eeepc-johanness>
 <20080411203501.7095b866@localhost> <20080411190816.GA17277@mithlond>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gabriel <g2p.code@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Fri Apr 11 23:40:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkQyc-0003pd-Eh
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 23:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593AbYDKVjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 17:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755607AbYDKVjU
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 17:39:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55476 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755593AbYDKVjU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 17:39:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AC65928C7;
	Fri, 11 Apr 2008 17:39:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E95A528C6; Fri, 11 Apr 2008 17:39:13 -0400 (EDT)
In-Reply-To: <20080411190816.GA17277@mithlond> (Teemu Likonen's message of
 "Fri, 11 Apr 2008 22:08:16 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79299>

Teemu Likonen <tlikonen@iki.fi> writes:

> Gabriel wrote (2008-04-11 20:35 +0200):
>
>> I think the transcript that started the thread makes it clear that
>> having "git remote add" not fetching is not the right default. The
>> user wants to use a remote repository, and has learned these are
>> called "remotes". So he does not have too much trouble
>> finding/remembering the command "git remote add <name> <url>". Now
>> with the user's goal in mind, it makes no sense to add a remote and
>> then not fetch it, because the user definitely wants to do something
>> with the remote. By not fetching it, we are surprising the user 
>
> Hmm, I'm quite newbie but I have never expected "git remote add" to
> fetch anything. I wouldn't want it to do it automatically. From the
> beginning I saw "git remote" as a _configuration_ tool.

Good student ;-).

Not only that fetch-after-add is _not_ a common nor majority thing at all
(contrary to what Gabriel assumed), the "fetch" step is conceptually an
unrelated operation from the primary point of "remote add"; "-f" option is
a mere convenience feature and we stop at making it conveniently
available, never making it a default nor overly advertising it.

If the user tells you not to fetch, the command should not bother the user
with excess messages, unless the user explicitly asks to, either.
