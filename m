From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: report invalid commit correctly
Date: Wed, 30 May 2012 14:11:01 -0700
Message-ID: <7vvcjdxtlm.fsf@alter.siamese.dyndns.org>
References: <7v7gvt1xz6.fsf@alter.siamese.dyndns.org>
 <1338395982-5448-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, manuelah@opera.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 30 23:11:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZqAg-0006te-O2
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 23:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234Ab2E3VLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 17:11:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35355 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753986Ab2E3VLF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 17:11:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68AAD8A37;
	Wed, 30 May 2012 17:11:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f4yKDuk63ENb7Mz8X/3tXvePOjk=; b=NwyZSo
	DCwL97DoWjvgRRpe5HJVVHN1UNuZpeSDGRr4DhFB6saIXxrZ0O/W2eajFyDCQY4P
	eQNONP2RR0vVB/3kwg86hnc7HxelhZKKYvrtVZwpE0ei/DnMQfUSXhS3AKNU2h6Q
	rBxRDOYV3B2fuTMG18RrSYRnnnfX/OSGmXMaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ECWuKh8GWRjm2p19rZpDeeAt8pFeA+at
	M1Bdn8vV1TDi44Sw5DH7EfEXXklG+AR+9raCGJVgVG6rIVo/fHz4VjC0yTYolHdr
	mZHo0k01b3/hCgY11hAk5qNB2hshaourr6DWIWy2o+N0Bm4es6XRDxMJahShH2/z
	Ho/53s7ibCs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A7EF8A36;
	Wed, 30 May 2012 17:11:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD7828A35; Wed, 30 May 2012
 17:11:02 -0400 (EDT)
In-Reply-To: <1338395982-5448-1-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Wed, 30 May 2012 18:39:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F6728196-AA9B-11E1-B40C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198834>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> In 9765b6a (rebase: align variable content, 2011-02-06), the code
> to error out was moved up one level. Unfortunately, one reference
> to a function parameter wasn't rewritten as it should, leading to
> the wrong parameter being errored on.
>
> This error was propagated by 71786f5 (rebase: factor out reference
> parsing, 2011-02-06) and merged in 78c6e0f (Merge branch
> 'mz/rebase', 2011-04-28).
>
> Correct this by reporting $onto_name istead.
>
> Reported-By: Manuela Hutter <manuelah@opera.com>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>
> Here's a proper patch, I guess.

Thanks.
