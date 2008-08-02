From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git svn and the post-receive hook
Date: Sat, 02 Aug 2008 11:22:13 -0700
Message-ID: <7v8wvfmg4q.fsf@gitster.siamese.dyndns.org>
References: <489485BC.1020607@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Sat Aug 02 20:23:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPLlA-0000lL-Kv
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 20:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbYHBSWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 14:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754129AbYHBSWU
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 14:22:20 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55961 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402AbYHBSWT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 14:22:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B4D16484CE;
	Sat,  2 Aug 2008 14:22:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BEDAA484CC; Sat,  2 Aug 2008 14:22:15 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F0E0DBEE-60BF-11DD-A087-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91166>

Pascal Obry <pascal@obry.net> writes:

> At the moment it seems to me that the post-receive hook is not called
> when tracking a remove Subversion repository.
>
> I think it would be nice to call the post-receive hook at the end of:
>
>    $ git svn rebase
>
> Why I need this?
>
> I'd like to check ...

Wait a minute.

Isn't "git svn rebase" an operation that you do on your local repository,
slurping the update from the other end and then replaying your change on
top of it?  If so, I think it falls into the same category as "post-fetch"
hook which would run after you run fetch, if such a thing existed.  See:

    http://thread.gmane.org/gmane.comp.version-control.git/79306/focus=79321

for the reason why we usually do not add such a hook on the local end.
