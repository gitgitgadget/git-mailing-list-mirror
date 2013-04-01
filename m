From: Junio C Hamano <gitster@pobox.com>
Subject: Re: transient build error after 'Writing MYMETA.yml and MYMETA.json'
Date: Mon, 01 Apr 2013 10:28:04 -0700
Message-ID: <7vhajqjh3v.fsf@alter.siamese.dyndns.org>
References: <CABURp0os62JCPCRsvQ+NneGaSobTUmgs7oZ9SqUiTH8AG0hPmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 19:28:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMiX8-000865-UP
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 19:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757199Ab3DAR2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 13:28:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60968 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755789Ab3DAR2G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 13:28:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36566117D7;
	Mon,  1 Apr 2013 17:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=onsY1c9OGjLYUZ/r9016j/eioJA=; b=wwyqJz
	wTnnirifNENwB0wn5+gd2BJ/HV0qaPqkVwPOAOzMP9lhg1w0ahyFACwIIeWJIgK7
	sGza+EbbIqwkHB76Vhg5K2Q/OYqfVBACx9YDPW54SwoGhh3BhycM7T9J2aOj2nOQ
	kU2hvkE/YRzj49i/lAKrq7I6BdfsLJHGbqyKI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cvXrdrLw3iO/uwhSq4++t5miEM2Rzlrt
	De2CynAq9iVrNDmfq3Nm48XwbQDx5kPCQaez2eCkZ6SIU/8Su2HTGcfPRHnY/mOZ
	smhaVjkbyCktzLOZFZ93hj/KdDfpmHmIEEH9hx0BX7VpPo9CY/OQskUGcXWtNGt0
	7mFtMhvoSDk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B012117D6;
	Mon,  1 Apr 2013 17:28:06 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD5F0117D4; Mon,  1 Apr
 2013 17:28:05 +0000 (UTC)
In-Reply-To: <CABURp0os62JCPCRsvQ+NneGaSobTUmgs7oZ9SqUiTH8AG0hPmQ@mail.gmail.com> (Phil
 Hord's message of "Mon, 1 Apr 2013 12:38:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 836B8250-9AF1-11E2-AEBA-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219694>

Phil Hord <phil.hord@gmail.com> writes:

> I have not seen this before, which makes me think it is something new
> in the makefiles.  But maybe it was a one-time fluke. When I ran
> 'make' again, it proceeded as normal.
> ...
> $ make prefix=/home/hordp all doc man
> ...
>     GEN git-add--interactive
> Writing perl.mak for Git
> Writing MYMETA.yml and MYMETA.json
> make[2]: *** [perl.mak] Error 1
> make[1]: *** [instlibdir] Error 2
> make: *** [git-add--interactive] Error 2
> $ make prefix=/home/hordp all doc man
>     GEN perl/PM.stamp
>     SUBDIR perl
> /usr/bin/perl Makefile.PL PREFIX='/home/hordp' INSTALL_BASE=''
> --localedir='/home/hordp/share/locale'
> Writing perl.mak for Git
> Writing MYMETA.yml and MYMETA.json
>     GEN git-add--interactive
>     GEN git-difftool
>     GEN git-archimport

I've also seen build failure with -j<something> in perl/
subdirectory from time to time, but the failure has been fairly
elusive for me that I haven't had a chance to look into what
triggers it.
