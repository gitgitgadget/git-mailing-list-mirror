From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-branch - allow deleting a fully specified
 branch-name
Date: Thu, 09 Apr 2009 17:39:46 -0700
Message-ID: <7vhc0x1gvh.fsf@gitster.siamese.dyndns.org>
References: <1239323335-4684-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 02:41:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls4oN-0008W2-1b
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 02:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937620AbZDJAj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 20:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937433AbZDJAjz
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 20:39:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47673 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576AbZDJAjx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 20:39:53 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 899A1A91B2;
	Thu,  9 Apr 2009 20:39:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6D792A91AE; Thu,
  9 Apr 2009 20:39:48 -0400 (EDT)
In-Reply-To: <1239323335-4684-1-git-send-email-mlevedahl@gmail.com> (Mark
 Levedahl's message of "Thu, 9 Apr 2009 20:28:55 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1A47252A-2568-11DE-9DB3-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116230>

Mark Levedahl <mlevedahl@gmail.com> writes:

> This change allows, for instance
> 	git branch -d refs/heads/foo
> to succeed. Without this patch, the code just assumes that the
> given branch name should be appended to "refs/heads" or
> "refs/remotes", thus attempting (and failing) in the above case
> to delete "refs/heads/refs/heads/foo"

Your logic is broken.

Why doesn't the user simply say "git branch -d foo"?  The command takes
"the branch name", not "arbitrary ref name".
