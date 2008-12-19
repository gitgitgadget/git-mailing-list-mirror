From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to extract files out of a "git bundle", no matter what?
Date: Fri, 19 Dec 2008 12:07:09 -0800
Message-ID: <7vtz906iaa.fsf@gitster.siamese.dyndns.org>
References: <87iqpgc6bn.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mdl123@verizon.net, git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Dec 19 21:09:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDleI-0004La-9x
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 21:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbYLSUHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 15:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbYLSUHU
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 15:07:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36558 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbYLSUHT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 15:07:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 410C21AAAC;
	Fri, 19 Dec 2008 15:07:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2447A1AAAB; Fri,
 19 Dec 2008 15:07:11 -0500 (EST)
In-Reply-To: <87iqpgc6bn.fsf@jidanni.org> (jidanni@jidanni.org's message of
 "Sat, 20 Dec 2008 03:29:00 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A2830060-CE08-11DD-8EDC-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103578>

jidanni@jidanni.org writes:

> Someone has handed you a "git bundle".
> How do you get the files out of it?
> If it were cpio, you would use -i, if it were tar, you would use -x...
> You read the git-bundle man page.
> You only get as far as
> # git-bundle verify bundle.bdl
> The bundle contains 1 ref
> d01... /heads/master
> The bundle requires these 0 ref
> bundle.bdl is okay
>
> The rest is mish-mosh.

The last example in the git-bundle man page might be a bit cryptic but
that is how bundles are expected to be used.  To give people repository
access who do not have real network connection other than Sneakernet.

For one shot extraction, defining a remote in the config is overkill and
you could just say:

	git ls-remote bundle.bdl

to see what branches it contains and if you are interested in its
master branch and want to merge it to your history, then

	git pull bundle.bdl master

should do that.
