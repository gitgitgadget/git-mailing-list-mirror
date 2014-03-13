From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [RFC PATCH 2/1] Make request-pull able to take a refspec of form local:remote
Date: Thu, 13 Mar 2014 14:22:00 -0700
Message-ID: <xmqqvbvhhk07.fsf@gitster.dls.corp.google.com>
References: <alpine.LFD.2.11.1401221535140.18207@i7.linux-foundation.org>
	<xmqqlhy6trfp.fsf@gitster.dls.corp.google.com>
	<CA+55aFyGaaMOL5pBhZ1BHMr07oDi2MuS-fPu4nnxhjoy+F0AQw@mail.gmail.com>
	<xmqqsises3u0.fsf@gitster.dls.corp.google.com>
	<CA+55aFyN7WWAF6pGfP+0j29nf6ETao0J5sUu+5UDaXUYC9_Geg@mail.gmail.com>
	<xmqqvbx9qgo7.fsf@gitster.dls.corp.google.com>
	<xmqqfvo6icqf.fsf_-_@gitster.dls.corp.google.com>
	<CA+55aFyWM+VDa4mdqseNy3tSnp23x=2sPtHf5KpxsfROeHbVGw@mail.gmail.com>
	<xmqqob1u6f5d.fsf@gitster.dls.corp.google.com>
	<xmqqvbvjmgys.fsf@gitster.dls.corp.google.com>
	<CAPig+cQTRFgbbyXsWraNTbL+nOY2y09KEJPfGc3wynFA+RWswQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 22:22:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOD5D-0001oc-FE
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 22:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754AbaCMVWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 17:22:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62062 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753219AbaCMVWW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 17:22:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA83673538;
	Thu, 13 Mar 2014 17:22:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oIZA5TkyZd1j/bgPumPN4gTh+lk=; b=NVsGLE
	6YHnlDVVEn3rtzClNVeRRIbn7r0WX9siV/YVHKjk4PD5giLw7YNPZ0O6yoh+jPjW
	lX/AHzxfaUzxm6mtTPsdJw6GucNfMawRwVgMHqn0Gy/j6iJlSxGVmXhBrooCdzOM
	JrEJ4tpwABDJAZ74qBteOwFA8+2Ug3dIuxa1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E0u9AB2VqL+SUd3GLQM5x+PGtVhL4Y4t
	UJLP54yw+E4iur6knjSNeCCvm9UAMoIFmjjdbhJAmVhV2DWM/51GYw1ZTZP1/XoQ
	tibEOszJr1WNUbh1h6kICPWcscUnT7q3bCalrdxgJViB6QEF7DbRBjyTnB1DNGRV
	GiCEB/Na44Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95F2273535;
	Thu, 13 Mar 2014 17:22:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 504D0734E2;
	Thu, 13 Mar 2014 17:22:07 -0400 (EDT)
In-Reply-To: <CAPig+cQTRFgbbyXsWraNTbL+nOY2y09KEJPfGc3wynFA+RWswQ@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 12 Mar 2014 19:18:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 88667BE2-AAF5-11E3-B213-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244051>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +Prepare a request to your upstream project to pull your changes to
>> +their tree to the standard output, by summarizing your changes and
>> +showing where your changes can be pulled from.
>
> Perhaps splitting this into two sentence (and using fewer to's) would
> make it a bit easier to grok? Something like:
>
>     Generate a request asking your upstream project to pull changes
>     into their tree. The request, printed to standard output,
>     summarizes the changes and indicates from where they can be
>     pulled.

Thanks.

>> +When the repository named by `<url>` has the commit at a tip of a
>> +ref that is different from the ref you have it locally, you can use
>
> Did you want to drop "it" from this sentence? Or did you mean to say
> "the ref as you have it locally"?

Thanks for your careful reading.  Will drop "it".
