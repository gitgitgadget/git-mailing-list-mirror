From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/10] revert: report fine-grained error messages from
 insn parser
Date: Thu, 15 Dec 2011 13:23:18 -0800
Message-ID: <7vsjklmsvt.fsf@alter.siamese.dyndns.org>
References: <CALkWK0kbV2WFfGVrA9m_Uwd4J8+U9Yde9Wxb-OZE9Y8K+Ta_4A@mail.gmail.com>
 <1323881677-11117-1-git-send-email-artagnon@gmail.com>
 <1323881677-11117-11-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 22:23:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbIly-0004xX-EX
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 22:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759421Ab1LOVXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 16:23:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33190 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754146Ab1LOVXV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 16:23:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D627A6059;
	Thu, 15 Dec 2011 16:23:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JcLSekDzZxb0h803TMvngN5zE54=; b=ubG2yR
	ipkaR+e9inq+n2sCR0BY6Q1kVJhh+7qTZ7KyeNtPQIJaqTkBlWY0Kx5KlG6XqgpG
	o4Ng2dtG53KTtWP6Vx1+4eeeFzjiK50vj1FF+dESXcGK/PIgR4j1ROWsXSRjJjrb
	5eKQ1wEShw4skKgUHF6Kk1Pa9YIzPKaH2rGvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gBoD1IgK9YJND0dCXzVIjzwTohO8jqao
	c5wQSH39KAsRl6j64fXybLYLpzSjSd9X33bJtAjf+k4hm0aMjNiScfvQKqHWNInb
	Gut9wMqEDXN44ZZhfyqTgWtOPVBwYm2fyXsxUTjdSpx1MxLn3tO3z/5UeXjTzHte
	g+qMTTxqU8U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD3916058;
	Thu, 15 Dec 2011 16:23:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65A746057; Thu, 15 Dec 2011
 16:23:20 -0500 (EST)
In-Reply-To: <1323881677-11117-11-git-send-email-artagnon@gmail.com>
 (Ramkumar Ramachandra's message of "Wed, 14 Dec 2011 22:24:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 030D698C-2763-11E1-86C1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187236>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Three kinds of errors can arise from parsing '.git/sequencer/todo':
> 1. Unrecognized action
> 2. Missing space after valid action prefix

I think these two are the same and shouldn't result in different error
messages, i.e. the first one in this sequence is still an "Unrecognized
action" error and does not have anything to do with "pick" action.

	pickle rr/cherry-pick~4
        pick rr/cherry-pick~3
