From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 15:27:57 -0700
Message-ID: <7vsj27ac2a.fsf@alter.siamese.dyndns.org>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
	<7vppxcdjd1.fsf@alter.siamese.dyndns.org>
	<7vhaindcuk.fsf@alter.siamese.dyndns.org>
	<CAMP44s2S4AtZUfH4NWCLt=p49QXeYSZKELYbahpBUgDofaFMsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 00:28:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXJ1p-0004Wc-Jt
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 00:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933746Ab3D3W2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 18:28:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48366 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760097Ab3D3W17 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 18:27:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 515CA1BF71;
	Tue, 30 Apr 2013 22:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lcWU+py0gNrTFVVXZlw87dLXZDI=; b=bqMeZm
	2r3F5q7+LHuLFp4cFmVX1vSVAPpODWk/kGmaBhi03xCpg66W9T3+0amXWh1q8hPn
	NyDd4Nht0EuRHC2EV4vkReXOFFxquTMdef26BYEFX1jkYH4GcuuwIdrcncQXmj+F
	3rl1f/Z0RJdQZgYIOtOzKQ9W9EW0gkqnHxJhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a7ezxGrQsm+cO5xX4pu7osky2YQKUXY5
	odkKtzta7vTMsbP5NOiK3mzltjm8J1dhyeZyZ6o+X5ZCcJOJrJP1ZiD17OEKOr5s
	K8IUDL7HRgxH6blYRLtaOa4g27mP41Tnwm9FlZnDKc2mGROVRFpu8F6umB0t37CY
	xeoCcZfTNf4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45AE41BF70;
	Tue, 30 Apr 2013 22:27:59 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B362B1BF6E;
	Tue, 30 Apr 2013 22:27:58 +0000 (UTC)
In-Reply-To: <CAMP44s2S4AtZUfH4NWCLt=p49QXeYSZKELYbahpBUgDofaFMsw@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 30 Apr 2013 17:17:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3620309E-B1E5-11E2-A140-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223030>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> That means "git checout @" should work the same way as "git checkout
>> HEAD", "git log @~4" would work the same way as "git log HEAD~4",
>> "git update-ref @ $(git rev-parse master)" should update the HEAD
>> without creating $GIT_DIR/@, etc.
>>
>> You can't go any simpler than that rule, and there is no room for
>> confusion if that rule is properly implemented.
>
> I disagree. I can do 'git log @{-1}-4', but I cannot do 'git
> update-ref @{-1}'. Why? Because the '@' notation is for revision
> parsing, and 'git update-ref' doesn't do revision parsing.
>
> I'd say, everywhere where you could do @{-1}, you should be able to do @.

Yes, @{-1} is about a ref, the branch that you were on previously.
That is why you can do

	git checkout fc/at-head
        git checkout master...
        git am -s <./+fc-updated-at-head-series.mbox
        git co -B @{-1}

We wouldn't be able to do the last step, if @{-1} evaluated it down
to the object name, losing the refname.

If "update-ref @{-1}" does not grok @{-1}, probably there needs a
call to interpret_nth_prior_checkout() in the codepath.
