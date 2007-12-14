From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makes 'git-stash show' stay quiet when there are no stashes.
Date: Thu, 13 Dec 2007 17:34:40 -0800
Message-ID: <7vir32xdn3.fsf@gitster.siamese.dyndns.org>
References: <20071214012838.GA8914@fawkes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jing Xue <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 02:35:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2zSN-0005RY-Qh
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 02:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759264AbXLNBew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 20:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757753AbXLNBew
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 20:34:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41697 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756922AbXLNBev (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 20:34:51 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 327C18484;
	Thu, 13 Dec 2007 20:34:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B0268481;
	Thu, 13 Dec 2007 20:34:43 -0500 (EST)
In-Reply-To: <20071214012838.GA8914@fawkes> (Jing Xue's message of "Thu, 13
	Dec 2007 20:28:38 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68210>

Jing Xue <jingxue@digizenstudio.com> writes:

> (I tried to send this trivial patch for a couple of times using
> git-send-email, but somehow it never turned up.)
>
> Currently when there are no stashes, 'git stash show' basically aborts with an
> error message from rev-parse: "fatal: Needed a single revision", which can be
> confusing. This patch makes git-stash keep quiet and exit gracefully in that
> case.

I agree "git stash show" should not give cryptic error message, but I
think you should do this only when the user did not explicitly say which
stash to show (that is, we should still give error message if the user
said "git stash show garbage").
