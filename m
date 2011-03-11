From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff-index and both deleted conflict
Date: Fri, 11 Mar 2011 09:28:20 -0800
Message-ID: <7vlj0lzhvv.fsf@alter.siamese.dyndns.org>
References: <201103111947.55412.dmit10@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dmitry Pavlenko <dmit10@mail.ru>
X-From: git-owner@vger.kernel.org Fri Mar 11 18:28:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py68k-0002O9-2g
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 18:28:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483Ab1CKR2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 12:28:30 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65175 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272Ab1CKR23 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 12:28:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 83C0C464F;
	Fri, 11 Mar 2011 12:29:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ENcewhVQ1YZmePCzvbNdgX61dOw=; b=SLM9GD
	t0oGp5Sb+whPDWscqqH1bkgvrE1nPgQU97cJ7zkfWYaQWcxzw5ecn2Z/M13YUyAs
	7h4RZrFn1vLu7gSaW62BjDJc/IvE5UM8lKpUDu5T9q2jzchkPtXvNzXiR0KyPAER
	LszllC8Dkeuk65M9qTR9jznuoKcE0J/JYvHsk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aCrkSc/tT2kZ8kOBr5drFKZL4COOyM+1
	8JpOCdvRGhoW2omkjOjttxix0eieB/sYKwlRtFaLtAjhBH7Po0ZBJJ1JomeGG0fB
	WOdsRi7PO/VMwp4ecw+XxmGZIy9cCWS+1wuWyus3nsSYVMxiCZdYQ679+0QHcq6/
	jDUQyM04rD8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5F16A464C;
	Fri, 11 Mar 2011 12:29:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5CD054648; Fri, 11 Mar 2011
 12:29:52 -0500 (EST)
In-Reply-To: <201103111947.55412.dmit10@mail.ru> (Dmitry Pavlenko's message
 of "Fri, 11 Mar 2011 19:47:55 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E116D48-4C05-11E0-9BE8-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168917>

Dmitry Pavlenko <dmit10@mail.ru> writes:

> that there's "no local changes in the repository (in the working tree and 
> index)" so that I could perform "git rebase" there?

There is a code that lets "git rebase" decide if it can run in the
source.  Look for require_clean_work_tree in git-sh-setup.sh
