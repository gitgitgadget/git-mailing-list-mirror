From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: possible Improving diff algoritm
Date: Wed, 12 Dec 2012 15:43:30 -0800
Message-ID: <7vobhy25wd.fsf@alter.siamese.dyndns.org>
References: <CAO54GHC4AXQO1MbU2qXMdcDO5mtUFhrXfXND5evc93kQhNfCrw@mail.gmail.com>
 <CAO54GHD3C2RKUvE5jK_XOCVbbDuE_c5xfe28rOL+DaE5anL-Wg@mail.gmail.com>
 <7vvcc73yzh.fsf@alter.siamese.dyndns.org>
 <CANv4PNm45xGBn2veKi1o0wB4K9NgsbtCsiymHNO4xbCDpJ5tDg@mail.gmail.com>
 <7vpq2f2az4.fsf@alter.siamese.dyndns.org>
 <CAH5451=4dqqMnQa-R6O4ZrHOPSpHU9joWqf2UuOkbLtU9f8bkQ@mail.gmail.com>
 <CALZVapnzYBhPU1nR=eCSnm73c9-SpHq34DHu7OWCkouCQS0FxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Morten Welinder <mwelinder@gmail.com>, Kevin <ikke@ikke.info>,
	git <git@vger.kernel.org>
To: Javier Domingo <javierdo1@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 00:43:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tivxw-0007D1-8V
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 00:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908Ab2LLXne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 18:43:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51505 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754462Ab2LLXnd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 18:43:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A447A067;
	Wed, 12 Dec 2012 18:43:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/81OZ3m4nSWIwyYWv7kakIRyx3A=; b=OJs0ED
	BXw2hChEHxKtO/drrqE6+SOSgm0S65auczNpzeE+sWUJiqqVDbPYHifsCpWp2GOM
	imu4TTuPs5kD++VbXJ6mmnvykgcBQZSIJO6eoHZZSCEcB/sWP0ft04j2b1qHLUfp
	RHstd+22y7fPHP2EKLQVyDctozag/nKW60xNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lBjvrLVjBd6PK87JxJc4Srr7RLmJks6r
	anhsedAtxESfVIWyy2qLwCYZSFhZhx+2txzZLymt1wOG2ujz1TKrLsAh3Ofqzi9r
	E6yJRI8T+epjlgvD5o1I7hoNj7gFZ1vw8doA7fzS/6I1EBVQiDKHS6IBANy/qyn3
	CNaZq1Gco3Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26C09A065;
	Wed, 12 Dec 2012 18:43:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99A43A064; Wed, 12 Dec 2012
 18:43:32 -0500 (EST)
In-Reply-To: <CALZVapnzYBhPU1nR=eCSnm73c9-SpHq34DHu7OWCkouCQS0FxQ@mail.gmail.com> (Javier
 Domingo's message of "Thu, 13 Dec 2012 00:32:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD11F620-44B5-11E2-8775-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211420>

Javier Domingo <javierdo1@gmail.com> writes:

> I must say it is _quite_ helpfull having the diffs well done (natural
> diffs as here named), just because when you want to review a patch on
> the fly, this sort of things are annoying.

I do not think anybody is arguing that it would not help the human
users to shift the hunk boundaries in the case Kevin's original
message demonstrated.
