From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] completion: fix issue with process substitution not
 working on Git for Windows
Date: Wed, 26 Oct 2011 14:07:04 -0700
Message-ID: <7vipnb1myv.fsf@alter.siamese.dyndns.org>
References: <CAJzBP5QYKOf4OUMm4vfVay=b7F_fHJf40JgzDAZZa7p0fxLpyA@mail.gmail.com>
 <1319656389-9515-1-git-send-email-stefan.naewe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org, git@vger.kernel.org
To: Stefan Naewe <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 26 23:07:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJAh1-0004Uw-DI
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 23:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260Ab1JZVHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 17:07:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61855 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300Ab1JZVHI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 17:07:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 200FD5D0E;
	Wed, 26 Oct 2011 17:07:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r0HGOOI2NjcemHw66YaNHC04ShY=; b=t2VxVH
	loUIz31K4sCjEaLsJkw3i08qCJyYFpnBRl+G6N7KO5FuzPxDZbIghtzazrIkUSQK
	PtVJ+sKhltxleM/s24OO6gkoKlMyQWAJZ7k7YBnMxaidClHDxGMsKWqHXmZ0tKf8
	Bdj6hOYfjLzIyKyaJ8SSEDCsbN+wFEvFFwetw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wZW7elemw9NTa3yfshMnivE2tXrCDLvy
	aK/WnOAkuAP2g7tsatbh+OsfSu5H/z01s38kGwlEdq7NxHim8Ucm/EfatS8DUpXL
	sQ7e8adNsgYY7VUJF2rccqNY1AhDvzP38ANyteWsdwlil4nq5ucg0s7G20mT7Gmp
	HBQ8RvT65ZU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17A4C5D0D;
	Wed, 26 Oct 2011 17:07:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8910A5D0C; Wed, 26 Oct 2011
 17:07:06 -0400 (EDT)
In-Reply-To: <1319656389-9515-1-git-send-email-stefan.naewe@gmail.com>
 (Stefan Naewe's message of "Wed, 26 Oct 2011 21:13:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 75EF935E-0016-11E1-AFCE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184278>

Stefan Naewe <stefan.naewe@gmail.com> writes:

> $ export GIT_PS1_SHOWUPSTREAM=1
> sh.exe": cannot make pipe for process substitution: Function not implemented
> sh.exe": cannot make pipe for process substitution: Function not implemented
> sh.exe": <(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n '): ambiguous redirect

Are these the exact strings you want to have in the commit log message? I
am particularly wondering about the dq after (but not around) 'sh.exe'.
