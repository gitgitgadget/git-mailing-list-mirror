From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/21] t6030: generalize test to not rely on current implementation
Date: Sun, 10 Apr 2016 12:16:08 -0700
Message-ID: <xmqqy48ls29z.fsf@gitster.mtv.corp.google.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-6-git-send-email-s-beyer@gmx.net>
	<570A596F.9080200@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Apr 10 21:16:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apKqr-0001xd-W2
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 21:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932748AbcDJTQX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2016 15:16:23 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63700 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932284AbcDJTQV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Apr 2016 15:16:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 11DAC541A3;
	Sun, 10 Apr 2016 15:16:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=S04aLOoYHLyg
	Ox3ecdqncy3ZS+w=; b=uIJu9mgtAC8hK4V6IGWeQa4m/gZaxA5joZlE2ZRt1KqL
	GV4E4siO3vlR4btLqs757msg0AJ8sGTd8w1XoaNCJCzKmNwmvhE0qv8VWgXjUFOA
	hRBRnCtbzG9PDjhmiWHfuCtHotIV27vTc8lIM9gUNHDHcuW2DfwrGE0a/0xy+Hg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JLaRj3
	6/zT+y3CUuo9U3Xvy8xVQS2WqfZGlMipr3EWgSWHfr1KE9VV2QG99PaHuPhuqpDh
	LmlFjhTIOgy/RWQIeiMa+5Kn+VO3usLCqfbBfX+KBELdmmQibwxQsfLHlY8BQGZo
	1531X86DvU+PosEFFRfMHPpWrq2cQucm4ywfY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 092D9541A2;
	Sun, 10 Apr 2016 15:16:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 73A385419E;
	Sun, 10 Apr 2016 15:16:09 -0400 (EDT)
In-Reply-To: <570A596F.9080200@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sun, 10 Apr 2016 15:47:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AE81C992-FF50-11E5-9FDB-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291187>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Portabily:
> Since yesterday/yesterweek the usage of hard-coded
> #!/bin/sh had shown to be problematic

That is not a new revelation, though ;-) It is just that these are
problematic to those on minority platforms, and by definition they
are noticed only when a very few people on minority platforms
happened to have run tests.

Thanks for keeping an eye on patches in flight to prevent new
instances of this issue from getting added.
