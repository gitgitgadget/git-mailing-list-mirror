From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Idea: "git format-patch" should get more information out of git
Date: Sat, 27 Aug 2011 11:46:12 -0700
Message-ID: <7vippiaduw.fsf@alter.siamese.dyndns.org>
References: <4E587CC0.4090508@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johan Herland <johan@herland.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Aug 27 20:50:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxNxM-0002YQ-QR
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 20:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506Ab1H0SuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 14:50:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41587 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908Ab1H0SuF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 14:50:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 598DF39ED;
	Sat, 27 Aug 2011 14:50:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=YSkDYW+9lP8mZXLCPYqwX8TKiV8=; b=XyZXdzswdtjaG2unjdch
	iC86qxsCDARul5IPy0rladlKaxo9QAq626IiJRNEsja67lF0CvK7X1cuNJWHrNNa
	zm4lovN3eLzPfV5KTDw81HafgXpxFEovFGXqwgK8QHBtseQVjTwEbJzS/qPpFzmp
	aOkLBtPEfKR8rHsnnc1VzgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=QQyVo4ojn+Tmb4yBPs+IBDr3JEt9+rgOZYIogyMgnRfLkw
	XH2j6W9yi25o4MnZdkS1w9nT6rMh7q9x69uNCuoNHptsd5XlFfgWM11bh2xQ0v0S
	Raa2Gx+IA4k7V9qw5oOon6h8CZLCT0CrMif718dU2aiX2V1BGlX+pjUmU4vbU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B15039EC;
	Sat, 27 Aug 2011 14:50:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9C9339E0; Sat, 27 Aug 2011
 14:50:00 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E450DF0-D0DD-11E0-A29A-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180239>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> 1. The extra information typed into the email series is not archived in
> the git repository, and therefore the emails have to be kept around.

The convention is to have information that is not meant to be kept around
after '---', so...

> 2. If it is discovered between "git format-patch" and "git send-email"
> that one of the patches needs a tweak, then the email series has to be
> generated anew and all of the hand-edits need to be redone.

I actually often work this backwards. Tweak the patch files, apply them to
commit that they are meant to be applied, retest and then finally send.
There is no "generating anew" involved.

> 4. There is no place to store the "additional information" (the part
> that comes in patch emails between the "---" and the diffstat) while
> working on the patch series;...

I thought there was a RFC floating around to do this using notes and also
teach it to "commit -e" a few months ago? I vaguelly recall that Peff and
one of the J's were involved, so I am CC'ing them.
