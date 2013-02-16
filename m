From: Junio C Hamano <gitster@pobox.com>
Subject: Re: supports diff.context config for git-diff-tree
Date: Fri, 15 Feb 2013 16:00:28 -0800
Message-ID: <7vhaldf7qb.fsf@alter.siamese.dyndns.org>
References: <CAHtLG6TPs=Z2i8s3_dd_igztuvuqE5L93cTtBM4q1zDCzpU55w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 01:00:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6VD5-0004pq-TD
	for gcvg-git-2@plane.gmane.org; Sat, 16 Feb 2013 01:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156Ab3BPAAc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Feb 2013 19:00:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61911 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034Ab3BPAAb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Feb 2013 19:00:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00395B85E;
	Fri, 15 Feb 2013 19:00:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=EQeDiXgoCTjA
	ObXQCkXOw6pJjf4=; b=lqRYFoIMO05cpfaMPgWcg/qAnd0LWTA7v38BvTOB/oDK
	bT0R4kn9owvO/AxoPoq5fT7oxo1/Xx/6LFwWmCwORBVkdS3CPO3HVKOjs+RcOWl4
	kI3t4hZZMOAze1FLne3QpgpEI/0M/LIBZEcaL6jLM1Rh6psmPx19eO6xGyhnweY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EuXTm9
	F0Phm3pcRpmfmZZ0pGz3xhCN4/Z+vcHUc6mXZ3zJ/XrPfUkJky0q7MMbGVnFGgK2
	3WU9JfWtz/J3UAeSC3C3io0iTfBftPknfUU9YAXHhOR2l7XweOmcPLUZOWuXqcBD
	pKUMt069MRNA2cchgiXPa9+oF90+m/FZMBJkU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7851B85A;
	Fri, 15 Feb 2013 19:00:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64A41B850; Fri, 15 Feb 2013
 19:00:30 -0500 (EST)
In-Reply-To: <CAHtLG6TPs=Z2i8s3_dd_igztuvuqE5L93cTtBM4q1zDCzpU55w@mail.gmail.com>
 (=?utf-8?B?IuS5memFuOmLsCIncw==?= message of "Sat, 16 Feb 2013 07:52:23
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E090DFFA-77CB-11E2-AC97-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216367>

=E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@gmail.com> writes:

> In git 1.8.1, git-diff supports diff.context config.
> However, git-diff-tree does not support this.
> Could you also add this to git-diff-tree?

That's more or less deliberate, isn't it?

Cosmetic details of the output from plumbing commands should not be
affected by random configuration variables the user happens to have
and break the assumption your script that reads their output makes.

If your custom Porcelain that is built using the plumbing commands
wants to honor such UI level configuration variables, "git config"
is there for that exact purpose.
