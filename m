From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] read-tree: at least one tree-ish argument is
 required
Date: Fri, 18 Dec 2009 15:46:55 -0800
Message-ID: <7vr5qrsv4g.fsf@alter.siamese.dyndns.org>
References: <4B274BDE.8000504@viscovery.net>
 <fabb9a1e0912181137t1265f86cs9e02019da136a0a@mail.gmail.com>
 <7veimsvz8a.fsf@alter.siamese.dyndns.org>
 <200912182304.27656.j.sixt@viscovery.net>
 <m3d42cc4i8.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 00:47:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLmXT-0004Gd-Fs
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 00:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669AbZLRXrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 18:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753244AbZLRXrJ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 18:47:09 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59528 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbZLRXrH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 18:47:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E3378A8878;
	Fri, 18 Dec 2009 18:47:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IAURYJfvlgdwTF0rtB1lUvAv+lc=; b=PGq6dk
	shuRTTXdu9YvO7v5PU5lCL0k3yHje7JT+/o67bWtEjjHvoyzal0+2kUncDi1apRi
	6V1Mroo8TR+awPL+cp4AqQOd7A3HrpuyD2cTMYgx/zGFISTKBd/qiBiQP8p7PBPD
	Vo8MsIIKH5HfChnk0sTH1Hpsp8WCiCdGc1TM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=evzQnNUnwAt9bN4DWV+IUUyjFr/heyHS
	36TlsK5uuwSpJ/f0iqPvdhInBdMRjlqMyQQMrVNG00qBbt6Fh6lXLnjKPRJGABpc
	kDSPCpfEn4GFfS4xZnZdfZQs2a+R8pciYfLGXj0YLZqKBfqSjbQQxHw7fif01N+d
	bvO67QX+MzI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A5CEFA8877;
	Fri, 18 Dec 2009 18:47:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 421C0A8876; Fri, 18 Dec 2009
 18:46:56 -0500 (EST)
In-Reply-To: <m3d42cc4i8.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Fri\, 18 Dec 2009 14\:17\:15 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A3F993B4-EC2F-11DE-8680-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135448>

Jakub Narebski <jnareb@gmail.com> writes:

> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>> Running read-tree without any arguments purges the index, but this is not
>> documented. This behavior is dubious at best because contrary to many
>> other commands, it does not use HEAD if nothing else is specified.
>> 
>> If one really wants to clear the index, this can be achieved with
>> 'git rm --cached .' or 'rm -f .git/index' in a more explicit way.
>
> One can (I think) also always use "git read-tree <empty tree>",
> where <empty tree> = 4b825dc642cb6eb9a060e54bf8d69288fbee4904

Come on.  If you genuinely believe that

    $ git read-tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904

is a better way to purge the index than

    $ git read-tree

then you need to get your head examined.  No, read-tree does not default
to examine HEAD and that will not change ;-).

Besides, read-tree is a plumbing.

Come back with a proof that there has never existed any script that uses
"read-tree" without arguments to purge the index, and I'd immediately
accept and apply the patch to retroactively forbid what the implementation
has allowed users to do for a long time.  Otherwise, I won't be involved
in discussing this before the next release is cut, as a change like this
needs a reasonable transition strategy as usual, and needs to happen after
the next release.
