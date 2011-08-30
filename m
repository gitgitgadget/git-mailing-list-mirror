From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Un-pessimize "diff-index $commit -- $pathspec"
Date: Tue, 30 Aug 2011 10:03:25 -0700
Message-ID: <7vsjoi3k82.fsf@alter.siamese.dyndns.org>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org>
 <1314653603-7533-1-git-send-email-gitster@pobox.com>
 <4E5CB5C6.6020403@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 30 19:03:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyRim-0006U0-Rl
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 19:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217Ab1H3RD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 13:03:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38320 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752258Ab1H3RD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 13:03:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AFC63DE7;
	Tue, 30 Aug 2011 13:03:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=usVfRgK8aUfojGFfhwtAaeTNSj8=; b=XhqAmF
	k+N07BOPuugvFyMxd9deyw48ouBiq5hJTWFMJQI2U4g8YpstwxRQkdFHvIP21Nqp
	pIqgpJcT21v9ODvZZlJDliefv4lVPDinWILmvTcYUk9Qmg2YyC6uaHqbo3hciEGd
	ILm4V1zKR46xYKBLRM48af4iqzyJsC1V4ilnA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M3oGdDIhWtf0W8WJ0Exl6KK5/+LX9fRC
	JoLP/JpThCGTiXTGLeWinRn8SUhFPgHXAQqwAv7AK73GZzwBHrjL9FEcnWWAmqnU
	Z8VtXu3vcHEQ3VjLX2MsOSWAogapkmJnE/9T+F12HXa+pHtg+a9gnnuxlXl0PLM4
	JP7BjmtqfMs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 810613DE6;
	Tue, 30 Aug 2011 13:03:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E6533DE5; Tue, 30 Aug 2011
 13:03:27 -0400 (EDT)
In-Reply-To: <4E5CB5C6.6020403@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Tue, 30 Aug 2011 12:04:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA908470-D329-11E0-AC50-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180418>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Seems my analysis wasn't that far off (though, admittedly, unspecific):

Yes, the "diff-index" implementation was updated over time a few times and
I was confused. Sorry.

Thanks for helping diagnosing the issue.
