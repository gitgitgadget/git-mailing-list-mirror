From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Virtual PATCH] Add an option to wrap a patch in <pre> in  
 git-imap-send which ironically results in a cleaner patch from Thunderbird.
Date: Fri, 13 Feb 2009 09:49:15 -0800
Message-ID: <7v4oyy9qhw.fsf@gitster.siamese.dyndns.org>
References: <499446D0.90602@codeweavers.com>
 <7viqnfezo5.fsf@gitster.siamese.dyndns.org>
 <49955860.80504@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremy White <jwhite@codeweavers.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 13 18:54:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY2Cb-0003Wd-Qr
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 18:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbZBMRtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 12:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbZBMRtY
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 12:49:24 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39033 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbZBMRtX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 12:49:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E8FA899628;
	Fri, 13 Feb 2009 12:49:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 954419961D; Fri,
 13 Feb 2009 12:49:16 -0500 (EST)
In-Reply-To: <49955860.80504@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri, 13 Feb 2009 12:24:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A52AE23C-F9F6-11DD-8518-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109766>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> What worries me the most is if there is any guarantee that this bug you
>> are exploiting to force it to send a patch in the common denominator
>> format _will not be fixed_ in future versions of Thunderbird.
>
> It's not a bug, it's a feature ;)
>
> In fact it really is: preformatted text in HTML (<pre>) is by definition
> left alone. Now, when you are about to send an HTML mail TB asks you
> what to do (or takes a choice from preferences/addressbook): send as
> HTML, as text or both.

Ok, "TB asks you what to do and you choose 'text-only'" is the part I
missed.  In that case, I'd agree it definitely is a feature not to use
flowed to convert that <pre>..</pre> to a plain text.  Thanks for an
explanation.

>> I see your patch deals only with ampersand, less-than, greater-than and
>> dquot.  Do you know if this is enough, or would letters outside US-ASCII
>> need to be expressed in ampersand-hash "character reference" notation?
>
> According to Ben of Mozilla fame this is enough for special characters.
> I don't know about UTF-8, though. Usually, TB recognizes the proper
> encoding.

Yeah, anything outside US-ASCII.  That was what I was wondering about.
