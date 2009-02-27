From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Teach @{-1} to git merge
Date: Thu, 26 Feb 2009 21:24:21 -0800
Message-ID: <7veixkpi4a.fsf@gitster.siamese.dyndns.org>
References: <7v4oyxzeay.fsf@gitster.siamese.dyndns.org>
 <76718490902132311j5add87bcpb103c951a8192b05@mail.gmail.com>
 <7vzlgpxz4g.fsf@gitster.siamese.dyndns.org>
 <7vskmhuzla.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902142332210.10279@pacific.mpi-cbg.de>
 <86d4c5e00902262027y13b19eb7nf89a45e83b986801@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Deskin Miller <deskinm@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 06:26:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcvEj-0006Nr-PX
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 06:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbZB0FYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 00:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbZB0FYd
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 00:24:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbZB0FYc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 00:24:32 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3AB8C2029;
	Fri, 27 Feb 2009 00:24:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8D6372024; Fri,
 27 Feb 2009 00:24:23 -0500 (EST)
In-Reply-To: <86d4c5e00902262027y13b19eb7nf89a45e83b986801@mail.gmail.com>
 (Deskin Miller's message of "Thu, 26 Feb 2009 23:27:05 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E76E0D8E-048E-11DE-8CF8-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111630>

Deskin Miller <deskinm@gmail.com> writes:

> I did 'git branch -M @{-1}' yesterday and ended up renaming my branch
> to refs/heads/@{-1}.  Personally my usage felt like it should work
> (but of course I think that); curious to know what others think, if
> this is a bug.

The @{-n} notation is supposed to be usable anywhere you would write a
branch name and should behave as if you wrote the name itself.  And 'git
branch -M <name> [<name>]' does expect a branch name, not a random
extended SHA-1 expression.

I'd say it is a bug.
