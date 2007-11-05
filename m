From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull opinion
Date: Mon, 05 Nov 2007 15:33:31 -0800
Message-ID: <7vd4uomfn8.fsf@gitster.siamese.dyndns.org>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 00:33:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpBS6-0008EV-FH
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 00:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbXKEXdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 18:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753374AbXKEXdk
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 18:33:40 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:51203 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbXKEXdk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 18:33:40 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 1AA1E2F0;
	Mon,  5 Nov 2007 18:33:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id A70DB929DA;
	Mon,  5 Nov 2007 18:33:54 -0500 (EST)
In-Reply-To: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com>
	(aghilesk@gmail.com's message of "Mon, 5 Nov 2007 16:52:12 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63586>

Aghiles <aghilesk@gmail.com> writes:

> Is there an "easier" way to pull into a dirty directory ? I am
> asking this to make sure I understand the problem and not
> because I find it annoying to type those 4 commands to perform
> a pull (although some of my colleagues do find that annoying :).

You need to switch your mindset from centralized SVN workflow.

The beauty of distributedness is that it redefines the meaning
of "to commit".  In distributed systems, the act of committing
is purely checkpointing and it is not associated with publishing
the result to others as centralized systems force you to.

Stop thinking like "I need to integrate the changes from
upstream into my WIP to keep up to date."  You first finish what
you are currently doing, at least to the point that it is
stable, make a commit to mark that state, and then start
thinking about what other people did.  You may most likely do a
"git fetch" followed by "git rebase" to update your WIP on top
of the updated work by others.

Once you get used to that, you would not have "a dirty
directory" problem.
