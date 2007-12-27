From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout without touching HEAD
Date: Thu, 27 Dec 2007 14:38:06 -0800
Message-ID: <7vsl1nix0x.fsf@gitster.siamese.dyndns.org>
References: <46a038f90712271422o7a831c09s463735ec41356b59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 27 23:38:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J81N9-000141-Gk
	for gcvg-git-2@gmane.org; Thu, 27 Dec 2007 23:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbXL0WiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2007 17:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbXL0WiO
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Dec 2007 17:38:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbXL0WiO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2007 17:38:14 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CC541641A;
	Thu, 27 Dec 2007 17:38:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A4B3640D;
	Thu, 27 Dec 2007 17:38:08 -0500 (EST)
In-Reply-To: <46a038f90712271422o7a831c09s463735ec41356b59@mail.gmail.com>
	(Martin Langhoff's message of "Fri, 28 Dec 2007 11:22:41 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69268>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> Is there a way to get a 'checkout' of a treeish _directly_ from git to
> an empty (or 'no conflicting paths'-guaranteed) directory, without
> touching HEAD?
>
> Using `git-archive ... | tar -x` is a waste of time and resources -- I
> do want this to be fast for large datasets. I have hacked it a bit by
> backing up HEAD, using git checkout with a temporary index, and then
> restoring HEAD, which I can do because my script has a big fat lock
> around it. But it's very un-gittish to need a big lock around me.

git read-tree -m -u HEAD $treeish
