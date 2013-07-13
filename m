From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mailmap: Testing the single letter name case.
Date: Sat, 13 Jul 2013 10:38:06 -0700
Message-ID: <7v8v1aicn5.fsf@alter.siamese.dyndns.org>
References: <1373665135-32484-2-git-send-email-gitster@pobox.com>
	<1373700020-30436-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Jul 13 19:38:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uy3mD-0007T7-Rp
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 19:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758144Ab3GMRiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 13:38:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52593 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058Ab3GMRiO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 13:38:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4189D300F4;
	Sat, 13 Jul 2013 17:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RpMXQJv+5P4jjvmUx8qLoLvf7uQ=; b=ZNJ1vP
	l9vlA8VbqmXf6oGuiafVfhLK9iy1m5WQzJi7jypwoLkeoSBtS0OxSYQxoIOZ+/Qy
	2wQyGf3m1ySnkUbBGNZcHpqBo8XaQ4ftDWK5bvs82od0eXrhUHITksrMnoqehwh3
	JZzYs8zqPyijN/Zil7frPVO9hKSUpydonFtVY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TLi1xuUvwk8KGFhQxWHACf7+pYaC3Ei8
	iOp1SYjK7ZX3R2jP83guZwwY0jv5S+P7EFnnJggzjiXCKjW4fzQ0Z+Lp+jW+l1mS
	BR1umdS4ZtB0IFyCohFm2DIZ3drijEObneNLNlkYjdiqmcQJHrbO81OS7Uj8U7DJ
	A1bEf077l1Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 352A5300F2;
	Sat, 13 Jul 2013 17:38:09 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72CB8300F1;
	Sat, 13 Jul 2013 17:38:08 +0000 (UTC)
In-Reply-To: <1373700020-30436-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Sat, 13 Jul 2013 09:20:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB3D69AA-EBE2-11E2-9C7A-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230284>

Stefan Beller <stefanbeller@googlemail.com> writes:

> This is a regression test for a66e77eab70a08938fdc2227b7ada0f0465c6991

Sorry, I do not quite get this.

If you apply the patch on top of the said commit before that commit, the
new test does not pass.

But if you apply the patch on top of the said commit, the new test
still does not pass.

So I am having hard time guessing what you meant by "regression
test".  It is not "a66e77 broke something that ought to work, and
this shows the breakage".  It is not "a66e77 fixed something and
this shows the previous breakage that got fixed."

It may be because the test is depending on ShortName not to be
downcased incorrectly, which was to be fixed by a later commit.  But
after applying this on top of jc/mailmap-case-insensitivity topic,
the test does not pass (and reverting a66e77 does not seem to affect
the result, either).
