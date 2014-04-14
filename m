From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] commit: add --ignore-submodules[=<when>] parameter
Date: Mon, 14 Apr 2014 14:08:43 -0700
Message-ID: <xmqqsipfmxes.fsf@gitster.dls.corp.google.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>
	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>
	<53374E49.9000702@gmail.com> <533874F9.3090802@web.de>
	<5338AC36.6000109@gmail.com> <5338B1B0.3050703@gmail.com>
	<5339BAE4.8020306@web.de>
	<CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com>
	<5339F122.60801@gmail.com> <5339FBB4.1010101@gmail.com>
	<533B2036.3050506@web.de> <533B36AA.3090600@gmail.com>
	<533C5CBD.4050601@web.de> <533C6B57.3080901@gmail.com>
	<534180BC.308@web.de> <53431CB8.2050600@gmail.com>
	<53432EA5.5060102@gmail.com> <53444368.9050607@web.de>
	<5349BC2C.9030509@gmail.com>
	<xmqqd2gjpxvy.fsf@gitster.dls.corp.google.com>
	<534C429A.6080508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Ronald Weiss <weiss.ronald@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 23:19:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZoHv-0004xr-LP
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 23:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755788AbaDNVTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 17:19:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44052 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755497AbaDNVIr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2014 17:08:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1714E7D9EE;
	Mon, 14 Apr 2014 17:08:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=naZy59mN1Kzx51sPjjoS4I8xwSs=; b=i5nO4j
	ylsFGZ+r5usUbcVNhoTAxS2sVeQNTp2gBD6fCKLszWNP57qeVVk5ALt6wjaztwkE
	vCkCWwm8PL4EHw6hZw1f1xbN/AsAdY+YV6WDvPt6DqIaJWR2ZEeSUHmn1Cdp6N3q
	wNXLsJb57FPKou+l0p82AdPa153cBnoB9Ix64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fje8z/KtKibgEvz9Np2O00/2pPGzz9RK
	IcjXz1IoDOB9/jwHhZIzDqU0YJvX/eA1nhaUHxWSF6v9Tpz6uKFN5TgQOrvyijg5
	KwtU3ubULC+tJl5qg3zVjW05ah/3eIJ4cO+d8X6refC8hDI0/zgQQnElBhR4BXqY
	acm5pnmRjQs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA0757D9EC;
	Mon, 14 Apr 2014 17:08:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F5807D9EA;
	Mon, 14 Apr 2014 17:08:45 -0400 (EDT)
In-Reply-To: <534C429A.6080508@gmail.com> (Ronald Weiss's message of "Mon, 14
	Apr 2014 22:18:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F6EE2056-C418-11E3-A271-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246266>

Ronald Weiss <weiss.ronald@gmail.com> writes:

> On 14. 4. 2014 20:30, Junio C Hamano wrote:
>> Ronald Weiss <weiss.ronald@gmail.com> writes:
>> 
>>> On 8. 4. 2014 20:43, Jens Lehmann wrote:
>>>>> Useful <when> values for commit are 'all' (default) or 'none'. The others
>>>>> ('dirty' and 'untracked') have same effect as 'none', as commit is only
>>>>> interested in whether the submodule's HEAD differs from what is commited
>>>>> in the superproject.
>>>>
>>>> Unless it outputs a status message, then 'dirty' and 'untracked' do
>>>> influence what is shown there. Apart from that (and maybe tests for
>>>> these two cases ;-) this is looking good to me.
>>>
>>> OK, I updated the patch for commit to take that into account. Also, I
>>> rebased both patches onto current master. Sending them in a moment.
>>>
>>> If you don't have any more complaints, can I add "Acked-by: <you>" and
>>> resend the patches to Junio?
>> 
>> It is not "When I see no more complaints, I'll resend with your
>> Ack".  An Ack is a positive thing, not lack of discovery of further
>> issues.
>
> I'm really sorry if the tone of my message sounded harsh to you, it
> wasn't meant like that at all.

No, that wasn't harsh at all.  I just did not want to get a patch
with Acked-by with somebody's name on it, when there is not yet an
Ack, as that will confuse me greatly.  My mental bandwidth is not
wide enough to keep track of all the in-flight topics I haven't yet
picked up.

I should be the one to say sorry if my message sounded harsh.

Thanks.

>> Rather, it is more like "I'll wait for your Acks and then I'll
>> resend with your Ack", or "If they look good, reply with Ack and let
>> the maintainer pick them up".
>
> OK.
