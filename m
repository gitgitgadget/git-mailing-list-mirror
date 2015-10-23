From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] expose parallelism for submodule {update, clone}
Date: Fri, 23 Oct 2015 12:25:39 -0700
Message-ID: <xmqqvb9xo098.fsf@gitster.mtv.corp.google.com>
References: <1445625879-30330-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 21:26:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZphyP-0008Jn-Bc
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 21:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbbJWTZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 15:25:54 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51296 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752266AbbJWTZn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 15:25:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4B21F23947;
	Fri, 23 Oct 2015 15:25:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mGeEElYBA/cv/4SDNZSWfdDD668=; b=MqTRWW
	03KL091xLQE27gOQdgSVisoar5+8c9/Lk3fDMJKR6gSn6Lx6jsnn/AmXq10Lht+8
	ARFDy8z44pelmrK3zwKJAPYL3Q6gvjMbOQ5Wnd0WoeNihHU4+5SYBxNPVuz26dnp
	9i2Uu8z7rGR43+QAu+3rtdLRg7Xt564BYPlBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m7kgcrWcuTzAiTEGdL53r/92Bwsif9EI
	O+l/Ann8fPWIpHANScszq5Ifq7cqXmSjyyR7pThQn8JzQnAcThjoqSxGF7VY5YHA
	rGuU3lxETvEKkXw368TxuB91hCSmSqShHBcGsT2uh62nYvHbjR+Pu5iFh7B/W5EW
	n1mDIp4r3oQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 43B1F23946;
	Fri, 23 Oct 2015 15:25:42 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BA2AB23944;
	Fri, 23 Oct 2015 15:25:41 -0400 (EDT)
In-Reply-To: <1445625879-30330-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 23 Oct 2015 11:44:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D9647706-79BB-11E5-B372-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280108>

Stefan Beller <sbeller@google.com> writes:

>   submodule update: Expose parallelism to the user
>   clone: Allow an explicit argument for parallel submodule clones

downcase Expose and Allow, perhaps?



I was looking at the previous one and I am getting the feeling that
everything up to "run-command: fix missing output from late callbacks"
is ready for 'next'.  Am I being too optimistic and missing something
that may make you want to do another reroll?

37bc721 submodule.c: write "Fetching submodule <foo>" to stderr
0904370 xread: poll on non blocking fds
fd6ed7c xread_nonblock: add functionality to read from fds without blocking
e7ba957 strbuf: add strbuf_read_once to read without blocking
8fc3f2e sigchain: add command to pop all common signals
f57c806 run-command: add an asynchronous parallel child processor
4733d9e fetch_populated_submodules: use new parallel job processing
dca8113 submodules: allow parallel fetching, add tests and documentation
79f3857 run-command: fix early shutdown
1c53754 run-command: clear leftover state from child_process structure
63ce47e run-command: initialize the shutdown flag
c3a5d11 test-run-command: test for gracefully aborting
74cc04d test-run-command: increase test coverage
376d400 run-command: fix missing output from late callbacks
