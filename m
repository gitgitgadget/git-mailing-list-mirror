From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/3] format-patch: --numbered-files and --stdout aren't
 mutually exclusive
Date: Sat, 21 Mar 2009 22:44:53 -0700
Message-ID: <7vljqy8622.fsf@gitster.siamese.dyndns.org>
References: <1237696363-6819-1-git-send-email-bebarino@gmail.com>
 <1237696363-6819-2-git-send-email-bebarino@gmail.com>
 <1237696363-6819-3-git-send-email-bebarino@gmail.com>
 <1237696363-6819-4-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 06:46:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlGW1-0007am-8s
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 06:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147AbZCVFpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 01:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbZCVFpB
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 01:45:01 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40968 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969AbZCVFpB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 01:45:01 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3B00B8435;
	Sun, 22 Mar 2009 01:44:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B070C8434; Sun,
 22 Mar 2009 01:44:55 -0400 (EDT)
In-Reply-To: <1237696363-6819-4-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Sat, 21 Mar 2009 21:32:43 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 94AA355A-16A4-11DE-AB04-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114120>

Stephen Boyd <bebarino@gmail.com> writes:

> For example:
>
>     git format-patch --numbered-files --stdout --attach HEAD~~
>
> will create two messages with files 1 and 2 attached respectively.
> There is no effect when using --numbered-files and --stdout together
> without an --attach or --inline, the files simply aren't created.

Hmm, "the files aren't created" is true, but I had to scratch my head if
you are describing a bug or justifying the change by saying "so filename
does not matter".

I think the change makes sense.  It could be argued that combination of
these two options should give a warning("ignoring --numbered"), but I do
not think it is even worth it.
