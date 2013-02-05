From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/13] contrib/subtree: Ignore testing directory
Date: Mon, 04 Feb 2013 20:36:34 -0800
Message-ID: <7vpq0fxtpp.fsf@alter.siamese.dyndns.org>
References: <1360037173-23291-1-git-send-email-greened@obbligato.org>
 <1360037173-23291-10-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Nylen <jnylen@gmail.com>, git@vger.kernel.org,
	Techlive Zheng <techlivezheng@gmail.com>,
	Wayne Walter <wayne@tickzoom.com>,
	"Avery Pennarun \"" <apenwarr@gmail.com>,
	Jakub Suder <jakub.suder@gmail.com>,
	John Yani <vanuan@gmail.com>,
	"David A. Greene <greened@obbligato.org>"@b-sasl-quonix.pobox.com
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 05:37:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2aHH-0001SW-LF
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 05:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543Ab3BEEgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 23:36:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44266 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753985Ab3BEEgj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 23:36:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E01CC888;
	Mon,  4 Feb 2013 23:36:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/S5d6WOQ7/UO4WWoNIpgWreutIk=; b=bT/ANg
	zG4wSe1bmDkoJ01RufVH9y5W77S+dy6s7vlYHEg6dOZMUKvOk5rQUBqxLMJStfut
	eK9vXvxuGSvW0dsdXpNKvuVxRZbXRLOsF5CM9MAQyaAeb15SD8LYFtflriOcOTEK
	L9MdtHnWBzxvZrKLDavXUtRfSWnrGsadFVRqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OX09ROcc7IW2Lj3WTOStRHarBgMvODaA
	IyBHwz2Yvfi2VSjfMtlUkNtJrOIQF/icSQPFFXh7uv4X1XJOCHGdPSs//MFAT7lR
	kavFBK+fU6w2KPHN1aWuQtm1LVR+uMf0P6JzyOqAMtNb10SHbGkNxi01j8w37L8U
	VEcu6w6iE8g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01E8EC887;
	Mon,  4 Feb 2013 23:36:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3E69C827; Mon,  4 Feb 2013
 23:36:37 -0500 (EST)
In-Reply-To: <1360037173-23291-10-git-send-email-greened@obbligato.org>
 (David A. Greene's message of "Mon, 4 Feb 2013 22:06:09 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1093278-6F4D-11E2-9E98-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215451>

"David A. Greene" <greened@obbligato.org> writes:

> From: Techlive Zheng <techlivezheng@gmail.com>
>

Justification is missing here.

contrib/subtree/Makefile seems to do "rm -rf" on 'mainline' and
'subproj' in its "clean" target, which makes them look like
build/test artifacts that need to be ignored.

If they are no longer build/test artifacts, perhaps their removal
also need to be dropped from the Makefile?

> Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---
>  contrib/subtree/.gitignore |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/subtree/.gitignore b/contrib/subtree/.gitignore
> index 91360a3..59aeeb4 100644
> --- a/contrib/subtree/.gitignore
> +++ b/contrib/subtree/.gitignore
> @@ -1,6 +1,5 @@
>  *~
>  git-subtree
> -git-subtree.xml
>  git-subtree.1
> -mainline
> -subproj
> +git-subtree.xml
> +t/trash\ directory.*
