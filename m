From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] blame: CRLF in the working tree and LF in the repo
Date: Sun, 26 Apr 2015 22:31:11 -0700
Message-ID: <xmqqzj5uxhls.fsf@gitster.dls.corp.google.com>
References: <553CD3DA.9090700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>, kasal@ucw.cz,
	sandals@crustytoothpaste.net
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 27 07:31:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymbdk-0008Lt-1U
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 07:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbbD0FbW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Apr 2015 01:31:22 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752736AbbD0FbS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2015 01:31:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D996F444B8;
	Mon, 27 Apr 2015 01:31:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8pLcmf0FM8DI
	pLcPE+zI/NYYfMs=; b=W/yPdpYh2ozUITins6DKovxJKzYiEg27d1dlX1WTdQ2W
	abLpRFLu3Vxrv29+h3WnITO1gqVZ8o0EPS0oTUHx7Dla4rPv1xIVTNM6nERS1t4V
	JGL+nFy85M4ykQMqamL2Bbq3ZdKxzrKqOA0WBdgRFV9R2c/5d1nv1ZkVj//oPFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LqdI6o
	B2pB4l5eHqh9EEeMNqxXQH3fYtOKAxkS0uEYLzTX8Z7UEEi7R4Syd4D3OyZ3283E
	xjY6+LBCsonKUV4VBY5DgHOgGbPU9siupiPtxrZuotPO+x/FKMzQ6ci6k2Ies5lt
	+C3zhReewrH3WzhMQY2gKnoGYTVl6MnnHcaqg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D2524444B7;
	Mon, 27 Apr 2015 01:31:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B300444B6;
	Mon, 27 Apr 2015 01:31:12 -0400 (EDT)
In-Reply-To: <553CD3DA.9090700@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sun, 26 Apr 2015 14:02:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9DC4DA38-EC9E-11E4-8DA0-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267846>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Although the intention of 4d4813a5 is good, it breaks
> the usual EOL-handling for Windows.
> Until we have a better solution, we suggest to revert it.

That makes it sound like you are proposing to rob Peter to pay Paul,
but that is not how we do things around here.  If both the case
4d4813a5 tried to solve and the issue reported by Stepan need to be
satisfied, the current code will stay as-is until you can find a
good solution to make both happy.

Having said that.

I suspect (I haven't looked very carefully for this round yet to be
sure, though) that it may turn out that the commit you are proposing
to revert was a misguided attempt to "fix" a non issue, or to break
the behaviour to match a mistaken expectation.  If that is the case
then definitely the reversion is a good idea, and you should argue
along that line of justification.

We'd just be fixing an old misguided and bad change in such a case.

Thanks.
