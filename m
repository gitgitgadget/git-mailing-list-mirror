From: Junio C Hamano <gitster@pobox.com>
Subject: Re: receive.denyNonNonFastForwards not denying force update
Date: Mon, 20 Aug 2012 18:22:26 -0700
Message-ID: <7v628dght9.fsf@alter.siamese.dyndns.org>
References: <CAHgXSop42qWcAEGn6=og8Pistv_Jrwhgcnv3B_ORVtSMi1fCHA@mail.gmail.com>
 <CAHgXSooFj2PJtcOWqsVNHUzMBQnH0cYzPjfs1CkzVuufwRVrog@mail.gmail.com>
 <7vzk5pjxy3.fsf@alter.siamese.dyndns.org>
 <CAMK1S_hMTGhiKDow3x-UZ7eNnTtpLd2=QUf6-YoQF1-O1ywi2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Arthorne <arthorne.eclipse@gmail.com>,
	git <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 03:22:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3dAy-0000g5-UD
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 03:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738Ab2HUBWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 21:22:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60426 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751358Ab2HUBWa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 21:22:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 640556F9F;
	Mon, 20 Aug 2012 21:22:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZCVugWwxG36bYTuXCSwpgdpxkVI=; b=Y/tXyU
	KwYZn410jHo3q5ZhUwPWnqVbzPezaL+d5Ltcdgg3bv3xGTHaLtbIAY0PapPU6+dN
	go9DBptyJncmWcJV5YRmsZ4hYVn++krmzCbNadA9CvBxU2vpkKV00qmCw481GNS9
	vY/eE3w5HalFz/ky6bqBH/rp+HhsYx87R2Yzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k2R8mG92PxNmUe1ELmfgLQKoeRC3lw85
	TyIhoC/7jgrUpEE/qFBATVAktG2+Blo46XzK7BqcQ3kAcmzLLzPtYG2314qRptNR
	82oyEKFf7FcENjgej6OADbNgP5FKPxKbofENcLcQ7NBUl8AMrqXBaH8OwlSM6jCR
	phS6VzotdyM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 522EF6F9E;
	Mon, 20 Aug 2012 21:22:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 91BE36F9C; Mon, 20 Aug 2012
 21:22:28 -0400 (EDT)
In-Reply-To: <CAMK1S_hMTGhiKDow3x-UZ7eNnTtpLd2=QUf6-YoQF1-O1ywi2w@mail.gmail.com> (Sitaram
 Chamarty's message of "Tue, 21 Aug 2012 06:22:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC172024-EB2E-11E1-A1FC-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203912>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> On Mon, Aug 20, 2012 at 10:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> John Arthorne <arthorne.eclipse@gmail.com> writes:
>>
>>> For all the details see this bugzilla, particularly comment #59 where we
>>> finally narrowed this down:
>>>
>>> https://bugs.eclipse.org/bugs/show_bug.cgi?id=343150
>>
>> What does "at the system level" in your "does *not* work at the
>> system level." exactly mean?
>
> "git config --system receive.denynonfastforwards true" is not honored.
>  At all.  (And I checked there was nothing overriding it).
>
> "--global" does work (is honored).
>
> Tested on 1.7.11

Thanks, and interesting.

Does anybody recall if this is something we did on purpose?  After
eyeballing the callchain starting from cmd_receive_pack() down to
receive_pack_config(), nothing obvious jumps at me.

Could this be caused by a chrooted environment not having
/etc/gitconfig (now I am just speculating)?

A quick "strace -f -o /tmp/tr git push ../neigh" seems to indicate
that at least access() is called on "/etc/gitconfig" as I expect,
which makes me think that near the beginning of git_config_early(),
we would read from /etc/gitconfig if the file existed (I do not
install any distro "git", so there is no /etc/gitconfig on my box).

Puzzled.
