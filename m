From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rebase -i: new option --name-rev
Date: Fri, 09 Mar 2012 01:45:25 -0800
Message-ID: <7vty1y85vu.fsf@alter.siamese.dyndns.org>
References: <1331203358-28277-1-git-send-email-domq@google.com>
 <1331203358-28277-2-git-send-email-domq@google.com>
 <87399jnyxh.fsf@thomas.inf.ethz.ch> <7vaa3qewqw.fsf@alter.siamese.dyndns.org>
 <7vipiebv1r.fsf@alter.siamese.dyndns.org> <4F59AFA9.5030205@viscovery.net>
 <CAJh6GrGEix8qfAuJamWzcr69=LjkZ-O9B=Vorvy_KTcJe3TcPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Thomas Rast <trast@inf.ethz.ch>
To: Dominique Quatravaux <domq@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 10:45:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5wOX-0000gC-Ib
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 10:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269Ab2CIJpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 04:45:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37967 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077Ab2CIJp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 04:45:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC2445141;
	Fri,  9 Mar 2012 04:45:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kP2Dfguo+tvjjqZ59k3XzAfVYv8=; b=Lk4x1r
	ynCNqI6/p8HJ9/3RMLD1u8OHWR+GsLIvKtA9rbNGJjvgEYPVWZtw0pVbYvdDp61R
	CuEvaBM7fluy30uuVtAiZK6E0dZcvYfNO189p+GE/8rRypJKg6gZnP6C5/YxeZar
	Sm7E9EgA+zOU33hclke3nUNoCNY0QaqoCFw2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I0IV+sDlep/0rcG4He0nTYRVCQlXDmDR
	bqgXDTkOuPPxl8nLYJpjobfmK0DtPtxqst25vCHfXXd1gzBSiLdACZZnLeXpymia
	jjC8MU13xka5mf4t+mye8mp2mAvzgC43D68JGPwllEQ3581nRNIrkgys2sYsljZS
	FQnJwU/BpCw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E26035140;
	Fri,  9 Mar 2012 04:45:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 798A9513E; Fri,  9 Mar 2012
 04:45:27 -0500 (EST)
In-Reply-To: <CAJh6GrGEix8qfAuJamWzcr69=LjkZ-O9B=Vorvy_KTcJe3TcPA@mail.gmail.com>
 (Dominique Quatravaux's message of "Fri, 9 Mar 2012 10:04:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 99F5BD1C-69CC-11E1-98C4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192700>

Dominique Quatravaux <domq@google.com> writes:

> On Fri, Mar 9, 2012 at 8:22 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Rebase -i happily linearizes mergy history, so this
>> does have some merits even today.
>
> Right, my personal itch is to "transplant" topic branches without their merge
> history getting in the way,...
> ...
>   pick 1234abc (topicB~2) Cool shiny new stuff
>   pick 234abc1 (master~2) Something something master
>   pick 34abc12 (master~1) Fix something something
>   pick 4abc123 (topicB)   Fix shiny new stuff

Ok. I didn't consider the "flattening" aspect of the rebase, and the
above makes sense to me.
