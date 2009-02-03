From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to diff versions of a file
Date: Mon, 02 Feb 2009 22:34:25 -0800
Message-ID: <7vk588do5q.fsf@gitster.siamese.dyndns.org>
References: <1c5969370902022100h7c03bbb6h2d9f443f877d89ec@mail.gmail.com>
 <alpine.DEB.1.10.0902022206060.28633@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Graham <mdg149@gmail.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Tue Feb 03 07:36:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUEtY-0004MN-Ix
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 07:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbZBCGee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 01:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbZBCGee
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 01:34:34 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56355 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641AbZBCGed (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 01:34:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B15496A36;
	Tue,  3 Feb 2009 01:34:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B2F3596A2F; Tue,
  3 Feb 2009 01:34:27 -0500 (EST)
In-Reply-To: <alpine.DEB.1.10.0902022206060.28633@asgard.lang.hm>
 (david@lang.hm's message of "Mon, 2 Feb 2009 22:08:44 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B7359630-F1BC-11DD-8985-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108154>

david@lang.hm writes:

> I don't think it's trivial

I think you meant to say it _is_ trivial.

> If you just wanted three commits ago you could do
>
> git diff HEAD..HEAD^^^ tree.c

That would give you a reverse diff; I think you probably meant the other
way around, "git diff HEAD~3 HEAD tree.c".

> but three changes to tree.c ago I think you need to do multiple
> iterations of git blame to find out what commit was three edits ago.

git diff $(git rev-list -3 HEAD -- tree.c | sed -n -e '$p') HEAD -- tree.c

This assumes that the history is linear but your statement "three edits
ago" already assumes that, so...
