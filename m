From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git diff' against files outside a git repo
Date: Sun, 26 Sep 2010 00:13:59 -0700
Message-ID: <7vwrq9m0y0.fsf@alter.siamese.dyndns.org>
References: <AANLkTinR7BJpD-FOS_DShg=r0ucF2C9oE6p-YoZU-5En@mail.gmail.com>
 <AANLkTik4kL8Mao1VM=njNxFSXOY7guwuEZgmpv0UTc8R@mail.gmail.com>
 <AANLkTikpPQM4GyP5O7+aw6_P9_1DdxUjTzpH=WhzW=wK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 09:21:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzlXy-0003bo-Cr
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 09:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416Ab0IZHOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 03:14:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061Ab0IZHOI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 03:14:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E6E25D9A10;
	Sun, 26 Sep 2010 03:14:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EolzaP7Mj+mWUE18H/farK7gFns=; b=ghzdXB
	Gfqfn4C3ghRuWq6jz/vb0a2yIjouxGMDihUTFjQjzxhwR97oqqPGcCLSBLc75r4Y
	yozclymrgCekuNAxKfsxcuVNv+H4dQPzMReskhdpokNtvxHdn/u6XqMpPgPHrPPp
	seojkDPYyMEbhv44JVDAyEZJVbaIvUJdcjcnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r8RpZMUIj2XvXsjc+TJ2WsryUE6vR3cK
	voC+BfVcRdKb00cYcGUpi/sTzwFea1RjKvdXDycTrCF1SIHGWWUhHz+lTzVHZt7R
	XeWRCHsLJyZSW93WE9Yy/10AqbzOs+Bvs7Ye4ZcVlfAsg3n/wvWICcXSCcxiRcVc
	Hz62B6tzTMk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A856BD9A0E;
	Sun, 26 Sep 2010 03:14:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6AC7D9A0A; Sun, 26 Sep
 2010 03:14:00 -0400 (EDT)
In-Reply-To: <AANLkTikpPQM4GyP5O7+aw6_P9_1DdxUjTzpH=WhzW=wK@mail.gmail.com>
 (Avery Pennarun's message of "Sat\, 25 Sep 2010 00\:45\:10 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A534EFDA-C93D-11DF-88E5-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157214>

Avery Pennarun <apenwarr@gmail.com> writes:

> Oddly, 'git diff file1 file2' *doesn't* work when file1 and file2 are
> in a working tree; git tries to diff something, apparently, but I
> don't know what.

Heh, I thought you've been using git long enough that you sh/would know
that you are comparing the index and the working tree, using "file1" and
"file2" as pathspecs.
