From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fixup! graph: output padding for merge subsequent
 parents
Date: Mon, 11 Feb 2013 11:58:24 -0800
Message-ID: <7va9ramxlr.fsf@alter.siamese.dyndns.org>
References: <7vtxplt5u2.fsf@alter.siamese.dyndns.org>
 <20130210131647.GA2270@serenity.lan>
 <7vliawt19c.fsf@alter.siamese.dyndns.org>
 <20130210210229.GB2270@serenity.lan>
 <7vwqufrdzd.fsf@alter.siamese.dyndns.org>
 <20130211105433.GA3245@farnsworth.metanate.com>
 <7vehgmol8y.fsf@alter.siamese.dyndns.org>
 <20130211190629.GC2270@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Feb 11 20:58:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4zWe-0008I1-7Q
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 20:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759348Ab3BKT63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 14:58:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33945 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758792Ab3BKT62 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 14:58:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EAD8B9B1;
	Mon, 11 Feb 2013 14:58:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JLYFQRXlIh0DYRdT05GZ0wSxb1I=; b=rQR81X
	5ZAVVY7NBv9VyF/VhyatTMnVOZNNYtMG8UbWS6MlzuzQYkOPo75m1c3Ai3tPslpi
	6abQ5u2xW8BnWL+q48wJ9+M7k2qXc/HoY/jlpOHHW007Wn5NGkG7KovRNmgo/vEp
	gJLG+AKtL8eCRKUbAtGg0W0MaARzyJU4bBsgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CSOD50uwFNpIyHUefTh1AwBNJvpLdYqc
	zIksIap+SFV0z7uPH/voQR9qxseBr1hgUfGO08FkNJgFeSXyx7kJJD5Kj1njOFTl
	Xc7Vi5WxJ29/i28Z4jzf9Lorf4/bVkJi1GAZTWjvcJVvhhEb03lWYtB1g1Y/ptqx
	7DEqg+WUIc0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62F75B9B0;
	Mon, 11 Feb 2013 14:58:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA112B9AE; Mon, 11 Feb 2013
 14:58:26 -0500 (EST)
In-Reply-To: <20130211190629.GC2270@serenity.lan> (John Keeping's message of
 "Mon, 11 Feb 2013 19:06:29 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 662ED990-7485-11E2-99A5-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216080>

John Keeping <john@keeping.me.uk> writes:

> On Mon, Feb 11, 2013 at 08:42:21AM -0800, Junio C Hamano wrote:
>> John Keeping <john@keeping.me.uk> writes:
>> 
>> > Perhaps it's best to leave the patch as it originally was to guarantee
>> > that we can't get stuck in graph_show_commit(), even when it's called at
>> > an unexpected time, but I see you've already squashed this change in.
>> >
>> > Would you prefer me to resend the original patch or send an update with
>> > this change and the above reasoning in the commit message?
>> 
>> Yes, please.  Let's have the original (I think I have it in my
>> reflog so no need to resend it) and this update on top as a separate
>> patch with an updated log message.
>
> I was suggesting dropping the change to remove the
> graph_is_commit_finished() check in the loop.  I'm not sure it buys us
> much and there are still situations that could result in the state
> changing to PADDING during the loop if the graph API is used in an
> unexpected way.

OK, so the fixup! was not done with enough thought.  I am fine with
dropping it.

Thanks.
