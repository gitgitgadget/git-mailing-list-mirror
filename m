From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Ambiguous ref names
Date: Fri, 20 Nov 2009 02:26:42 -0800
Message-ID: <7vzl6h3319.fsf@alter.siamese.dyndns.org>
References: <5195c8760911200218v5b75d690hbaaf00b44c8df6af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeenu V <jeenuv@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 11:26:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBQhf-0007Bm-1B
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 11:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbZKTK0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 05:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbZKTK0q
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 05:26:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33614 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbZKTK0q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 05:26:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A72C881E06;
	Fri, 20 Nov 2009 05:26:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=loOmhOSUMAU9Ek2/H1MmUoowExA=; b=a2sLZe
	O06CarpB8ODDawOjBhiMuBaC/hrbgKBkdeYH7xBUhcIxV9GkA9p0PSzxm1XwoA9K
	dE8fLGz6tdz4FTv8sE+EB7WyFtydeDlkKIvEPMQnhvePmPEH54zlmiksKeBrSbgw
	8xIpOFZ/mn5SaAuCmmCGdmVXW6pKgjwefAqtw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=voX7idbyUTxh6TU2U0zxPSDre2suSAt9
	9e6qBjW7mKX+TUojS5Qyh3GqIg7lUkrmuRnb9f+Zi0zrvKpDfe2dGWkq3nghkBmD
	cJ9XkN/8YUn33T/uKSEneZ1+vTIdQihnX32plFvEDZa+rG7EgQXxMkF2GObDU8pZ
	rXz5UfQpbL0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8464D81E05;
	Fri, 20 Nov 2009 05:26:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2D1681E04; Fri, 20 Nov
 2009 05:26:44 -0500 (EST)
In-Reply-To: <5195c8760911200218v5b75d690hbaaf00b44c8df6af@mail.gmail.com>
 (Jeenu V.'s message of "Fri\, 20 Nov 2009 15\:48\:44 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3522E110-D5BF-11DE-B4A7-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133325>

Jeenu V <jeenuv@gmail.com> writes:

> If I've two branches a.b.c and a.b.c.d, why does 'git checkout'
> complains about ambiguous ref names?

Because it doesn't???

    : demo; git init
    Initialized empty Git repository in /var/tmp/gomi/twelve/.git/
    : demo/master; >f
    : demo/master; git add f
    : demo/master; git commit -a -m 'initial'
    [master (root-commit) cb1d5f2] initial
     0 files changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 f
    : demo/master; git branch a.b.c
    : demo/master; git branch a.b.c.d
    : demo/master; git checkout a.b.c
    Switched to branch 'a.b.c'

It could be that you have a tag and a branch that are both named a.b.c,
though.
