From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reachability lists in git
Date: Tue, 18 Nov 2014 12:33:24 -0800
Message-ID: <xmqqmw7ouu3v.fsf@gitster.dls.corp.google.com>
References: <Pine.LNX.4.44L0.1411181354320.4374-100000@iolanthe.rowland.org>
	<20141118194129.GI6527@google.com>
	<xmqqzjbouv0y.fsf@gitster.dls.corp.google.com>
	<20141118202250.GK6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alan Stern <stern@rowland.harvard.edu>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 21:33:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqpSt-0003XO-Lv
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 21:33:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbaKRUd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 15:33:27 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55668 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754237AbaKRUd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 15:33:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DBA81EF0F;
	Tue, 18 Nov 2014 15:33:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TUmwU7XvWxu5MQ3mPkf0dQxSC2E=; b=un0fcH
	FACnLB4SzoKpMTqFs9N1/4wtbJsIJQg3Pju1QR0P8cU1YsIuAotKFnCl6BFAJ9GD
	bsZyxMn31tUzesH8+WqxjeGvn+RaXUUgTP+hBpANH4l0SOGdphQrD7UZtDfclaeE
	d+YFCI11n3ypwfF7HNcInXOQnZUwV3EGPIuPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j28bkUP/GAcCzUVELMqXDqK5e0EVoWz8
	6Ehnu3XVTLzoVnGYr4MayOtaG8LEqYXNTHyYa9AcGAE7eAhz3WPLZ9aTNKA7vZm2
	682y278Onwre+9WQB7EGRRiexT+RhjxOv28MuHTSh6lC7cJiuk69kQ6gik/TwNQF
	XfwIPZtC8Ok=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 455321EF0E;
	Tue, 18 Nov 2014 15:33:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B2A171EF0D;
	Tue, 18 Nov 2014 15:33:27 -0500 (EST)
In-Reply-To: <20141118202250.GK6527@google.com> (Jonathan Nieder's message of
	"Tue, 18 Nov 2014 12:22:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 26DC494C-6F62-11E4-9369-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> --ancestry-path is my current favorite tool for walking-forward needs.
>>
>> Curious.  I often want to answer this question:
> [...]
>> And my experiments with --ancestry-path has been less than ideal.
>
> Thanks for an example.  I've found it works okay interactively, less
> so for scripted use (so I wish there were something better, though I
> haven't sketched out what that something better would look like).
>
>>     Commit 982ac87 was reported to be faulty.  What topic was it on
>>     and at which point was it merged to 'master'?
>
>  $ git log --graph --ancestry-path 982ac87^..origin/master

Yup, that is what I've been using and was wishing that there would
be better alternatives.
