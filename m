From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] Explicitly list all valid diff tools and document
 --tool-help as an option
Date: Mon, 23 Jul 2012 09:48:44 -0700
Message-ID: <7vr4s2mnir.fsf@alter.siamese.dyndns.org>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com>
 <500CFAE1.3070304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 18:48:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StLoT-0007vl-27
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 18:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424Ab2GWQss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 12:48:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64451 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754399Ab2GWQsr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 12:48:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBFAE685C;
	Mon, 23 Jul 2012 12:48:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LgI9EjJi5FHIx0n8wwgowmbZGIg=; b=HMgiGV
	TMEVki0+FVD52nXER1dirreR/E/zpqDT2UaruUFMpV8Y2thFXapR8f5thnucvAAB
	i72TccVlpAS4JW7ZYSYT6I2q32x6nubmkwe7snhBqZ2+JOoAeDLxuevfunbjpJgw
	OfX/f9BPTsceBbshiRlnlsgJMfi5PAluuCx6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ruCUwlJLD67cSbqeRtGEF6Wd1ncdq7fN
	aKxug8mbVt83CTRrO2AYgyuOrlRx0GPZYp/0K5njPWr/UVPMvEchB0l/zb+bpv9m
	TIQEQReVebiwHwK+Ldw/i5wR4sszMZ05BXKkfvdUagzrS/LqvCL3IKVVZ+iO3cEZ
	iWnzMalVjYU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA09E685B;
	Mon, 23 Jul 2012 12:48:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 152336859; Mon, 23 Jul 2012
 12:48:45 -0400 (EDT)
In-Reply-To: <500CFAE1.3070304@gmail.com> (Sebastian Schuberth's message of
 "Mon, 23 Jul 2012 09:18:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44E033EA-D4E6-11E1-994D-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201940>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  Documentation/git-difftool.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
> index 31fc2e3..5dd54f1 100644
> --- a/Documentation/git-difftool.txt
> +++ b/Documentation/git-difftool.txt
> @@ -36,9 +36,12 @@ OPTIONS
>  
>  -t <tool>::
>  --tool=<tool>::
> -	Use the diff tool specified by <tool>.  Valid values include
> -	emerge, kompare, meld, and vimdiff. Run `git difftool --tool-help`
> -	for the list of valid <tool> settings.

I thought we say "include" because we really do not want to list
millions of tools here, so mild NAK on this part.

> +	Use the diff tool specified by <tool>.  Valid diff tools are:
> +	araxis, bc3, diffuse, ecmerge, emerge, gvimdiff, kcompare, kdiff3,
> +	meld, opendiff, p4merge, tkdiff, vimdiff and xxdiff.
> +
> +--tool-help::
> +	List the supported and available diff tools.

This part is a good addition (but it already is mentioned in the
description of --tool above, so it is more or less a "Meh").

>  +
>  If a diff tool is not specified, 'git difftool'
>  will use the configuration variable `diff.tool`.  If the
