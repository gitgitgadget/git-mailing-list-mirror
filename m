From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 07/16] Add a symlink 'git-remote-svn' in base dir.
Date: Tue, 14 Aug 2012 13:46:43 -0700
Message-ID: <7vvcgl8amk.fsf@alter.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Tue Aug 14 22:46:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1O0r-0007sa-TW
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 22:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757499Ab2HNUqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 16:46:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35473 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756336Ab2HNUqs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 16:46:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2C61853A;
	Tue, 14 Aug 2012 16:46:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CUhAcw+1eYTgFB3/O/4YCCRUeV0=; b=Q8ohgv
	a2dlA6sB5e2dnDCXAYwrAY059/75MVyhFzmN3dCT0Cm9RXkVcw+CUZ5W6enjjMxU
	abmXexr8u4Ntw/0RR2MO/E0vDYtVrxESetRYNesrcB61dHpz0C+1NhTxNECYFg7/
	ncY3nCIWli8r39kZIoQvAhsXo5qqfhckbMUCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uoneDlO2koxcuaRzpe3jxe4XpHl1DFkg
	73hf/YajXEZ5nNGV1mA7IL6QnOcUfD1/nr6Zh1bOn9owJT4SA4tK692OpH00Spmt
	18C+wMRyZhCkHMCPJlOYQkIYpfRgvGEw0+9hVu0hXqI2Fe3VbSlb2hOFIp/vSfFt
	uBSffaIbZFI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F05E8539;
	Tue, 14 Aug 2012 16:46:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA9E78536; Tue, 14 Aug 2012
 16:46:44 -0400 (EDT)
In-Reply-To: <1344971598-8213-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 (Florian Achleitner's message of "Tue, 14 Aug 2012 21:13:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 28C26026-E651-11E1-84DB-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203449>

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

Please scratch my previous comment.  I thought you were adding an
entry to .gitignore or something.

I'd rather not to see such a symbolic link that points at a build
product in the source tree.  Making a symlink from the toplevel
Makefile _after_ we built it in contrib/svn-fe/ (and removing it
upon "make clean") is OK, though.
