From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2010, #05; Sat, 21)
Date: Mon, 23 Aug 2010 09:33:42 -0700
Message-ID: <7vy6bx1e6x.fsf@alter.siamese.dyndns.org>
References: <7v4oen5clj.fsf@alter.siamese.dyndns.org>
 <AANLkTin26gfGTZyo+ZzG8s-FBTvY2Q9tYgYAQ70f8Lx=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Aug 23 18:33:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnZyB-0000sd-2g
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 18:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127Ab0HWQdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 12:33:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab0HWQdw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 12:33:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 71E63D0094;
	Mon, 23 Aug 2010 12:33:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=xChu27TX7r0RzDKwuyquy1sa/Rk=; b=clnAwxpsgPxf84y1i4VFArE
	7W8Ye6GQlGUTtFl4rPGsQReIy/JjeYWcHmUonHQE866WJMCy6oEWGBSFLLWQpjkK
	zKDUXQoRQ/zvFYU/tQo4rMrbncgBVeoqoa4pF3DS70Pc2FoJ2DL+WRibt/GhY5OI
	yYnQQYZzn522Yn0AP9xo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=LPRIwrMf5ErhDOGlOn9TPo9tRRYSAGS6meEhkVssSub9nQpzR
	DfPZ6E25ShAzbNUmG1MdkPOY06e6qiCcim64U1plr1WmDjkNqgHUL8JOd1goU+JG
	kwwiBQhIYVKfpWVdGo8KRncR2UjUqfpc5lcO14fcF1UHrxpQlPg9Ng2Ed0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DE65D0093;
	Mon, 23 Aug 2010 12:33:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 950F6D0090; Mon, 23 Aug
 2010 12:33:44 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 33FCDB30-AED4-11DF-8B53-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154235>

Greg Brockman <gdb@MIT.EDU> writes:

>> * gb/shell-ext (2010-07-28) 3 commits
>>  - Add sample commands for git-shell
>>  - Add interactive mode to git-shell for user-friendliness
>>  - Allow creation of arbitrary git-shell commands
>>
>> I am not very happy about adding these backdoors to git-shell, which is
>> primarily a security mechanism, and obviously security and backdoor do not
>> mix well.
>
> That's a fair concern, and I would not feel slighted if you decided to
> abandon the patches for this reason.  However, are there things we
> could do to mitigate the chance of an attacker taking advantage of the
> new functionality?  For example, what about requiring the git shell
> user to set a config variable in order to enable the extended shell?
> Or alternatively, as someone suggested previously, require the root
> user to drop some enabling config into /etc?

My gut feeling is that the current requirement that the repository owner
has to have the subcommand directory for git-shell as an explicit sign
that he wants to enable this feature is probably the same as requiring a
configuration variable.  As I am not sure if a system-wide policy would
help in what way, I would say what we have is probably sufficient.

Comments from more folks who are involved in installations with users with
varying degree of trustworthiness would be helpful, though.
