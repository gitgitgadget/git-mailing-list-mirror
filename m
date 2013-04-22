From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add .gitconfig variable commit.gpg-sign
Date: Mon, 22 Apr 2013 16:43:19 -0700
Message-ID: <7vip3em8rs.fsf@alter.siamese.dyndns.org>
References: <CAASwCXf3YHmdQ_eSkShyzn5VniO=ufm3VTqV1JVOUN610bzE_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joel Jacobson <joel@trustly.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 01:43:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUQON-0003R6-Re
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 01:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045Ab3DVXnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 19:43:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43194 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065Ab3DVXnW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 19:43:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E44319833;
	Mon, 22 Apr 2013 23:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uVD/FUfNVyxWrM+wCwEHI3blc+0=; b=ExqlWv
	1KhFlukZcxnOYGNSI1CZ0OzMM0bqMioXWpx8p5qmo/80/C/wzhrf2yWFKG6aYrVO
	EfMzfglYfil9L/JpKuFDkn+LxDBq6JitUKY28RdKrjlWqNChWFPB8eTjs9I0Mzk8
	Sq1CL4h08yAVyxjBMyIsOLj1efGHUACWHgokk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aH0Rk5ntruWaRTEj0TbayAOZrvuSb+Ve
	7TdLdi1hWZBUWnZdZrlGIYVozLGTtD6adGwxAWI4UvtkLja7YvR+8N+71YnrnUJb
	t9KngxFLyzhi8Li+0rbo+UiKReYUy+wE/whlfBNzWK17qnzh3Xe8i5ML59myJLc/
	vLSnqm8bgi0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 259A119832;
	Mon, 22 Apr 2013 23:43:21 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9658A19830;
	Mon, 22 Apr 2013 23:43:20 +0000 (UTC)
In-Reply-To: <CAASwCXf3YHmdQ_eSkShyzn5VniO=ufm3VTqV1JVOUN610bzE_A@mail.gmail.com>
	(Joel Jacobson's message of "Tue, 23 Apr 2013 00:23:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A0664F4-ABA6-11E2-9F5B-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222130>

Joel Jacobson <joel@trustly.com> writes:

> Signed-off-by: Joel Jacobson <joel@trustly.com>
> ---
>  builtin/commit.c | 4 +++-

No docs?  No tests?

As to the design, any regular configuration variable settings must
be overridable from the command line for a single invocation. Please
design an escape hatch in, for somebody who has this configuration
variable set, but does not want to sign this commit he is about to
make.

Also do we generally use dash in the configuration variable names?
I thought the norm was section.CamelCase.

> +       if (!strcmp(k, "commit.gpg-sign"))
> +               return git_config_string(&sign_commit, k, v);
>         if (!strcmp(k, "commit.cleanup"))
>                 return git_config_string(&cleanup_arg, k, v);
>
> --
> --to=gitster@pobox.com
