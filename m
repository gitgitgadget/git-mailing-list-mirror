From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC][PATCH] send-email: add --[no-]xmailer option
Date: Wed, 03 Dec 2014 08:56:45 -0800
Message-ID: <xmqqk328k6ya.fsf@gitster.dls.corp.google.com>
References: <20140324213814.GA1267@achilles.my.domain>
	<20141202193243.GA2999@charon.olymp>
	<20141203023419.GA10519@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Luis Henriques <henrix@camandro.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Dec 03 17:56:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwDET-00040j-Jd
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 17:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbaLCQ4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 11:56:49 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56550 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751153AbaLCQ4s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 11:56:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F101921480;
	Wed,  3 Dec 2014 11:56:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bIM9ahiIGARpcMennoT6nRpUJt0=; b=wZwEoW
	H6enBL94hx7guxDP7ypP2CGZMwaWuVpveP6tDk6Bz/1RZnsGduQO8LGmIAVZ2Oq7
	wVzppZv0K1Gel9R0R8UWAsrzrW5LAaofmmznOOsh12bz0Hq+f5tqtK+AVv8RrPSt
	iQumF7GC2pIkue3oDwDGxnqKXCM7M18vKZPNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dnl+sTU8pQ1R1icekUWIkMY7ZcZ4RYrS
	eQ0HTVxw8ipvsD6FmatpX9k2l1Z20BqhsaroVOoIQ3FXdtNkjG18VnSFYrzfY+gW
	4E9jsYx41CTMgubQ5QFwvzDnzYttDUYV+nsye+NhtxYVr4kEOCplJPZaFkbH3ucK
	XO2DEQl/ZhA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5BBC2147F;
	Wed,  3 Dec 2014 11:56:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 67CBF2147A;
	Wed,  3 Dec 2014 11:56:47 -0500 (EST)
In-Reply-To: <20141203023419.GA10519@dcvr.yhbt.net> (Eric Wong's message of
	"Wed, 3 Dec 2014 02:34:19 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5E46B082-7B0D-11E4-A100-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260661>

Eric Wong <normalperson@yhbt.net> writes:

> Luis Henriques <henrix@camandro.org> wrote:
>> On Mon, Mar 24, 2014 at 09:38:27PM +0000, Luis Henriques wrote:
>> > Add --[no-]xmailer that allows a user to disable adding the 'X-Mailer:'
>> > header to the email being sent.
>> >
>> 
>> Ping
>> 
>> It's been a while since I sent this patch.  Is there any interest in
>> having this switch in git-send-email?
>
> I wasn't paying attention when the original was sent, but this
> looks good to me.
>
> Acked-by: Eric Wong <normalperson@yhbt.net>
>
>> I honestly don't like disclosing too much information about my system,
>> in this case which MUA I'm using and its version.
>
> Right on.  I would even favor this being the default.
>
> Auto-generated Message-Id headers also shows the use of git-send-email;
> perhaps there can be a way to configure that, too.  However,
> git-send-email respects manually-added Message-Id headers in the
> original patch, so it's less of a problem, I suppose.

I actually do not think this is a good idea from debuggability.
