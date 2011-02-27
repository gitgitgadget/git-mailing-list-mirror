From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Sun, 27 Feb 2011 00:15:27 -0800
Message-ID: <7vzkph6ggw.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
 <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
 <AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
 <20110214231920.GA24814@elie>
 <AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
 <20110226215139.GA19176@elie>
 <AANLkTimyXciScc5K6ozggMHsy9YmgyOFpy6pgKBEypC9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 09:15:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtbnA-0004SF-TJ
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 09:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571Ab1B0IPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 03:15:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50072 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338Ab1B0IPl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 03:15:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0EF652343;
	Sun, 27 Feb 2011 03:16:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bMfN8jDXER8ppQJmblMdrsFD290=; b=GELwdw
	y+GyZSpsXTIHHFCKaXkdMImVJXitXDbUKswFMwXoJ5uadu4VHoHuWHtDMsKFQ9pU
	zeoAdB1lm94K20gxtj+CtXJYTTn5vFYxNgVRpSAYFz2UAJTM9dWSZDMQWMTpG3xh
	Dc9ZXdiEj0RaSx72wLE+zIXRgzgm75T9tqajo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xNxprkA0DqqYQMcAXk38Q+Mn9KNqxjtp
	pdAdAgf1HLjjmtxK5EDlviWfqhPmRRRxU7SjzNTY6x9kmAEWcXXcxz8r0vCINPM6
	ZCbObknRpvbhuaV5I46AfETYjKJURERBCtyjMQiufo9HHxoVxKlTpn339dX5WS0W
	orys+ScbA9s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BD2AC2341;
	Sun, 27 Feb 2011 03:16:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 75CF72340; Sun, 27 Feb 2011
 03:16:45 -0500 (EST)
In-Reply-To: <AANLkTimyXciScc5K6ozggMHsy9YmgyOFpy6pgKBEypC9@mail.gmail.com>
 (Felipe Contreras's message of "Sun\, 27 Feb 2011 02\:16\:40 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ED98A07A-4249-11E0-A002-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168010>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> There's always resistance, but 1.8 is supposed to contain stuff as "if
> git was written from scratch".

Yes, the 1.8.0 is indeed an opportunity to rethink, based on the wisdom we
have gained over the years since the current git was written.

If there has already been a clear consensus that we would have done
something differently if we knew better, it is an opportunity to first
discuss if there is a way to correct these earlier mistakes in a way that
does not have to introduce incompatibility, and if it is not feasible,
discuss a plan to ease incompatible changes in without hurting existing
users too much.

A new discussion or proposal is fine, but you should be able to see that
an effort to start building consensus from now is very much outside the
scope of the discussion for the 1.8.0 we have been having.

Besides, taking what other people said already in the thread also into
account, it looks to me that what you are advocating is too premature to
be called a consensus yet.
