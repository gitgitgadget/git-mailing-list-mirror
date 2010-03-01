From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] make union merge an xdl merge favor
Date: Mon, 01 Mar 2010 01:01:20 -0800
Message-ID: <7vaausza8v.fsf@alter.siamese.dyndns.org>
References: <972adf380be481b5e8d031481586e9c34da2cbb7.1267385538.git.bert.wesarg@googlemail.com> <17999fdb3ff374156acb7fc670426265fa27b94b.1267385538.git.bert.wesarg@googlemail.com> <7vwrxx2k29.fsf@alter.siamese.dyndns.org> <36ca99e91002282257i7f07f035o15d8d64e062ee94e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 10:01:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm1VP-00088d-8V
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 10:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839Ab0CAJBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 04:01:30 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812Ab0CAJB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 04:01:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BB159D70B;
	Mon,  1 Mar 2010 04:01:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zkLB391hplRgdvxSDiAMVj2SDZQ=; b=lOpprj
	9XfqhaBE6dD/tms3X+fLE+rA41Y6hlx3RWohIgazc3B6HOcxsC8V2Z303uTYd7cN
	0FAEeozPZJEbTzaNfyia/VyljCeoEcwthmEDvbV6+GeiM7JVFsH3LoXdqMFuLHsY
	Nczai8yAWfzat9A3OHZW5iqF2oLYioZPoLk+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mt2PlcqK6pkl5IJX2RH9mXEKV2deRGPW
	5ulU3h3R7thyTAB09c7JU0Hw94M8FPCAU7eOBwoEm42otRAa3KVAV9ct6k0uqu5E
	UkQ+biMF0FsMxITpMYhIfmU4QJ3iE5ExA9F38guTJoGGdY7lzAjSgBl9gfMRbdVJ
	15EStgBjb/Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 079D09D709;
	Mon,  1 Mar 2010 04:01:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F3009D708; Mon,  1 Mar
 2010 04:01:21 -0500 (EST)
In-Reply-To: <36ca99e91002282257i7f07f035o15d8d64e062ee94e@mail.gmail.com>
 (Bert Wesarg's message of "Mon\, 1 Mar 2010 07\:57\:40 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 03A1A9C2-2511-11DF-BA83-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141307>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> WIll do. On a side note: I plan to support the --union option also for
> git-checkout. Would that be a good idea?

What does it do?  Resolve conflicted paths using union merge at checkout
time?  That somehow feels like a dirty "because we can, and I only care
about union" hack to me.

I am mildly against "merge-file --union" in the first place.  The part I
actually liked in [2/3] was the removal of postprocessing.
