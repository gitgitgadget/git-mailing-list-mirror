From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/3] branch: deprecate --set-upstream and show help if
 we detect possible mistaken use
Date: Thu, 23 Aug 2012 14:16:41 -0700
Message-ID: <7vtxvt2ts6.fsf@alter.siamese.dyndns.org>
References: <7vk3wtjt3o.fsf@alter.siamese.dyndns.org>
 <1345748186-1081-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Aug 23 23:16:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4eln-0007zH-Aq
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 23:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756960Ab2HWVQq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Aug 2012 17:16:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38750 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756758Ab2HWVQo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 17:16:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4B9681FB;
	Thu, 23 Aug 2012 17:16:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JVpZVvsG4xSE
	sve8LR6cm5KJRFQ=; b=PXaVG0xDWH73MAXRLAPt7y8zjDfpAOSmVVNSZnK/jx6z
	VhOk1oi2N257jsu3RRmKSTryfZny0HYeXpKNfmFRdeqsdYZxyS7/4CEc47SHx7oC
	a/WbKYbbb7UNyusNfiHppl++E0RsbDaq0eW2GzyYYOpTeh/NbPAMKciRG4K+Chk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MF/Ikx
	hX1r954pyt4oS5+8HRoOkzGowbwToBiHJXu68/OoWtKr20LTr9l2WxstS90TUIbw
	Fj32lWzSFzjUFiUEFDr3RtVV0b/Z4Z73FVk4DDvFw0tYyVjfEkUO7W0W8wajVlsq
	YMCNtdWqdXkaNWIsPXA37C6Nl6pYOxVILEQQA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3C6281FA;
	Thu, 23 Aug 2012 17:16:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31AF481F9; Thu, 23 Aug 2012
 17:16:43 -0400 (EDT)
In-Reply-To: <1345748186-1081-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Thu, 23 Aug 2012 20:56:26
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D663DD14-ED67-11E1-B063-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204172>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> The 'track' in the message is still not great, but it does fit with
> the one above. Maybe if we make it say "If youw wanted [...] track th=
e
> remote-tracking branch 'origin/master'" it would be clearer?

The verb "track" in the phrase "remote-tracking branch" means "keep
track of the branch at the remote, by storing a copy of the last
observed state of it".  In the same sentence, the verb "track"
elsewhere is used to describe what the branch B whose upstream is
set to B@{upstream} does against B@{upstream}, but that is not
"keeping a copy"---it is doing an entirely different thing.

If we say that the branch B whose upstream is set to B@{upstream} is
"building on top of B@{upstream}", "integrating with B@{upstream}",
"forked from B@{upstream}", etc., without using the verb "track"
that already means something else (i.e. keeps track of the copy of
last observed state), it would reduce the confusion, but I do not
think it would clarify anything if the verb "track" is used for
that.

As usual, because I am not the best source of phrasing, others may
find a better verb than "builds", "forks", or "integrates", though.

> I've simplified and tightened the logic. Now it will only show the
> undo message if the branch didn't exist locally and there is a
> remote-tracking branch of the same name.

The updated and simplified logic reads quite straight-forward, and
looks good.  It is likely that the message will be reworded and also
localized in the future, so it would make sense to use test_i18ncmp
from the day one, though.

Thanks.  Will queue.
