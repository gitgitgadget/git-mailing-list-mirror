From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [minor usability suggestion] git rebase <upstream> --onto
 <newbase> ?
Date: Fri, 07 Nov 2008 10:23:42 -0800
Message-ID: <7vej1ngztd.fsf@gitster.siamese.dyndns.org>
References: <20081107092035.GA1339@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Fri Nov 07 19:26:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyW1o-0003fx-98
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 19:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbYKGSYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 13:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbYKGSYW
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 13:24:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63907 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbYKGSYV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 13:24:21 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 858DC7A998;
	Fri,  7 Nov 2008 13:24:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5B0EB7A98F; Fri,
  7 Nov 2008 13:23:49 -0500 (EST)
In-Reply-To: <20081107092035.GA1339@elte.hu> (Ingo Molnar's message of "Fri,
 7 Nov 2008 10:20:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4B8CDF9A-ACF9-11DD-A1E8-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100321>

Ingo Molnar <mingo@elte.hu> writes:

>  earth4:~/tip> git rebase 685aebb --onto linus
>  Current branch core/urgent is up to date.
> ...
> For example "git log" is exemplary in this area as it accepts just 
> about any permutation of parameters thrown at it, ...

Not really.

There may be oddball commands whose parameter order have been established
differently long before "git log" came, but almost all of them now use the
same convention used by the "git log" family, which is flags/options then
revs (and then paths if the operation makes sense with paths).  And rebase
is not one of the oddball ones.

Your "rebase" example is a rev then a flag/option, which is not how any
other git command take its command line parameters.

> Or at least we should print some sort of warning/error?

With that I agree with.  Patches? ;-)
