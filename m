From: Junio C Hamano <gitster@pobox.com>
Subject: Re: using git-blame with patches as input
Date: Mon, 16 Jun 2008 14:54:54 -0700
Message-ID: <7vabhl9hap.fsf@gitster.siamese.dyndns.org>
References: <20080616213517.GE20727@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 23:56:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8MgB-0000az-Mj
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 23:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213AbYFPVzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 17:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756202AbYFPVzE
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 17:55:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34113 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756125AbYFPVzD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 17:55:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7EC6BD710;
	Mon, 16 Jun 2008 17:55:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BDB44D70C; Mon, 16 Jun 2008 17:54:57 -0400 (EDT)
In-Reply-To: <20080616213517.GE20727@redhat.com> (Don Zickus's message of
 "Mon, 16 Jun 2008 17:35:17 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DF44E948-3BEE-11DD-9480-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85238>

Don Zickus <dzickus@redhat.com> writes:

> For example, if I took the top three commits from HEAD and appended them
> into one patch file and then ran this tool with the patch as input, I
> would hope that it gave as output the three original commits.

Unfortunately blame does not work in such an inefficient way.  The patch
text from your second commit (that is, the diff that shows what used to be
in the first commit and what is in the second commit) may be further
rewritten in the third commit, so if you start blaming such a text from
HEAD, the blame stops at the HEAD commit saying "the text you have is even
newer".

> ...  Unfortunately, I don't quite understand
> some of the algorithms git-blame does when it splits the patch chunks into
> smaller pieces to determine which pieces are blame-able on the parents.

http://thread.gmane.org/gmane.comp.version-control.git/28826
