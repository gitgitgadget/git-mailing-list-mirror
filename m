From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] git-diff.txt: group the [--] and [<path>...] templates
Date: Wed, 24 Apr 2013 12:21:04 -0700
Message-ID: <7vy5c7buqn.fsf@alter.siamese.dyndns.org>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
	<1366821216-20868-4-git-send-email-artagnon@gmail.com>
	<7vtxmvdc4d.fsf@alter.siamese.dyndns.org>
	<CALkWK0nU-iTSF2DnmJAB=kj6w+VFv3rQrixEnHz0vyXf2d2=Mw@mail.gmail.com>
	<7vbo93db25.fsf@alter.siamese.dyndns.org>
	<CALkWK0nN+9XOTCqiY+yB9moQSvFFpSO=OZjJtLphBd2eQ24uDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 21:21:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV5Fj-0004CQ-KU
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 21:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757357Ab3DXTVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 15:21:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50114 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757329Ab3DXTVH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 15:21:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B45319843;
	Wed, 24 Apr 2013 19:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=blGMLB3kf9U6SUjX3OBcIb0sBGw=; b=cG717F
	YRIdnlFO97Gm+uZU3uWi4MwoAW+EOX3ruiJrq7+XUbjCK1mIhJCy4l7S4I0bf8Ew
	A2YNGOZeW0uU2MwOzb9VMLwHAVuTswNdvJNZDMqJTVuXTlkcHQ3hjCNI8cMIQSm5
	ykJ3+PZMCQMuztbGpl21zSbdl8JceFIZ1l994=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IY4Wl8XkdRFQ+oF1u+wU86cknDkL4Ar5
	sgggKcyY+g+qYihBuZXTDGXQaEBW3XAlnCHXexw2OXYcpfMhT3prnsZYxz+zfOOd
	Fw7hdyNAopGsjhFrWu4ajWaTgQJThVZPxEQnpRnwbihS6vRtThpp7LaPeU2eEdXw
	NFAA2BmQJ5A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 202A919842;
	Wed, 24 Apr 2013 19:21:07 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A26B19841;
	Wed, 24 Apr 2013 19:21:06 +0000 (UTC)
In-Reply-To: <CALkWK0nN+9XOTCqiY+yB9moQSvFFpSO=OZjJtLphBd2eQ24uDw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 25 Apr 2013 00:23:38 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C963D56-AD14-11E2-905B-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222303>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> The same logic would apply to this semi-nonsense rewrite, no?
>>
>>         git diff [[options] [--]] [<path>...]
>>
>> Everything else comes before "--" (if exists) that separates it from
>> the list of pathspecs.
>
> Yeah, except it's sometimes
>
>     [[options] [revision range] [--]] [<path>...]
>
> and other times
>
>     [[options] [<commit>...] [--]] [<path>...]
>
> and yet other times
>
>     [[options] [--]] [<path>...]
>
> Whereas mine is always
>
>     ... [[--] [<path>]]
>
> (everywhere in git)

You are missing the entire point.  Neither [[everything else][--]][path]
or [everything else][[--][path]] is better than without the extra
level of [], which does not help clarifying _anything_.
