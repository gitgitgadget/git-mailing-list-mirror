From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git alias question
Date: Wed, 28 Dec 2011 21:32:34 -0800
Message-ID: <7vy5twx7rh.fsf@alter.siamese.dyndns.org>
References: <CAFLRbopjqW7OEWN4kxy+6Gb828h4zBC_h=4WiP-q1__LeezxUw@mail.gmail.com>
 <87wr9g2hcd.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Horowitz <michael.horowitz@ieee.org>,
	git <git@vger.kernel.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Dec 29 06:32:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rg8ba-0003Yc-En
	for gcvg-git-2@lo.gmane.org; Thu, 29 Dec 2011 06:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888Ab1L2Fci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Dec 2011 00:32:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56520 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854Ab1L2Fch (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Dec 2011 00:32:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E477721A;
	Thu, 29 Dec 2011 00:32:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GS2R85iwy18QQhZ50Q7M9qxop7Q=; b=YVB3jf
	ph3zy324BL2kdxHzbLEZ3aW/zg1jbNuwuhYzzFMtTEvISzzj/a4bVwMSw1wQnhMs
	KcpZprwmHNrLuXqLikP1pp20zC598M3gEP/pQRzD0Pz3hQSUV0P7wuTiu+zQ3C1Z
	FcooXo+ABMqEeRK7tdGi+Ga/rn2W3/xJBYBBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wvqIjy8DNgC8JBlehqcoAt2PvIZYWRb/
	lmJKqxd7+Xe+LHD6Q1kaA9hJkKWAYYTAN7xpw979nnGVK0Qyf1FFb4ktxuLtiTyd
	junS9Z0VyPtiHAzLAVt8PAMRfPi9NtQAcWGx1vkA9kunIXozqzPkk8wmgh+7fRJ0
	coSyKOSZ5b0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35A1A7219;
	Thu, 29 Dec 2011 00:32:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A759E7218; Thu, 29 Dec 2011
 00:32:35 -0500 (EST)
In-Reply-To: <87wr9g2hcd.fsf@catnip.gol.com> (Miles Bader's message of "Thu,
 29 Dec 2011 12:21:22 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8386A12A-31DE-11E1-889D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187772>

Miles Bader <miles@gnu.org> writes:

> Michael Horowitz <michael.horowitz@ieee.org> writes:
>> I was able to make the following 2 aliases, which work perfectly
>> except for one problem...
>>
>> ldiff = "!git diff `git rev-list --reverse -n 2 HEAD -- $1` -- $1"
>> ldifft = "!git difftool `git rev-list --reverse -n 2 HEAD -- $1` -- $1"
>>
>> The problem is the limitation that shell commands are always executed
>> at the top-level directory of the repository.
>
> Hmmm, it'd be cool if git exported an environment variable containing
> the CWD when it invoked external aliases like this...!

Yeah, something like GIT_PREFIX environment variable, I guess.
