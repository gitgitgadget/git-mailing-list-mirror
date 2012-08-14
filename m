From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 07/16] Add a symlink 'git-remote-svn' in base dir.
Date: Tue, 14 Aug 2012 13:43:33 -0700
Message-ID: <7vzk5x8aru.fsf@alter.siamese.dyndns.org>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 22:44:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Ny9-00049m-Cv
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 22:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757480Ab2HNUns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 16:43:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33670 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757421Ab2HNUng (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 16:43:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20FC48440;
	Tue, 14 Aug 2012 16:43:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F4g4N2BcHyucAscFO3+gcTlxfCU=; b=cXIW21
	KOTKuqW9uxSjCmyBS5WcTxSWLVXkBHkjyvWIVQz+WwusdLrbbHKqhH0kqVgfFgvd
	5il9t0YSGV7x6wJJqmsvVCWTrVuTCosvoZ8Frobq9SmVcLvquAMdBjKKeylU4jW2
	XJ39+e4h+SeUnb/tcmLe7uCuKs9Oxe6mnbduk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EwHLMlTTzVPoJFrebCEQW6mTe2MLl0bD
	ki3sKWRO9T2i71QD/fnbYNERgbCq+3Cy/8xxZQK+Qa4DnT4RE7+0XggklWydbPKE
	vehavRwwqEts3AMWiWzKb4ZhHiKwJ2tovcq4wKxk9wscGR34Fc6KkweuryLlIUuu
	k6uWgNE8V2k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D669843F;
	Tue, 14 Aug 2012 16:43:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69265843E; Tue, 14 Aug 2012
 16:43:35 -0400 (EDT)
In-Reply-To: <1344971598-8213-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 (Florian Achleitner's message of "Tue, 14 Aug 2012 21:13:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7DE2D22-E650-11E1-806E-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203448>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> Allow execution of git-remote-svn even if the binary
> currently is located in contrib/svn-fe/.
>
> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> ---
>  git-remote-svn |    1 +
>  1 file changed, 1 insertion(+)
>  create mode 120000 git-remote-svn
>
> diff --git a/git-remote-svn b/git-remote-svn
> new file mode 120000
> index 0000000..d3b1c07
> --- /dev/null
> +++ b/git-remote-svn
> @@ -0,0 +1 @@
> +contrib/svn-fe/remote-svn
> \ No newline at end of file

Not paying enough attention to the patch you are sending?
