From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Fix the shallow deepen bug with no-done
Date: Fri, 07 Feb 2014 12:03:00 -0800
Message-ID: <xmqqbnyivggb.fsf@gitster.dls.corp.google.com>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
	<xmqq4n4cyr61.fsf@gitster.dls.corp.google.com>
	<CACsJy8AdOdVCma8FYeDM0kTd=Bgo-atpXmxFvmK4rzH6jOZEzQ@mail.gmail.com>
	<20140207192031.GY30398@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 21:03:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBrds-00076M-PQ
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 21:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbaBGUDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 15:03:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40652 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589AbaBGUDL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 15:03:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFA196ACD7;
	Fri,  7 Feb 2014 15:03:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9IjeoASws4FP+ROSULTNT5hPujI=; b=b4R+wU
	zuUrM1MyUDe/ygJk7KkY+oLOtKAj/LxU3iUiXDz5VqjCbp3t38kwXwrAh8wp6Iqk
	3lQk0fQd36KcRjLZ5eIlT7TwapHZxirR46j837pU37fDD+XmQ/vP6+a/mUwN4KuL
	RJhpYK/Rn2bbxlRF3hSPVkt6soGixi3Um+p+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WZs/3ozPWVQmE3T9IOmIAVKmsV4IlNuv
	/OqlWLKQ4GfyZVNAqyEx8EoXz6zgESaAO0uZ3oWTYESUYv6zBFeRYte1AJHkS9A0
	CzGB8sJ6v96ACmMux+8dp1vJ2gytmvhDM1fBr8n31wXoFXWJnYF5+SFactXSCi6Y
	j+syuiIsTo0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD4DE6ACD6;
	Fri,  7 Feb 2014 15:03:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C25636ACD3;
	Fri,  7 Feb 2014 15:03:03 -0500 (EST)
In-Reply-To: <20140207192031.GY30398@google.com> (Jonathan Nieder's message of
	"Fri, 7 Feb 2014 11:20:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DA6FD09C-9032-11E3-916D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241792>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Duy Nguyen wrote:
>
>> Don't take it the wrong way. I was just summarizing the last round. It
>> surprised me though that this went under my radar. Perhaps a bug
>> tracker is not a bad idea after all (if Jeff went missing, this bug
>> could fall under the crack)
>
> I'm happy to plug
> - http://bugs.debian.org/cgi-bin/pkgreport.cgi?src=git;include=tags:upstream
> - http://packages.qa.debian.org/common/index.html (email subscription link:
>   source package = git; under "Advanced" it's possible to subscribe to
>   bug-tracking system emails and skip e.g. the automated build stuff)
> - https://www.debian.org/Bugs/Reporting (bug reporting interface -
>   unfortunately the important part is buried under "Sending the bug
>   report via e-mail")
> again. :)

Then I'd add my bits ;-)

    http://git-blame.blogspot.com/p/leftover-bits.html

Admittedly I haven't touched it for a while, as I usually update it
during a lull, often in the pre-release -rc freeze period, but the
list has been quite active during -rc this cycle.

I probably should start dropping any new topics on the list and find
leftover bits during this cycle.
