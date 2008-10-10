From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git confused by rename
Date: Fri, 10 Oct 2008 08:44:08 -0700
Message-ID: <7vabdcmp4n.fsf@gitster.siamese.dyndns.org>
References: <fb6605670810100741k7cff25c7y4df66834cf7482a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael P. Soulier" <msoulier@digitaltorque.ca>
X-From: git-owner@vger.kernel.org Fri Oct 10 17:45:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoKBI-0003Nk-Aq
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 17:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759198AbYJJPoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 11:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759395AbYJJPoS
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 11:44:18 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49495 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759064AbYJJPoR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 11:44:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 223C489D4F;
	Fri, 10 Oct 2008 11:44:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5109F89D42; Fri, 10 Oct 2008 11:44:10 -0400 (EDT)
In-Reply-To: <fb6605670810100741k7cff25c7y4df66834cf7482a0@mail.gmail.com>
 (Michael P. Soulier's message of "Fri, 10 Oct 2008 10:41:54 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4B4D5712-96E2-11DD-9ADF-FA2D76724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97942>

"Michael P. Soulier" <msoulier@digitaltorque.ca> writes:

> #       renamed:    templates/scrc/index.html -> templates/scrc/cres_taps.html
> #       modified:   templates/scrc/index.html
>
> Looking at the last two lines here, there is obviously an issue.

I am puzzled.

Looking at wt-status.c "renamed: A -> B" will be shown only when A and B
are similar enough *and* there is no A remaining in the final result, and
in such a case, "modified: A" should not be shown.  Because git does not
care how you created B (IOW, it does not matter if B was typed from
scratch with copying and pasting, or created by copying and editing), the
"renamed: A -> B" entry itself is not surprising nor look like a bug at
all, but its presense at the same time as "modified: A" does feel very
fishy.
