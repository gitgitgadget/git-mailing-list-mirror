From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git describe relative to a given tag pattern
Date: Mon, 06 Feb 2012 14:10:19 -0800
Message-ID: <7vhaz362b8.fsf@alter.siamese.dyndns.org>
References: <CA+mfgz0VB9qMHHtoT76zCOiUaH=8egdMDrneQVRBug2waQsGAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Mercer <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 23:10:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuWlX-0004sZ-QD
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 23:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317Ab2BFWKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 17:10:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47619 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754554Ab2BFWKW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 17:10:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 665BF6ABD;
	Mon,  6 Feb 2012 17:10:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kL1R1s0yYZmkwa2ExnjLcZ5KOKk=; b=GgRO8s
	0frvnTaI1/IHLNlk+NRDBjZbS08rXMxCLiEd4uJOqWlDB8NPyLU5GkowecmC44vK
	SGgwNfJciQFMMT0iyLXOAKdKVwnEpw4v+L1ulqGJwTVc++s77Qr7+LQ0w/Tn8quy
	oTakyiTK9frJEwud8d2tOAqND1dcgmnKHkiKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SbZb1N7SBxdlbHuRwmGHtQ7CzIAYgznk
	F0sVNp9/Ili+g7S9QU7Xhjmn6bKr4h+Oj402sFWYc33FM+dsLqmfIhYmVE2tX2vH
	FLTOq9v6NTZNWDP054xC50FiR/TM6V6+dcFWE+md7ferI03mpiAoFzr2ezFouVsp
	WRBddu6UjGg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DBB86ABC;
	Mon,  6 Feb 2012 17:10:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC4796ABB; Mon,  6 Feb 2012
 17:10:20 -0500 (EST)
In-Reply-To: <CA+mfgz0VB9qMHHtoT76zCOiUaH=8egdMDrneQVRBug2waQsGAg@mail.gmail.com> (Adam
 Mercer's message of "Mon, 6 Feb 2012 16:03:32 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5C1FF8C0-510F-11E1-B323-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190113>

Adam Mercer <ramercer@gmail.com> writes:

> $ git describe --match=lal-v* HEAD
> fatal: No tags can describe 'cee13cbb25d0fa38f6e3bc6622bc751ebf35d2f0'.

Perhaps Git is correct and your HEAD is not a descendant of any tag whose
name matches the pattern "lal-v*".

Here is how people can mimic the situation:

	$ git checkout v1.7.6~20
        $ git describe --match='v1.7.*' HEAD
        v1.7.6-rc0-3-g6c92972
        $ git describe --match='v1.7.[7-9]*' HEAD
        fatal: No tags can describe '6c92972d7f5ab247a8cab5e4b88cb281bf201970'.
	Try --always, or create some tags.
