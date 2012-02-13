From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git cherry doesn't list a merge commit
Date: Mon, 13 Feb 2012 10:57:17 -0800
Message-ID: <7vaa4mfto2.fsf@alter.siamese.dyndns.org>
References: <4F392976.9070009@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tajti =?utf-8?Q?=C3=81kos?= <akos.tajti@intland.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 19:58:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx15g-0005wi-Cf
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 19:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757568Ab2BMS5U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 13:57:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58630 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757559Ab2BMS5U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2012 13:57:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66FF972CA;
	Mon, 13 Feb 2012 13:57:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5movpGIzBIw+
	Jhe1Od+oFWt0HbQ=; b=v1WTmlfNkaHrIPpCWDIU1s3cmxl784q8hoaSY7DzxfPY
	d9weN8S2viVpqOu/vGTOpRoG4y/rm0Smv+OJVkQJwDW0WCEVKDWa8Ud1FZDVfTW0
	1A8yUS0439IKDjUXk4nNQRs0inIDxwfTx5HCENPkhNVDfHYHNnVZER/VyTeO4GI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mOJbfv
	7rod1rI+wHFTBWpjqGjGOwKr49bwQHbGU0oyPle299KXJe+d8O8+xxZY4//DvNz4
	7jkxmN2tqgwPIwKkxwUvqU2VV6eNNjlEb+FlT3S6R6ZP/ebFthjRaJY+0XUkVpHr
	j5WUEaj5/t5ZpC0fHN62q4HNXLWVbLp+COlB4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D83B72C9;
	Mon, 13 Feb 2012 13:57:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEB6472C7; Mon, 13 Feb 2012
 13:57:18 -0500 (EST)
In-Reply-To: <4F392976.9070009@intland.com> ("Tajti =?utf-8?Q?=C3=81kos=22?=
 =?utf-8?Q?'s?= message of "Mon, 13 Feb 2012 16:17:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D92CFD0-5674-11E1-91C6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190648>

Tajti =C3=81kos <akos.tajti@intland.com> writes:

> However, the manual of git cherry says:
> "*Every* commit that doesn=E2=80=99t exist in the <upstream> branch h=
as its
> id (sha1) reported, prefixed by a symbol. The ones that have
> equivalent change already in the <upstream> branch are prefixed with =
a
> minus (-) sign"

The sole purpose of the command is to decide which commits in the exist=
ing
history to run "format-patch" on to feed the output to "am" to update t=
he
other history, and it was clear for both readers and the author of the
documentation that a "commit" meant a "non-merge commit" in that contex=
t.

A patch to rephrase it to "every non-merge commit" for clarity may not =
be
useless, though.
