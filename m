From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] A test for commit --amend allowing changing of a very
 empty commit message
Date: Thu, 21 Feb 2008 12:23:10 -0800
Message-ID: <7vwsoyt5xt.fsf@gitster.siamese.dyndns.org>
References: <20080221195438.GA6973@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 21:24:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSHxc-00057m-Qe
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 21:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756285AbYBUUX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 15:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756241AbYBUUX2
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 15:23:28 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37741 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436AbYBUUX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 15:23:27 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1A5FA242C;
	Thu, 21 Feb 2008 15:23:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 77BB0242B; Thu, 21 Feb 2008 15:23:19 -0500 (EST)
In-Reply-To: <20080221195438.GA6973@steel.home> (Alex Riesen's message of
 "Thu, 21 Feb 2008 20:54:38 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74651>

Alex Riesen <raa.lkml@gmail.com> writes:

> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>
> Well, it fails... In current master

Then please mark it with test_expect_failure.

> +test_expect_success 'allow amend of an empty message' '
> +
> +	git reset --hard &&
> +	sha=$(:|git commit-tree HEAD^{tree} -p HEAD) &&

You do not have to pipe; </dev/null would do ;-).
