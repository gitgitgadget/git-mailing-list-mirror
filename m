From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Get a git diff without taking index into account
Date: Wed, 18 Feb 2015 08:33:52 -0800
Message-ID: <xmqqfva341sf.fsf@gitster.dls.corp.google.com>
References: <CAAoZyYN-ohiq-Od=u-cd5FRH8=NpJNGS+zEo+NYgwAK7Kjaz_w@mail.gmail.com>
	<CAAoZyYPhiKX1F5ymdSijR7=e8CT1sqaomehBjt-NVDz_A4V4UA@mail.gmail.com>
	<CAPc5daU9km+gr-DHJzJF59mugwGeNX69H27E_DaoyBZnuzoiFw@mail.gmail.com>
	<CAAoZyYPVopmP_bv7EZS912R4bxpzNm49_q0XXZXqa52dTDDM2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Frederich <eric.frederich@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 17:34:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO7Zd-0006Xa-QT
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 17:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbbBRQeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 11:34:00 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64587 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751712AbbBRQd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 11:33:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C75E336A3A;
	Wed, 18 Feb 2015 11:33:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wLYFykPD5p7NiODfhezA2dbnjAc=; b=s4TrE6
	F1qWBAoc7pC7IjZlm55EAqa/AVcorhDB7JIiqFkMp5He3sZA6jZQzelAwIk6RZnS
	q92UwfBhr7GLDTaIBCtFNFozRVjzGKVz7wfWLX3+spDkb4CKHKicE+WM+MAv6/qW
	+NgYrxa6e/zLquqaEw42rs1DYkla/d0kDJOuU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FJ7/ZRRO8Mh3X6uhovYNuESgR68NmHDk
	/kHJPpxfuSCt14VtO14kqrlXYNo/vfVacvYJoLK/YNGNQvBlM7oTmL+t5Wm36Pei
	4PsYBQrhkktD5xOWYdd2vpOtPZ7Tkp46292AGV4kMMLRa5wvnHnC1BtZt8mSpFSf
	p7J/EraV4/4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BEA6C36A39;
	Wed, 18 Feb 2015 11:33:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4231636A38;
	Wed, 18 Feb 2015 11:33:53 -0500 (EST)
In-Reply-To: <CAAoZyYPVopmP_bv7EZS912R4bxpzNm49_q0XXZXqa52dTDDM2Q@mail.gmail.com>
	(Eric Frederich's message of "Wed, 18 Feb 2015 10:42:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ED04D49C-B78B-11E4-AA9E-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264028>

Eric Frederich <eric.frederich@gmail.com> writes:

> This is from "git help diff".  It seems to imply that I should be able to do it.
> It mentions nothing of the index.

Most of the documentation on early subcommands (and "git diff"
certainly is one of the early subcommands) were written back when
everybody knew that Git almost always talks about _tracked_ files
that are known to the index, and the only time it even cares about
untracked ones that are not in the index was when it tries to help
users by reminding what the user may have forgot to "git add".

Documentation pages do not bother repeating "this only looks at
tracked paths" for this reason; Git is about tracked files by
default.

Perhaps you can suggest how to improve the description of commands
without being too repetitive?

Thanks.
