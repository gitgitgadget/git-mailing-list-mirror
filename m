From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase: Print name of rev when using shorthand
Date: Wed, 16 Apr 2014 10:01:09 -0700
Message-ID: <xmqqk3api4yy.fsf@gitster.dls.corp.google.com>
References: <1397419474-31999-1-git-send-email-modocache@gmail.com>
	<xmqqwqerogvr.fsf@gitster.dls.corp.google.com>
	<CAN7MxmUikP6pVAj3cpDiSbFxawScTh5zKusPUe8SpkNbH=e6Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 19:02:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaTDy-0006DK-9R
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 19:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbaDPRCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 13:02:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39062 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970AbaDPRCH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 13:02:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CBE07C2AA;
	Wed, 16 Apr 2014 13:02:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cCj/VdG322pKewjVPv9zx/pnrWM=; b=XdurRM
	Hb+u2VxVv3AM61KKV5Lnpwr3RuAaeXkKYc51aj5iXQukmJ/GBeua7oKtCQjGyJTn
	IMyO/CMytoRxvA019MizV7Z0oFAX5IDMPEUtdEw69ogLAjlZCilnPnJkTCRWvFNb
	28tq6B0fHGrcuyncax69Sb6jrjvQi2257P0Qg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ww5WuKCSuSu2s8/cph4o6gMXTxdk6PbH
	x5RjNGgXA7UECp2VE/WjyWYnsBmjjshVlawX2rfHr+DyiCdYt2CICvsWzF4+r31N
	UPQSC5qYqyr4z9aRasKhgANum6zddakzRuTsLROdh60+kkLi+ghDv5nOGTuH6eDX
	HVXZOuKLvwE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F37737C2A9;
	Wed, 16 Apr 2014 13:02:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02D677C276;
	Wed, 16 Apr 2014 13:01:10 -0400 (EDT)
In-Reply-To: <CAN7MxmUikP6pVAj3cpDiSbFxawScTh5zKusPUe8SpkNbH=e6Aw@mail.gmail.com>
	(Brian Gesiak's message of "Wed, 16 Apr 2014 17:19:41 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B5F9002C-C588-11E3-A31B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246346>

Brian Gesiak <modocache@gmail.com> writes:

> Personally, I've been using the "-" shorthand with "git checkout"
> for a year or so, but only learned about "@{-1}" a few months ago.
> I think those who use "@{-1}" are familiar enough with the concept
> that they don't need to have the reference translated to a
> symbolic full name. Users familiar with "-" might not be aware of
> "@{-1}", however, so I'd prefer not to output it as we are
> currently.

I do not understand that reasoning.

The concept of "n-th prior checkout" (aka @{-n}) and "immediately
previous checkout" (aka "-") are equivalent, even though the former
may be more generic.

You seem to be saying that those who understand the former are with
superiour mental capacity in general than those who only know the
latter, and they can always remember where they came from.  It
sounds similar to an absurd claim (pulled out of thin-air only for
illustration purposes) that French-speaking people are of superiour
mind and do not need as much help with math as English speakers.

> Furthermore, were we to translate "@{-1}", does that mean we
> should also translate "@{-2}" or prior?

Surely, why not.  If a user is so forgetful to need help remembering
where s/he was immediately before, wouldn't it be more helpful to
give "here is where you were" reminder for older ones to allow them
to double check they specified the right thing and spot possible
mistakes?

I can buy "that would be a lot more work, and I do not want to do it
(or I do not think I can solve it in a more general way)", though.
